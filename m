Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50572C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 06:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B73D20834
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 06:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmjJjIXH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B73D20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbeLBGnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 01:43:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:43776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbeLBGnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 01:43:12 -0500
Received: from localhost (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AC4F2080A;
        Sun,  2 Dec 2018 06:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543732989;
        bh=tUScfa9qufsdJMhxsv09IInvsVqQ3er9DhtdOKBsedo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PmjJjIXHVPc7n/4NJP3Wpgi7TnRTAJd+INlo/sBlI5dDlIstOAn+EXAkpbzZvX4tn
         Umz3Hy6k51C8x7SU5/86+vUpdRnDQfOiuLB/0+ZwcuGPqcDZR2zhST69GtuBgo3LNv
         dcdbPqv2+a0iiFYpIn3Ntizx8x6CZpzwTb9ZztAI=
Date:   Sun, 2 Dec 2018 01:43:04 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     tglx@linutronix.de,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, stable@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] x86/mm: Drop usage of __flush_tlb_all() in
 kernel_physical_mapping_init()
Message-ID: <20181202064304.GA221015@sasha-vm>
References: <154362450646.2367148.16448130381211111341.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154362453268.2367148.268782514142834053.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <154362453268.2367148.268782514142834053.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 04:35:32PM -0800, Dan Williams wrote:
>Commit f77084d96355 "x86/mm/pat: Disable preemption around
>__flush_tlb_all()" addressed a case where __flush_tlb_all() is called
>without preemption being disabled. It also left a warning to catch other
>cases where preemption is not disabled. That warning triggers for the
>memory hotplug path which is also used for persistent memory enabling:
>
> WARNING: CPU: 35 PID: 911 at ./arch/x86/include/asm/tlbflush.h:460
> RIP: 0010:__flush_tlb_all+0x1b/0x3a
> [..]
> Call Trace:
>  phys_pud_init+0x29c/0x2bb
>  kernel_physical_mapping_init+0xfc/0x219
>  init_memory_mapping+0x1a5/0x3b0
>  arch_add_memory+0x2c/0x50
>  devm_memremap_pages+0x3aa/0x610
>  pmem_attach_disk+0x585/0x700 [nd_pmem]
>
>Andy wondered why a path that can sleep was using __flush_tlb_all() [1]
>and Dave confirmed the expectation for TLB flush is for modifying /
>invalidating existing pte entries, but not initial population [2]. Drop
>the usage of __flush_tlb_all() in phys_{p4d,pud,pmd}_init() on the
>expectation that this path is only ever populating empty entries for the
>linear map. Note, at linear map teardown time there is a call to the
>all-cpu flush_tlb_all() to invalidate the removed mappings.
>
>[1]: https://lore.kernel.org/lkml/9DFD717D-857D-493D-A606-B635D72BAC21@amacapital.net
>[2]: https://lore.kernel.org/lkml/749919a4-cdb1-48a3-adb4-adb81a5fa0b5@intel.com
>
>Fixes: f77084d96355 ("x86/mm/pat: Disable preemption around __flush_tlb_all()")
>Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>Cc: Thomas Gleixner <tglx@linutronix.de>
>Cc: Peter Zijlstra <peterz@infradead.org>
>Cc: Borislav Petkov <bp@alien8.de>
>Cc: <stable@vger.kernel.org>
>Reported-by: Andy Lutomirski <luto@kernel.org>
>Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
>Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Hi Dan,

This patch on it's own doesn't apply to any of the stable trees, does it
maybe depend on some of the previous patches in this series?

--
Thanks,
Sasha
