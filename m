Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD69C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76AC92146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551132194;
	bh=nNsEHRLABgH2MGlH1w3/XjegCqMt/oJX5jLYcByuKxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N/bncv1AoxllwuTNBTmCCZtqNyIPC9tgJXYY2kqFibV3VWz5b9wZelsQ7pDvuHdhe
	 rWs6/wPld9++uc1xkxzTrK8qjzVuLKv92F3d9TnSrssRcQy3MC4UXHSiLEBTTYMq8I
	 a2XuOo4EdWvYqxDM+ZTJN/X0qBw+FKvp//+PVcZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbfBYWDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 17:03:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:45780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728872AbfBYVOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:14:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20E5B2147C;
        Mon, 25 Feb 2019 21:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129290;
        bh=nNsEHRLABgH2MGlH1w3/XjegCqMt/oJX5jLYcByuKxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LchIPdVhLucVu210GwwEL83qY0orpiQPy/o/ODih+AIvRV/eLlsqp7HokcxOp51e4
         XVAyHivzghCxVleNW/4gzT7y6GUm32uCpvarPmzuqJ8Lh6X0ViHBVt4ViEuu3eofVQ
         ta9yE0H3PiSGw8o390tF7ipDAZButOxgHCUFMC4A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 46/63] x86/boot: Disable the address-of-packed-member compiler warning
Date:   Mon, 25 Feb 2019 22:11:46 +0100
Message-Id: <20190225195039.338175843@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195035.713274200@linuxfoundation.org>
References: <20190225195035.713274200@linuxfoundation.org>
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

From: Matthias Kaehlcke <mka@chromium.org>

commit 20c6c189045539d29f4854d92b7ea9c329e1edfc upstream.

The clang warning 'address-of-packed-member' is disabled for the general
kernel code, also disable it for the x86 boot code.

This suppresses a bunch of warnings like this when building with clang:

./arch/x86/include/asm/processor.h:535:30: warning: taking address of
  packed member 'sp0' of class or structure 'x86_hw_tss' may result in an
  unaligned pointer value [-Waddress-of-packed-member]
    return this_cpu_read_stable(cpu_tss.x86_tss.sp0);
                                ^~~~~~~~~~~~~~~~~~~
./arch/x86/include/asm/percpu.h:391:59: note: expanded from macro
  'this_cpu_read_stable'
    #define this_cpu_read_stable(var)       percpu_stable_op("mov", var)
                                                                    ^~~
./arch/x86/include/asm/percpu.h:228:16: note: expanded from macro
  'percpu_stable_op'
    : "p" (&(var)));
             ^~~

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20170725215053.135586-1-mka@chromium.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/boot/compressed/Makefile |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -34,6 +34,7 @@ KBUILD_CFLAGS += $(cflags-y)
 KBUILD_CFLAGS += -mno-mmx -mno-sse
 KBUILD_CFLAGS += $(call cc-option,-ffreestanding)
 KBUILD_CFLAGS += $(call cc-option,-fno-stack-protector)
+KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
 
 KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
 GCOV_PROFILE := n


