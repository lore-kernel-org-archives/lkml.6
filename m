Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8943FC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53478205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543988;
	bh=m+ulCkNmKM407BMsqM2mIyiq8hRNKYsFDUcZVTBrGZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ITDYpR9eZT0jxzcpuOE5P4d+1JFW2Q/LThGB0wzHSe2h3CSSB2oz4w4kPGnaLZCnW
	 Ep2Q1yxeYy5vp1ge8guV0s6pXUC/hi86/RIIJf/WGq/k1ZaT2F02W2KbXsJba0PSGR
	 lD9+oEHEBn17GWNUORpnq1yid5eEZvEx85ybN2oE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53478205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbeLKP6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:58:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:48214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731048AbeLKP6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:58:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9A09205C9;
        Tue, 11 Dec 2018 15:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543920;
        bh=m+ulCkNmKM407BMsqM2mIyiq8hRNKYsFDUcZVTBrGZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SmJqkKv/C8RQZNPiMhWA978LDImUVkZg7yr1bvqrlhQpYAhjTmTfPBuPUSK+QzMt2
         l6yR39BobD8yDgmhXf7AlEZTqXvRqgHVqgHhEjmU8ssVgjTJ8NvTOprtKRqgr1f0fb
         kVEIHYJW1DwYCdutZoQ+RLyKkVJQntB5juRy3h4k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.19 080/118] arm64: hibernate: Avoid sending cross-calling with interrupts disabled
Date:   Tue, 11 Dec 2018 16:41:39 +0100
Message-Id: <20181211151647.498633571@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

From: Will Deacon <will.deacon@arm.com>

commit b4aecf78083d8c6424657c1746c7c3de6e61669f upstream.

Since commit 3b8c9f1cdfc50 ("arm64: IPI each CPU after invalidating the
I-cache for kernel mappings"), a call to flush_icache_range() will use
an IPI to cross-call other online CPUs so that any stale instructions
are flushed from their pipelines. This triggers a WARN during the
hibernation resume path, where flush_icache_range() is called with
interrupts disabled and is therefore prone to deadlock:

  | Disabling non-boot CPUs ...
  | CPU1: shutdown
  | psci: CPU1 killed.
  | CPU2: shutdown
  | psci: CPU2 killed.
  | CPU3: shutdown
  | psci: CPU3 killed.
  | WARNING: CPU: 0 PID: 1 at ../kernel/smp.c:416 smp_call_function_many+0xd4/0x350
  | Modules linked in:
  | CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.20.0-rc4 #1

Since all secondary CPUs have been taken offline prior to invalidating
the I-cache, there's actually no need for an IPI and we can simply call
__flush_icache_range() instead.

Cc: <stable@vger.kernel.org>
Fixes: 3b8c9f1cdfc50 ("arm64: IPI each CPU after invalidating the I-cache for kernel mappings")
Reported-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Tested-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Tested-by: James Morse <james.morse@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/hibernate.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -214,7 +214,7 @@ static int create_safe_exec_page(void *s
 	}
 
 	memcpy((void *)dst, src_start, length);
-	flush_icache_range(dst, dst + length);
+	__flush_icache_range(dst, dst + length);
 
 	pgdp = pgd_offset_raw(allocator(mask), dst_addr);
 	if (pgd_none(READ_ONCE(*pgdp))) {


