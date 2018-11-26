Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46459C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0697820645
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayF5s0xN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0697820645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730939AbeKZV5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:57:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:42496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729291AbeKZV5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:57:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0776220645;
        Mon, 26 Nov 2018 11:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230247;
        bh=O/ao8AFCAclcigtm4liKGluTkCT19Y94pjKeG97UGxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ayF5s0xNRZ8/Bxcz/kSJy5hZQ6+HIyVC/jd/uXDnOov+5lf+tlB6g2ofQnKX6urqy
         sBkLa/ubcj2+yH/hKl0VFtIMYT64+/a3boCSwIEugw9IljzbtomW6LplTdy2AJ5iL+
         xYPtCgjYfVgn3atQhq2JhOe0fVPHRPF5BM+PlQvs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 063/118] lib/raid6: Fix arm64 test build
Date:   Mon, 26 Nov 2018 11:50:57 +0100
Message-Id: <20181126105103.383803960@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 313a06e636808387822af24c507cba92703568b1 ]

The lib/raid6/test fails to build the neon objects
on arm64 because the correct machine type is 'aarch64'.

Once this is correctly enabled, the neon recovery objects
need to be added to the build.

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/raid6/test/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/raid6/test/Makefile b/lib/raid6/test/Makefile
index 5d73f5cb4d8a..79777645cac9 100644
--- a/lib/raid6/test/Makefile
+++ b/lib/raid6/test/Makefile
@@ -27,7 +27,7 @@ ifeq ($(ARCH),arm)
         CFLAGS += -I../../../arch/arm/include -mfpu=neon
         HAS_NEON = yes
 endif
-ifeq ($(ARCH),arm64)
+ifeq ($(ARCH),aarch64)
         CFLAGS += -I../../../arch/arm64/include
         HAS_NEON = yes
 endif
@@ -41,7 +41,7 @@ ifeq ($(IS_X86),yes)
 		    gcc -c -x assembler - >&/dev/null &&        \
 		    rm ./-.o && echo -DCONFIG_AS_AVX512=1)
 else ifeq ($(HAS_NEON),yes)
-        OBJS   += neon.o neon1.o neon2.o neon4.o neon8.o
+        OBJS   += neon.o neon1.o neon2.o neon4.o neon8.o recov_neon.o recov_neon_inner.o
         CFLAGS += -DCONFIG_KERNEL_MODE_NEON=1
 else
         HAS_ALTIVEC := $(shell printf '\#include <altivec.h>\nvector int a;\n' |\
-- 
2.17.1



