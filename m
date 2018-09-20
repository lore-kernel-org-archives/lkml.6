Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5760C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ABEC21531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wm9PColh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ABEC21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388139AbeITXIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:08:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44024 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732794AbeITXIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:08:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id k5-v6so10196989wre.10;
        Thu, 20 Sep 2018 10:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+3J6L7h/sEn5CncGiCzMXe2W5FPwQDjmK1q81IjlWiU=;
        b=Wm9PColhFrOz4RV32gXm1loYa4k8jnr1YsSZUSKunLS7oNcmlChMIi67t/cNvqUDu6
         pQDF9jzqrBW2wX5R8yMqzYrnREQCWhXLhe/k3dMROyfsz0uCL3RVNgQAVPuo/She14bn
         jHpFneo0IeU03rrK0qMPYYWKKa3eAQjLWtSkIocJeH1MiKTrmHD3M1EF9oqcqULsE1hD
         yMEmf+G3aljK6TpfoELbFr850gTrZ9qkvA7e5sng79mz2A1FbsjMOzDrO8pv3xzGMcs5
         Tvy/jj/P5TZSG4sS6CpDn+kFfQxKV8maitnFgqA3PTy2uDvscNAaZ6lDCWmu1iBE0k/E
         W9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+3J6L7h/sEn5CncGiCzMXe2W5FPwQDjmK1q81IjlWiU=;
        b=DDj1P5Fz0oMPg72yRvbRNT/6DOI1qEKAhrr6wURjV3lBjgUTRhSMoYddnGWw28dEsZ
         I8j/lpsbDR9Laa6Th596EswlAhyAsYutM3v/uxdl5tvMdkBB4BWbNwKBrzh9txQRitaY
         2yr0A3srFchtfdv024TX1W3lAWTNBJyfhgvz6rMm4L6clPQhErYC2HdlezIKaPOv/59L
         86cbWyO/w1MT/pBciD4UuZ2+jOaTSOhgP/udY6KHVAa73C3c5NVrsT37xZ98nI5k/LN/
         TKqi8h1Was55IFsL4D37WzJgTMgHrHkgFhB7zcPv0z0Rrnw3S/4H8IzW2LEgqujYz1iG
         GhgQ==
X-Gm-Message-State: APzg51DRdnuvUSNa8n+/sHjNDhu6OvBgAepMraddSnpzetDwGsWcPtlP
        S23QcZZjBuo9HZVH6bGXf8w=
X-Google-Smtp-Source: ANB0VdZJwXFX2HiJwO4YDTcGI8p9jybt5IMb4nZGDkX3uwjShn0jVZFVVvihNZlH7IrJYUvbeG+j8g==
X-Received: by 2002:adf:fe06:: with SMTP id n6-v6mr35098498wrr.171.1537464221923;
        Thu, 20 Sep 2018 10:23:41 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id q200-v6sm3466562wmd.2.2018.09.20.10.23.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 10:23:41 -0700 (PDT)
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
Subject: [PATCH v5 08/15] Compiler Attributes: KENTRY used twice the "used" attribute
Date:   Thu, 20 Sep 2018 19:22:54 +0200
Message-Id: <20180920172301.21868-9-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com>
References: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 include/linux/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 4030a2940d6b..17ee9165ca51 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -146,7 +146,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	extern typeof(sym) sym;					\
 	static const unsigned long __kentry_##sym		\
 	__used							\
-	__attribute__((__section__("___kentry" "+" #sym ), used))	\
+	__attribute__((__section__("___kentry" "+" #sym )))	\
 	= (unsigned long)&sym;
 #endif
 
-- 
2.17.1

