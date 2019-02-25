Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C4BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3DB62147C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129328;
	bh=4p7FLSB6JvF04Z/oTslA3dYnuowtUlaZ/8wisrOAvrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nYlbhXUWZu4rRD1lYm9K4K6rMgvhiWao+Gi/9TDLL0ZSFZu9MjDdisXGGHi04/bqV
	 wBJNE/DP7/55n5mKQgKdDvfQrPBz6SDSLl/eNY4Xd8YmvWt04MP9UL7K6MXXNZ4ApD
	 tUp46IHXdvTj6tSjxTZJQ4d8vEXYpCrX+ieh+amI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbfBYVP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:15:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:46580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728954AbfBYVPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:15:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 859492147C;
        Mon, 25 Feb 2019 21:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129324;
        bh=4p7FLSB6JvF04Z/oTslA3dYnuowtUlaZ/8wisrOAvrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q99FyY3mg55oD0lJ3ovvPVLLBkDuXpshEfaXPpesNNWgLj7Jh92baZfq2i0gnARDh
         UHF+hdHUpF1/ULMDRzf8dYtE9sXKyiVYtxCz9ODL81m8lkMxjMuhbK3nMofd6aaJ40
         Qv/KsSch3cv+UekxJFIB2jeINj4AvcSwMDDlxXV0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 51/63] kbuild: clang: remove crufty HOSTCFLAGS
Date:   Mon, 25 Feb 2019 22:11:51 +0100
Message-Id: <20190225195039.734781072@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195035.713274200@linuxfoundation.org>
References: <20190225195035.713274200@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
[nc: Backport to 4.9; adjust context]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Makefile |    5 -----
 1 file changed, 5 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -306,11 +306,6 @@ HOSTCXX      = g++
 HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer -std=gnu89
 HOSTCXXFLAGS = -O2
 
-ifeq ($(shell $(HOSTCC) -v 2>&1 | grep -c "clang version"), 1)
-HOSTCFLAGS  += -Wno-unused-value -Wno-unused-parameter \
-		-Wno-missing-field-initializers -fno-delete-null-pointer-checks
-endif
-
 # Decide whether to build built-in, modular, or both.
 # Normally, just do built-in.
 


