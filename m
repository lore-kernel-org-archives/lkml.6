Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC742C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A255E20817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXHSoAns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A255E20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbeKZVrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:47:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:56262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbeKZVrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:47:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9149920817;
        Mon, 26 Nov 2018 10:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229651;
        bh=77rtFgs82BiWNpE7TNqtEshHwHI04rzENm2iK2P/csI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iXHSoAnsa4jD0DmrVBFzRriI38Y0U+RQZ4/V4+v3DMw6fxTHgmEE039lpFilZTU6A
         YtuEiBVmPZ8o8/vIg8B/Wm7doiqSRTy3hvrHMSvK9ik4GuWU2GSisIuj6qXnjNjvdT
         8vdq5JAuyb/kaktzZ0YlwlSJ3VwkSKmQg/LzXRVw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 20/70] kbuild: fix linker feature test macros when cross compiling with Clang
Date:   Mon, 26 Nov 2018 11:50:35 +0100
Message-Id: <20181126105048.780330753@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105046.722096341@linuxfoundation.org>
References: <20181126105046.722096341@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nick Desaulniers <ndesaulniers@google.com>

commit 86a9df597cdd564d2d29c65897bcad42519e3678 upstream.

I was not seeing my linker flags getting added when using ld-option when
cross compiling with Clang. Upon investigation, this seems to be due to
a difference in how GCC vs Clang handle cross compilation.

GCC is configured at build time to support one backend, that is implicit
when compiling.  Clang is explicit via the use of `-target <triple>` and
ships with all supported backends by default.

GNU Make feature test macros that compile then link will always fail
when cross compiling with Clang unless Clang's triple is passed along to
the compiler. For example:

$ clang -x c /dev/null -c -o temp.o
$ aarch64-linux-android/bin/ld -E temp.o
aarch64-linux-android/bin/ld:
unknown architecture of input file `temp.o' is incompatible with
aarch64 output
aarch64-linux-android/bin/ld:
warning: cannot find entry symbol _start; defaulting to
0000000000400078
$ echo $?
1

$ clang -target aarch64-linux-android- -x c /dev/null -c -o temp.o
$ aarch64-linux-android/bin/ld -E temp.o
aarch64-linux-android/bin/ld:
warning: cannot find entry symbol _start; defaulting to 00000000004002e4
$ echo $?
0

This causes conditional checks that invoke $(CC) without the target
triple, then $(LD) on the result, to always fail.

Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
[nc: Fix conflicts due to lack of commit 3298b690b21cd in linux-4.4.y
     Use KBUILD_CFLAGS instead of CC_OPTION_FLAGS because commit
     d26e94149276f that introduced that variable isn't in 4.4 either]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/Kbuild.include |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -147,12 +147,13 @@ cc-ifversion = $(shell [ $(cc-version) $
 # cc-ldoption
 # Usage: ldflags += $(call cc-ldoption, -Wl$(comma)--hash-style=both)
 cc-ldoption = $(call try-run,\
-	$(CC) $(1) -nostdlib -x c /dev/null -o "$$TMP",$(1),$(2))
+	$(CC) $(1) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -nostdlib -x c /dev/null -o "$$TMP",$(1),$(2))
 
 # ld-option
 # Usage: LDFLAGS += $(call ld-option, -X)
 ld-option = $(call try-run,\
-	$(CC) -x c /dev/null -c -o "$$TMPO" ; $(LD) $(1) "$$TMPO" -o "$$TMP",$(1),$(2))
+	$(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -x c /dev/null -c -o "$$TMPO"; \
+	$(LD) $(LDFLAGS) $(1) "$$TMPO" -o "$$TMP",$(1),$(2))
 
 # ar-option
 # Usage: KBUILD_ARFLAGS := $(call ar-option,D)


