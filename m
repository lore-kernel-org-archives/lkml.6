Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A46C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE832085B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+/Rwl6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE832085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbeJYWrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:47:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727433AbeJYWra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:47:30 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 752E52085A;
        Thu, 25 Oct 2018 14:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476874;
        bh=r3qMu/c6UMYlBb8stk9qiIBL7pfn9hhAWXa+NM3Ymzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p+/Rwl6ccFzjFGa3+ITo7QsjgqpwDi08oUvpqCwvEprpeIILKdea5Mrvod/VXbSO9
         6cypcNw175B0gY2g/E8WOCSFg8mwtqHuzh5GvwbTKFQrwDRfL7SAMreBEGxridgz2V
         IQmLANcDyEQY4KYbN5e9kCMo5DFx/ziHXeQ87Byo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 04/98] MIPS: Handle non word sized instructions when examining frame
Date:   Thu, 25 Oct 2018 10:12:49 -0400
Message-Id: <20181025141423.213774-4-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Redfearn <matt.redfearn@imgtec.com>

[ Upstream commit 11887ed172a6960673f130dad8f8fb42778f64d7 ]

Commit 34c2f668d0f6b ("MIPS: microMIPS: Add unaligned access support.")
added fairly broken support for handling 16bit microMIPS instructions in
get_frame_info(). It adjusts the instruction pointer by 16bits in the
case of a 16bit sp move instruction, but not any other 16bit
instruction.

Commit b6c7a324df37 ("MIPS: Fix get_frame_info() handling of microMIPS
function size") goes some way to fixing get_frame_info() to iterate over
microMIPS instuctions, but the instruction pointer is still manipulated
using a postincrement, and is of union mips_instruction type. Since the
union is sized to the largest member (a word), but microMIPS
instructions are a mix of halfword and word sizes, the function does not
always iterate correctly, ending up misaligned with the instruction
stream and interpreting it incorrectly.

Since the instruction modifying the stack pointer is usually the first
in the function, that one is usually handled correctly. But the
instruction which saves the return address to the sp is some variable
number of instructions into the frame and is frequently missed due to
not being on a word boundary, leading to incomplete walking of the
stack.

Fix this by incrementing the instruction pointer based on the size of
the previously decoded instruction (& remove the hack introduced by
commit 34c2f668d0f6b ("MIPS: microMIPS: Add unaligned access support.")
which adjusts the instruction pointer in the case of a 16bit sp move
instruction, but not any other).

Fixes: 34c2f668d0f6b ("MIPS: microMIPS: Add unaligned access support.")
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/16953/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/kernel/process.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 0211dc737a21..1cc133e7026f 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -346,6 +346,7 @@ static int get_frame_info(struct mips_frame_info *info)
 	bool is_mmips = IS_ENABLED(CONFIG_CPU_MICROMIPS);
 	union mips_instruction insn, *ip, *ip_end;
 	const unsigned int max_insns = 128;
+	unsigned int last_insn_size = 0;
 	unsigned int i;
 
 	info->pc_offset = -1;
@@ -357,15 +358,19 @@ static int get_frame_info(struct mips_frame_info *info)
 
 	ip_end = (void *)ip + info->func_size;
 
-	for (i = 0; i < max_insns && ip < ip_end; i++, ip++) {
+	for (i = 0; i < max_insns && ip < ip_end; i++) {
+		ip = (void *)ip + last_insn_size;
 		if (is_mmips && mm_insn_16bit(ip->halfword[0])) {
 			insn.halfword[0] = 0;
 			insn.halfword[1] = ip->halfword[0];
+			last_insn_size = 2;
 		} else if (is_mmips) {
 			insn.halfword[0] = ip->halfword[1];
 			insn.halfword[1] = ip->halfword[0];
+			last_insn_size = 4;
 		} else {
 			insn.word = ip->word;
+			last_insn_size = 4;
 		}
 
 		if (is_jump_ins(&insn))
@@ -387,8 +392,6 @@ static int get_frame_info(struct mips_frame_info *info)
 						tmp = (ip->halfword[0] >> 1);
 						info->frame_size = -(signed short)(tmp & 0xf);
 					}
-					ip = (void *) &ip->halfword[1];
-					ip--;
 				} else
 #endif
 				info->frame_size = - ip->i_format.simmediate;
-- 
2.17.1

