Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9844EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB29216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB29216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=archlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeI0T7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 15:59:45 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45577 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbeI0T7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 15:59:45 -0400
Received: by mail-lj1-f193.google.com with SMTP id x16-v6so2413051ljd.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 06:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ntkNKkKJwIDMWVsmG3RqQ/G/MNKrYxExVLVwnPO9oNY=;
        b=OfJr6xS/5Htnv8BKmEPXCIZ/MMF/hv+e8TzvrMzHOfD6AxygEjzGlD3GLHXCie4vr3
         inzzNXXRSj/pgh2zje/mXdHoBcggohuKOSOm+MXh1jonnKbmKyF2P7ak6c+/zHk/UZmY
         ddRvL+1El3TXl6nMpSJmy2MDGvvmDctdNV/CQhmk54uHg3p77hHZ+YNjz+0FzDwG/5TH
         FCLzSRUN/k+1ArKwoNWY2cDuiofx+nr4qilVFk4ppBHNRl4tN1UwXmFXDO/BlxesimjR
         Y5sKT+jzB1tf1tw/B+TBbLtDKfb/gjCtGUPIvGSAFJ7pXE8pRwPRuUZ3sDDsmj0gLWU7
         Zu9A==
X-Gm-Message-State: ABuFfohDtRgnFXxEo6BiWC9A53KQ9bZhJ4wJJO7ri19ncvvT/ELQnfOO
        VpaMK9I8payVbQmNuv1fxO77g8RV
X-Google-Smtp-Source: ACcGV61X9g9nQqz3ZxUMeOsxZEm1Mt3dvSDNjugIQ/JYl3gvVJw2B8Chp4kwqXFGIaeb8A4l2ajgiw==
X-Received: by 2002:a2e:5b17:: with SMTP id p23-v6mr7804162ljb.91.1538055684448;
        Thu, 27 Sep 2018 06:41:24 -0700 (PDT)
Received: from afr_pc.appeartv.lan ([195.159.183.42])
        by smtp.gmail.com with ESMTPSA id x139-v6sm451878lfd.53.2018.09.27.06.41.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 06:41:23 -0700 (PDT)
From:   xyproto@archlinux.org
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Alexander=20F=2E=20R=C3=B8dseth?= <xyproto@archlinux.org>
Subject: [PATCH] Reduce boot header size with 1 byte
Date:   Thu, 27 Sep 2018 15:41:17 +0200
Message-Id: <20180927134117.15371-1-xyproto@archlinux.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander F. Rødseth <xyproto@archlinux.org>

Only ah needs to be set to 0 before calling interrupt 0x16 for waiting
for a keypress.

This patch changes the line that uses xor so that it only zeroes "ah" instead of "ax".
This saves a byte.

Signed-off-by: Alexander F. Rødseth <xyproto@archlinux.org>
---
 arch/x86/boot/header.S | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 850b8762e889..905cb96f43d4 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -71,14 +71,15 @@ msg_loop:
 	jmp	msg_loop
 
 bs_die:
-	# Allow the user to press a key, then reboot
-	xorw	%ax, %ax
+	# Allow the user to press a key
+	xorb	%ah, %ah
 	int	$0x16
+
+	# Boostrap by reading sector 1, head 0, track 0 from drive
 	int	$0x19
 
-	# int 0x19 should never return.  In case it does anyway,
-	# invoke the BIOS reset code...
-	ljmp	$0xf000,$0xfff0
+	# If boostrap somehow did not work, invoke the BIOS reset code
+	ljmp	$0xf000, $0xfff0
 
 #ifdef CONFIG_EFI_STUB
 	.org	0x3c
-- 
2.19.0

