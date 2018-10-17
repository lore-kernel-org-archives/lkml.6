Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CD5ECDE3C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A582145D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Yht17Gwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A582145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeJRGbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:31:31 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45429 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbeJRGba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:31:30 -0400
Received: by mail-ed1-f68.google.com with SMTP id m6-v6so2898172eds.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 15:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=27wwu/S7X+V3DNcHaNB1drCOYKf3ZuNA3Wa6mreaLtU=;
        b=Yht17GwpOjEqe6Ufmk/wbV4swS4qBFGl9lmuiuIWL5HfeG7rdaciq59fCjotXEGbPj
         M0tXDDr5Jq0EglHczuSBXLH7jBEoKdo8yXyKU1TSvwBtqYuSOnLQUuw7FfRcroeKEy0Y
         LzifiGEtlgX6A4lpQ00PfZx+D+47zUDjMj4aE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=27wwu/S7X+V3DNcHaNB1drCOYKf3ZuNA3Wa6mreaLtU=;
        b=fi0etrvWqqzbOqegN2nn12MxQv52Y7MBESY4fF/o0VB7ZLmR759gtmbraPEPURi1a0
         zb2422QagteODAKnQ5R1VSZZkuDsiv03VHT/3quheKkeA7XtxtJo/HTLn3UxxSF4OvSd
         afVspew9h1sm6Ee0DumAIA/gogAdZ1giI2IFBXdh66SAvc9pKa1hcjS/ZETX+ImcqB/s
         pQlHenwzDLwGtcIiHdv5T7ZW7MlsMPowgE+EGhnEXWlc1YqYwHXkTdqZDbaTzDE8RE9d
         P42qsatDt0ok6v5I4399t5jCGWVcS1NtFOwLQv1SCin376eVJd9t48FtyKmbWIrcJos/
         ZwBQ==
X-Gm-Message-State: ABuFfohq3qol2tYT4XWrTp8F+zrtm3z+ljYWdmuT+CuHbTOFYhlNeHzR
        2+m/Mqo7POA336cMTCIZqxV+m0a94K4=
X-Google-Smtp-Source: ACcGV62bHsFLYB81D0KjCqW61nB6+NxK5b4xUVE1y5Aa/2HlQlEoeNEjBGExAlhGrySKAz/4mBEfBA==
X-Received: by 2002:a50:8d1b:: with SMTP id s27-v6mr1743978eds.107.1539815621641;
        Wed, 17 Oct 2018 15:33:41 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id e30-v6sm7001555edd.25.2018.10.17.15.33.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Oct 2018 15:33:41 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [POC 03/12] arch/Kconfig: add ARCH_HAS_RAI symbol
Date:   Thu, 18 Oct 2018 00:33:23 +0200
Message-Id: <20181017223332.11964-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181017223332.11964-1-linux@rasmusvillemoes.dk>
References: <20181017223332.11964-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 9d329608913e..160893bd6a5c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -275,6 +275,9 @@ config ARCH_THREAD_STACK_ALLOCATOR
 config ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	bool
 
+config ARCH_HAS_RAI
+	bool
+
 config HAVE_REGS_AND_STACK_ACCESS_API
 	bool
 	help
-- 
2.19.1.6.gbde171bbf5

