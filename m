Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4452EECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09CDB20989
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zNXMmS/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09CDB20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbeKIHib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:38:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:57702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728491AbeKIHi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:38:29 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4670F21479;
        Thu,  8 Nov 2018 22:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714460;
        bh=gT4w/vKH/EeSL/xNu1EjioFWFu7p9ZUEzowGZPeILkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zNXMmS/Xi7IUbJgtOhUWScn0FP+zTwVCypP+GE0D9ZIRv29L4t5Urvuh/bCN+jG72
         VzEYZjlPZOW1MTsPKoPC6XrOgGXZWhbGdgRHVkaDvX/HGYJ132DYFC86unwshJ12NI
         VLTKbvYaWkHHGJ1x/URT1oiA89wvzlKFAmO13rtc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matt Redfearn <matt.redfearn@imgtec.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 074/114] MIPS: Handle non word sized instructions when examining frame
Date:   Thu,  8 Nov 2018 13:51:29 -0800
Message-Id: <20181108215107.708860634@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index ed6cac4a4df0..a9cc74354df8 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -341,6 +341,7 @@ static int get_frame_info(struct mips_frame_info *info)
 	bool is_mmips = IS_ENABLED(CONFIG_CPU_MICROMIPS);
 	union mips_instruction insn, *ip, *ip_end;
 	const unsigned int max_insns = 128;
+	unsigned int last_insn_size = 0;
 	unsigned int i;
 
 	info->pc_offset = -1;
@@ -352,15 +353,19 @@ static int get_frame_info(struct mips_frame_info *info)
 
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
@@ -382,8 +387,6 @@ static int get_frame_info(struct mips_frame_info *info)
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



