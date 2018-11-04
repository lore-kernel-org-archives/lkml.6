Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657C9ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F379204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ev1F7Edo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F379204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbeKDXTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:19:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:46198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730659AbeKDXH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:07:57 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68CA920880;
        Sun,  4 Nov 2018 13:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339573;
        bh=GYrcv1H0rCWOqbRXNUnea7pfBWsIAaFTv7LhpHD73Xc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ev1F7EdolDP0N3/Pcm8HYE1nnNIyX4Sw9cQS3a9DnasNP6cj2PEGjr93RPLsbmJqj
         gesP6HSvqE04wNWYjCCMEApjjnNDtssJxjQbjQtJBDTTh/jlJ4PA/yX8pWDg1JkRxX
         730T1Z+gllWiQCSCDGR+bPZmpvRD5Tep57fLNyl4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 09/45] powerpc/64/module: REL32 relocation range check
Date:   Sun,  4 Nov 2018 08:52:04 -0500
Message-Id: <20181104135240.88431-9-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135240.88431-1-sashal@kernel.org>
References: <20181104135240.88431-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Piggin <npiggin@gmail.com>

[ Upstream commit b851ba02a6f3075f0f99c60c4bc30a4af80cf428 ]

The recent module relocation overflow crash demonstrated that we
have no range checking on REL32 relative relocations. This patch
implements a basic check, the same kernel that previously oopsed
and rebooted now continues with some of these errors when loading
the module:

  module_64: x_tables: REL32 527703503449812 out of range!

Possibly other relocations (ADDR32, REL16, TOC16, etc.) should also have
overflow checks.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/module_64.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index b8d61e019d06..f7b1203bdaee 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -685,7 +685,14 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 
 		case R_PPC64_REL32:
 			/* 32 bits relative (used by relative exception tables) */
-			*(u32 *)location = value - (unsigned long)location;
+			/* Convert value to relative */
+			value -= (unsigned long)location;
+			if (value + 0x80000000 > 0xffffffff) {
+				pr_err("%s: REL32 %li out of range!\n",
+				       me->name, (long int)value);
+				return -ENOEXEC;
+			}
+			*(u32 *)location = value;
 			break;
 
 		case R_PPC64_TOCSAVE:
-- 
2.17.1

