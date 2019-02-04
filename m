Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E5BC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36925217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277174;
	bh=496DgQahFoBAya8f0wELTpDV0zqW7Q/+FuevApmtA74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Itp2wOVq3JXB82FwNHoICgdF88+Sbjntdg7ng7Gw6qSTGTqImo5OsW3DYcHVng7VC
	 lIrW19XpgIQ3qN7AV/vgMgpIK+jbeu3ORp3YkEaRLrY7sSTfXHCbIAIjMOmz2cPsZH
	 PiTVAx3hmAfDR7id4sAW2A9VvqmQTaB/pyjA+WN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730898AbfBDKqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:46:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:44358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731350AbfBDKqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:46:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F4021217D6;
        Mon,  4 Feb 2019 10:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277169;
        bh=496DgQahFoBAya8f0wELTpDV0zqW7Q/+FuevApmtA74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q9oeV73heepf6oF5so6F1R88SC4KRgpzuvQ8ScmH1a45inW6dU1tfmfJHRVVPrWlL
         w06z+9ye7PbeutELEt50aU6tUoNe2VAohXneqFIzgMzgPM45KzsDWBSB9KEkivIGAI
         qjmXCfTpvCfnFG9uOid+/GKmyDvWpX/1jBq9TwHQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.14 26/46] arm64: kaslr: ensure randomized quantities are clean also when kaslr is off
Date:   Mon,  4 Feb 2019 11:36:57 +0100
Message-Id: <20190204103613.128089789@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103608.651205056@linuxfoundation.org>
References: <20190204103608.651205056@linuxfoundation.org>
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

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

commit 8ea235932314311f15ea6cf65c1393ed7e31af70 upstream.

Commit 1598ecda7b23 ("arm64: kaslr: ensure randomized quantities are
clean to the PoC") added cache maintenance to ensure that global
variables set by the kaslr init routine are not wiped clean due to
cache invalidation occurring during the second round of page table
creation.

However, if kaslr_early_init() exits early with no randomization
being applied (either due to the lack of a seed, or because the user
has disabled kaslr explicitly), no cache maintenance is performed,
leading to the same issue we attempted to fix earlier, as far as the
module_alloc_base variable is concerned.

Note that module_alloc_base cannot be initialized statically, because
that would cause it to be subject to a R_AARCH64_RELATIVE relocation,
causing it to be overwritten by the second round of KASLR relocation
processing.

Fixes: f80fb3a3d508 ("arm64: add support for kernel ASLR")
Cc: <stable@vger.kernel.org> # v4.6+
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/kaslr.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -88,6 +88,7 @@ u64 __init kaslr_early_init(u64 dt_phys)
 	 * we end up running with module randomization disabled.
 	 */
 	module_alloc_base = (u64)_etext - MODULES_VSIZE;
+	__flush_dcache_area(&module_alloc_base, sizeof(module_alloc_base));
 
 	/*
 	 * Try to map the FDT early. If this fails, we simply bail,


