Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10ECDC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D425E2073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549278014;
	bh=qUKTDBpIIabum9KoFkPIihz1dVKieHOX3Iaa9KkShys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i2n66SkPQr6f0XRdRaiJsmNZyc73Y6MWzUb3KCILnluItPXdRresdA7nklYH+PaZt
	 aXa0iJfhzsbgJ0wKhp9nzMxyjw5ZEA0OS6JaKUzhKBPIjZAMmqH9+rpYBWGcgprGa2
	 0Y7tG2SspmPGkEB8DjrvnEeS61n3f0bk+4IPE82g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732801AbfBDLAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:00:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:47248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732017AbfBDKtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:49:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDF72217D6;
        Mon,  4 Feb 2019 10:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277362;
        bh=qUKTDBpIIabum9KoFkPIihz1dVKieHOX3Iaa9KkShys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bjdGHBbeScPhRcaXmDCm9j3Fno+pIAhlULtUIBowgV9VZB5rTG0DpwV+cYRnds2lK
         PcjGkR507C3jEi8XX3rAu3UNZJzre9FVJ9KElRfcSkcapsI20kodhasLEt3j224y9x
         c3RcvqWYNtDTgL85QPvD2gBRud78L+cDPHmK7IGY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Morse <james.morse@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.19 44/74] arm64: hibernate: Clean the __hyp_text to PoC after resume
Date:   Mon,  4 Feb 2019 11:36:57 +0100
Message-Id: <20190204103625.253308250@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103619.714714157@linuxfoundation.org>
References: <20190204103619.714714157@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Morse <james.morse@arm.com>

commit f7daa9c8fd191724b9ab9580a7be55cd1a67d799 upstream.

During resume hibernate restores all physical memory. Any memory
that is accessed with the MMU disabled needs to be cleaned to the
PoC.

KVMs __hyp_text was previously ommitted as it runs with the MMU
enabled, but now that the hyp-stub is located in this section,
we must clean __hyp_text too.

This ensures secondary CPUs that come online after hibernate
has finished resuming, and load KVM via the freshly written
hyp-stub see the correct instructions.

Signed-off-by: James Morse <james.morse@arm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/hibernate.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -299,8 +299,10 @@ int swsusp_arch_suspend(void)
 		dcache_clean_range(__idmap_text_start, __idmap_text_end);
 
 		/* Clean kvm setup code to PoC? */
-		if (el2_reset_needed())
+		if (el2_reset_needed()) {
 			dcache_clean_range(__hyp_idmap_text_start, __hyp_idmap_text_end);
+			dcache_clean_range(__hyp_text_start, __hyp_text_end);
+		}
 
 		/* make the crash dump kernel image protected again */
 		crash_post_resume();


