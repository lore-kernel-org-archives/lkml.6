Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0498DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A4320817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2mWZXyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A4320817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbeKZVtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:49:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:57982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbeKZVtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:49:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CF192089F;
        Mon, 26 Nov 2018 10:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229724;
        bh=VlzQdNDX0XuOBPnDpM4SI5xfFn5RC00AAbsrMEjB9FY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S2mWZXyVIuGXPtNF+z1MzpDEXn+xv3Vt1/fP43334GKwiVIUTt0UORvjbMn9NoN0d
         Pu0l9pGmksbH8fE/Tt0r03oyhXPjJxzR6PJ9Lvc8lETPDtM7aPDWGWcuS1Ge+ACEkU
         O9MnL298BxWwDfDjKNoB/PZ8dRNrikdZi9Ji5vMI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Charlebois <charlebm@gmail.com>,
        Behan Webster <behanw@converseincode.com>,
        =?UTF-8?q?Jan-Simon=20M=C3=B6ller?= <dl9pf@gmx.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 12/70] kbuild, LLVMLinux: Add -Werror to cc-option to support clang
Date:   Mon, 26 Nov 2018 11:50:27 +0100
Message-Id: <20181126105048.064487973@linuxfoundation.org>
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

From: Mark Charlebois <charlebm@gmail.com>

commit c3f0d0bc5b01ad90c45276952802455750444b4f upstream.

Clang will warn about unknown warnings but will not return false
unless -Werror is set. GCC will return false if an unknown
warning is passed.

Adding -Werror make both compiler behave the same.

[arnd: it turns out we need the same patch for testing whether -ffunction-sections
       works right with gcc. I've build tested extensively with this patch
       applied, so let's just merge this one now.]

Signed-off-by: Mark Charlebois <charlebm@gmail.com>
Signed-off-by: Behan Webster <behanw@converseincode.com>
Reviewed-by: Jan-Simon Möller <dl9pf@gmx.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
[nc: Adjust context due to lack of d26e94149276f]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/Kbuild.include |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -112,12 +112,12 @@ as-instr = $(call try-run,\
 # Usage: cflags-y += $(call cc-option,-march=winchip-c6,-march=i586)
 
 cc-option = $(call try-run,\
-	$(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) $(1) -c -x c /dev/null -o "$$TMP",$(1),$(2))
+	$(CC) -Werror $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) $(1) -c -x c /dev/null -o "$$TMP",$(1),$(2))
 
 # cc-option-yn
 # Usage: flag := $(call cc-option-yn,-march=winchip-c6)
 cc-option-yn = $(call try-run,\
-	$(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) $(1) -c -x c /dev/null -o "$$TMP",y,n)
+	$(CC) -Werror $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) $(1) -c -x c /dev/null -o "$$TMP",y,n)
 
 # cc-option-align
 # Prefix align with either -falign or -malign
@@ -127,7 +127,7 @@ cc-option-align = $(subst -functions=0,,
 # cc-disable-warning
 # Usage: cflags-y += $(call cc-disable-warning,unused-but-set-variable)
 cc-disable-warning = $(call try-run,\
-	$(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -W$(strip $(1)) -c -x c /dev/null -o "$$TMP",-Wno-$(strip $(1)))
+	$(CC) -Werror $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -W$(strip $(1)) -c -x c /dev/null -o "$$TMP",-Wno-$(strip $(1)))
 
 # cc-name
 # Expands to either gcc or clang


