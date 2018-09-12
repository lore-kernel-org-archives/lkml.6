Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB71C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 03:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD8720880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 03:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="qRpaCtGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD8720880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeILIm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 04:42:28 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:27063 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeILIm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 04:42:28 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w8C3dQvK021725;
        Wed, 12 Sep 2018 12:39:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w8C3dQvK021725
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536723566;
        bh=8pnlnNMp5ZvT74QGz1uw/1I2jd9vKv051IV1iHw/KzE=;
        h=From:To:Cc:Subject:Date:From;
        b=qRpaCtGe0mDOiu6XkF0YLWJDRHQufjkmZds88mEbcXGOoAnPwS2pxoUHFrvW1Nb1p
         GDSyGCqQGKEgMGbNa4iZIUiasVLKWPNC7cvlIadMSO78teAde6xOKf3XohDt75brNa
         MpaHVjpk5IO+nAaNHp8povWfDB5+9r4UM4uPSt5A2CfVYKaJ3exqkeroiOqLidMlJo
         euWbxz6jEIWtAYnZOR0cIQFKmgOtVlp1A6JKrDvVo1iSN06/cfuFCbaz9ihjqUWbY7
         hdP7Fr4IsNBEJqcd3Z52GaHb8s/hTCeb64nVJnKwljRm2pnq6qtqUY4PvxWA0RwrOc
         uw/mbV4yAU9Cg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Shannon Nelson <shannon.nelson@oracle.com>,
        linux-kernel@vger.kernel.org, Nick Alcock <nick.alcock@oracle.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] sparc: vdso: clean-up vdso Makefile
Date:   Wed, 12 Sep 2018 12:39:13 +0900
Message-Id: <1536723553-21287-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/sparc/vdso/Makefile is a replica of arch/x86/entry/vdso/Makefile.

Clean-up the Makefile in the same way as I did for x86:

 - Remove unnecessary export
 - Put the generated linker script to $(obj)/ instead of $(src)/
 - Simplify cmd_vdso2c

The corresponding x86 commits are:

 - 61615faf0a89 ("x86/build/vdso: Remove unnecessary export in Makefile")
 - 1742ed2088cc ("x86/build/vdso: Put generated linker scripts to $(obj)/")
 - c5fcdbf15523 ("x86/build/vdso: Simplify 'cmd_vdso2c'")

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/sparc/vdso/Makefile | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index dd0b5a9..dc85570 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -31,23 +31,21 @@ obj-y += $(vdso_img_objs)
 targets += $(vdso_img_cfiles)
 targets += $(vdso_img_sodbg) $(vdso_img-y:%=vdso%.so)
 
-export CPPFLAGS_vdso.lds += -P -C
+CPPFLAGS_vdso.lds += -P -C
 
 VDSO_LDFLAGS_vdso.lds = -m64 -Wl,-soname=linux-vdso.so.1 \
 			-Wl,--no-undefined \
 			-Wl,-z,max-page-size=8192 -Wl,-z,common-page-size=8192 \
 			$(DISABLE_LTO)
 
-$(obj)/vdso64.so.dbg: $(src)/vdso.lds $(vobjs) FORCE
+$(obj)/vdso64.so.dbg: $(obj)/vdso.lds $(vobjs) FORCE
 	$(call if_changed,vdso)
 
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include
 hostprogs-y			+= vdso2c
 
 quiet_cmd_vdso2c = VDSO2C  $@
-define cmd_vdso2c
-	$(obj)/vdso2c $< $(<:%.dbg=%) $@
-endef
+      cmd_vdso2c = $(obj)/vdso2c $< $(<:%.dbg=%) $@
 
 $(obj)/vdso-image-%.c: $(obj)/vdso%.so.dbg $(obj)/vdso%.so $(obj)/vdso2c FORCE
 	$(call if_changed,vdso2c)
-- 
2.7.4

