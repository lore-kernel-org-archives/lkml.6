Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE90C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9909320645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547571537;
	bh=wSNuL6bGTQezeWqrRDKAMEj31y8Wd9U/OSUbRywJJIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rgqppq5v8hKNY/ZwZrgZRWox7ZFeWco0P/aXtVUSMYKV/uozOr54RiENDddedILkG
	 KqjSESCDD4GBWr6ijseenW4IyvK1Pbn6G+tW31xqlYYQrTlfN9MxPARwVLoaQ+ZTnc
	 WGv9gLiGzGBL8kL5iJ5l2KSd5Mn7IW5qaREIlGQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388163AbfAOQ6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:58:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:55930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728643AbfAOQjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:39:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A6FE2054F;
        Tue, 15 Jan 2019 16:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570384;
        bh=wSNuL6bGTQezeWqrRDKAMEj31y8Wd9U/OSUbRywJJIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TgJmYPfG/ZolKpOSHx++xgisjkRXVL5sbPWL7o0Mr1K8NwbzvVXosr6z3DWWxfzgq
         vjvdIjJIDE+gp0Ot5PnwclhMO5xWOOi3nCOYKFdMNCu1ndOqAO9iWBiQuGvCPeSgqc
         vO0cF8Mnac2PHNGmK55H5iTEKLWrNoa0NA9RzkUk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 4.9 06/16] USB: storage: add quirk for SMI SM3350
Date:   Tue, 15 Jan 2019 17:35:49 +0100
Message-Id: <20190115154848.926819086@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154848.164648613@linuxfoundation.org>
References: <20190115154848.164648613@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1285,6 +1285,18 @@ UNUSUAL_DEV( 0x090c, 0x1132, 0x0000, 0xf
 		US_FL_FIX_CAPACITY ),
 
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
  * Reported by Paul Hartman <paul.hartman+linux@gmail.com>
  * This card reader returns "Illegal Request, Logical Block Address
  * Out of Range" for the first READ(10) after a new card is inserted.


