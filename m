Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF12C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F41E2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762488;
	bh=/LlHPs9L2b0IUpCh1SahTOj8Nz0vl1r0x3cs7iKIoQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AkxUyEWZGBvJdkylAcHjAdN1M6e93knGMJGsv4qWi5Wv88g5hSu60TjPaPNe4/rM3
	 ZMLHag9tlrFgsP05Lm4RU34qD0Rn3dKg/xno/shjXZmW7E/ueFyx0FRCf+P4ZGXB40
	 vt7V5CEec0YBOevnTC+UVUHaMwlu/vraSs0ESNq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbfA2LsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:48:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:38894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731269AbfA2LsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:48:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADFB32083B;
        Tue, 29 Jan 2019 11:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762483;
        bh=/LlHPs9L2b0IUpCh1SahTOj8Nz0vl1r0x3cs7iKIoQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u1wexhrfwdv4HJsHcMblxYVuXGcPP8HHPU7Dka3GOyBMlhHf1KrPKIb4vOqujGJLB
         FE3OgtfsmdTuj6S8fVT2QG8GbA5RzCc/9Vd2s+b6/qSgVgT4z4PT3tEi2Ts0yGPHIP
         YLqRIoBXgsLifbpfg4o+eOMVUzNBN3XLX1qJCg/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 4.14 20/68] ARC: perf: map generic branches to correct hardware condition
Date:   Tue, 29 Jan 2019 12:35:42 +0100
Message-Id: <20190129113133.311161744@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
References: <20190129113131.751891514@linuxfoundation.org>
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


