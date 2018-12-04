Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C402C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A4E214ED
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIzLN660"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A4E214ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbeLDLEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:04:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:50774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727917AbeLDLEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:04:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51FB1214DA;
        Tue,  4 Dec 2018 11:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921441;
        bh=LVzxVzcBcgNb/YuCttW6yzZWwJcVYMN3Qu+7aj5uNFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EIzLN660onp945NFBbKGk6CJwSb19H+0jkqWNVUKN2G0hiKJBuO6rIQW2JEUon93l
         NDyJvk+C97Nt1/3K1KiEKpp1lot+7JAG/d/D2vH1z21m+8Ma/BdP6uh4t1aNbbinsC
         EU3pNIXCJowTupjwSPwgLErrZsZASFdCGGJm9buY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bpetkov@suse.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 073/146] x86/bugs: Fix the AMD SSBD usage of the SPEC_CTRL MSR
Date:   Tue,  4 Dec 2018 11:49:19 +0100
Message-Id: <20181204103729.772640229@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
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

From: Tom Lendacky thomas.lendacky@amd.com

commit 612bc3b3d4be749f73a513a17d9b3ee1330d3487 upstream

On AMD, the presence of the MSR_SPEC_CTRL feature does not imply that the
SSBD mitigation support should use the SPEC_CTRL MSR. Other features could
have caused the MSR_SPEC_CTRL feature to be set, while a different SSBD
mitigation option is in place.

Update the SSBD support to check for the actual SSBD features that will
use the SPEC_CTRL MSR.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Borislav Petkov <bpetkov@suse.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 6ac2f49edb1e ("x86/bugs: Add AMD's SPEC_CTRL MSR usage")
Link: http://lkml.kernel.org/r/20180702213602.29202.33151.stgit@tlendack-t1.amdoffice.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -166,7 +166,8 @@ x86_virt_spec_ctrl(u64 guest_spec_ctrl,
 		guestval |= guest_spec_ctrl & x86_spec_ctrl_mask;
 
 		/* SSBD controlled in MSR_SPEC_CTRL */
-		if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD))
+		if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD) ||
+		    static_cpu_has(X86_FEATURE_AMD_SSBD))
 			hostval |= ssbd_tif_to_spec_ctrl(ti->flags);
 
 		if (hostval != guestval) {
@@ -535,9 +536,10 @@ static enum ssb_mitigation __init __ssb_
 		 * Intel uses the SPEC CTRL MSR Bit(2) for this, while AMD may
 		 * use a completely different MSR and bit dependent on family.
 		 */
-		if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
+		if (!static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD) &&
+		    !static_cpu_has(X86_FEATURE_AMD_SSBD)) {
 			x86_amd_ssb_disable();
-		else {
+		} else {
 			x86_spec_ctrl_base |= SPEC_CTRL_SSBD;
 			x86_spec_ctrl_mask |= SPEC_CTRL_SSBD;
 			wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);


