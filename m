Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4207FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043CC208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 043CC208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388804AbeHWMcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:32:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56086 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbeHWMcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:32:31 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 26438CA0;
        Thu, 23 Aug 2018 09:03:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bert Kenward <bkenward@solarflare.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 256/324] sfc: hold filter_sem consistently during reset
Date:   Thu, 23 Aug 2018 09:55:22 +0200
Message-Id: <20180823075008.841081744@linuxfoundation.org>
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

[ Upstream commit 193f20033c54db0dc9563f722fbafbcd5fa0e80d ]

We should take and release the filter_sem consistently during the
reset process, in the same manner as the mac_lock and reset_lock.

For lockdep consistency we also take the filter_sem for write around
other calls to efx->type->init().

Fixes: c2bebe37c6b6 ("sfc: give ef10 its own rwsem in the filter table instead of filter_lock")
Signed-off-by: Bert Kenward <bkenward@solarflare.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/sfc/efx.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -1840,12 +1840,6 @@ static void efx_remove_filters(struct ef
 	up_write(&efx->filter_sem);
 }
 
-static void efx_restore_filters(struct efx_nic *efx)
-{
-	down_read(&efx->filter_sem);
-	efx->type->filter_table_restore(efx);
-	up_read(&efx->filter_sem);
-}
 
 /**************************************************************************
  *
@@ -2657,6 +2651,7 @@ void efx_reset_down(struct efx_nic *efx,
 	efx_disable_interrupts(efx);
 
 	mutex_lock(&efx->mac_lock);
+	down_write(&efx->filter_sem);
 	mutex_lock(&efx->rss_lock);
 	if (efx->port_initialized && method != RESET_TYPE_INVISIBLE &&
 	    method != RESET_TYPE_DATAPATH)
@@ -2714,9 +2709,8 @@ int efx_reset_up(struct efx_nic *efx, en
 	if (efx->type->rx_restore_rss_contexts)
 		efx->type->rx_restore_rss_contexts(efx);
 	mutex_unlock(&efx->rss_lock);
-	down_read(&efx->filter_sem);
-	efx_restore_filters(efx);
-	up_read(&efx->filter_sem);
+	efx->type->filter_table_restore(efx);
+	up_write(&efx->filter_sem);
 	if (efx->type->sriov_reset)
 		efx->type->sriov_reset(efx);
 
@@ -2733,6 +2727,7 @@ fail:
 	efx->port_initialized = false;
 
 	mutex_unlock(&efx->rss_lock);
+	up_write(&efx->filter_sem);
 	mutex_unlock(&efx->mac_lock);
 
 	return rc;
@@ -3440,7 +3435,9 @@ static int efx_pci_probe_main(struct efx
 
 	efx_init_napi(efx);
 
+	down_write(&efx->filter_sem);
 	rc = efx->type->init(efx);
+	up_write(&efx->filter_sem);
 	if (rc) {
 		netif_err(efx, probe, efx->net_dev,
 			  "failed to initialise NIC\n");
@@ -3729,7 +3726,9 @@ static int efx_pm_resume(struct device *
 	rc = efx->type->reset(efx, RESET_TYPE_ALL);
 	if (rc)
 		return rc;
+	down_write(&efx->filter_sem);
 	rc = efx->type->init(efx);
+	up_write(&efx->filter_sem);
 	if (rc)
 		return rc;
 	rc = efx_pm_thaw(dev);


