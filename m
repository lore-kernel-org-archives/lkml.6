Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E887AC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2EF2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUVzRWxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2EF2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbeJKXGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:06:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727569AbeJKXGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:06:04 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0684420652;
        Thu, 11 Oct 2018 15:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272301;
        bh=eP9PO8qbHkaipGryjfhmdMRFcjfVv9Q3zqyp5jdWxzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nUVzRWxoh4zVoIHuWiYV3xBhjk+TRtoDpL0pvaXS1QrmrDGLi31ZPu/Aq84Ac2jg0
         aYl7Ga5ph2twf+n1HZTf3GZvlvzPXnMPzc47ag6rdIgo0FtxY3rHyLOxwGXguOq/oG
         5UIKZI71/yu6XEYWvnEqYiQmzS5dBoWC9VuoszqE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3.18 059/120] Revert "usb: cdc-wdm: Fix a sleep-in-atomic-context bug in service_outstanding_interrupt()"
Date:   Thu, 11 Oct 2018 17:34:00 +0200
Message-Id: <20181011152552.191441533@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

commit e871db8d78df1c411032cbb3acfdf8930509360e upstream.

This reverts commit 6e22e3af7bb3a7b9dc53cb4687659f6e63fca427.

The bug the patch describes to, has been already fixed in commit
2df6948428542 ("USB: cdc-wdm: don't enable interrupts in USB-giveback")
so need to this, revert it.

Fixes: 6e22e3af7bb3 ("usb: cdc-wdm: Fix a sleep-in-atomic-context bug in service_outstanding_interrupt()")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/class/cdc-wdm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -452,7 +452,7 @@ static int clear_wdm_read_flag(struct wd
 
 	set_bit(WDM_RESPONDING, &desc->flags);
 	spin_unlock_irq(&desc->iuspin);
-	rv = usb_submit_urb(desc->response, GFP_ATOMIC);
+	rv = usb_submit_urb(desc->response, GFP_KERNEL);
 	spin_lock_irq(&desc->iuspin);
 	if (rv) {
 		dev_err(&desc->intf->dev,


