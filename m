Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D5FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0574B20869
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7dAQwnO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0574B20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbeIDAzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 20:55:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37418 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729079AbeIDAzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 20:55:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so1763502wrr.4;
        Mon, 03 Sep 2018 13:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VqRqOGZ4G4JNA6fITKU0kaGxJLv/GQRGqVshL6cqUnI=;
        b=A7dAQwnOCtPnkh9wwQe3CpCyq8Vs+lmQREw47ahv3vjNKPZCzSzuEv1bmKssLspqno
         xd4JSpFb0Kzi+X2VofhHKHk1Bc+9BxqOGbCwbik19Ijzht7lCahBpRpMXBlq5fh/mZDP
         ENzi9nJ5I+Q+Sdg0Jn/qBect0qWfaW2QJMO957rU6GdfTJ+KL5a/MB4gQEYYSdVY9Tvw
         UkqX5C5WM3A7/tW+X7WkKenwrI42a/z2wqpyNa25SYrZQUbneR5P3HBx2LRc3YheROYx
         pZovZDT+B+bsEyK7N0bZvGQLhlAyJY3OB4VxGbGJ89pD3oPkI7pWrc6/vi3LnZmccNxw
         oeyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VqRqOGZ4G4JNA6fITKU0kaGxJLv/GQRGqVshL6cqUnI=;
        b=XfSzBrjSEVyC0283rtEM8jn+EayBtP4JueDxfPQzM+xlANw7GUFchIpo/TcBk4RLCm
         w5+F41nY0oq9aocfGKhmaT1QGA52Q83J2V+H+rSr05grsEYaA3Lzn6m/T5Cn0jJI5Ahx
         8/cQmltTTFIgrlTKf7PKcHx3fhXUlUJr18m+ziB7HXETT9Ek0Nd/832vwFg+Sb44js8g
         i2fzvloHN2yhZdPhrQCM1RRRYAtFqiSG5E1CiohmHSMEIXrWKV90y/gzUr1JHN+39uN5
         poUUDIoZI2CDqimy38XpjB1+0b0O0HOjnbGO36z5PU75MTGSdv9aJl6/KVjSJpMXLi6O
         NZyw==
X-Gm-Message-State: APzg51CNis6lWyC3sus+87Kz4UjAV4cEwj2KlpN2eBpOz6QYYj1mW24W
        KXcx8c/o6m/kg6Mn+Tm9dac=
X-Google-Smtp-Source: ANB0VdaC2O2j/3WXWW4ExhS5xM025jXAMQa2R1YofjjnG+XZNzIOGXTxPbz4srbFstTmzJvXCbWyJw==
X-Received: by 2002:a5d:4684:: with SMTP id u4-v6mr21062416wrq.76.1536006841130;
        Mon, 03 Sep 2018 13:34:01 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id 132-v6sm12354870wmd.13.2018.09.03.13.33.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 13:34:00 -0700 (PDT)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-sparse@vger.kernel.org
Subject: [PATCH 10/12] Compiler Attributes: KENTRY used twice the "used" attribute
Date:   Mon,  3 Sep 2018 22:33:14 +0200
Message-Id: <20180903203316.16183-11-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180903203316.16183-1-miguel.ojeda.sandonis@gmail.com>
References: <20180903203316.16183-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Eli Friedman <efriedma@codeaurora.org>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org
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

