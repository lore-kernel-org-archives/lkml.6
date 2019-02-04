Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5387CC282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15FEA2070C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277328;
	bh=ZlEdznJGZI5dDuiNAC6ZviUs4L5niiaj4d+Nh3gCYMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0U8XXi7BGkD747deeueNqqdD4IQXf6eQMLEprMYKrDrqaPrYLF0pmHimKTS5Q013D
	 7mj7erBGXUBYIQmWuRQ3TMrDA/PybyZeZUWrqkrs4HwRRxtwwqNQ9OfQNsmk/4jtAk
	 aDr3Xqdd77say7iUarZK7a8/ej6RYspSt1n0wXKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731901AbfBDKsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:48:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:46692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731411AbfBDKso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:48:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35E8E2070C;
        Mon,  4 Feb 2019 10:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277323;
        bh=ZlEdznJGZI5dDuiNAC6ZviUs4L5niiaj4d+Nh3gCYMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UsavTiKCegMpwh4R2gVFrxKSda0T0HSJPxfiBl6sjCdZ5sybIDzgkR1TKvriernmL
         m6hW+fqyV0emJwCPbXmzqJWsJMRPVmSG+xfRnOAgMuy45Lk1GE96vooZRksGbmJGv9
         1YUbAaPMsBJj/tjl1H8W6Z7sV/tXZu+gnoYO/7NI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.19 41/74] arm64: kaslr: ensure randomized quantities are clean also when kaslr is off
Date:   Mon,  4 Feb 2019 11:36:54 +0100
Message-Id: <20190204103624.801024564@linuxfoundation.org>
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


