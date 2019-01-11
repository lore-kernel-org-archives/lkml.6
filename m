Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1A3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCAF20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547219024;
	bh=C/hfEG3elNUSBJAw5OtSt+T9uOZuLNDbp+oXKyV6Gak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QICupVbzseamv0EzpxY0doVE0tXFjHZ0wA4PUA56gIrYz4FjFK1DH1AKEicUC/1re
	 huQsGDbhMQH6zUhfQBgE4oSsRVDwcNGiSttEH5X9U7slZChmA8Tpl5jZt/vkicUMvI
	 gYvY2FO1mBUe+tJ8rG4NjsDgQ6alnttIbPsTlFFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391841AbfAKPDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:03:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:50256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389029AbfAKOar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:30:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC42B2063F;
        Fri, 11 Jan 2019 14:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217047;
        bh=C/hfEG3elNUSBJAw5OtSt+T9uOZuLNDbp+oXKyV6Gak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1HPVnNvwchE8Bgs3auPYqhmtoJj/NtL2vnIhedX24MNV1Y0D6QhHRGsKNLMud70Nd
         RP/iN1k0AEd8chwLwegRnjzE3gGMGEn8MiBsy3UNCC5GvO5Q4zkNcW1iaoN3F/qJ/0
         32qSisVwMEeYKd921KhRIwVZbg6H9ceeJrBNbVok=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 003/105] powerpc/mm: Fix linux page tables build with some configs
Date:   Fri, 11 Jan 2019 15:13:34 +0100
Message-Id: <20190111131103.272001621@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
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
index 31c1c61afaa4..0bbaf7344872 100644
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



