Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C906DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C86208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C86208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbeK2KPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:15:04 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37394 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbeK2KPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:15:04 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CF9E589F;
        Wed, 28 Nov 2018 23:11:47 +0000 (UTC)
Date:   Wed, 28 Nov 2018 15:11:45 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     luto@kernel.org, will.deacon@arm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        naveen.n.rao@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        jeyu@kernel.org, netdev@vger.kernel.org, ard.biesheuvel@linaro.org,
        jannh@google.com, kristen@linux.intel.com, dave.hansen@intel.com,
        deneen.t.dock@intel.com
Subject: Re: [PATCH 2/2] x86/modules: Make x86 allocs to flush when free
Message-Id: <20181128151145.78a3d8b1f66f6b8fd66f0629@linux-foundation.org>
In-Reply-To: <20181128000754.18056-3-rick.p.edgecombe@intel.com>
References: <20181128000754.18056-1-rick.p.edgecombe@intel.com>
        <20181128000754.18056-3-rick.p.edgecombe@intel.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018 16:07:54 -0800 Rick Edgecombe <rick.p.edgecombe@intel.com> wrote:

> Change the module allocations to flush before freeing the pages.
> 
> ...
>
> --- a/arch/x86/kernel/module.c
> +++ b/arch/x86/kernel/module.c
> @@ -87,8 +87,8 @@ void *module_alloc(unsigned long size)
>  	p = __vmalloc_node_range(size, MODULE_ALIGN,
>  				    MODULES_VADDR + get_module_load_offset(),
>  				    MODULES_END, GFP_KERNEL,
> -				    PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
> -				    __builtin_return_address(0));
> +				    PAGE_KERNEL_EXEC, VM_IMMEDIATE_UNMAP,
> +				    NUMA_NO_NODE, __builtin_return_address(0));
>  	if (p && (kasan_module_alloc(p, size) < 0)) {
>  		vfree(p);
>  		return NULL;

Should any other architectures do this?
