Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E8AECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8511A20658
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGEDPQMN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8511A20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbeJSCJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:09:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728851AbeJSCJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:09:32 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C472B20658;
        Thu, 18 Oct 2018 18:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539886044;
        bh=1IlCrphBLd2ppfoYdkqdtmJNwEQBvrMip9VYqERm9Ho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gGEDPQMNQ2KvT8apyf0HhUzdeyI5RlKeXaHE7ncmJRi+G4VQLW/1R1KefK27y/FnO
         TO9Y8O1W2ig4O9gj85nUTn9FvRooIJG1bdEWaGsczXCaO6WH782o7imV9sBQ/EuyoX
         /7wg3frF0hy3/0BVi6yPBHAKOAGEMAobrghOufjE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Neuling <mikey@neuling.org>,
        Breno Leitao <leitao@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 41/48] powerpc/tm: Fix userspace r13 corruption
Date:   Thu, 18 Oct 2018 19:55:16 +0200
Message-Id: <20181018175430.101932836@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175427.133690306@linuxfoundation.org>
References: <20181018175427.133690306@linuxfoundation.org>
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


