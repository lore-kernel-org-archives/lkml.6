Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D1BC004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 00:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2520E20700
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 00:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeLVqzax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2520E20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbeJWJIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 05:08:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55613 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbeJWJI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 05:08:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id x6-v6so706989wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 17:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aGCpIF7CviiST/QOdxQ5gL9es39WZiaffX36WFY2hZ4=;
        b=ZeLVqzaxrJd96dmqGeJUe4iBQiY7L+SN/poVNJln5dgy62U3z0f/oqcrU2aYmXkSn4
         NzR5w1luZKuCmPgj8RNmt70o6qP4FamVJBiCPEge5TLRk9HcIXRGCRNKST89/YPqBQ3U
         Zhr6wi9DFGVqNU0p7IuvmcSQH6mCjMj2oizwKV1dEx4LZi5oQFVFyMuenqgu+cKwHXjj
         IiHVBdbnsT4lt9mx4gBuCi1leRgRylyQmXCa5likk/UV45MoU1snIeA9MRvGBlMTcPlb
         1sS205IwmP3/Uji7Bm0dnZ9awQpvakIkoVx7x9ZCMyBb5ttBO6nFYuhgIwH4ozINV81J
         bMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aGCpIF7CviiST/QOdxQ5gL9es39WZiaffX36WFY2hZ4=;
        b=mDBxYyi1UAwoxfHCaUuZ7x2TcfVp+MVAmRY3GDJRjbrqgcO++bHi94U3vyllnqsXSe
         raZC/MFl/Zbx8jwgFctU0PnctCCV/lToodmPtLZdHgbC2bq0LFb6wowsISVe1eSk0ID/
         6HBYz0VC14vklab2Dw2NcD6Q2PawPspJGlQZQXeRzgJi9qbh6m128hnkTBOJGqMjp+5G
         Qf1p81C6dxKJJwIAMoDrzso7c7z53hNoSO6YV8KcilINlrW41827KgCamHYL5x6oMo8o
         Moyj5p8O1YyCToxalMbDOkX4PPYTYBTGLwT71sRvV8+goACNh7mS0xTzCuO/e3s9e25G
         WbFw==
X-Gm-Message-State: ABuFfohmcFNEuS5oUOo+7KVc1SKpwJ30OSInq40RzoSJf5CSbflFFTxx
        gaTQ842nwhi0g8mlRYRLA88=
X-Google-Smtp-Source: ACcGV63GSQF0IlhstPPYdQVBeoWbpTwcOtsIhEo4tMkQBv9LsL092yev/zMTL9Ur0f0qMUEUsnbb6g==
X-Received: by 2002:a1c:1694:: with SMTP id 142-v6mr18366094wmw.113.1540255653625;
        Mon, 22 Oct 2018 17:47:33 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id v184-v6sm9788275wme.3.2018.10.22.17.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 17:47:32 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH RFC] x86: Don't include '-Wa,-' when building with Clang
Date:   Mon, 22 Oct 2018 17:37:26 -0700
Message-Id: <20181023003725.21463-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 77b0bf55bc67 ("kbuild/Makefile: Prepare for using macros in
inline assembly code to work around asm() related GCC inlining bugs")
added this flag to KBUILD_CFLAGS, where it works perfectly fine with
GCC. However, when building with Clang, all of the object files compile
fine but the build hangs indefinitely at init/main.o, right before the
linking stage. Don't include this flag when building with Clang.

The kernel builds and boots to a shell in QEMU with both GCC and Clang
with this patch applied.

Link: https://github.com/ClangBuiltLinux/linux/issues/213
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

The reason this patch is labeled RFC is while I can verify that this
fixes the issue, I'm not entirely sure why the '-Wa,-' works for GCC
and not Clang. I looked into what the flag means and I couldn't really
find anything so I just assume it's taking input from stdin? The issue
could stem from how GCC forks gas versus how Clang does it. If this
isn't of concern and the maintainers are happy with this patch as is,
feel free to take it.

 arch/x86/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 5b562e464009..4736dcc1caec 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -239,7 +239,10 @@ archheaders:
 archmacros:
 	$(Q)$(MAKE) $(build)=arch/x86/kernel arch/x86/kernel/macros.s
 
-ASM_MACRO_FLAGS = -Wa,arch/x86/kernel/macros.s -Wa,-
+ASM_MACRO_FLAGS = -Wa,arch/x86/kernel/macros.s
+ifneq ($(cc-name),clang)
+ASM_MACRO_FLAGS += -Wa,-
+endif
 export ASM_MACRO_FLAGS
 KBUILD_CFLAGS += $(ASM_MACRO_FLAGS)
 
-- 
2.19.1

