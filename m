Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B24ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 23:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC5920834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 23:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Y0m3j7hk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC5920834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbeJ0IDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 04:03:17 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43276 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728854AbeJ0IDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 04:03:14 -0400
Received: by mail-ed1-f65.google.com with SMTP id y20-v6so2650139eds.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 16:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RkvcFGGyuf83L1ZfChu0yT5Y/kH4xBnyJYjeiBClSrI=;
        b=Y0m3j7hkgIS6ByJBd4TkCsLmbq0s6mpkM60+M1N4d+pKb+V7TJ+JRzjc1Bs3swqsNN
         E3D7s2fO7RtdHJgO1QanfKrddeVWxzECc2Bid5RlJszfAmeu2nwupiegEVTz6JWZ96Uw
         HsMygc7OqagaMM4sXFox4Vr4Ykk50bvh92qU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RkvcFGGyuf83L1ZfChu0yT5Y/kH4xBnyJYjeiBClSrI=;
        b=iU3RRxHQCvuR4GPOTld204VOYZKqHtmzimo6tGVgL6Bi7hxo10V6MeWEggh04M2f2G
         xsbzlIsz27tTHZ1U/2Tvwzjk3EVG4Q3CmOIOKa4Go6DUYTHlQTrN0xZwNU/G3IUDDEBP
         32nF2oYasvgKWgAZhk0yZdOABfi4Rw9m53PDsfQgp/EELgDewQ/ieQIttCPoBSqAXmgB
         RPZY6I7Ue+KiOf32IzeZv1njqdaZ34kSFyR2BNX1s9IkukGJTFxmOsriBrRGvA+9e/ld
         XeyxDktFwDeFowFJm1ImNmHylhdLUC9H5A+jU19Gg3vRDxFC2HPe5LBSEF3j4WUpaxlb
         RMIw==
X-Gm-Message-State: AGRZ1gIzo+cLaX2/jjNVsuvj5g+M8wnh0hekCyZhoVvHjtrsgN8T9AlO
        bqzteezaIYh58oy+tl/EX/pia2wtj2kJfw==
X-Google-Smtp-Source: AJdET5eyEPyEohX1w4g/sUs50AAkPfCSbBMVarxlhqmpDQM4CU8OuBTJTqP95eA3oHN7SfgTVbLrpw==
X-Received: by 2002:a17:906:7746:: with SMTP id o6-v6mr3709747ejn.48.1540596253857;
        Fri, 26 Oct 2018 16:24:13 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id o13-v6sm3986746edc.95.2018.10.26.16.24.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Oct 2018 16:24:13 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [RFC PATCH 1/7] compiler_attributes.h: add __attribute__((format_arg)) shorthand
Date:   Sat, 27 Oct 2018 01:24:03 +0200
Message-Id: <20181026232409.16100-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181026232409.16100-1-linux@rasmusvillemoes.dk>
References: <20171108223020.24487-1-linux@rasmusvillemoes.dk>
 <20181026232409.16100-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __format_arg attribute tells gcc that it can use a specific
argument to the annotated function as the format string for the
purpose of type-checking a surrounding __printf function call. For
example, assuming one has a fmtcheck function declared as

  const char *fmtcheck(const char *, const char *, unsigned) __format_arg(2);

and this is used in

  sprintf(buf, fmtcheck(what->ever, "%d %lx", 0), i, m)

gcc checks that the varargs (i and m) matches the second argument to the
fmtcheck function, i.e. that they are (int, long). With

  sprintf(buf, what->ever, i, m)

the compiler cannot do any type checking.

Even a static inline fmtcheck() that just returns its first argument
would provide documentation for which specifiers what->ever is supposed
to contain, but we'll implement an actual run-time check later.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/compiler_attributes.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 6b28c1b7310c..08264df52322 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -32,6 +32,7 @@
 # define __GCC4_has_attribute___assume_aligned__      (__GNUC_MINOR__ >= 9)
 # define __GCC4_has_attribute___designated_init__     0
 # define __GCC4_has_attribute___externally_visible__  1
+# define __GCC4_has_attribute___format_arg__          1
 # define __GCC4_has_attribute___noclone__             1
 # define __GCC4_has_attribute___optimize__            1
 # define __GCC4_has_attribute___nonstring__           0
@@ -140,6 +141,18 @@
 #define __printf(a, b)                  __attribute__((__format__(printf, a, b)))
 #define __scanf(a, b)                   __attribute__((__format__(scanf, a, b)))
 
+/*
+ * Optional
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-format_005farg-function-attribute
+ * clang: apparently supported, but undocumented
+ */
+#if __has_attribute(__format_arg__)
+# define __format_arg(n) __attribute__((__format_arg__(n)))
+#else
+# define __format_arg(n)
+#endif
+
 /*
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-gnu_005finline-function-attribute
  * clang: https://clang.llvm.org/docs/AttributeReference.html#gnu-inline
-- 
2.19.1.6.gbde171bbf5

