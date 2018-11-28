Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4C5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 01:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31254206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 01:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31254206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbeK1Mjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 07:39:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57434 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbeK1Mjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 07:39:42 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 41E183002C6A;
        Wed, 28 Nov 2018 01:39:53 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 58AEC5C1B2;
        Wed, 28 Nov 2018 01:39:52 +0000 (UTC)
Date:   Wed, 28 Nov 2018 09:39:49 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, X86 ML <x86@kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Dave Anderson <anderson@redhat.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] x86_64, vmcoreinfo: Append 'page_offset_base' to
 vmcoreinfo
Message-ID: <20181128013949.GH1824@MiWiFi-R3L-srv>
References: <1542318469-13699-1-git-send-email-bhsharma@redhat.com>
 <20181121113944.GD27797@zn.tnic>
 <CAGXu5jKYxgLPD4YonGSXjECJS=c18rxWmuFC1eeUJK9fLeTxcg@mail.gmail.com>
 <20181127232916.GG1824@MiWiFi-R3L-srv>
 <CAGXu5jJzVMmqJ9JvFqDhDx=QShiWisWO0bY49cD5r-7By5dxFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJzVMmqJ9JvFqDhDx=QShiWisWO0bY49cD5r-7By5dxFg@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 28 Nov 2018 01:39:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/18 at 04:39pm, Kees Cook wrote:
> >> >> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> >> >> index 4c8acdfdc5a7..6161d77c5bfb 100644
> >> >> --- a/arch/x86/kernel/machine_kexec_64.c
> >> >> +++ b/arch/x86/kernel/machine_kexec_64.c
> >> >> @@ -356,6 +356,9 @@ void arch_crash_save_vmcoreinfo(void)
> >> >>       VMCOREINFO_SYMBOL(init_top_pgt);
> >> >>       vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
> >> >>                       pgtable_l5_enabled());
> >> >> +#ifdef CONFIG_RANDOMIZE_BASE
> 
> Okay, gotcha. In that case, shouldn't this be CONFIG_RANDOMIZE_MEMORY?

Currently, Kirill added level5 support to x86_64, and kernel with level5
enabled can be boot switched into level4 or level5 with kernel option
"no5lvl". So page_offset_base will be changed accordingly. You can see
code pasted at bottom, DYNAMIC_MEMORY_LAYOUT is added for this change,
not only KASLR, but 5LEVEL.

If only put it inside ifdef CONFIG_RANDOMIZE_MEMORY, change between l4
and l5 will force us to decide page_offset again if
CONFIG_RANDOMIZE_MEMORY or CONFIG_RANDOMIZE_BASE is not set. Besides, 
below commit change the starting address of the direct mapping again, if
only judge CONFIG_RANDOMIZE_MEMORY, in case KASLR is disabled, code in
userspace may need many if-else checking as below. So if we pass, better
pass it for all.

get_page_offset()
{
	if(get_page_offset_from_vmcoreinfo()) {
		xxx //in KASLR case
		return;
	} else if (check_5level_paging()) {
		if (version < 4.21) {
			page_offset = 0xff10000000000000;
		} else //version > = 4.21
		{
			page_offset = 0xff11000000000000;
		}
		
	} else { //4level
		if (version < 2.6.27) {
			page_offset = 0xffff810000000000;
		} else if (version < 4.21) {
			page_offset = 0xffff880000000000;
		} else //version > = 4.21
		{
			page_offset = 0xffff888000000000,;
		}
	}
}

Sign, seeing above code, I still think that deducing it from
kcore/vmcore elf header is better. Can't we be better to ourselves?

commit d52888aa2753e3063a9d3a0c9f72f94aa9809c15
Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Date:   Fri Oct 26 15:28:54 2018 +0300

    x86/mm: Move LDT remap out of KASLR region on 5-level paging

[bhe@ linux]$ git describe --contains d52888aa2753e3063a9d3a0c9f72f94aa9809c15
v4.20-rc2~5^2~4


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
unsigned long page_offset_base __ro_after_init = __PAGE_OFFSET_BASE_L4;                                                                           
EXPORT_SYMBOL(page_offset_base);
unsigned long vmalloc_base __ro_after_init = __VMALLOC_BASE_L4;
EXPORT_SYMBOL(vmalloc_base);
unsigned long vmemmap_base __ro_after_init = __VMEMMAP_BASE_L4;
EXPORT_SYMBOL(vmemmap_base);
#endif


config DYNAMIC_MEMORY_LAYOUT                                                                                                                      
        bool
        ---help---
          This option makes base addresses of vmalloc and vmemmap as well as
          __PAGE_OFFSET movable during boot.

config RANDOMIZE_MEMORY
        bool "Randomize the kernel memory sections"
        depends on X86_64
        depends on RANDOMIZE_BASE
        select DYNAMIC_MEMORY_LAYOUT
        default RANDOMIZE_BASE

config X86_5LEVEL
        bool "Enable 5-level page tables support"
        select DYNAMIC_MEMORY_LAYOUT
        select SPARSEMEM_VMEMMAP
        depends on X86_64
