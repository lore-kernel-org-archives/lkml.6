Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28ABFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA81020811
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1ty/8NMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394294AbfBNDGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:06:05 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:64385 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733190AbfBNDGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:06:05 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x1E35Pg6020814;
        Thu, 14 Feb 2019 12:05:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x1E35Pg6020814
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550113528;
        bh=9+FohcoLHm8KYNdVvN4X6+iAEs7CLHpN0SKeH6bEVW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1ty/8NMW+CQYyU1AAuHhVNAXdSzFBQqFW09+HRt81NogjtBW0P6b+UdsowdN+nYpZ
         0G2z93wrqw/G2JCM802DB2vENVcXsfyKSKMntbRx0ORPadmAmI+G/pOibhITpKO+9a
         Ll4ONtRawU1Zp6U+EeQoCUsxq1a1RedYF/dGwA35ZwHeYOOkQpHPcsK/6txvP5PSc5
         KMjBV0sg5nvES7Rzro+dwALW472L2H54pSUqMuNO56N1dWBJUVknPZnd6CAtQE+JJB
         vPMDxTPFAZZ5rfmBD1pdx9YIJH5jCX8SlJqZOkD4P147mWs39Sy4/NyqA+WlJrC7Fp
         PKhG36EGwz20g==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] kbuild: move tools_silent to a more relevant place
Date:   Thu, 14 Feb 2019 12:05:18 +0900
Message-Id: <1550113521-23577-5-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550113521-23577-1-git-send-email-yamada.masahiro@socionext.com>
References: <1550113521-23577-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This would disturb the change the sub-make part. Move it near the
tools/ target.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 3956e93..0180b23 100644
--- a/Makefile
+++ b/Makefile
@@ -90,7 +90,6 @@ endif
 
 ifneq ($(findstring s,$(filter-out --%,$(MAKEFLAGS))),)
   quiet=silent_
-  tools_silent=s
 endif
 
 export quiet Q KBUILD_VERBOSE
@@ -1664,6 +1663,11 @@ image_name:
 	@echo $(KBUILD_IMAGE)
 
 # Clear a bunch of variables before executing the submake
+
+ifeq ($(quiet),silent_)
+tools_silent=s
+endif
+
 tools/: FORCE
 	$(Q)mkdir -p $(objtree)/tools
 	$(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(tools_silent) $(filter --j% -j,$(MAKEFLAGS))" O=$(abspath $(objtree)) subdir=tools -C $(src)/tools/
-- 
2.7.4

