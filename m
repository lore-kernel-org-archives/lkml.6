Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9AEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDEA21104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtSdh3wd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DDEA21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeKZVsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:48:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:56466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbeKZVsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:48:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A365220817;
        Mon, 26 Nov 2018 10:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229661;
        bh=yghS8yjS2GSmiWSkV1w5Mrhwd+0cd0mAis5l60u8Tjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JtSdh3wdP/DuZjGzpQwn43Fuu4RNty+RZauI26w+lTmgIu/SmRHpqgNcDILW6/zW0
         A7uBATxjQWW+iA11eegIjfHrtUkZ4kE9T1+GGRQUX4acsyi4KQOMSBxJtmSfbL916w
         C4I9OMLbGSAbUudrO8e9SFEwQyjE7AjbWd3xBLmA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 24/70] kbuild: clang: remove crufty HOSTCFLAGS
Date:   Mon, 26 Nov 2018 11:50:39 +0100
Message-Id: <20181126105049.139615921@linuxfoundation.org>
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

From: Nick Desaulniers <nick.desaulniers@gmail.com>

commit df16aaac26e92e97ab7234d3f93c953466adc4b5 upstream.

When compiling with `make CC=clang HOSTCC=clang`, I was seeing warnings
that clang did not recognize -fno-delete-null-pointer-checks for HOSTCC
targets.  These were added in commit 61163efae020 ("kbuild: LLVMLinux:
Add Kbuild support for building kernel with Clang").

Clang does not support -fno-delete-null-pointer-checks, so adding it to
HOSTCFLAGS if HOSTCC is clang does not make sense.

It's not clear why the other warnings were disabled, and just for
HOSTCFLAGS, but I can remove them, add -Werror to HOSTCFLAGS and compile
with clang just fine.

Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
[nc: Adjust context]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Makefile |    5 -----
 1 file changed, 5 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -306,11 +306,6 @@ HOSTCXX      = g++
 HOSTCFLAGS   = -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer -std=gnu89
 HOSTCXXFLAGS = -O2
 
-ifeq ($(shell $(HOSTCC) -v 2>&1 | grep -c "clang version"), 1)
-HOSTCFLAGS  += -Wno-unused-value -Wno-unused-parameter \
-		-Wno-missing-field-initializers -fno-delete-null-pointer-checks
-endif
-
 # Decide whether to build built-in, modular, or both.
 # Normally, just do built-in.
 


