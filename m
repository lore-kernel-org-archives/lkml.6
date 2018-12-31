Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09B9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 08:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2564620B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 08:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="GgqVkxlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbeLaIYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 03:24:34 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:31572 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbeLaIYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 03:24:32 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wBV8OIjs008355;
        Mon, 31 Dec 2018 17:24:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wBV8OIjs008355
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546244662;
        bh=MSX7E/Yr9wKRJPYXLcNN01TdcBq4zxC6Gw6XsUjaLF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GgqVkxlL2rzuH5ZCWkx9kSR2xufulpUA3iFmrIf1SfG9Vp+UrLBTJdafFnHYqsPq1
         w2qrmJE2Slxtlh/schtjztYO5ypfWP+Hj/2c76xAxajTTBqZKCfE2ob9yMqgNlWYzl
         TnwWvcpX5H1kM2xfqQgapag1DMVOPtn1W338TaY5VtWJYlm07gZ4iSAwM5FDXFtgSU
         u9b/ko61kejrLas6I8YyjmR0nw9TDT73Vst4m3WtdILtc5h1sB/3izf+VHsAxLU5u+
         RlE5pNOGKYMJQ8xcjNDenGdbNO9Yz/t0iwqakkQtjHG7r7su5wfV/4aVO06ynO6GzS
         BEDLyE7x/loBQ==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] kbuild: make LINUX_VERSION_CODE in <linux/version.h> more readable
Date:   Mon, 31 Dec 2018 17:24:11 +0900
Message-Id: <1546244651-10447-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546244651-10447-1-git-send-email-yamada.masahiro@socionext.com>
References: <1546244651-10447-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makefile does not need to calculate LINUX_VERSION_CODE.
Let's leave it to the preprocessor.

This commit changes include/generated/uapi/linux/version.h as follows:

Before:

  #define LINUX_VERSION_CODE 267264
  #define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))

After:

  #define LINUX_VERSION_CODE KERNEL_VERSION(4, 20, 0)
  #define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))

The latter is more human-readable in my opinion.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 437d603..1ebf5ed 100644
--- a/Makefile
+++ b/Makefile
@@ -1131,8 +1131,7 @@ define filechk_utsrelease.h
 endef
 
 define filechk_version.h
-	echo \#define LINUX_VERSION_CODE $(shell                         \
-	expr $(VERSION) \* 65536 + 0$(PATCHLEVEL) \* 256 + 0$(SUBLEVEL)); \
+	echo '#define LINUX_VERSION_CODE KERNEL_VERSION($(VERSION), $(PATCHLEVEL), $(SUBLEVEL))'; \
 	echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))'
 endef
 
-- 
2.7.4

