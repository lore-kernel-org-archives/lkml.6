Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3F0C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98521206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897220;
	bh=6y/QdhOPm1lJOdSu4vQyoPU9Ji3wwxGw/wkZhlF9na0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TWrUxDTvUX7Vg+/V88bd8kcPfSvjPAuAbg7g0BImoqdrJl4NYgZ9ZCiAZR03+W7fn
	 FjFZKL8ROzrXs8f//UqhLPAIY5oqZQQIZYI48bFD76h+4LzUYnFQ4nwxYIWlhjkH5B
	 amnoaITv3UEM708wtCfx/5MypqbNJbt8Y+qLzceE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389979AbfBKPAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:00:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:48148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389465AbfBKPAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:00:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B91BE21773;
        Mon, 11 Feb 2019 15:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897215;
        bh=6y/QdhOPm1lJOdSu4vQyoPU9Ji3wwxGw/wkZhlF9na0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qN7BWDK2AZIFxIqhynv0GLNWo+3jq+8cS8pYKpY1SHGdOIFtPYy61PK1Q6gJ0ASoX
         JDNssXl0lr1UX3ZLwTDMJ/yPHkw7/A9BwT40kNq4eMFP6B90A5X5WtIYDXhKc91NDZ
         ZuZdCoR/skd5nb5sju5w/bvrUQEI2ZlARYOHRFEY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 129/205] powerpc/mm: Fix reporting of kernel execute faults on the 8xx
Date:   Mon, 11 Feb 2019 15:18:47 +0100
Message-Id: <20190211141836.874786059@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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



