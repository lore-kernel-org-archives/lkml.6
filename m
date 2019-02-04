Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B106AC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF182147A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="QzXIrhW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbfBDJLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:11:35 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:19831 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfBDJLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 04:11:35 -0500
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Feb 2019 04:11:33 EST
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x149B3dD005281;
        Mon, 4 Feb 2019 18:11:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x149B3dD005281
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549271464;
        bh=XzPk4zZ7cIQxJU5LknCfKO75cJienGDZnk54W3rrB5U=;
        h=From:To:Cc:Subject:Date:From;
        b=QzXIrhW2S21k72/cjZV5gRYnPif+T1FmiQXwptSQIIoVN7uF9UDWpNtdECvyNhIaR
         f0tWVAIal8T8v+5XPQph4xd1XzlaPoF+dofGD9JYPxKC/k9CB+TA2XrZZPCDBp11Gu
         UCYb2Pwl2OXZpdToREXcQZh/K44oWzxlBOP49iu6G0U2L4WkSeuTjl3qktsnjPyE6L
         icPdeeKZeTvBZCjUU1ZzZqe5wMte4z5LReemWoyJkasLLYRxFMqlljcQhMBX3qv0c/
         77lpcpzlEg4pfUKE2e2nWvMOka9UdEHA+W4+g5T5MY12CGInLNNebriai3fO1s93ek
         I/Brj085a5j0A==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-sh@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org, Rich Felker <dalias@libc.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2] sh: fix build error for invisible CONFIG_BUILTIN_DTB_SOURCE
Date:   Mon,  4 Feb 2019 18:10:55 +0900
Message-Id: <1549271455-19292-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I fixed a similar build error in commit 1b1e4ee86e00 ("sh: fix build
error for empty CONFIG_BUILTIN_DTB_SOURCE"), but it came back again.

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
when CONFIG_OF_EARLY_FLATTREE=y. If CONFIG_USE_BUILTIN_DTB is disabled,
CONFIG_BUILTIN_DTB_SOURCE is invisible instead of defined as "".

Add obj-$(CONFIG_USE_BUILTIN_DTB) guard to avoid the attempt to build
the non-existing file.

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


Changes in v2:
  - Change the subject a bit because the cause of the error is different

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

