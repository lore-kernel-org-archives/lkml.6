Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401A7C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E7220844
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693471;
	bh=7Xl9785Ooo3tc69cLRHlbmgfz8adtXgl//L6MK5SQog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OWwq3zvYEPtOI/DFLtdgwyz4mYQfgi68q2YmoMuZMOxi+yHp/rqFPIH7vucKnB39Q
	 b0vyqQn+rUy6GIEK3dS0XhZJoXEHWTSxrtBeCqh1S8CVeKFzhnPoCjMIqy+tNxGkzc
	 MkTN0I617AgffiugrY3A/0WElChOl9wOU+p/2JFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390485AbfA1Qht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:37:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:33740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389827AbfA1QY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:24:59 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99AF92147A;
        Mon, 28 Jan 2019 16:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692698;
        bh=7Xl9785Ooo3tc69cLRHlbmgfz8adtXgl//L6MK5SQog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wWZG4VOxz+gjgTZMbOALx5E5mD8a9bcuFDuDasqXP1usiGV0NfFYa/64lGTOlUuhU
         iK+dSTX3DNksVv7hI42bldhhCw7OXESXz0nxFcIVJoNJH2akaWSLbh0RJuhSlzQvtg
         U+N6sVZce9WMrqvdG+bxOGAGn7JWtAnXRYDxUhbc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jiong Wang <jiong.wang@netronome.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 33/80] mips: bpf: fix encoding bug for mm_srlv32_op
Date:   Mon, 28 Jan 2019 11:23:14 -0500
Message-Id: <20190128162401.58841-33-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128162401.58841-1-sashal@kernel.org>
References: <20190128162401.58841-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiong Wang <jiong.wang@netronome.com>

[ Upstream commit 17f6c83fb5ebf7db4fcc94a5be4c22d5a7bfe428 ]

For micro-mips, srlv inside POOL32A encoding space should use 0x50
sub-opcode, NOT 0x90.

Some early version ISA doc describes the encoding as 0x90 for both srlv and
srav, this looks to me was a typo. I checked Binutils libopcode
implementation which is using 0x50 for srlv and 0x90 for srav.

v1->v2:
  - Keep mm_srlv32_op sorted by value.

Fixes: f31318fdf324 ("MIPS: uasm: Add srlv uasm instruction")
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@vger.kernel.org
Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/uapi/asm/inst.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index 1b6f2f219298..9db764b51ffe 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -290,8 +290,8 @@ enum mm_32a_minor_op {
 	mm_ext_op = 0x02c,
 	mm_pool32axf_op = 0x03c,
 	mm_srl32_op = 0x040,
+	mm_srlv32_op = 0x050,
 	mm_sra_op = 0x080,
-	mm_srlv32_op = 0x090,
 	mm_rotr_op = 0x0c0,
 	mm_lwxs_op = 0x118,
 	mm_addu32_op = 0x150,
-- 
2.19.1

