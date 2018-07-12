Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BB9C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4CA208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="UJY34Hho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE4CA208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732447AbeGLIMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:12:13 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:56398 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbeGLILp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:11:45 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w6C81cQk012716;
        Thu, 12 Jul 2018 17:01:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w6C81cQk012716
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531382506;
        bh=OW/iguCGS3P8sUTd5gG6WZtTqvjg0ShWICCDmC9kjMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UJY34Hho3d+vt8X7T/YvXP0dG3s7hQR+gvlyuFdVhFZRVTGnt/5nAoDTkIXbqcPPw
         XmKaOsWItfgLnSw0fF06MjFvq2RDXNNqvcQ8KcwsGjki6Wm4VxvjElrtdvz2R0ntrJ
         EfFW3faGY8uIPabGLCQYJt6gYkFda2D2vAoZey1KIOoRg7+eAjrRhmnZKk6RNiLeoW
         IFdafgpoFVt4pJOFAox1nKmjqAbzRve4NbRLpAVp1HXZsVWNTGXdoYAEkKV3VWXld1
         nibTIrZwZQ2tyJPQuRpLChTjSO2NwaxMRvqme4tpphdwpVrIj0sorp7ua9b47ucqp2
         hS35leQOsOsfg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>, x86@kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        openrisc@lists.librecores.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Jeff Dike <jdike@addtoit.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 5/6] kbuild: change ld_flags to contain LDFLAGS_$(@F)
Date:   Thu, 12 Jul 2018 17:01:35 +0900
Message-Id: <1531382496-3719-6-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531382496-3719-1-git-send-email-yamada.masahiro@socionext.com>
References: <1531382496-3719-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put $(LDFLAGS_$(@F)) into ld_flags so that $(LDFLAGS_pcap.o) and
$(LDFLAGS_vde.o) in arch/um/drivers/Makefile are absorbed.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/um/drivers/Makefile | 4 ++--
 scripts/Makefile.lib     | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index 16b3ceb..69331983 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -25,10 +25,10 @@ LDFLAGS_vde.o := -r $(shell $(CC) $(CFLAGS) -print-file-name=libvdeplug.a)
 targets := pcap_kern.o pcap_user.o vde_kern.o vde_user.o
 
 $(obj)/pcap.o: $(obj)/pcap_kern.o $(obj)/pcap_user.o
-	$(LD) -r -dp -o $@ $^ $(LDFLAGS) $(LDFLAGS_pcap.o)
+	$(LD) -r -dp -o $@ $^ $(ld_flags)
 
 $(obj)/vde.o: $(obj)/vde_kern.o $(obj)/vde_user.o
-	$(LD) -r -dp -o $@ $^ $(LDFLAGS) $(LDFLAGS_vde.o)
+	$(LD) -r -dp -o $@ $^ $(ld_flags)
 
 #XXX: The call below does not work because the flags are added before the
 # object name, so nothing from the library gets linked.
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 1915574..f56bb4b 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -162,7 +162,7 @@ a_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
 cpp_flags      = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
 		 $(__cpp_flags)
 
-ld_flags       = $(LDFLAGS) $(ldflags-y)
+ld_flags       = $(LDFLAGS) $(ldflags-y) $(LDFLAGS_$(@F))
 
 DTC_INCLUDE    := $(srctree)/scripts/dtc/include-prefixes
 
@@ -225,7 +225,7 @@ $(obj)/%: $(src)/%_shipped
 # ---------------------------------------------------------------------------
 
 quiet_cmd_ld = LD      $@
-cmd_ld = $(LD) $(ld_flags) $(LDFLAGS_$(@F)) $(filter-out FORCE,$^) -o $@
+cmd_ld = $(LD) $(ld_flags) $(filter-out FORCE,$^) -o $@
 
 # Objcopy
 # ---------------------------------------------------------------------------
-- 
2.7.4

