Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96FEC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F712145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="EH0dGTpS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F712145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbeLCHvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 02:51:45 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:60227 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbeLCHvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 02:51:45 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id wB37p4O6009296;
        Mon, 3 Dec 2018 16:51:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wB37p4O6009296
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543823468;
        bh=FqpO5zyD2YzdwZn60QrxTfZLs1HKycrr9Un4ocfeCp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EH0dGTpSvfi7tLAoqRthaOukjr3aF6e5c12jc0poD3DMKbnmLQaMmEpwea5mygBTo
         SlqFCaNd7+9WMnwKtBFIBRHr6AHKlyOltByXcWVAy8sJiyMr8xwenYXw+Ap+og7Q3h
         Bf230MH+FMvDz4YTdjaAaDvCBZ79X7X9I9igA3paNuEbl9GCpSrOjQ4MpgdWYEMCG9
         Wv49gXnotJ5PVrLcfM/PR1ZgMW+wpnQGRln+PSOGUY3/23Vbjtxb61dqV4pSXnIrf4
         Wd84u+NgbLvWkLd4o7OYlhiAcX6ssZZAqWpV6OTE2+7C0/CWOeIkkgscwasWD7eg5W
         aLjKoRWyTobGg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Michal Simek <monstr@monstr.eu>
Cc:     linux-kbuild@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] microblaze: add linux.bin* and simpleImage.* to PHONY
Date:   Mon,  3 Dec 2018 16:50:55 +0900
Message-Id: <1543823457-32478-6-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
References: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux.bin, linux.bin.gz, and linux.bin.ub are phony targets to
generate a corresponding image under arch/microblaze/boot/.

simpleImage.% also works like a PHONY target, but a pattern that
contains '%' cannot be a PHONY target. I renamed it to equivalent
simpleImage.$(DTB).

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/microblaze/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
index c5d5b0e..7a5df02 100644
--- a/arch/microblaze/Makefile
+++ b/arch/microblaze/Makefile
@@ -79,11 +79,13 @@ all: linux.bin
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
 
+PHONY += linux.bin linux.bin.gz linux.bin.ub
 linux.bin linux.bin.gz linux.bin.ub: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 	@echo 'Kernel: $(boot)/$@ is ready' ' (#'`cat .version`')'
 
-simpleImage.%: vmlinux
+PHONY += simpleImage.$(DTB)
+simpleImage.$(DTB): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) simple_images
 	@echo 'Kernel: $(boot)/$@ is ready' ' (#'`cat .version`')'
 
-- 
2.7.4

