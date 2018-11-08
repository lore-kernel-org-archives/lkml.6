Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AF7ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BD42089A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJov1msc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98BD42089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbeKIHbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:31:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:46644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbeKIHbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:31:52 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5290220840;
        Thu,  8 Nov 2018 21:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714066;
        bh=kiVlvCJab2hihUJsl94SlbXxeDgbswky7gZvzo7ICLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tJov1msciGp2oOiPexgfYI9oYSciyyZ5vUYuh80Qvywu3gXfw/arIz6G6SQke0eih
         UZaraIk84CY9BrWVvLgcmuxqDjnbgBvdhqpJm+I+fJdg1d0g05p8tN/d5E/kGwRrwO
         yalyIQoxRYCwSVES63TcG+q1KR4fuKcPAzOvMEgM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Neuling <mikey@neuling.org>,
        Breno Leitao <leitao@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 018/144] powerpc/tm: Fix userspace r13 corruption
Date:   Thu,  8 Nov 2018 13:49:49 -0800
Message-Id: <20181108215056.113886501@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Neuling <mikey@neuling.org>

[ Upstream commit cf13435b730a502e814c63c84d93db131e563f5f ]

When we treclaim we store the userspace checkpointed r13 to a scratch
SPR and then later save the scratch SPR to the user thread struct.

Unfortunately, this doesn't work as accessing the user thread struct
can take an SLB fault and the SLB fault handler will write the same
scratch SPRG that now contains the userspace r13.

To fix this, we store r13 to the kernel stack (which can't fault)
before we access the user thread struct.

Found by running P8 guest + powervm + disable_1tb_segments + TM. Seen
as a random userspace segfault with r13 looking like a kernel address.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/tm.S |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -199,13 +199,20 @@ dont_backup_fp:
 	std	r1, PACATMSCRATCH(r13)
 	ld	r1, PACAR1(r13)
 
-	/* Store the PPR in r11 and reset to decent value */
 	std	r11, GPR11(r1)			/* Temporary stash */
 
+	/*
+	 * Store r13 away so we can free up the scratch SPR for the SLB fault
+	 * handler (needed once we start accessing the thread_struct).
+	 */
+	GET_SCRATCH0(r11)
+	std	r11, GPR13(r1)
+
 	/* Reset MSR RI so we can take SLB faults again */
 	li	r11, MSR_RI
 	mtmsrd	r11, 1
 
+	/* Store the PPR in r11 and reset to decent value */
 	mfspr	r11, SPRN_PPR
 	HMT_MEDIUM
 
@@ -234,7 +241,7 @@ dont_backup_fp:
 	ld	r4, GPR7(r1)			/* user r7 */
 	ld	r5, GPR11(r1)			/* user r11 */
 	ld	r6, GPR12(r1)			/* user r12 */
-	GET_SCRATCH0(8)				/* user r13 */
+	ld	r8, GPR13(r1)			/* user r13 */
 	std	r3, GPR1(r7)
 	std	r4, GPR7(r7)
 	std	r5, GPR11(r7)


