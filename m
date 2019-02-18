Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E32C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C918F21736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550500478;
	bh=8ZCyAgxXYxtDXgKgmgUQk0E66R8+TTI+hXTjFPP7WNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CTqEl+xTSaorc1xMXnENUxW1rkwdqCxjlotWKCn7bIAO4e5Us211HIAhg5jpeyaLK
	 T+1rVknN0gu65mXtv96TRdJfdJFNu/e0ac0fTcrgzr1s3KP7Cty7u4zcPrFM7vCs6K
	 sUjIg9Ofv41jnOrHYZVnduvE1wXiXJ3gNXUhqqQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387823AbfBRN4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:56:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:36688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387802AbfBRN4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:56:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0598D2077B;
        Mon, 18 Feb 2019 13:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498189;
        bh=8ZCyAgxXYxtDXgKgmgUQk0E66R8+TTI+hXTjFPP7WNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KC8gDAHDncm64eWXEm4Ly929FjnHUeFt/yFUT8MWPL00gtB67uC9aaZf48l4pYIpf
         /RS4BTW/rNpPds5bEBaUnTB0+NYadUocE4jKiW97+oInDeet+nf+5S4TZXcEYZG/NC
         nLYoABjQcGRQVBYFYcK9VLmmqjJy0SZ+L61T+EJY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        "David A. Long" <dave.long@linaro.org>,
        Julien Thierry <julien.thierry@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 21/62] ARM: fix the cockup in the previous patch
Date:   Mon, 18 Feb 2019 14:43:27 +0100
Message-Id: <20190218133507.741384971@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133505.801423074@linuxfoundation.org>
References: <20190218133505.801423074@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

Commit d6951f582cc50ba0ad22ef46b599740966599b14 upstream.

The intention in the previous patch was to only place the processor
tables in the .rodata section if big.Little was being built and we
wanted the branch target hardening, but instead (due to the way it
was tested) it ended up always placing the tables into the .rodata
section.

Although harmless, let's correct this anyway.

Fixes: 3a4d0c2172bc ("ARM: ensure that processor vtables is not lost after boot")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Tested-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mm/proc-macros.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index 19516fbc2c55..5461d589a1e2 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -278,7 +278,7 @@
  * If we are building for big.Little with branch predictor hardening,
  * we need the processor function tables to remain available after boot.
  */
-#if 1 // defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
+#if defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
 	.section ".rodata"
 #endif
 	.type	\name\()_processor_functions, #object
@@ -316,7 +316,7 @@ ENTRY(\name\()_processor_functions)
 	.endif
 
 	.size	\name\()_processor_functions, . - \name\()_processor_functions
-#if 1 // defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
+#if defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
 	.previous
 #endif
 .endm
-- 
2.19.1



