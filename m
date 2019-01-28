Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0270AC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73E421741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548694480;
	bh=IxeLqy+pbG/czc1f5xcz8yg4UaOs4dx0S290veZj5zk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vK/qWam8HCAP/dLrTDmLmGstzl3rO/AQoAkyQRm09xbYZjsQf15vTaPzWdTk9bJgL
	 bNn1jzvUtdNKl5PCnV3yKeJYDMlyJ2G/MVcNrcwIE8ldHIbAFkegtCjthJOWNryfzV
	 oIosq51GXfKe9v1gThzCxnWEi+5hat8lBf7rACNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388317AbfA1Qyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:54:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:52094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388299AbfA1QRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:17:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02D7320879;
        Mon, 28 Jan 2019 16:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692272;
        bh=IxeLqy+pbG/czc1f5xcz8yg4UaOs4dx0S290veZj5zk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a6GcsT5qbx5YPD8Z1G0H23teXbp2srtmyRVMiqDG5hE/+Qv1pM+eR37vfY8JNBwXy
         qaEoYzKRv5XarH5cF6IFcrZVkBoGNioOvUFPL0WM77kz9/1u9CQPlqJNpt0UfhACWg
         AjfRqWCJG8EttLuO5BAX2WLXB8tcTyN0P1TBBFnw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.14 134/170] powerpc/mm: Fix reporting of kernel execute faults on the 8xx
Date:   Mon, 28 Jan 2019 11:11:24 -0500
Message-Id: <20190128161200.55107-134-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
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
index 6e1e39035380..52863deed65d 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -215,7 +215,9 @@ static int mm_fault_error(struct pt_regs *regs, unsigned long addr, int fault)
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

