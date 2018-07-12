Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055C8C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC8E20C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="oX++y4sY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC8E20C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbeGLILo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:11:44 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:56360 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbeGLILo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:11:44 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w6C81cQj012716;
        Thu, 12 Jul 2018 17:01:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w6C81cQj012716
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531382504;
        bh=PR1zPWKBmHPFKOICGRPcOVP5bxb/1PLJfA29JpKbpzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oX++y4sYzpmRliDuKa0z0KZr7X0/v0VoEh3/WBVUUxo5ptYBNGoWmuu2L8C+8Mr8J
         XI5nkK3kn0ASFhPIcfkTAHcBhS1jPe8ONmAEjrHsWvskx+Vf5ESiS0T4B5xS26NV5b
         tJaUHMdJOg4PpHySQEr9MPTXICN2YL+gY1nI7wGTD8ltJFK93NAvPmFbjzaCY9X/db
         m+C1JhoKDXP0zGSjylJcI5m67AMkgQ0BjbnDZh5H8vggf7zsaWWDfB3a10BhUH5s8W
         6puTM++YXvdtevxPMTlRkgI9eMP4dlZ08lkfGCngLM9SEj/h0Dx7J/IYazLcvHd2si
         kRBENwpOPehYA==
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
Subject: [PATCH 4/6] kbuild: replace $(LDFLAGS) $(ldflags-y) with $(ld_flags)
Date:   Thu, 12 Jul 2018 17:01:34 +0900
Message-Id: <1531382496-3719-5-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531382496-3719-1-git-send-email-yamada.masahiro@socionext.com>
References: <1531382496-3719-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

$(LDFLAGS) $(ldflags-y) is equivalent to $(ld_flags).

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.lib | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 1bb594f..1915574 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -225,8 +225,7 @@ $(obj)/%: $(src)/%_shipped
 # ---------------------------------------------------------------------------
 
 quiet_cmd_ld = LD      $@
-cmd_ld = $(LD) $(LDFLAGS) $(ldflags-y) $(LDFLAGS_$(@F)) \
-	       $(filter-out FORCE,$^) -o $@
+cmd_ld = $(LD) $(ld_flags) $(LDFLAGS_$(@F)) $(filter-out FORCE,$^) -o $@
 
 # Objcopy
 # ---------------------------------------------------------------------------
-- 
2.7.4

