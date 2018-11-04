Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA03C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 23:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A672082D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 23:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6v2TWnz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A672082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbeKEI2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 03:28:44 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36638 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730484AbeKEI2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 03:28:44 -0500
Received: by mail-pg1-f195.google.com with SMTP id z17-v6so3330895pgv.3;
        Sun, 04 Nov 2018 15:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FYux4C2W77ompUQVjAbeAh3v7QT2cdZi06vXygmle5U=;
        b=X6v2TWnzkxTvrtjhspedABX3+3IMc2u8jvE7A+YZLOcXW01H7Oh9o7TuZhFoHv0tyE
         yq/YwK+NniMGr9wnbckTEX0bRAg7Ffu8d29k6PGBgTgPsC0BakRjE9HNBCCNPm/6PF4A
         F0/2yNXJg2A8ZOHmg25yOb0gJVDz7lxRUwk9nG19M+biDg4mUqgLqit8gegZKCLBijAq
         hRQzefA7wYdGndb6gMg1AmTsOTUmmjypb+KbNFKo2Xpz100YNfKAXnniR+n1sgKu8xlc
         omr8KAPjbWlBJuMulPxaFIvLD+YLDjmsktcoRd5RzhQs7JG7Rxsx2DfojgCnOVRhjkmi
         9KYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=FYux4C2W77ompUQVjAbeAh3v7QT2cdZi06vXygmle5U=;
        b=MClhQBRB63nOHLVY7r/WCV0SZ1LAGwjqlDnQNYA71dT/Id+AQ8wjKsiBl9/ZqehJGz
         7qYS6MD2t0la7vYBWPci/4L7G7eo4VCngqd6LCttvREk2lFjj2pa1W5hTr7lHjZYfxtT
         XeeagDRERHEDmvRL1LDxMutM4AnBlESbOn1cWFI2pjipo2knuJQW6Tbchl7QTtBUGL+u
         67nxGE9WX2tJ4wkKny3D1xyvpiIsKiZwEvMHkEQcipiNDdvNh/T//TJiHn8kZfBwJica
         BD7YPa6ltuyg/8g+mvC5DxNA04St9uRZlnrkSLO+ULK/AoK71H5CuZ9EhcmE/kcR+BVq
         l/ng==
X-Gm-Message-State: AGRZ1gIYq//lY3tm+u0lVbXLQ5SoWjVhimieQTx/LERhOkTxekZtSpj/
        XYlU5t+nSmyGbLa9+khL/EU=
X-Google-Smtp-Source: AJdET5fMU/L9ONzwUnycp7JkHaHEI+ABkuD4LzA5aQJqNWEG3vzRGs5xlnX+lQeDIpZDAGa7kQAPvA==
X-Received: by 2002:a63:4e18:: with SMTP id c24-v6mr17877627pgb.6.1541373125365;
        Sun, 04 Nov 2018 15:12:05 -0800 (PST)
Received: from aurora.jms.id.au (pa49-178-43-40.pa.nsw.optusnet.com.au. [49.178.43.40])
        by smtp.gmail.com with ESMTPSA id v185-v6sm45133255pfv.48.2018.11.04.15.11.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 15:12:04 -0800 (PST)
Received: by aurora.jms.id.au (sSMTP sendmail emulation); Mon, 05 Nov 2018 09:41:53 +1030
From:   Joel Stanley <joel@jms.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] Makefile: Export clang toolchain variables
Date:   Mon,  5 Nov 2018 09:41:32 +1030
Message-Id: <20181104231133.30848-2-joel@jms.id.au>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181104231133.30848-1-joel@jms.id.au>
References: <20181104231133.30848-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The powerpc makefile will use these in it's boot wrapper.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 9aa352b38815..a2db3c885b38 100644
--- a/Makefile
+++ b/Makefile
@@ -495,6 +495,9 @@ endif
 ifneq ($(GCC_TOOLCHAIN),)
 CLANG_GCC_TC	:= --gcc-toolchain=$(GCC_TOOLCHAIN)
 endif
+export CLANG_TARGET
+export CLANG_GCC_TC
+export CLANG_PREFIX
 KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
 KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
 KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
-- 
2.19.1

