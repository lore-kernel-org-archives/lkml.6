Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89C2C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80D32147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763777;
	bh=OTQX3yQ8cD4bN36v1aipQ4nUuVx2XYb9yT5Tgg2Ikyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cjlAI+nNpp39QhwscQuarZwvhVuKSigPqOzRka6E5Fdym7keWqJ8xii4bqy1ySZg8
	 HVqiBE1Ppthti6Zxr5pwLKoOIRjuU6OYvRom/5OHxQP19sPOycoTEDX0mO0+PtKtVH
	 JyCYkNClkxwYm1I4asXhl8yRWATgXd6fXinqV6Bk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfA2Lia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:38:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:55134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729099AbfA2Li2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:38:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FCB020844;
        Tue, 29 Jan 2019 11:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761907;
        bh=OTQX3yQ8cD4bN36v1aipQ4nUuVx2XYb9yT5Tgg2Ikyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zCdtTwc209NnWwOgjGsaAUF2ND4ttjZWmeCTh5cEJx7i6EawLWS2grCX6cTQy5CGx
         B9odhtX6nUGowCQh15oJGVYHuq0MRubNobFCyLvE4QXZ9T4UARJMbUHwkcxjnzWEfq
         AEDXYKsuAWDbI74N2JZ+89MdBeJ/Lr1LjD5AEVSk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 4.20 043/117] ARC: perf: map generic branches to correct hardware condition
Date:   Tue, 29 Jan 2019 12:34:54 +0100
Message-Id: <20190129113209.752734309@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

commit 3affbf0e154ee351add6fcc254c59c3f3947fa8f upstream.

So far we've mapped branches to "ijmp" which also counts conditional
branches NOT taken. This makes us different from other architectures
such as ARM which seem to be counting only taken branches.

So use "ijmptak" hardware condition which only counts (all jump
instructions that are taken)

'ijmptak' event is available on both ARCompact and ARCv2 ISA based
cores.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: stable@vger.kernel.org
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
[vgupta: reworked changelog]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arc/include/asm/perf_event.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/arc/include/asm/perf_event.h
+++ b/arch/arc/include/asm/perf_event.h
@@ -103,7 +103,8 @@ static const char * const arc_pmu_ev_hw_
 
 	/* counts condition */
 	[PERF_COUNT_HW_INSTRUCTIONS] = "iall",
-	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = "ijmp", /* Excludes ZOL jumps */
+	/* All jump instructions that are taken */
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = "ijmptak",
 	[PERF_COUNT_ARC_BPOK]         = "bpok",	  /* NP-NT, PT-T, PNT-NT */
 #ifdef CONFIG_ISA_ARCV2
 	[PERF_COUNT_HW_BRANCH_MISSES] = "bpmp",


