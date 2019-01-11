Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5A8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98362063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217335;
	bh=YuZq0vVop3dNBTveU/q3GqzA9tMTgS/gUX4jYd4Ycfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w2hbkqdpba2ysNE8A/3ZxaAF4sHKAbpbFoJlSSociO4dh8ndPZGqlQ9BuUhB6Jwxr
	 GhHe2qXolgkZ8SvEzcRFaphyF1mILNsIvO6yCqHiDxcs1Ph+Bs4KxhW9QOXd1k4dBD
	 bUcv/cAdg+EWNkfSUmpWDZvcQXItpqKKlFuZMXGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390184AbfAKOfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:35:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:55790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390169AbfAKOfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:35:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8723E2063F;
        Fri, 11 Jan 2019 14:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217331;
        bh=YuZq0vVop3dNBTveU/q3GqzA9tMTgS/gUX4jYd4Ycfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pRZf6bdSLTB96HIGCdi/9xl2mOzBQ7yL59KEClVyu2AB/Zp450srIBbjD0NP60/LS
         272bSkJtQXqc4qiT5Rdh+Z9TkoPwcEUzymIu2HX6Tt07T/mnGWKrAoGk0BM2RQ2Hbm
         Hq9f1Biv4zmFaB//z9dPPGqT59l9H4DFz0gcJNnU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 005/148] powerpc/mm: Fix linux page tables build with some configs
Date:   Fri, 11 Jan 2019 15:13:03 +0100
Message-Id: <20190111131114.550705712@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 462951cd32e1496dc64b00051dfb777efc8ae5d8 ]

For some configs the build fails with:

  arch/powerpc/mm/dump_linuxpagetables.c: In function 'populate_markers':
  arch/powerpc/mm/dump_linuxpagetables.c:306:39: error: 'PKMAP_BASE' undeclared (first use in this function)
  arch/powerpc/mm/dump_linuxpagetables.c:314:50: error: 'LAST_PKMAP' undeclared (first use in this function)

These come from highmem.h, including that fixes the build.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/dump_linuxpagetables.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
index bdf33b989f98..8464c2c01c0c 100644
--- a/arch/powerpc/mm/dump_linuxpagetables.c
+++ b/arch/powerpc/mm/dump_linuxpagetables.c
@@ -19,6 +19,7 @@
 #include <linux/hugetlb.h>
 #include <linux/io.h>
 #include <linux/mm.h>
+#include <linux/highmem.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <asm/fixmap.h>
-- 
2.19.1



