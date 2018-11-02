Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80E1C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4C020848
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcRlMknT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE4C020848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbeKCD7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:59:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728743AbeKCD7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:59:37 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F65C2084A;
        Fri,  2 Nov 2018 18:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184682;
        bh=A7dchIM4K0GllAboFlkE+qr56wPZSHXfgomQ36DxAIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mcRlMknTIVPmKBRfTcww63K3e+k7qWHn0WfqkXVbc5c6Q799uB6ES9kXE84ObhTih
         Ce1HI4DUnAlAz7nFA99+4IDoh1BMUKH046vAlRMwuGTSQk4lIBNuvnkMRapGA0dfQs
         gC0HEA6QrvKmYz3q+27kWV6oSzdotJIWRSqu1OIo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 067/143] kbuild: set no-integrated-as before incl. arch Makefile
Date:   Fri,  2 Nov 2018 19:34:12 +0100
Message-Id: <20181102182902.562305541@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 0f0e8de334c54c38818a4a5390a39aa09deff5bf ]

In order to make sure compiler flag detection for ARM works
correctly the no-integrated-as flags need to be set before
including the arch specific Makefile.

Fixes: cfe17c9bbe6a ("kbuild: move cc-option and cc-disable-warning after incl. arch Makefile")
Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 16d1a18496fb..8cc08595b760 100644
--- a/Makefile
+++ b/Makefile
@@ -487,6 +487,8 @@ CLANG_GCC_TC	:= --gcc-toolchain=$(GCC_TOOLCHAIN)
 endif
 KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
 KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
+KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
+KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
 endif
 
 RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register
@@ -721,8 +723,6 @@ KBUILD_CFLAGS += $(call cc-disable-warning, tautological-compare)
 # See modpost pattern 2
 KBUILD_CFLAGS += $(call cc-option, -mno-global-merge,)
 KBUILD_CFLAGS += $(call cc-option, -fcatch-undefined-behavior)
-KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
-KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
 else
 
 # These warnings generated too much noise in a regular build.
-- 
2.17.1



