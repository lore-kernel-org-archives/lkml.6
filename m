Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B89C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A55218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548357756;
	bh=aUQcYbay/d5fMnMTTCJdigzmbFp/rvn44U228bkp9os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XdFmNjTuZf7+soF4kxzAQ7fWaIYyzX3aMegcOpZrfQh3l5QjCDwHi/n273BTIjrLY
	 9tSK4XspKHTMONtqWpOaZ7Dw1XfpsqZ0wAfTa9OOXsfDBmg/cxIYL6p4XXyhV0QRjF
	 7F3kYF14QqYvyDPuBh3AlI5AXEVWBv6obXjkHQ3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfAXTWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:22:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:47144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729573AbfAXTWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:22:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFC30218CD;
        Thu, 24 Jan 2019 19:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357751;
        bh=aUQcYbay/d5fMnMTTCJdigzmbFp/rvn44U228bkp9os=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pbVHcnNt0yAPhdHmAvR9Ixnkx/A148Jk9/0/0mL7KrCEPK5w1sbecmAgNY+XznwHk
         uSSZmvAujqCTNdO255I+WsErG5H6shGPL4DRJRTLEoQVlcdF4HzeFQwvT7Dva/6mZ5
         jjK/ip8cmgv7vyBt3egbjdQfShWoSdrIs+AgjABA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 3.18 06/52] USB: storage: add quirk for SMI SM3350
Date:   Thu, 24 Jan 2019 20:19:30 +0100
Message-Id: <20190124190141.994586529@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190140.879495253@linuxfoundation.org>
References: <20190124190140.879495253@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Icenowy Zheng <icenowy@aosc.io>

commit 0a99cc4b8ee83885ab9f097a3737d1ab28455ac0 upstream.

The SMI SM3350 USB-UFS bridge controller cannot handle long sense request
correctly and will make the chip refuse to do read/write when requested
long sense.

Add a bad sense quirk for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Cc: stable <stable@vger.kernel.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/storage/unusual_devs.h |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -1393,6 +1393,18 @@ UNUSUAL_DEV(  0x0d49, 0x7310, 0x0000, 0x
 		US_FL_SANE_SENSE),
 
 /*
+ * Reported by Icenowy Zheng <icenowy@aosc.io>
+ * The SMI SM3350 USB-UFS bridge controller will enter a wrong state
+ * that do not process read/write command if a long sense is requested,
+ * so force to use 18-byte sense.
+ */
+UNUSUAL_DEV(  0x090c, 0x3350, 0x0000, 0xffff,
+		"SMI",
+		"SM3350 UFS-to-USB-Mass-Storage bridge",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_BAD_SENSE ),
+
+/*
  * Pete Zaitcev <zaitcev@yahoo.com>, bz#164688.
  * The device blatantly ignores LUN and returns 1 in GetMaxLUN.
  */


