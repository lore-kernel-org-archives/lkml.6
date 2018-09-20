Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850F6ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DBC21532
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyG8mo8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39DBC21532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388264AbeITXI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:08:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45614 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbeITXIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:08:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id 20-v6so10195428wrb.12;
        Thu, 20 Sep 2018 10:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MnTJefPcDnUjEexZ63YwvuA/ucBgN9alSs7ZSnkWlhg=;
        b=kyG8mo8+p3E7jf+6xlOwFJvKyHNsmY94KkGDK0ETcTSQtdy23Mcic7JODYSUPS6O4Z
         YdNBY82M40WiupXxE5vJ6kiM3VdTJB1HWi5tX/CVAMsOiTjWXDLBZFB7OKpt6RoWKMRH
         PLPc0eRIKGI4ZnBij01n0tbpYnnd7Wj2+NBss+Gi9yorw53kK3lxsXh3PV6L91N5p4/U
         9fx3izf6XJ3ud062UAGCQXzK8aE4hYiJ74Vpqxg2fc3wK0eJiACCxzukVVB35nDRqhR6
         ySr7Pz4pTQVtSeHI9PSPSFfVbDguFSm5IUggyEHZUuJmOYlAOWq/SRdqsbPonllKycCI
         bFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MnTJefPcDnUjEexZ63YwvuA/ucBgN9alSs7ZSnkWlhg=;
        b=nFxERmkUuZ16JWj20c/6Uw2JiTzQxCLHighLgq6C1NMCq3lNT55DFT/DkPIjICZox9
         M+vC0FjsSyUjGlHIRNW/rHRJ+mEumoYIYXlc1lBXLbWMPzKhd1RYPdYpznIwjiDr593H
         py2MZWzPda3o4JDzO0yDHSrOPFM54WkZ/rHkGbz25ojjZ5pJ0DL3S+FVXI+ZWLYC22fJ
         OYChXFngoCnv53Z2pZXfxzgNpEKMvh7Y99sl7krM9vm+XVcF+HBIoiW6Dlwpryat/EOZ
         lJVYEp+Gw+0qi1DKV0+9DJm5zNImh4aZmDkN0XroUXSol7ftOUuULA792WSu/gF+yYxP
         Xj4w==
X-Gm-Message-State: APzg51CA8766KcoQkjNLcrkU/j4jPQUvZX/jFdOzw8C32bsPE8x+6uMi
        zTvBnE1z86M8pcmbjNuJSk4=
X-Google-Smtp-Source: ANB0VdZyGjxq0fGXj6GT4VCfup6Xj7NZdcFTuXeYqkCEurXaYspOYS+t6mFFyuYf0ETFRwSfK5qyBA==
X-Received: by 2002:adf:9f13:: with SMTP id l19-v6mr35348305wrf.206.1537464232875;
        Thu, 20 Sep 2018 10:23:52 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id q200-v6sm3466562wmd.2.2018.09.20.10.23.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 10:23:52 -0700 (PDT)
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
Subject: [PATCH v5 13/15] Compiler Attributes: enable -Wstringop-truncation on W=1 (gcc >= 8)
Date:   Thu, 20 Sep 2018 19:22:59 +0200
Message-Id: <20180920172301.21868-14-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com>
References: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 217c3e019675 ("disable stringop truncation warnings for now")
disabled -Wstringop-truncation since it was too noisy.

Having __nonstring available allows us to let GCC know that a string
is not meant to be NUL-terminated, which helps suppressing some
-Wstringop-truncation warnings.

Note that using __nonstring actually triggers other warnings
(-Wstringop-overflow, which is on by default) which may be real
problems. Therefore, cleaning up -Wstringop-truncation warnings
also buys us the ability to uncover further potential problems.

To encourage the use of __nonstring, we put the warning back at W=1.
In the future, if we end up with a fairly warning-free tree,
we might want to enable it by default.

Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 scripts/Makefile.extrawarn | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 8d5357053f86..b8f36f5f43f2 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -29,6 +29,7 @@ warning-1 += $(call cc-option, -Wmissing-include-dirs)
 warning-1 += $(call cc-option, -Wunused-but-set-variable)
 warning-1 += $(call cc-option, -Wunused-const-variable)
 warning-1 += $(call cc-option, -Wpacked-not-aligned)
+warning-1 += $(call cc-option, -Wstringop-truncation)
 warning-1 += $(call cc-disable-warning, missing-field-initializers)
 warning-1 += $(call cc-disable-warning, sign-compare)
 
-- 
2.17.1

