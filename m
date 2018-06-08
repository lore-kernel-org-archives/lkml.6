Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 8HsDGR+5Gls6RQAAmS7hNA
	; Fri, 08 Jun 2018 17:13:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D17ED6089E; Fri,  8 Jun 2018 17:13:28 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="XyXVS+t7"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3F0AF60590;
	Fri,  8 Jun 2018 17:13:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F0AF60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbeFHRNC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 13:13:02 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:19838 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751719AbeFHRNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 13:13:01 -0400
Received: from grover.sesame (FL1-125-199-20-195.osk.mesh.ad.jp [125.199.20.195]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id w58HCbWF008555;
        Sat, 9 Jun 2018 02:12:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w58HCbWF008555
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528477960;
        bh=sFOR8yPtAuS5GqeUxlJjV5u9vMKxeK8qrl3vZ67e+B8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XyXVS+t7bL0S4pTNtX4JYs8XZw7iQqbNG/93vjhxGbk4g0299O91tGr2RyE0RRPfN
         9CyEpQ/4nLuTtTupdchKKmiIeLbK/1Vc5AUikQNk7/UaAMuuWA+OtZ7U+cAwk7t118
         aTSP6XnA7hFZSLxJgg58BvL3moI75Rz+xNASLUCaVAZcSuRNTVBC4CzTbgtCChaByJ
         BL3K28mJT6kqNO+qdGCx+sN4Ru9g01AilX6E3r6PP58TdLoixZSecu+TANRk9XFi+E
         ch3lJM043w/GXpL2NJYsb4LIdDFXQKFS5YfXd4ARxGCdYjDB3k2v7Il/1tJ7+U6upn
         XcjEAyvQ3Of2w==
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH 3/3] bpfilter: do not (ab)use host-program build rule
Date: Sat,  9 Jun 2018 02:12:10 +0900
Message-Id: <1528477930-7342-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528477930-7342-1-git-send-email-yamada.masahiro@socionext.com>
References: <1528477930-7342-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is an ugly hack to overwrite $(HOSTCC) with $(CC) to reuse the
build rules from scripts/Makefile.host.  It should not be tedious
to write a build rule for its own.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 net/bpfilter/Makefile                   | 17 +++++++++++------
 net/bpfilter/{main.c => bpfilter_umh.c} |  0
 2 files changed, 11 insertions(+), 6 deletions(-)
 rename net/bpfilter/{main.c => bpfilter_umh.c} (100%)

diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
index 39c6980..6571b30 100644
--- a/net/bpfilter/Makefile
+++ b/net/bpfilter/Makefile
@@ -3,18 +3,23 @@
 # Makefile for the Linux BPFILTER layer.
 #
 
-hostprogs-y := bpfilter_umh
-bpfilter_umh-objs := main.o
-HOSTCFLAGS += -I. -Itools/include/ -Itools/include/uapi
-HOSTCC := $(CC)
-
 ifeq ($(CONFIG_BPFILTER_UMH), y)
 # builtin bpfilter_umh should be compiled with -static
 # since rootfs isn't mounted at the time of __init
 # function is called and do_execv won't find elf interpreter
-HOSTLDFLAGS += -static
+STATIC := -static
 endif
 
+quiet_cmd_cc_user = CC      $@
+      cmd_cc_user = $(CC) -Wall -Wmissing-prototypes -O2 -std=gnu89 \
+		    -I$(srctree) -I$(srctree)/tools/include/ \
+		    -I$(srctree)/tools/include/uapi $(STATIC) -o $@ $<
+
+$(obj)/bpfilter_umh: $(src)/bpfilter_umh.c FORCE
+	$(call if_changed,cc_user)
+
+targets += bpfilter_umh
+
 $(obj)/bpfilter_umh_blob.o: $(obj)/bpfilter_umh
 
 obj-$(CONFIG_BPFILTER_UMH) += bpfilter.o
diff --git a/net/bpfilter/main.c b/net/bpfilter/bpfilter_umh.c
similarity index 100%
rename from net/bpfilter/main.c
rename to net/bpfilter/bpfilter_umh.c
-- 
2.7.4
