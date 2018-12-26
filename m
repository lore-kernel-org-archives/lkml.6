Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6051AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 255772087F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545865339;
	bh=jNIR5DhCmFvWuaOLeArnByYKeYdHSv56Pl0InoEVKiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VR3rJ1dTBSVUk31tXR3cXxcnAlfbz/rYEFl/sKI23tcQw/IJcCut/Sw4LJSn02sBF
	 B03Tw5BLL51grS64YAPd7E2QUJehTraPI6BrMBivz5vxwB1Y5R+mHDvuCTQPbME5a6
	 csLTawAqYEhf7jKG1L+CDYcqX9RkYrwMPoPaZJEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbeLZWgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:36:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:36036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbeLZWgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:36:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD19F21741;
        Wed, 26 Dec 2018 22:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863768;
        bh=jNIR5DhCmFvWuaOLeArnByYKeYdHSv56Pl0InoEVKiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bJ8AaaytxWSMc21bQrL3Dh1m5eITR3NFImkpFzGIBJGF/h02Jpqb9tcagSIStLhti
         LEJyigVip8gpeXj1a36KL34x1uzyTuySL5DR9YOaJ8QdwBYrfi//ggyemog5WjP1H8
         rwtX1aYIgnzW2eLrLPfNSpSIQwnc9TplOsIRJMPw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 05/97] powerpc/mm: Fix linux page tables build with some configs
Date:   Wed, 26 Dec 2018 17:34:25 -0500
Message-Id: <20181226223557.149329-5-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

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

