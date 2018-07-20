Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D139DECDFBD
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9274F20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9274F20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389604AbeGTN1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:27:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48484 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389409AbeGTN1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:27:43 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 79752CC4;
        Fri, 20 Jul 2018 12:36:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 008/101] alx: take rtnl before calling __alx_open from resume
Date:   Fri, 20 Jul 2018 14:13:14 +0200
Message-Id: <20180720121423.250305609@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
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

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit bc800e8b39bad60ccdb83be828da63af71ab87b3 ]

The __alx_open function can be called from ndo_open, which is called
under RTNL, or from alx_resume, which isn't. Since commit d768319cd427,
we're calling the netif_set_real_num_{tx,rx}_queues functions, which
need to be called under RTNL.

This is similar to commit 0c2cc02e571a ("igb: Move the calls to set the
Tx and Rx queues into igb_open").

Fixes: d768319cd427 ("alx: enable multiple tx queues")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/atheros/alx/main.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/atheros/alx/main.c
+++ b/drivers/net/ethernet/atheros/alx/main.c
@@ -1897,13 +1897,19 @@ static int alx_resume(struct device *dev
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct alx_priv *alx = pci_get_drvdata(pdev);
 	struct alx_hw *hw = &alx->hw;
+	int err;
 
 	alx_reset_phy(hw);
 
 	if (!netif_running(alx->dev))
 		return 0;
 	netif_device_attach(alx->dev);
-	return __alx_open(alx, true);
+
+	rtnl_lock();
+	err = __alx_open(alx, true);
+	rtnl_unlock();
+
+	return err;
 }
 
 static SIMPLE_DEV_PM_OPS(alx_pm_ops, alx_suspend, alx_resume);


