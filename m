Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945E9C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642192147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548696828;
	bh=vC/ukNBMPh3rDeABJNkvK8Wl2UdjPsjqWwLjaMBZ+MU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vTiAXo480YkqjMhCpk4OPKAPSRPq9InQx81ICeCZ+92DuuwF1S93maT8Md3j9Nl3f
	 V28zedNfv8dQhGlQW5OtH14Kquv7IyWb2EdXF3+1XLOCr3lCWLBQjdGDO/kTPcnYpE
	 oJ1NZC0pVJa3eQ7qXS2APVG4yVy15Dw3p058b7vw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbfA1Rdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:33:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:42092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729377AbfA1P4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:56:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F7A62175B;
        Mon, 28 Jan 2019 15:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690980;
        bh=vC/ukNBMPh3rDeABJNkvK8Wl2UdjPsjqWwLjaMBZ+MU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CDda3iwQHxk1UP0f3R7y8IogAXO0y/zOmtTwEeX8iFKRobmyGUXqVoLXyioKLtlXZ
         wSy5nsaNdOoD5vSC/yJHP8fAQAX7C1id5E4wfwsh4Wr0zujjOhyKtPq7NcsctzzeuE
         AHyoFJUa9cia+CckXEecJZeL8dz2jYSEE9U+H2m8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.20 253/304] powerpc/mm: Fix reporting of kernel execute faults on the 8xx
Date:   Mon, 28 Jan 2019 10:42:50 -0500
Message-Id: <20190128154341.47195-253-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

[ Upstream commit ffca395b11c4a5a6df6d6345f794b0e3d578e2d0 ]

On the 8xx, no-execute is set via PPP bits in the PTE. Therefore
a no-exec fault generates DSISR_PROTFAULT error bits,
not DSISR_NOEXEC_OR_G.

This patch adds DSISR_PROTFAULT in the test mask.

Fixes: d3ca587404b3 ("powerpc/mm: Fix reporting of kernel execute faults")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/fault.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 1697e903bbf2..50e5c790d11e 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -226,7 +226,9 @@ static int mm_fault_error(struct pt_regs *regs, unsigned long addr,
 static bool bad_kernel_fault(bool is_exec, unsigned long error_code,
 			     unsigned long address)
 {
-	if (is_exec && (error_code & (DSISR_NOEXEC_OR_G | DSISR_KEYFAULT))) {
+	/* NX faults set DSISR_PROTFAULT on the 8xx, DSISR_NOEXEC_OR_G on others */
+	if (is_exec && (error_code & (DSISR_NOEXEC_OR_G | DSISR_KEYFAULT |
+				      DSISR_PROTFAULT))) {
 		printk_ratelimited(KERN_CRIT "kernel tried to execute"
 				   " exec-protected page (%lx) -"
 				   "exploit attempt? (uid: %d)\n",
-- 
2.19.1

