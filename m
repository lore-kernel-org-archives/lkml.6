Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74B1C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A61A2176F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549276778;
	bh=D3ml3PO8bjPXalP01UOML4lkYb/n6ONgIsitWVQ8r/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CuN2n5KpSQk+U0F8uioCmnFIeMLVuAzqssDiRtBhXbbIxbhpfpfvpYF5N2EU7nNdQ
	 F+tATeHn7w2swsKSbf0y5zgBLrxNRfNfrmCHrfMUoow+uWzMUAP8/qE8vV+luUpR5D
	 ZX7r6VostwnijnFtnFdsyID+GCHzGGCOBnt5enD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbfBDKjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:39:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:37610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728391AbfBDKjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:39:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 026E3217D6;
        Mon,  4 Feb 2019 10:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276772;
        bh=D3ml3PO8bjPXalP01UOML4lkYb/n6ONgIsitWVQ8r/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xUA9c5UO6weJ5huIsIIna1L1tTXmsvZ9Cq8d+3pmV8qHEkGEp1Ms/GcPhzHOO8lN0
         E53uPYZufqAA9G/MmN4CFfa1hz3Xi1AZZW5k2MqOllzRG4h81ojDYgxqPdsXLGCgQH
         w+CvCzf7OdoigQdGyYtt2f7oojwTK0mfmVo9vwg8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 4.4 10/65] ARC: perf: map generic branches to correct hardware condition
Date:   Mon,  4 Feb 2019 11:36:03 +0100
Message-Id: <20190204103612.306606637@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103610.583715954@linuxfoundation.org>
References: <20190204103610.583715954@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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


