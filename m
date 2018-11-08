Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8E2C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7DE2081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VP9s2q5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7DE2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbeKIHgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:36:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:53104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728279AbeKIHgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:36:00 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2302820892;
        Thu,  8 Nov 2018 21:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714312;
        bh=aDZ3hyJnKBLvijBCWkZurkiwA2Ssp54fgUr+tHoo4Po=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VP9s2q5C6ASForKZ355IQWDbnr+vA5R2cVZRWyunpvfOnthlCtCcK4XL6yyF/7WsD
         K3FlvRqDAUmdBlcu543zsOLQ/bnCaV/e6gnfyH8pv2BwMdR1Inafv9F6l+ZKYPtF5T
         mFUKbvbv8ih7lD7y+H7+f+QRFIcHyCJkUHo61zgQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tobias Herzog <t-herzog@gmx.de>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 3.18 142/144] cdc-acm: correct counting of UART states in serial state notification
Date:   Thu,  8 Nov 2018 13:51:53 -0800
Message-Id: <20181108215108.493302487@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
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

From: Tobias Herzog <t-herzog@gmx.de>

commit f976d0e5747ca65ccd0fb2a4118b193d70aa1836 upstream.

The usb standard ("Universal Serial Bus Class Definitions for Communication
Devices") distiguishes between "consistent signals" (DSR, DCD), and
"irregular signals" (break, ring, parity error, framing error, overrun).
The bits of "irregular signals" are set, if this error/event occurred on
the device side and are immeadeatly unset, if the serial state notification
was sent.
Like other drivers of real serial ports do, just the occurence of those
events should be counted in serial_icounter_struct (but no 1->0
transitions).

Signed-off-by: Tobias Herzog <t-herzog@gmx.de>
Acked-by: Oliver Neukum <oneukum@suse.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/class/cdc-acm.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -336,17 +336,17 @@ static void acm_ctrl_irq(struct urb *urb
 
 		if (difference & ACM_CTRL_DSR)
 			acm->iocount.dsr++;
-		if (difference & ACM_CTRL_BRK)
-			acm->iocount.brk++;
-		if (difference & ACM_CTRL_RI)
-			acm->iocount.rng++;
 		if (difference & ACM_CTRL_DCD)
 			acm->iocount.dcd++;
-		if (difference & ACM_CTRL_FRAMING)
+		if (newctrl & ACM_CTRL_BRK)
+			acm->iocount.brk++;
+		if (newctrl & ACM_CTRL_RI)
+			acm->iocount.rng++;
+		if (newctrl & ACM_CTRL_FRAMING)
 			acm->iocount.frame++;
-		if (difference & ACM_CTRL_PARITY)
+		if (newctrl & ACM_CTRL_PARITY)
 			acm->iocount.parity++;
-		if (difference & ACM_CTRL_OVERRUN)
+		if (newctrl & ACM_CTRL_OVERRUN)
 			acm->iocount.overrun++;
 		spin_unlock(&acm->read_lock);
 


