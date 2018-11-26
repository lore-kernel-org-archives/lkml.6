Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1708CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 01:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB54E20865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 01:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB54E20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbeKZMU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 07:20:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46020 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbeKZMU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 07:20:57 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7B136307DAA0;
        Mon, 26 Nov 2018 01:28:27 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A0E2D425F;
        Mon, 26 Nov 2018 01:28:26 +0000 (UTC)
Date:   Mon, 26 Nov 2018 09:28:24 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        Boris Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Dave Anderson <anderson@redhat.com>,
        James Morse <james.morse@arm.com>,
        Omar Sandoval <osandov@fb.com>, x86@kernel.org,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] x86_64, vmcoreinfo: Append 'page_offset_base' to
 vmcoreinfo
Message-ID: <20181126012824.GB1824@MiWiFi-R3L-srv>
References: <1542318469-13699-1-git-send-email-bhsharma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542318469-13699-1-git-send-email-bhsharma@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 26 Nov 2018 01:28:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/18 at 03:17am, Bhupesh Sharma wrote:
> Adding 'page_offset_base' to the vmcoreinfo can be specially useful for
> live-debugging of a running kernel via user-space utilities
> like makedumpfile (see [1]).
> 
> Recently, I saw an issue with the 'makedumpfile' utility (see [2] for
> details), whose live debugging feature is broken with newer kernels

I think this paragraph explained why KCORE_REMAP adding caused the
mistake of page_offset calculation in makedumpfile. It can prove the
advantage of appending 'page_offset_base' to vmcoreinfo. The old way I
took in makedumpfile could be impacted by kernel code change, adding it
to vmcoreinfo can make it stable. The example is KCORE_REMAP adding, and
later it's removed.

But it's not live debugging feature of makedumpfile. Makedumpfile can't be
used to live debug. The feature is called '--mem-usage' in makedumpfile,
in fact it's used to estimate how big the vmcore could be so that customer
can deply an appropriate size of storage space to store it. Because both
kcore and vmcore are all elf files which the 1st kernel's memory is
mapped to, even though they are different, kcore is dynamically changing.
This is more likely a precision in order of of magnitude. This is a feature
required by redhat customer.

I thought you are talking about using DaveA's crash utility to live
debug the running kernel, like we usually do with gdb.

	gdb vmlinux /proc/kcore

Yes, this gdb live debugging is broken because of KASLR. We have bug about
this, while it has not been fixed. Using Crash utility to replace gdb is
one way if Crash code is adjusted.

> (I tested the same with 4.19-rc8+ kernel), as KCORE_REMAP segments were
> added to kcore, thus leading to an additional sections in the same, and
> makedumpfile is not longer able to determine the start of direct
> mapping of all physical memory, as it relies on traversing the PT_LOAD
> segments inside kcore and using the last PT_LOAD segment
> to determine the start of direct mapping.
...
> Testing:
> -------

This one vmcoreinfo entry adding won't impact kernel performance. And
page_offset_base need be got during makedumpfile initialization, it
won't impact makedumpfile efficiency either, especially compared with
the later page filterring and writting out to storage space. I don't
think there's any need to provide a detailed test result here. If
possible, just mention it works in this way, maybe it's better in some
aspects, such as code simplicity, etc.

>  - I tested this patch (rebased on 'linux-next') on a x86_64 machine
>    using the modified 'makedumpfile' user-space code (see [3] for my
>    github tree which contains the same) for determining how many pages
>    are dumpable when different dump_level is specified (which is
>    one use-case of live-debugging via 'makedumpfile').
>  - I tested both the KASLR and non-KASLR boot cases with this patch.
>  - Here is one sample log (for KASLR boot case) on my x86_64 machine:
> 
>    < snip..>
>    The kernel doesn't support mmap(),read() will be used instead.
> 
>    TYPE		PAGES			EXCLUDABLE	DESCRIPTION
>    ----------------------------------------------------------------------
>    ZERO		21299           	yes		Pages filled
>    with zero
>    NON_PRI_CACHE	91785           	yes		Cache
>    pages without private flag
>    PRI_CACHE	1               	yes		Cache pages with
>    private flag
>    USER		14057           	yes		User process
>    pages
>    FREE		740346          	yes		Free pages
>    KERN_DATA	58152           	no		Dumpable kernel
>    data
> 
>    page size:		4096
>    Total pages on system:	925640
>    Total size on system:	3791421440       Byte
> 
...

> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index 4c8acdfdc5a7..6161d77c5bfb 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -356,6 +356,9 @@ void arch_crash_save_vmcoreinfo(void)
>  	VMCOREINFO_SYMBOL(init_top_pgt);
>  	vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
>  			pgtable_l5_enabled());
> +#ifdef CONFIG_RANDOMIZE_BASE

Finally, embracing it into CONFIG_RANDOMIZE_BASE ifdefery seems not
right. The latest kernel is using page_offset_base to do the dynamic
memory layout between level4 and level5 changing. This may not work in
5-level system with CONFIG_RANDOMIZE_BASE=n.

> +	VMCOREINFO_NUMBER(page_offset_base);
> +#endif
>  
>  #ifdef CONFIG_NUMA
>  	VMCOREINFO_SYMBOL(node_data);
> -- 
> 2.7.4
> 
