Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A19C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716C6214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="FqsTiXVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbfBDI4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:56:32 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:39829 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfBDI4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:56:31 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x148thNu020312;
        Mon, 4 Feb 2019 17:55:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x148thNu020312
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549270544;
        bh=dBMQG3SSG2E1tFJaJSpKo+VkzYBIHjMFKLjCPYxftJk=;
        h=From:To:Cc:Subject:Date:From;
        b=FqsTiXVKrrFWA+c5bX+qxCRdWtBZi+j8MreLls7UxUqaWiexNGt6p4qI6Mj2p819w
         URJ19+NgbzERtqDumSr/Ar9Zt0OD/NiS+EBGkUPIHfbvbWzZMDE6jIY79v7MLSw5S1
         GyBS59dhtTVwY93NMsayfOvYwRduTumUoWWRHye+zBk6K+tYX6YJEfjPwGLrNjMmhK
         2RZUEODPqUGDmGOOK2xrS/6SDKu4ZX8/Lv8n9K1QwXl6l2qOLOJTeHCH/zDCFIakhR
         DXcG3OZcDaFBoiMClI/e5liKqE8lCpBl5xMuVevy/R9hu8Nx5nQIc9wPIVm8EzV+tU
         cNCW9qZt8l2ew==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-sh@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org, Rich Felker <dalias@libc.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] sh: fix build error for empty CONFIG_BUILTIN_DTB_SOURCE again
Date:   Mon,  4 Feb 2019 17:55:26 +0900
Message-Id: <1549270526-17230-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I fixed this build error in commit 1b1e4ee86e00 ("sh: fix build error
for empty CONFIG_BUILTIN_DTB_SOURCE"), but it came back again.

Since commit 37c8a5fafa3b ("kbuild: consolidate Devicetree dtb
build rules"), the combination of CONFIG_OF_EARLY_FLATTREE=y and
CONFIG_USE_BUILTIN_DTB=n results in the following build error:

make[1]: *** No rule to make target 'arch/sh/boot/dts/.dtb.o', needed by 'arch/sh/boot/dts/built-in.a'.  Stop.
make: *** [Makefile;1727: arch/sh/boot/dts/] Error 2

Prior to that commit, there was only one path to descend into
arch/sh/boot/dts/, and arch/sh/Makefile correctly guards it with
CONFIG_USE_BUILTIN_DTB:

  core-$(CONFIG_USE_BUILTIN_DTB)  += arch/sh/boot/dts/

Now, there is another path to descend there from the top Makefile
when CONFIG_OF_EARLY_FLATTREE=y. Add obj-$(CONFIG_USE_BUILTIN_DTB)
guard in case CONFIG_BUILTIN_DTB_SOURCE is hidden due to the unmet
'depends on'.

Fixes: 37c8a5fafa3b ("kbuild: consolidate Devicetree dtb build rules")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Observant reviewers may point out another problem.
There is a race condition when CONFIG_OF_EARLY_FLATTREE=y.

Some architectures (sh, xtensa, etc.) embed a DTB in vmlinux,
so there are two paths to descend into arch/*/boot/dts/.
For parallel build with -j<N> option, two threads may build
under arch/*/boot/dts/ simultaneously.

Yes, this is a problem, and it is in my TODO list.
For some reasons, I will postpone it by the next development cycle.

For now, I want to fix this sh build error first because kbuild test
robot is still complaining about it.


 arch/sh/boot/dts/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/boot/dts/Makefile b/arch/sh/boot/dts/Makefile
index 01d0f7f..2563d1e 100644
--- a/arch/sh/boot/dts/Makefile
+++ b/arch/sh/boot/dts/Makefile
@@ -1,3 +1,3 @@
 ifneq ($(CONFIG_BUILTIN_DTB_SOURCE),"")
-obj-y += $(patsubst "%",%,$(CONFIG_BUILTIN_DTB_SOURCE)).dtb.o
+obj-$(CONFIG_USE_BUILTIN_DTB) += $(patsubst "%",%,$(CONFIG_BUILTIN_DTB_SOURCE)).dtb.o
 endif
-- 
2.7.4

