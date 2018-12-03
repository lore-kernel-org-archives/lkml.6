Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A97C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD512145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="co1Q0A6S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AD512145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbeLCHvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 02:51:45 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:60228 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbeLCHvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 02:51:45 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id wB37p4O2009296;
        Mon, 3 Dec 2018 16:51:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wB37p4O2009296
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543823465;
        bh=dCLplUBM+3R1bEdXjczaPed5zfwez0ZYRnU/1stqcvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=co1Q0A6S09DDXYdLbai/ARiMGRuDBTzjrztRh3tKnHV6lLzqM+7p1ZW8uykqIeZ3B
         Z5mSPpNSOtsMDChV2kO+V+DrN1/CXWePoZxwg3+aLsjiqLsWzVLZMAp0ZkTDkOgMTT
         +EEYd22lpK/IJVIwWYc1SVxNdMMoHRD+gazX31L+x71aB/lUu0NrSgscWkazKAiA+s
         DpqyMwt8Y2AdzjhHCTxj4nonDzbhGwjyGKuZWYgwL6yWs+8MGOUaQLbhdFq6FIcITn
         j6ZrkxQOd3Ps07Fvz3rW0vIdoMZISub/EIbG7kKPtRONjIYal+yTdNgvPd3toJenjK
         hL5OIO32hYfSQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Michal Simek <monstr@monstr.eu>
Cc:     linux-kbuild@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] microblaze: fix cleaning of boot images
Date:   Mon,  3 Dec 2018 16:50:51 +0900
Message-Id: <1543823457-32478-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
References: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The simpleImage.<dt> target generates the following files:

  arch/microblaze/boot/simpleImage.<dt>
  arch/microblaze/boot/simpleImage.<dt>.ub
  arch/microblaze/boot/simpleImage.<dt>.strip
  arch/microblaze/boot/simpleImage.<dt>.unstrip

However, "make ARCH=microblaze clean" only cleans up the unstrip
image. Fix the clean-files to take care of all the four.

Adding linux.bin.ub to clean-files is redundant because it is
already added into "targets".

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/microblaze/boot/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/boot/Makefile b/arch/microblaze/boot/Makefile
index 600e5a1..e8684a2 100644
--- a/arch/microblaze/boot/Makefile
+++ b/arch/microblaze/boot/Makefile
@@ -37,4 +37,4 @@ $(obj)/simpleImage.%: vmlinux FORCE
 	$(call if_changed,strip,.strip)
 	@echo 'Kernel: $(UIMAGE_OUT) is ready' ' (#'`cat .version`')'
 
-clean-files += simpleImage.*.unstrip linux.bin.ub
+clean-files += simpleImage.*
-- 
2.7.4

