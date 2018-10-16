Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74872C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 291582089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIuzZdDW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 291582089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbeJPKDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 06:03:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36316 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbeJPKDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 06:03:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id y16so23517795wrw.3;
        Mon, 15 Oct 2018 19:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gOyXkJDnSlE3gpqkeJtz41TDcg6ukRD3sVQtk2uyz/Y=;
        b=KIuzZdDWEBqkVcEfH75CpxteTqignt85PVwVHZFP/ih8+Uf7k35+bCbFmpAmaNhxOV
         3dtDi2aShNIWAchCyS3aEOGDcCcqaws3mPro9uIMsy1KiLvi7O+riX3ujukdiYM3V7KO
         4GVVv3N83ZxF7koVENee97tKXFn6bG17eu5rbs99WkhaOhkr3ZAVqdGkXbwt18J+ll81
         BtpvE5+gjfw3tNPAtNOPExwhKKElikalC3L9WwyT+F4vz2sN3sKDO/ys1DAvPGI1/2D6
         U18lWdp6LwiqXm+5SaJSGInhU1XzxgLuuXKS6oL+2ZCt1R0m7WD2xeZta1umJEXuMOUf
         HscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gOyXkJDnSlE3gpqkeJtz41TDcg6ukRD3sVQtk2uyz/Y=;
        b=TpMdfXPI3z08pSBm3L2yIrFNeIcdpLD8syiEDDIOGfpQ9ElOlpCQj0QO3ojytpWT9F
         WQAxnZn0flAZW3IMZ/oeMB4Xmry3D1SOJ+zkzVLh+b9cTnPRruviw5uJNEwn7WrdhWVC
         J8DqIVbMtYJjpsmPjPrkvWBt6gMsh8+YCDtvSRGZAkDGEmJWSI6FWaZzmrv/jD/n9AMu
         SGDkH61xUKGZVfKRnfZZZ1U/DDq5qxk+6/xbtY288goE0iYxaShaMw6jotNI3q503LFd
         pO1SJAZWpwQB1nj56XSyb25N5o7XmUWqDFNoFaX4vb1vPbXh7sFWXoQTNLiWgM6P4AO+
         TBOA==
X-Gm-Message-State: ABuFfoi8rT6egCdA7gA4rIrLbWLVrSa0r3H0bxhWt/nyGSwSQkAG+DMN
        L2nJHdgE0YlBGLpOrdf+OPk=
X-Google-Smtp-Source: ACcGV60ibUhjharNiu3d62xk5iGDcJdF6XACLBtfY0HzRBh86u6t6XgQ2LPASOrwU3w1tqeqy0Rd7Q==
X-Received: by 2002:a5d:6748:: with SMTP id l8-v6mr15483236wrw.197.1539656143833;
        Mon, 15 Oct 2018 19:15:43 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 203-v6sm10383570wmn.34.2018.10.15.19.15.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 19:15:43 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] Kbuild: Hide Clang's -Wempty-body behind W=1
Date:   Mon, 15 Oct 2018 19:14:55 -0700
Message-Id: <20181016021454.11953-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are only a few instances of this warning in an arm64 allyesconfig
build but none of them appear useful. I believe the intention of the
warning is to avoid situations like this:

if (condition);
        statement;

where the user really intended

if (condition)
        statement;

However, these instances have already been caught by GCC's warning about
misleading indentation so the remaining warnings are about loops that
fall into one of three categories:

1. Execute a function unconditionally (avoiding a useless variable to
   hold the return value):

drivers/isdn/hisax/hfc_pci.c:131:34: warning: if statement has empty body
[-Wempty-body]
        if (Read_hfc(cs, HFCPCI_INT_S1));
                                        ^

2. Advancing a value to be used later on in the function like a pointer
   or a count:

drivers/atm/eni.c:244:48: warning: for loop has empty body
[-Wempty-body]
        for (order = 0; (1 << order) < *size; order++);
                                                      ^

3. Busy waiting:

drivers/atm/zatm.c:513:7: warning: while loop has empty body
[-Wempty-body]
        zwait;
             ^

None of these uses are problematic or need to be addressed. Clang
suggests moving the semi-colon to the next line to silence these
warnings but that defeats the purpose of the compact nature of these
constructs so just hide the warning behind W=1 so its use can still be
audited but it won't polute a regular build.

Link: https://github.com/ClangBuiltLinux/linux/issues/42
Link: https://github.com/ClangBuiltLinux/linux/issues/66
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 scripts/Makefile.extrawarn | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index cf6cd0ef6975..8709d9d6faf1 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -11,6 +11,7 @@
 # are not supported by all versions of the compiler
 # ==========================================================================
 
+KBUILD_CFLAGS += $(call cc-disable-warning, empty-body)
 KBUILD_CFLAGS += $(call cc-disable-warning, packed-not-aligned)
 
 ifeq ("$(origin W)", "command line")
@@ -32,6 +33,7 @@ warning-1 += $(call cc-option, -Wpacked-not-aligned)
 warning-1 += $(call cc-option, -Wstringop-truncation)
 warning-1 += $(call cc-disable-warning, missing-field-initializers)
 warning-1 += $(call cc-disable-warning, sign-compare)
+warning-1 += $(call cc-option, -Wempty-body)
 
 warning-2 := -Waggregate-return
 warning-2 += -Wcast-align
-- 
2.19.1

