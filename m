Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79C1C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C77F20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C77F20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbeIMSoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:44:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58952 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbeIMSoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:44:17 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 32EE6D16;
        Thu, 13 Sep 2018 13:34:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Govindarajulu Varadarajan <gvaradar@cisco.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 41/60] enic: do not call enic_change_mtu in enic_probe
Date:   Thu, 13 Sep 2018 15:30:48 +0200
Message-Id: <20180913131747.359884598@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131745.261413581@linuxfoundation.org>
References: <20180913131745.261413581@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Govindarajulu Varadarajan <gvaradar@cisco.com>

commit cb5c6568867325f9905e80c96531d963bec8e5ea upstream.

In commit ab123fe071c9 ("enic: handle mtu change for vf properly")
ASSERT_RTNL() is added to _enic_change_mtu() to prevent it from being
called without rtnl held. enic_probe() calls enic_change_mtu()
without rtnl held. At this point netdev is not registered yet.
Remove call to enic_change_mtu and assign the mtu to netdev->mtu.

Fixes: ab123fe071c9 ("enic: handle mtu change for vf properly")
Signed-off-by: Govindarajulu Varadarajan <gvaradar@cisco.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/cisco/enic/enic_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -2683,7 +2683,6 @@ static int enic_probe(struct pci_dev *pd
 	 */
 
 	enic->port_mtu = enic->config.mtu;
-	(void)enic_change_mtu(netdev, enic->port_mtu);
 
 	err = enic_set_mac_addr(netdev, enic->mac_addr);
 	if (err) {
@@ -2732,6 +2731,7 @@ static int enic_probe(struct pci_dev *pd
 		netdev->features |= NETIF_F_HIGHDMA;
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
+	netdev->mtu = enic->port_mtu;
 
 	err = register_netdev(netdev);
 	if (err) {


