Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A53C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED98F206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="G1X0coXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED98F206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbeK2BLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:11:23 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38194 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeK2BLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:11:22 -0500
Received: by mail-pf1-f193.google.com with SMTP id q1so10230020pfi.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 06:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dTSwJN4JRQVZ+k0IVkIDcn8Xu4jKAMDWHghpT1s4ppk=;
        b=G1X0coXbndfPX1u00zCVALGvWKopsy5wlAEWmsMhf27AoyZOr2lzDd/svHr8Y/1vSj
         KQTuj2PvzIwS1kgbBMY3j/5kssap7VLfXD+60T9l0VCUasGGdn8CPP0ACjvqyXk4/Ere
         rKlBEvoaqxUmPCf6pjONtnz1RZWKRUAMlH23jCWlF+5WRCXmyUMSTLK7gmJyN7Ct7T2r
         cvwOqNueJF0qdjU1/SV7wO+fOOL5UzNQgWG8NDVEKXV+5Qmzb5pcHV9Li3x6IRWIxpvO
         AJ4oadwuUWLJp0J1OJZeI5mRjOkiqy6zJsdhJVI4oZ4wt+ig/ocaO++OZ6JNg/NJVl2c
         tqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dTSwJN4JRQVZ+k0IVkIDcn8Xu4jKAMDWHghpT1s4ppk=;
        b=AHo5jM3vdDiHAXMuW7Y41IFtI3372ojrNFmnXSC+D9LSJQtsayaluA8XGTcQoEYMtp
         t5mvhmAxWfK/Ad7LtyW7I8566yDlFsO3buy8XnqtSY4YUKdZNBUKbbTnL4bHv5oaMj4C
         A0lIA+WSwtUSuK3+YUogCUqep15l+UvS78TrIq7krrRq3m9YGqYlVPDHZvcl5kl5ETEM
         DOpvn8m3tyHVgei9SAnOke6Sf2lMCR+JoVJZuEul78nol/wi6p3FznYr4m+Bw2qp0Xdp
         tOchofHU+FJalHzTHkeUYL2Ofx9Ebd8ZPW1+V+c8GI/Cr46I5kXsUOzTxLJsQCbaj5gK
         6gYQ==
X-Gm-Message-State: AA+aEWZoJz6KYyBlvDNw/BNRB52WlOjWmJy5u7CFBApataBS1K0R+Ykc
        Yh7fMw2ixHzulzJb10ZeOypdRQ==
X-Google-Smtp-Source: AFSGD/V3MCJURkA/WIwOPKgxMVwgM6nlheLuNuIABPXDcH+2mbS/fynCCrd8gmOg+spPdEt1BLgMww==
X-Received: by 2002:aa7:8045:: with SMTP id y5mr5670875pfm.62.1543414175042;
        Wed, 28 Nov 2018 06:09:35 -0800 (PST)
Received: from n3-021-216.byted.org ([123.58.9.124])
        by smtp.gmail.com with ESMTPSA id c13sm13288604pfe.93.2018.11.28.06.09.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 06:09:34 -0800 (PST)
From:   Xiaozhou Liu <liuxiaozhou@bytedance.com>
To:     "ndesaulniers@google.com" <ndesaulniers@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc:     Xiaozhou Liu <liuxiaozhou@bytedance.com>
Subject: [PATCH] Compiler Attributes: move kernel-only attributes into __KERNEL__
Date:   Wed, 28 Nov 2018 22:08:50 +0800
Message-Id: <20181128140852.178260-1-liuxiaozhou@bytedance.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attributes such as `__gnu_inline' are meant to be used within the
kernel. When userspace somehow includes <linux/compiler.h>
(eg. tools/bpf), compilation errors would be shown:

        "error: unknown type name ‘__gnu_inline’"

So just move these things into __KERNEL__ and the behavior is kept
as before.

Fixes: a3f8a30f3f00 ("Compiler Attributes: use feature checks instead of version checks")
Signed-off-by: Xiaozhou Liu <liuxiaozhou@bytedance.com>
---
 include/linux/compiler_types.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 4a3f9c09c92d..2fb2c311e5d6 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -161,6 +161,8 @@ struct ftrace_likely_data {
 #define __diag_error(compiler, version, option, comment) \
 	__diag_ ## compiler(version, error, option)
 
+#ifdef __KERNEL__
+
 #ifdef CONFIG_ENABLE_MUST_CHECK
 #define __must_check		__attribute__((__warn_unused_result__))
 #else
@@ -215,4 +217,6 @@ struct ftrace_likely_data {
  */
 #define noinline_for_stack noinline
 
+#endif /* __KERNEL__ */
+
 #endif /* __LINUX_COMPILER_TYPES_H */
-- 
2.11.0

