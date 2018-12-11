Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29832C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18AA20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="QnxwKuqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18AA20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbeLKMCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:02:13 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:34042 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeLKMCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:02:11 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wBBC1w9a007779;
        Tue, 11 Dec 2018 21:02:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wBBC1w9a007779
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544529721;
        bh=pcU+erkhIq5EpFhj6n6ekH67ypKiRSokNmokWp7Wk0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QnxwKuqn65ZDAAJkRsbsw8nuFm8NHD3cIWJjpK00cHKn0syj5pvPVWmmf3tpUQ11t
         17wLK1Ke/wQebsxk7544ryDkbVw2m1IS7900pCANQIAfHL7gzWupOLsEO1qyZwjj6u
         1PaZvZiK8AIyH+Vb1hSc/ujFC91/XdDDvWZU5pSTlkcvFJIKx7JvsdEq6Q8jARxypE
         qqZcS8f83oJwCllJxeMqG7mVnVcpHoWF8JrzMihMu80XcY7hdBQeSZcoOmAhLBKZh0
         FFWVBWfBXGhAMEmxC54lUuiiNBLQj5RloduMtdTfy6od3mtQX1LN05ETOwOUpt8fbj
         ZgnetS9dhDqLg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] kbuild: handle part-of-module correctly for *.ll and *.symtypes
Date:   Tue, 11 Dec 2018 21:01:56 +0900
Message-Id: <1544529716-4917-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544529716-4917-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544529716-4917-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The single targets *.ll and *.symtypes never treated as a module.
Fix this.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 321b5b7..795fedc 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -94,7 +94,7 @@ endif
 # ---------------------------------------------------------------------------
 
 # Default is built-in, unless we know otherwise
-$(foreach x, i lst o s, $(patsubst %.o,%.$(x),$(real-obj-m))): \
+$(foreach x, i ll lst o s symtypes, $(patsubst %.o,%.$(x),$(real-obj-m))): \
 	part-of-module := y
 
 modkern_cflags =                                          \
-- 
2.7.4

