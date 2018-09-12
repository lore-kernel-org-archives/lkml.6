Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE82C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A295120880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="gbYweFDH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A295120880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbeILLr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 07:47:28 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:52570 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeILLr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 07:47:27 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w8C6i7nm032726;
        Wed, 12 Sep 2018 15:44:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w8C6i7nm032726
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536734648;
        bh=Jh0WL1uvZdv8o+kX2QnK3vJ9SIKyOfbJjsmeTOa55NM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gbYweFDHgjroOeHxdMWUrrKTsShT1LSjzP3I4UA0Vz9w5ZeA1Huim7iId6Q1tCMmr
         4bbN9EVf9aXrljyn/FI22F5ga4Ow+RgMTn2/i8D72NxnXGrMty99BpXppVP/y6KBIr
         tEl0DeekxV3fWTHb47BzjLRAIDnT89OWRrPLbCB06PMNnLKUwnLfErcc15YtjfITzQ
         bYotO7w8wTJw9soW2qpK34vqHM4Iwt7okL+nOvUY8G//zDKHRjF+2O3i80dh6ZpmsL
         s0adYJ5grhD6cfFzmQVz1Yud8UQyWL5ciE79djvc/e1axvWkf90Zy0tPzXfS7n5S8d
         Kn1Rw1IOitwSg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] kbuild: remove dead code in cmd_files calculation in top Makefile
Date:   Wed, 12 Sep 2018 15:43:30 +0900
Message-Id: <1536734610-22173-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536734610-22173-1-git-send-email-yamada.masahiro@socionext.com>
References: <1536734610-22173-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nobody sets 'targets' in the top-level Makefile or arch/*/Makefile,
hence $(targets) is empty.

$(wildcard .*.cmd) will do for including the .vmlinux.cmd file.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 4b76e22..8f6dbfc 100644
--- a/Makefile
+++ b/Makefile
@@ -1721,8 +1721,7 @@ cmd_crmodverdir = $(Q)mkdir -p $(MODVERDIR) \
                   $(if $(KBUILD_MODULES),; rm -f $(MODVERDIR)/*)
 
 # read all saved command lines
-
-cmd_files := $(wildcard .*.cmd $(foreach f,$(sort $(targets)),$(dir $(f)).$(notdir $(f)).cmd))
+cmd_files := $(wildcard .*.cmd)
 
 ifneq ($(cmd_files),)
   $(cmd_files): ;	# Do not try to update included dependency files
-- 
2.7.4

