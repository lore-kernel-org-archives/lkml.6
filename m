Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2202ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A49620834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="njkFcmaw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A49620834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbeJYWvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:51:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728038AbeJYWvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:51:41 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28B872085B;
        Thu, 25 Oct 2018 14:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477123;
        bh=T3qeweJ3D7lrSRobE2R4jyZt8rTYBW3424ZlemCGyDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=njkFcmawkxjoSjeJTBGSD8ro+uATCjc0M6EpatKYn121rusM+0pqJNesAKx9QQjPj
         5X8wd1VX2RsKNux5sOTEbn5utjXDjTTIPegE5A3oItjFbg2whToiyb4L8gK3eblRri
         DiTYLc11hywanCEHHIWR+wSPDQP4xJmXij4EmhS4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Ingo Molnar <mingo@kernel.org>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 63/65] MIPS: microMIPS: Fix decoding of swsp16 instruction
Date:   Thu, 25 Oct 2018 10:17:03 -0400
Message-Id: <20181025141705.213937-63-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Redfearn <matt.redfearn@imgtec.com>

[ Upstream commit cea8cd498f4f1c30ea27e3664b3c671e495c4fce ]

When the immediate encoded in the instruction is accessed, it is sign
extended due to being a signed value being assigned to a signed integer.
The ISA specifies that this operation is an unsigned operation.
The sign extension leads us to incorrectly decode:

801e9c8e:       cbf1            sw      ra,68(sp)

As having an immediate of 1073741809.

Since the instruction format does not specify signed/unsigned, and this
is currently the only location to use this instuction format, change it
to an unsigned immediate.

Fixes: bb9bc4689b9c ("MIPS: Calculate microMIPS ra properly when unwinding the stack")
Suggested-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Cc: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: Miodrag Dinic <miodrag.dinic@imgtec.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: David Daney <david.daney@cavium.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/16957/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/uapi/asm/inst.h | 2 +-
 arch/mips/kernel/process.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index 9b44d5a816fa..1b6f2f219298 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -846,7 +846,7 @@ struct mm16_r3_format {		/* Load from global pointer format */
 struct mm16_r5_format {		/* Load/store from stack pointer format */
 	__BITFIELD_FIELD(unsigned int opcode : 6,
 	__BITFIELD_FIELD(unsigned int rt : 5,
-	__BITFIELD_FIELD(signed int simmediate : 5,
+	__BITFIELD_FIELD(unsigned int imm : 5,
 	__BITFIELD_FIELD(unsigned int : 16, /* Ignored */
 	;))))
 };
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index a9cc74354df8..ebd8a715fe38 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -207,7 +207,7 @@ static inline int is_ra_save_ins(union mips_instruction *ip, int *poff)
 			if (ip->mm16_r5_format.rt != 31)
 				return 0;
 
-			*poff = ip->mm16_r5_format.simmediate;
+			*poff = ip->mm16_r5_format.imm;
 			*poff = (*poff << 2) / sizeof(ulong);
 			return 1;
 
-- 
2.17.1

