Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45AEC04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2F021019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYQ6tzKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B2F021019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbeK3BLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:11:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:36332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728222AbeK3BLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:11:49 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E95C2208E7;
        Thu, 29 Nov 2018 14:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543500380;
        bh=KDkeRMymATt1860s7HzfNeD69XxFf9VqcPfSNGt8nPQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SYQ6tzKQrVKV3s4iaHtLtEYWLkuLZgz2UopbdvsMEl4LrjFN0pPUfzYKDSSa5F87b
         2uLQ/lJ4lhgreTWGoJnNZLO5kMicKIUXTkS/zcgBXpctamrEGyiDqRpYE2p3iiJD3m
         48xCeHFTpB72Cg6WSLrLIap0Rwz2Is9Jha9Juho0=
Date:   Thu, 29 Nov 2018 23:06:16 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     akpm@linux-foundation.org, luto@kernel.org, will.deacon@arm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com,
        naveen.n.rao@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, rostedt@goodmis.org, mingo@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, jeyu@kernel.org,
        netdev@vger.kernel.org, ard.biesheuvel@linaro.org,
        jannh@google.com, kristen@linux.intel.com, dave.hansen@intel.com,
        deneen.t.dock@intel.com
Subject: Re: [PATCH 0/2] =?ISO-2022-JP?B?RG9uGyRCIUcbKEJ0?= leave executable
 TLB entries to freed pages
Message-Id: <20181129230616.f017059a093841dbaa4b82e6@kernel.org>
In-Reply-To: <20181128000754.18056-1-rick.p.edgecombe@intel.com>
References: <20181128000754.18056-1-rick.p.edgecombe@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018 16:07:52 -0800
Rick Edgecombe <rick.p.edgecombe@intel.com> wrote:

> Sometimes when memory is freed via the module subsystem, an executable
> permissioned TLB entry can remain to a freed page. If the page is re-used to
> back an address that will receive data from userspace, it can result in user
> data being mapped as executable in the kernel. The root of this behavior is
> vfree lazily flushing the TLB, but not lazily freeing the underlying pages. 

Good catch!

> 
> There are sort of three categories of this which show up across modules, bpf,
> kprobes and ftrace:

For x86-64 kprobe, it sets the page NX and after that RW, and then release
via module_memfree. So I'm not sure it really happens on kprobes. (Of course
the default memory allocator is simpler so it may happen on other archs) But
interesting fixes.

Thank you,


> 
> 1. When executable memory is touched and then immediatly freed
> 
>    This shows up in a couple error conditions in the module loader and BPF JIT
>    compiler.
> 
> 2. When executable memory is set to RW right before being freed
> 
>    In this case (on x86 and probably others) there will be a TLB flush when its
>    set to RW and so since the pages are not touched between setting the
>    flush and the free, it should not be in the TLB in most cases. So this
>    category is not as big of a concern. However, techinically there is still a
>    race where an attacker could try to keep it alive for a short window with a
>    well timed out-of-bound read or speculative read, so ideally this could be
>    blocked as well.
> 
> 3. When executable memory is freed in an interrupt
> 
>    At least one example of this is the freeing of init sections in the module
>    loader. Since vmalloc reuses the allocation for the work queue linked list
>    node for the deferred frees, the memory actually gets touched as part of the
>    vfree operation and so returns to the TLB even after the flush from resetting
>    the permissions.
> 
> I have only actually tested category 1, and identified 2 and 3 just from reading
> the code.
> 
> To catch all of these, module_alloc for x86 is changed to use a new flag that
> instructs the unmap operation to flush the TLB before freeing the pages.
> 
> If this solution seems good I can plug the flag in for other architectures that
> define PAGE_KERNEL_EXEC.
> 
> 
> Rick Edgecombe (2):
>   vmalloc: New flag for flush before releasing pages
>   x86/modules: Make x86 allocs to flush when free
> 
>  arch/x86/kernel/module.c |  4 ++--
>  include/linux/vmalloc.h  |  1 +
>  mm/vmalloc.c             | 13 +++++++++++--
>  3 files changed, 14 insertions(+), 4 deletions(-)
> 
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
