Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73BDC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8B42086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8B42086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbeIKM7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 08:59:06 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41092 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeIKM7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 08:59:06 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fzdbI-0000h6-DS; Tue, 11 Sep 2018 10:00:44 +0200
Date:   Tue, 11 Sep 2018 10:00:44 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     gregkh@linuxfoundation.org, johan@kernel.org, bjorn@mork.no,
        mingo@kernel.org, oneukum@suse.com, viro@zeniv.linux.org.uk,
        mark.rutland@arm.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "usb: cdc-wdm: Fix a sleep-in-atomic-context bug in
 service_outstanding_interrupt()"
Message-ID: <20180911080044.ufe6mvspupckf5ob@linutronix.de>
References: <20180901081210.16655-1-baijiaju1990@gmail.com>
 <20180911074930.2g6ryk7qe46cijhi@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180911074930.2g6ryk7qe46cijhi@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 6e22e3af7bb3a7b9dc53cb4687659f6e63fca427.

The bug the patch describes to, has been already fixed in commit
2df6948428542 ("USB: cdc-wdm: don't enable interrupts in USB-giveback")
so need to this, revert it.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/usb/class/cdc-wdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index 656d247819c9d..bec581fb7c636 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -460,7 +460,7 @@ static int service_outstanding_interrupt(struct wdm_device *desc)
 
 	set_bit(WDM_RESPONDING, &desc->flags);
 	spin_unlock_irq(&desc->iuspin);
-	rv = usb_submit_urb(desc->response, GFP_ATOMIC);
+	rv = usb_submit_urb(desc->response, GFP_KERNEL);
 	spin_lock_irq(&desc->iuspin);
 	if (rv) {
 		dev_err(&desc->intf->dev,
-- 
2.19.0.rc2

