Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09332C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C384E218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900741;
	bh=oGg5iQVgAh9anK6wyEm98yTwIRFqFSuqdZaexuZLnA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=arIR2RQyk1UAToKQYWQ+9q36xwNV5Dum/Y6sNDQxkJtlxkXdZVZfZAkmxbdcQ4tK0
	 gqwqLseAJITGTO/PFMhsEe+U3WrJy/cYXpPOQ2UmUD6rYe1db0M/juo9fFfpopnEGg
	 HNwANHf3rYPvRhiSHLZXJsJissb1ruoTE5ui6SoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbfBKP7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:59:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:39978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730194AbfBKOcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:32:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4B4D20844;
        Mon, 11 Feb 2019 14:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895552;
        bh=oGg5iQVgAh9anK6wyEm98yTwIRFqFSuqdZaexuZLnA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bA6ji38ShWkrJmeMyyZxkzcqyJoQpmUP6ZEeqaOoUpXlX6otSzx+iQ2bdHw+vClCU
         pALqUgz00eU/dhe1GCL70M0JNWA46zp84X/x37sN7iztza8JumPlNIHf1GGeEOqWBd
         E4rhQITKRDcoTp1N5lV4kTefo+oALx1Rfyfiw0M8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 241/352] powerpc/mm: Fix reporting of kernel execute faults on the 8xx
Date:   Mon, 11 Feb 2019 15:17:48 +0100
Message-Id: <20190211141902.496412047@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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



