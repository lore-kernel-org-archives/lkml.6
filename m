Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9A7C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 23:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8DD20851
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 23:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8DD20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeK1K2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 05:28:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbeK1K2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 05:28:52 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A03D0307DAB3;
        Tue, 27 Nov 2018 23:29:21 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CB14B19747;
        Tue, 27 Nov 2018 23:29:20 +0000 (UTC)
Date:   Wed, 28 Nov 2018 07:29:16 +0800
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
Message-ID: <20181127232916.GG1824@MiWiFi-R3L-srv>
References: <1542318469-13699-1-git-send-email-bhsharma@redhat.com>
 <20181121113944.GD27797@zn.tnic>
 <CAGXu5jKYxgLPD4YonGSXjECJS=c18rxWmuFC1eeUJK9fLeTxcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKYxgLPD4YonGSXjECJS=c18rxWmuFC1eeUJK9fLeTxcg@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 27 Nov 2018 23:29:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/18 at 02:16pm, Kees Cook wrote:
> Why is KERNELOFFSET= not sufficient?
> 
> See commit b6085a865762 ("x86, kaslr: export offset in VMCOREINFO ELF notes")
> 
> +       vmcoreinfo_append_str("KERNELOFFSET=%lx\n",
> +                             (unsigned long)&_text - __START_KERNEL);

KERNELOFFSET is virtual address delta after kernel text KASLR, namely
the offset from the original default kernel text virtual address,
0xffffffff88000000.

While after memory region KASLR in kernel_randomize_memory(), the
starting address of the direct mapping of physical memory, PAGE_OFFSET,
is changed too. We need get it to analyze memory in makedumpfile/crash.
Currently we deduce it from elf program segment of kcore:
Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
......

  LOAD           0x00000a62c0004000 0xffff8a62c0001000 0x0000000000001000
                 0x000000000009c000 0x000000000009c000  RWE    1000

page_offset = 0xffff8a62c0001000 - 0x0000000000001000;
Since we put the direct mapping segments at the bottom part of kcore, we
can always get page_offset right.

Thanks
Baoquan

> 
> -Kees
> 
> >> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> >> index 4c8acdfdc5a7..6161d77c5bfb 100644
> >> --- a/arch/x86/kernel/machine_kexec_64.c
> >> +++ b/arch/x86/kernel/machine_kexec_64.c
> >> @@ -356,6 +356,9 @@ void arch_crash_save_vmcoreinfo(void)
> >>       VMCOREINFO_SYMBOL(init_top_pgt);
> >>       vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
> >>                       pgtable_l5_enabled());
> >> +#ifdef CONFIG_RANDOMIZE_BASE
> >> +     VMCOREINFO_NUMBER(page_offset_base);
> >> +#endif
> >>
> >>  #ifdef CONFIG_NUMA
> >>       VMCOREINFO_SYMBOL(node_data);
> 
> -- 
> Kees Cook
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
