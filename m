Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3579C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE656206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UWVKchDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfBLAgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 19:36:44 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39535 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbfBLAgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 19:36:44 -0500
Received: by mail-qk1-f196.google.com with SMTP id x6so7673716qki.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 16:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=p6UZlmJNvW6qn9lMpKGAK6h+ZzY5nTSp1ppNfG3zito=;
        b=UWVKchDptb/mMvXJH9eaB8sONNav2zs3oXVVHA5crBHGZhtrPABF+Jmp/e6N34QkOh
         8yzZN0l3BbHFjPaGNM5Y21GEgbheGKJX/rOWLWeijXS/oyVVFH5Bo8mXzRCw+Kj+3d+g
         jaE2E0AX1jfFbP2lO2Ot5uqndRvxFRSBUYb6kSdLNjvmM+ED0rN6MJxH6uUQPi7DJ9A8
         Fnv+63IA3AQtyY26+pY2VjCEPnII2Yka/faT9thWhNixbqPOCmBjTq181g/njQUAMEFL
         tsfmA95a4Dp9O9gUcXlKXnOe2I9ndbypXH6q6Ic6dM+Koez8aELRa8LYecQS87VhQBi8
         nK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=p6UZlmJNvW6qn9lMpKGAK6h+ZzY5nTSp1ppNfG3zito=;
        b=Tn3YFhFr5g8GOVH0ZfBhmg/6zjERwzNEwPGOLRJqZcFFcfTiILSNBceb+7BB3yks7S
         5ixOBgaDuo5fKvZ7Uc+OCmQ+xBK0g3pz/ljqTp1QLpd7gC1WcDW+wA69nzBS3dmPJyUc
         sTfvd6Z0dNo2hUE2OMrmKPBklloONh4xVsKZxmtpDO57EoOY8PBK4IJEPqicto3K2UnV
         Rui1AiD7CFjUBhh73MCpue0xQFOdvA2PE1rW88NfCEShh6dZNrp+9BD3ODoybNz07ZkH
         3g0trLqR6p25lX+KTrN34iNDSAXGeGbrTy6f61j+Rfyg6wmk/7HK/iuy7M39ugSGr8N2
         jOfA==
X-Gm-Message-State: AHQUAuZKCgazz44jyLEIwN9mUQp1hv07ViU8cdIrGwPZURLoYKHMlsoF
        Mr85bv352mjWasd+MkKHT0FAcR56yVk=
X-Google-Smtp-Source: AHgI3IZ4gDwEtOxJyTPIOZ/X3r46Q9RkizJvkG/Mq9uFnWxS2ErKHmLm18k4YefmbFenNhpPuOYlow==
X-Received: by 2002:ae9:ea0f:: with SMTP id f15mr700826qkg.113.1549931802995;
        Mon, 11 Feb 2019 16:36:42 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id i126sm11758710qkc.78.2019.02.11.16.36.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 16:36:42 -0800 (PST)
Date:   Mon, 11 Feb 2019 19:36:41 -0500 (EST)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Matthew Whitehead <tedheadster@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vt: perform safe console erase in the right order
Message-ID: <nycvar.YSQ.7.76.1902111931420.2031@knanqh.ubzr>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4b4ecd9cb853 ("vt: Perform safe console erase only once") removed
what appeared to be an extra call to scr_memsetw(). This missed the fact
that set_origin() must be called before clearing the screen otherwise
old screen content gets restored on the screen when using vgacon. Let's
fix that by moving all the scrollback handling to flush_scrollback()
where it logically belongs, and invoking it before the actual screen
clearing in csi_J(), making the code simpler in the end.

Reported-by: Matthew Whitehead <tedheadster@gmail.com>
Signed-off-by: Nicolas Pitre <nico@linaro.org>
Tested-by: Matthew Whitehead <tedheadster@gmail.com>
Fixes: 4b4ecd9cb853 ("vt: Perform safe console erase only once")
Cc: stable@vger.kernel.org

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index bba75560d1..9646ff63e7 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -935,8 +935,11 @@ static void flush_scrollback(struct vc_data *vc)
 {
 	WARN_CONSOLE_UNLOCKED();
 
+	set_origin(vc);
 	if (vc->vc_sw->con_flush_scrollback)
 		vc->vc_sw->con_flush_scrollback(vc);
+	else
+		vc->vc_sw->con_switch(vc);
 }
 
 /*
@@ -1503,8 +1506,10 @@ static void csi_J(struct vc_data *vc, int vpar)
 			count = ((vc->vc_pos - vc->vc_origin) >> 1) + 1;
 			start = (unsigned short *)vc->vc_origin;
 			break;
+		case 3: /* include scrollback */
+			flush_scrollback(vc);
+			/* fallthrough */
 		case 2: /* erase whole display */
-		case 3: /* (and scrollback buffer later) */
 			vc_uniscr_clear_lines(vc, 0, vc->vc_rows);
 			count = vc->vc_cols * vc->vc_rows;
 			start = (unsigned short *)vc->vc_origin;
@@ -1513,13 +1518,7 @@ static void csi_J(struct vc_data *vc, int vpar)
 			return;
 	}
 	scr_memsetw(start, vc->vc_video_erase_char, 2 * count);
-	if (vpar == 3) {
-		set_origin(vc);
-		flush_scrollback(vc);
-		if (con_is_visible(vc))
-			update_screen(vc);
-	} else if (con_should_update(vc))
-		do_update_region(vc, (unsigned long) start, count);
+	update_region(vc, (unsigned long) start, count);
 	vc->vc_need_wrap = 0;
 }
 
