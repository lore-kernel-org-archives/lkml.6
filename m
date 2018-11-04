Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7A4ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 23:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4072082D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 23:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzgzJlJX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4072082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbeKEI2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 03:28:55 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38028 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730484AbeKEI2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 03:28:54 -0500
Received: by mail-pg1-f195.google.com with SMTP id f8-v6so3326487pgq.5;
        Sun, 04 Nov 2018 15:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UpNAPKimz1my7YVFzTj+MgOPaV27toX8fTxUd9TBuTE=;
        b=jzgzJlJX/qfXtaRGtaTlkLG1juQ+83tLMdAYz7BTO7biw8rUNMsz/upQxTFL6cuezV
         l1Uo4i+PkJ/T0q0E4zAdlHuctra15I9aREmowH/dIqqZuhABT7DbEIV9sVLkyJkkjzKY
         CCHg7zep0+GDimeKRdhPKauysEJh4l7mdI3/X5cUPzw3c1E6/rCey6LHok3pn3b+auS/
         D6dAIHtuVJ8CseQe4TmOrGDJmH99ETXjC2kWSmORq4SU/hrR/1qkksBB1BKvjnRYM3+m
         IAfBnBYjLJVkBqRYF5INWOvut1BMn+tlxnT1wPQmET9GMNT5QA3tS8dTlHiA6npJeGkx
         kJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=UpNAPKimz1my7YVFzTj+MgOPaV27toX8fTxUd9TBuTE=;
        b=hL+7mb8SJj96/haE/DrPFX23qx9VuA0PLpVM4SQt9BVIEDsL4BGhzfnau132MDQZF4
         rN2QdlUTMBRms85far4XWKuPEa0GW7E0VDcWoRPGvtyw+/YEUjO8x1hGSx2ayqT6GEw3
         MSMa3x45z+//Z+cmPVCV5HEVru8DwHbeLt094l/s3tTBF7PRvSP63ZMHj9MVqcZIsxml
         BCifoBQ0DRik3paL8GLwSLU0XGqspvEG5o9F7Huq0PYfL+ci1l5+Dwyeo/ulN/QhMAB7
         VR3fkaBJ+YUuWar2BLlAwFDmta1GviLzgNIRfICFs5pJIF7fZ9e8rIYHpZhO1af4n8RA
         sVNg==
X-Gm-Message-State: AGRZ1gLz89ULiMrY06OoPGsiHG6++SYCiC+/Yf+MDZLxWK51XHrPNZ0x
        ExilYh2n5AdrjfNODKZ1FqM=
X-Google-Smtp-Source: AJdET5drI1g+j4nUcrlzMnpH0ujnY37mrNpHJZpV7v1qFPLkku6SpnghRSEAQ7ynsIyFYYhIvy6TzA==
X-Received: by 2002:a62:5d49:: with SMTP id r70-v6mr20112960pfb.123.1541373135917;
        Sun, 04 Nov 2018 15:12:15 -0800 (PST)
Received: from aurora.jms.id.au (pa49-178-43-40.pa.nsw.optusnet.com.au. [49.178.43.40])
        by smtp.gmail.com with ESMTPSA id z8sm286467pgz.53.2018.11.04.15.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 15:12:15 -0800 (PST)
Received: by aurora.jms.id.au (sSMTP sendmail emulation); Mon, 05 Nov 2018 09:42:04 +1030
From:   Joel Stanley <joel@jms.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/boot: Set target when cross-compiling for clang
Date:   Mon,  5 Nov 2018 09:41:33 +1030
Message-Id: <20181104231133.30848-3-joel@jms.id.au>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181104231133.30848-1-joel@jms.id.au>
References: <20181104231133.30848-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang needs to be told which target it is building for when cross
compiling.

Link: https://github.com/ClangBuiltLinux/linux/issues/259
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/boot/Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 39354365f54a..8fdb1890f09a 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -55,6 +55,13 @@ BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
 
 BOOTARFLAGS	:= -cr$(KBUILD_ARFLAGS)
 
+ifdef CONFIG_CC_IS_CLANG
+BOOTCFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
+BOOTAFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
+BOOTCFLAGS += $(call cc-option, -no-integrated-as)
+BOOTAFLAGS += $(call cc-option, -no-integrated-as)
+endif
+
 ifdef CONFIG_DEBUG_INFO
 BOOTCFLAGS	+= -g
 endif
-- 
2.19.1

