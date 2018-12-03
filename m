Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24608C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE4220672
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="gYi/FM64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE4220672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbeLCHvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 02:51:47 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:60224 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeLCHvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 02:51:45 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id wB37p4O7009296;
        Mon, 3 Dec 2018 16:51:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wB37p4O7009296
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543823468;
        bh=/bkD1AaEj77ORfzeA5lP0B9fBeG7hxBuHP/+JIDuorc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gYi/FM64UmEWhru1vPEsWksgX7+4FHQ/yeM0vaw/7w4qb0I0gZvTdsvNSo3eqWcua
         xqA9aSeYGR3iM4RMZysWfwtFtqDZKyzMVPB8qw4vgRa7C/dqHu5bTcrgxYEsXFrJVd
         JdcNRQxDjrbdxST93V4SQpssHnUFh2VJclPjJ1JHnFDrMFZ/1bnyUhC26ANl1dUEg2
         MdMw3AO6RAF/55ZBRx6ALj1KqBFEYlsd6vlC7GhW8PigLdHkF7xGaKJOsjgaWxlENs
         h75chG7rpwz/pMkMPDNIqWehKGUH7NmLRY2QoM1YwdFRLdDxuSX92ZAk4J0QZCUvLP
         sD+umS9WKn3HA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Michal Simek <monstr@monstr.eu>
Cc:     linux-kbuild@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] microblaze: fix race condition in building boot images
Date:   Mon,  3 Dec 2018 16:50:56 +0900
Message-Id: <1543823457-32478-7-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
References: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I fixed a race condition in the parallel building of ARM in commit
3939f3345050 ("ARM: 8418/1: add boot image dependencies to not
generate invalid images").

I see the same problem for MicroBlaze too.

"make -j<N> ARCH=microblaze all linux.bin.ub" results in a broken build
since two threads descend into arch/microblaze/boot simultaneously.

Add proper dependencies to avoid it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/microblaze/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
index 7a5df02..544796d 100644
--- a/arch/microblaze/Makefile
+++ b/arch/microblaze/Makefile
@@ -79,13 +79,15 @@ all: linux.bin
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
 
+linux.bin.ub linux.bin.gz: linux.bin
+
 PHONY += linux.bin linux.bin.gz linux.bin.ub
 linux.bin linux.bin.gz linux.bin.ub: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 	@echo 'Kernel: $(boot)/$@ is ready' ' (#'`cat .version`')'
 
 PHONY += simpleImage.$(DTB)
-simpleImage.$(DTB): vmlinux
+simpleImage.$(DTB): linux.bin.ub
 	$(Q)$(MAKE) $(build)=$(boot) simple_images
 	@echo 'Kernel: $(boot)/$@ is ready' ' (#'`cat .version`')'
 
-- 
2.7.4

