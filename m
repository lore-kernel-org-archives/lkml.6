Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2C7C3279B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9760924075
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="D3NedPtz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9760924075
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753190AbeGECs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 22:48:56 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:51109 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752970AbeGECsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 22:48:55 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w652mOP5008929;
        Thu, 5 Jul 2018 11:48:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w652mOP5008929
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530758905;
        bh=L4dPtSttjxtasaQ4iZCG0mt9I75T77RHuVpk2GSomLI=;
        h=From:To:Cc:Subject:Date:From;
        b=D3NedPtz1Wrr/AiwZqbHBdahcyhx6zEDh2wk83RllcZXUpVEJJnoSTnDFT//PUhiN
         wLDxIktMzESB2vk7f8pe8s+13ekABEA7S4F2YpcC/L5K3ZVqvv2HFnoPOG3mr7ZxHe
         4omUrVm6v6MrbRFtq00OPxR2bP0UaXfSbqIse/aC1qGTmycgkiizQw03sVQa5eaQbA
         OXNXBRnvGBqVlgFcVGfPMybsLsSwlTSyk2YIVOKkV04ZVETX6f4/fohgdghZmGouYL
         DolzCL03GWFcgzkTXlDGeGvpuh+Ch6/VEvWW5oNtI1fdUh8QvEtEFuE8E7Fg5/2bxl
         SG1woAWGRpocQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: do not drop -I without parameter
Date:   Thu,  5 Jul 2018 11:48:21 +0900
Message-Id: <1530758901-32014-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment line for addtree says "skip if -I has no parameter".

What it actually does is "drop if -I has no parameter".  For example,
if you have the compiler flag '-I foo' (a space between), it will be
converted to 'foo'.  This completely changes the meaning.

What we want is, "do nothing" for -I without parameter so that
'-I foo' is kept as-is.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Kbuild.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index b2d14f1..ed303f5 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -214,7 +214,7 @@ hdr-inst := -f $(srctree)/scripts/Makefile.headersinst obj
 # Prefix -I with $(srctree) if it is not an absolute path.
 # skip if -I has no parameter
 addtree = $(if $(patsubst -I%,%,$(1)), \
-$(if $(filter-out -I/% -I./% -I../%,$(1)),$(patsubst -I%,-I$(srctree)/%,$(1)),$(1)))
+$(if $(filter-out -I/% -I./% -I../%,$(1)),$(patsubst -I%,-I$(srctree)/%,$(1)),$(1)),$(1))
 
 # Find all -I options and call addtree
 flags = $(foreach o,$($(1)),$(if $(filter -I%,$(o)),$(call addtree,$(o)),$(o)))
-- 
2.7.4

