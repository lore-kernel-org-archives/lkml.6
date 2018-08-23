Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73C4C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB552208CC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB552208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388790AbeHWMc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:32:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56074 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbeHWMc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:32:28 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 01889BBF;
        Thu, 23 Aug 2018 09:03:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jarod Wilson <jarod@redhat.com>,
        Bert Kenward <bkenward@solarflare.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 255/324] sfc: avoid hang from nested use of the filter_sem
Date:   Thu, 23 Aug 2018 09:55:21 +0200
Message-Id: <20180823075008.797514921@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bert Kenward <bkenward@solarflare.com>

[ Upstream commit 1c56c0994a533ce564843a0d17af7a3e6e68f269 ]

In some situations we may end up calling down_read while already
holding the semaphore for write, thus hanging. This has been seen
when setting the MAC address for the interface. The hung task log
in this situation includes this stack:
  down_read
  efx_ef10_filter_insert
  efx_ef10_filter_insert_addr_list
  efx_ef10_filter_vlan_sync_rx_mode
  efx_ef10_filter_add_vlan
  efx_ef10_filter_table_probe
  efx_ef10_set_mac_address
  efx_set_mac_address
  dev_set_mac_address

In addition, lockdep rightly points out that nested calling of
down_read is incorrect.

Fixes: c2bebe37c6b6 ("sfc: give ef10 its own rwsem in the filter table instead of filter_lock")
Tested-by: Jarod Wilson <jarod@redhat.com>
Signed-off-by: Bert Kenward <bkenward@solarflare.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/sfc/ef10.c |   30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -4288,9 +4288,9 @@ static int efx_ef10_filter_pri(struct ef
 	return -EPROTONOSUPPORT;
 }
 
-static s32 efx_ef10_filter_insert(struct efx_nic *efx,
-				  struct efx_filter_spec *spec,
-				  bool replace_equal)
+static s32 efx_ef10_filter_insert_locked(struct efx_nic *efx,
+					 struct efx_filter_spec *spec,
+					 bool replace_equal)
 {
 	DECLARE_BITMAP(mc_rem_map, EFX_EF10_FILTER_SEARCH_LIMIT);
 	struct efx_ef10_nic_data *nic_data = efx->nic_data;
@@ -4307,7 +4307,7 @@ static s32 efx_ef10_filter_insert(struct
 	bool is_mc_recip;
 	s32 rc;
 
-	down_read(&efx->filter_sem);
+	WARN_ON(!rwsem_is_locked(&efx->filter_sem));
 	table = efx->filter_state;
 	down_write(&table->lock);
 
@@ -4498,10 +4498,22 @@ out_unlock:
 	if (rss_locked)
 		mutex_unlock(&efx->rss_lock);
 	up_write(&table->lock);
-	up_read(&efx->filter_sem);
 	return rc;
 }
 
+static s32 efx_ef10_filter_insert(struct efx_nic *efx,
+				  struct efx_filter_spec *spec,
+				  bool replace_equal)
+{
+	s32 ret;
+
+	down_read(&efx->filter_sem);
+	ret = efx_ef10_filter_insert_locked(efx, spec, replace_equal);
+	up_read(&efx->filter_sem);
+
+	return ret;
+}
+
 static void efx_ef10_filter_update_rx_scatter(struct efx_nic *efx)
 {
 	/* no need to do anything here on EF10 */
@@ -5284,7 +5296,7 @@ static int efx_ef10_filter_insert_addr_l
 		EFX_WARN_ON_PARANOID(ids[i] != EFX_EF10_FILTER_ID_INVALID);
 		efx_filter_init_rx(&spec, EFX_FILTER_PRI_AUTO, filter_flags, 0);
 		efx_filter_set_eth_local(&spec, vlan->vid, addr_list[i].addr);
-		rc = efx_ef10_filter_insert(efx, &spec, true);
+		rc = efx_ef10_filter_insert_locked(efx, &spec, true);
 		if (rc < 0) {
 			if (rollback) {
 				netif_info(efx, drv, efx->net_dev,
@@ -5313,7 +5325,7 @@ static int efx_ef10_filter_insert_addr_l
 		efx_filter_init_rx(&spec, EFX_FILTER_PRI_AUTO, filter_flags, 0);
 		eth_broadcast_addr(baddr);
 		efx_filter_set_eth_local(&spec, vlan->vid, baddr);
-		rc = efx_ef10_filter_insert(efx, &spec, true);
+		rc = efx_ef10_filter_insert_locked(efx, &spec, true);
 		if (rc < 0) {
 			netif_warn(efx, drv, efx->net_dev,
 				   "Broadcast filter insert failed rc=%d\n", rc);
@@ -5369,7 +5381,7 @@ static int efx_ef10_filter_insert_def(st
 	if (vlan->vid != EFX_FILTER_VID_UNSPEC)
 		efx_filter_set_eth_local(&spec, vlan->vid, NULL);
 
-	rc = efx_ef10_filter_insert(efx, &spec, true);
+	rc = efx_ef10_filter_insert_locked(efx, &spec, true);
 	if (rc < 0) {
 		const char *um = multicast ? "Multicast" : "Unicast";
 		const char *encap_name = "";
@@ -5429,7 +5441,7 @@ static int efx_ef10_filter_insert_def(st
 					   filter_flags, 0);
 			eth_broadcast_addr(baddr);
 			efx_filter_set_eth_local(&spec, vlan->vid, baddr);
-			rc = efx_ef10_filter_insert(efx, &spec, true);
+			rc = efx_ef10_filter_insert_locked(efx, &spec, true);
 			if (rc < 0) {
 				netif_warn(efx, drv, efx->net_dev,
 					   "Broadcast filter insert failed rc=%d\n",


