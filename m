Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EFCC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5D820892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="pfPV1Ut1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5D820892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbeLGLen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 06:34:43 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:45963 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeLGLem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 06:34:42 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wB7BY6rh020070;
        Fri, 7 Dec 2018 20:34:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wB7BY6rh020070
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544182450;
        bh=KCjsuzrFx2wg6Gb74nuWaE7EsmARAPFNbSOugl+oRTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pfPV1Ut1bR4IXnGwf+6EIt1LbiqTyb5LbVKnf7+K0eZUCgtoMPjQCO6mOLX4T2QV7
         7k6JZOcwwnaURvchhtm3B9KDlnSLh72JME1xtEAN3A0Cz5PbsuK1YNfV4FDhQwf2UR
         KzvteyUmcvxIF8101kmv53rJyPU1MTK6XmZHhU1VuF3i3gJzVl/fm9o/DbI3qoBcEe
         ULSqWRdHwbneq2BBbsIS7ICIXjTocnCt0pBVazajm5PAja4lbJuI9HGeaxGHgyqv4c
         Mzx18+rMIP0H50ieZiY3vzF8mekSZNPM6DFIWMe3RnjGR0hByvWQwNG0doajVJPFYp
         ijWK7318OezPQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Michal Simek <monstr@monstr.eu>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] microblaze: remove the explicit removal of system.dtb
Date:   Fri,  7 Dec 2018 20:33:57 +0900
Message-Id: <1544182437-26660-7-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544182437-26660-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544182437-26660-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I guess

    || (rm -f $@ && echo false)

... should be

    || (rm -f $@ && false)

In fact, no Makefile needs to delete a target explicitly on error.

It is automatically done since commit 9c2af1c7377a ("kbuild: add
.DELETE_ON_ERROR special target").

I also reused equivalent cmd_shipped from scripts/Makefile.lib.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

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

