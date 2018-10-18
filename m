Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082C6ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB56E204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v4+EMzYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB56E204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbeJSB7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:59:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728728AbeJSB7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:59:02 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A85362145D;
        Thu, 18 Oct 2018 17:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885417;
        bh=YpxBF48hzr3UsmcO/OGmcc1GDJXxe4EvrOl8JLeSlrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v4+EMzYa+AdaBWgH0k6kppd1I/jEuv7csZXECRXAjbjfX1Q8FVxL3+VOzpcv+5xTw
         2ZINe8fp/ialmVIBn2d1sT/oDn9IA/IWrXcI6FQnDgIQ5Zs3PQVlFBD4K1TBMgENFt
         GQ4Ut2cIWajhRkFoVEqE+8UeL2R3EvlfBbIDNMhY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Schmitz <schmitzmic@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 22/53] Input: atakbd - fix Atari CapsLock behaviour
Date:   Thu, 18 Oct 2018 19:54:15 +0200
Message-Id: <20181018175420.556188408@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.561567978@linuxfoundation.org>
References: <20181018175416.561567978@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Schmitz <schmitzmic@gmail.com>

[ Upstream commit 52d2c7bf7c90217fbe875d2d76f310979c48eb83 ]

The CapsLock key on Atari keyboards is not a toggle, it does send the
normal make and break scancodes.

Drop the CapsLock toggle handling code, which did cause the CapsLock
key to merely act as a Shift key.

Tested-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/keyboard/atakbd.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

--- a/drivers/input/keyboard/atakbd.c
+++ b/drivers/input/keyboard/atakbd.c
@@ -189,14 +189,8 @@ static void atakbd_interrupt(unsigned ch
 
 		scancode = atakbd_keycode[scancode];
 
-		if (scancode == KEY_CAPSLOCK) {	/* CapsLock is a toggle switch key on Amiga */
-			input_report_key(atakbd_dev, scancode, 1);
-			input_report_key(atakbd_dev, scancode, 0);
-			input_sync(atakbd_dev);
-		} else {
-			input_report_key(atakbd_dev, scancode, down);
-			input_sync(atakbd_dev);
-		}
+		input_report_key(atakbd_dev, scancode, down);
+		input_sync(atakbd_dev);
 	} else				/* scancodes >= 0xf3 are mouse data, most likely */
 		printk(KERN_INFO "atakbd: unhandled scancode %x\n", scancode);
 


