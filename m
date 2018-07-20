Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E8FECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299E720850
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="l3xg9h8e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299E720850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeGTIe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:34:57 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:28419 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbeGTIe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:34:57 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w6K7kdj2008048;
        Fri, 20 Jul 2018 16:46:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w6K7kdj2008048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532072806;
        bh=jDNKqUuLzwnkvVwfACbXbAwZGNLvx4EVw6xRbAj0t/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l3xg9h8eBW6BDpqghTyEn9aAAh6RLEQgf5k5e+GQgHfzHy1QZkuhHeQweBrx/9lCe
         UijafqbgrnZpY3Or/WVOd0QOAVHaYfy4Ah22G9gHfuPB4ixDd+OwbAlX4GdH5FhH8i
         UsJuZKFdf4Ymwfewzchruad9WWMO+tatMGVbrE1vggYLGXjCZrOgn0QoLmLVevP/4/
         pjz+tadZTbEbLGLAi/T6fl17djU19/Spe0iYXUmsfgbVo8rSMNRZfYlz4lG6J2Vjm7
         INa/a41gUa0MkjQAjjKBjSRTpdxU27RuAviyngHCBfte/eihbd16vfd4brDhdiJKtk
         X1r6UpdmG1mSA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/11] kbuild: do not update config for 'make kernelrelease'
Date:   Fri, 20 Jul 2018 16:46:35 +0900
Message-Id: <1532072796-7947-11-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532072796-7947-1-git-send-email-yamada.masahiro@socionext.com>
References: <1532072796-7947-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'make kernelrelease' depends on CONFIG_LOCALVERSION(_AUTO), but
for the same reason as install targets, we do not want to update
the configuration just for printing the kernelrelease string.

This is likely to happen when you compiled the kernel with
CROSS_COMPILE, but forget to pass it to 'make kernelrelease'.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v4: None

 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index ad83917..0ec1c27 100644
--- a/Makefile
+++ b/Makefile
@@ -225,7 +225,8 @@ no-dot-config-targets := $(clean-targets) \
 			 cscope gtags TAGS tags help% %docs check% coccicheck \
 			 $(version_h) headers_% archheaders archscripts \
 			 kernelversion %src-pkg
-no-sync-config-targets := $(no-dot-config-targets) install %install
+no-sync-config-targets := $(no-dot-config-targets) install %install \
+			   kernelrelease
 
 config-targets  := 0
 mixed-targets   := 0
-- 
2.7.4

