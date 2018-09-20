Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265E4ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8BC321523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VD1VOOzG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8BC321523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388304AbeITXIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:08:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36012 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbeITXI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:08:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id j192-v6so362363wmj.1;
        Thu, 20 Sep 2018 10:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vbv1Y/GlhcruRFT8QBdnUxOtMBEpuuFGHW2cNrplv7o=;
        b=VD1VOOzGehS8sa9shxFULPPYTsNU3Ee7fFmG53lD5PyLy80l70mCcQxwAZJZk2NYl7
         L/xaZNlQCQrMM0J8B5fDiXZtVZayvCJOFc80AAf7sGsL/5BWo6sdGl5HhEAKd7v9NFFw
         dxRL7jToUx2EjOlB3qk1L/q7gsjXM5DtWXxywFVMGfXExxcBHc9WCDeLrirhYw3htrjQ
         rU1BfQfOEm81Dbl3L7gh0Wyz8nNZR4Bb16FE/rV1vXKsAWzMxym2yyQwtEGJerL6vIrW
         2BfcTvzZuNlRW7UQ82+UdyDXM6ZNhyoEZIbdGNwaIcMpkadOUVMqamZAxecOd71cKYBY
         05uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vbv1Y/GlhcruRFT8QBdnUxOtMBEpuuFGHW2cNrplv7o=;
        b=EQEJc392e014onr0arkWOIhVumOF6/6rlnCcSZSKteUiep/1pgAGaMdA7a2exfV3NG
         gJ6dncIE1Sjkt+D+Ksqu4YLbYu47L1CVCdCfkpeFRKbaMuA6Gj/JEMkiaUCNFsyH/bqU
         FaZuOoolFs3moH26kjCJCAorN05YC9fbZARY315Abp2uQggUZo+kA6w35oD3xOKvJjAd
         j5Q3X2Lm1QKaE5aNGssgQJ6j184AGZ49m0F3b7BL9eni8jm/Dt+c0Iokgg8UboQeb4ZG
         mnEdAh/NPz4QGwQHDDv/iAM4wQGB5Le+AU1MZKiWaBPg+BHwje55cjRbgxzBVlNDAs7M
         jmwA==
X-Gm-Message-State: APzg51DL/wxD4tRw2tjolmNWYROlXmYnSoQOLbo0aaO0cAGlZGuPtUzJ
        ZcudsfvSLymd1SI5v7WQP8g=
X-Google-Smtp-Source: ANB0VdasYzls/w9wxWSqLqLIYHgUA/UOrQWws132mWDbYGx7sHWqHHLxq1EqKYphbf6s8dekc165NA==
X-Received: by 2002:a1c:3d07:: with SMTP id k7-v6mr3939395wma.146.1537464237286;
        Thu, 20 Sep 2018 10:23:57 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id q200-v6sm3466562wmd.2.2018.09.20.10.23.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 10:23:56 -0700 (PDT)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Olof Johansson <olof@lxom.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        David Rientjes <rientjes@google.com>, Willy Tarreau <w@1wt.eu>,
        Martin Sebor <msebor@gmail.com>,
        Christopher Li <sparse@chrisli.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Theodore Ts'o <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH v5 15/15] Compiler Attributes: ext4: remove local __nonstring definition
Date:   Thu, 20 Sep 2018 19:23:01 +0200
Message-Id: <20180920172301.21868-16-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com>
References: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 072ebb3bffe6 ("ext4: add nonstring annotations to ext4.h")
introduced a local definition of __nonstring to suppress some false
positives in gcc 8's -Wstringop-truncation.

Since now we support __nonstring for everyone, remove it.

Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 fs/ext4/ext4.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index caff935fbeb8..2acdfdad3d3f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -45,15 +45,6 @@
 
 #include <linux/compiler.h>
 
-/* Until this gets included into linux/compiler-gcc.h */
-#ifndef __nonstring
-#if defined(GCC_VERSION) && (GCC_VERSION >= 80000)
-#define __nonstring __attribute__((nonstring))
-#else
-#define __nonstring
-#endif
-#endif
-
 /*
  * The fourth extended filesystem constants/structures
  */
-- 
2.17.1

