Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13794C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0FF20672
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="04NndtQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF0FF20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbeLCHwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 02:52:14 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:60442 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbeLCHvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 02:51:53 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id wB37p4O8009296;
        Mon, 3 Dec 2018 16:51:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wB37p4O8009296
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543823469;
        bh=XuSq2PAyWJ8SgmLhjLsNRYQS3C416oLEGtt8Uth20Ws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=04NndtQRfn4Vvm379KZRYQyu4MK14Ijbe2qNkcqGdnRPsy5kp2Q15g70bWu42T6BW
         PcHvZyDCLiFseO6EGGwFCGXC+GQamCYTZgXZagRiE7Y15PUleK3zLehToQc95MuyUP
         xwWA/NpwqFsencduPmhhTvakyZ7Q21bLFGz8TTnhpmC9nEVrmeLkwAJ9EqH6VZg5e1
         E2081oIsFdTvME92rIllLNtwsfj15ZJILi6wQXvDqfEiENu2hGMVIDPCd7OnmYoP5E
         PCOG9hMkczMVKcLMHlPMc6hW2zMp4nTy9Y1APwD/Tc4Ewo0MbFMxJL7xMrjIr6Dbbe
         4qcs8YH2RgHHQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Michal Simek <monstr@monstr.eu>
Cc:     linux-kbuild@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] microblaze: remove the unneeded code just in case file copy fails
Date:   Mon,  3 Dec 2018 16:50:57 +0900
Message-Id: <1543823457-32478-8-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
References: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I guess

    || (rm -f $@ && echo false)

... should be

    || (rm -f $@ && false)

since printing the string "false" on the console has no point.

Moreover, no Makefile needs to delete a target on error explicitly
since commit 9c2af1c7377a ("kbuild: add .DELETE_ON_ERROR special
target").

Reuse equivalent cmd_shipped from scripts/Makefile.lib.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/microblaze/boot/dts/Makefile | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/microblaze/boot/dts/Makefile b/arch/microblaze/boot/dts/Makefile
index c7324e7..ef00dd3 100644
--- a/arch/microblaze/boot/dts/Makefile
+++ b/arch/microblaze/boot/dts/Makefile
@@ -12,12 +12,9 @@ $(obj)/linked_dtb.o: $(obj)/system.dtb
 # Generate system.dtb from $(DTB).dtb
 ifneq ($(DTB),system)
 $(obj)/system.dtb: $(obj)/$(DTB).dtb
-	$(call if_changed,cp)
+	$(call if_changed,shipped)
 endif
 endif
 
-quiet_cmd_cp = CP      $< $@$2
-	cmd_cp = cat $< >$@$2 || (rm -f $@ && echo false)
-
 # Rule to build device tree blobs
 DTC_FLAGS := -p 1024
-- 
2.7.4

