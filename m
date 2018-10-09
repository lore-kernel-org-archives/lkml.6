Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8C7C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 04:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2251E206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 04:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2251E206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeJIMDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 08:03:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbeJIMDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 08:03:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 80120308424D;
        Tue,  9 Oct 2018 04:48:43 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C7E764436;
        Tue,  9 Oct 2018 04:48:42 +0000 (UTC)
Date:   Tue, 9 Oct 2018 12:48:39 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-doc@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Thomas Garnier <thgarnie@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/3 v2] x86/mm/doc: Enhance the x86-64 virtual memory
 layout descriptions
Message-ID: <20181009044839.GH5140@MiWiFi-R3L-srv>
References: <20181006084327.27467-1-bhe@redhat.com>
 <20181006122259.GB418@gmail.com>
 <20181006143821.GA72401@gmail.com>
 <20181006170317.GA21297@gmail.com>
 <CALCETrXcsf9fNAkZH29e=p8pTkqE=YR42cbnLWmqqbAbJQ6KbA@mail.gmail.com>
 <20181009003553.GG5140@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009003553.GG5140@MiWiFi-R3L-srv>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 09 Oct 2018 04:48:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/18 at 08:35am, Baoquan He wrote:
> Hi Andy, Ingo
> 
> On 10/06/18 at 03:17pm, Andy Lutomirski wrote:
> > On Sat, Oct 6, 2018 at 10:03 AM Ingo Molnar <mingo@kernel.org> wrote:
> > > ... but unless I'm missing something it's not really fundamental for it to be at the PGD level
> > > - it could be two levels lower as well, and it could move back to the same place where it's on
> > > the 47-bit kernel.
> > >
> > 
> > The subtlety is that, if it's lower than the PGD level, there end up
> > being some tables that are private to each LDT-using mm that map
> > things other than the LDT.  Those tables cover the same address range
> > as some corresponding tables in init_mm, and if those tables in
> > init_mm change after the LDT mapping is set up, the changes won't
> > propagate.
> > 
> > So it probably could be made to work, but it would take some extra care.
> 
> In 4-level paging mode, we reserve 512 GB virtual address space for it to
> map, the 512 GB is one PGD entry. In 5-level paging mode, we reserve 4
> PB for mapping LDT, and leave the previous 512 GB space next to
> cpu_entry_area mapping empty as unused hole. Maybe we can still put LDT
> map for PTI in the old place, after cpu_entry_area mapping in 5-level.
> Then in 5-level, 512 GB is only one p4d entry, however it's in the last
> pgd entry, each pgd points to 256 TB area, and the last pgd entry will
> points to p4d table which always exists in system since it contains
> kernel text mapping etc. Now if LDT take one entry in the always
> existing p4d table, maybe it can still works as before it owns a whole
> pgd entry, oh, no, 4 PB will cost 16 pgd entries.

Sorry, I am too long-winded. Here I mean that LDT map of 512 GB will
occupy one p4d entry alone, and the corresponding pgd and p4d table are
all always presnet and populated and unchanged. It might not need
any page table change to propagate. Not sure if there's any other risk
in this case.

Thanks
Baoquan

> 
> Most importantly, putting LDT map for PTI in KASLR area, won't it cause
> code bug, if we randomize the direct mapping/vmaloc/vmemmap to make them
> overlap with LDT map area? We didn't take LDT into consideration when do
> memory region KASLR.
> 
> 
> 4-level virutal memory layout:
> 
> ffff800000000000 | -128    TB | ffff87ffffffffff |    8 TB | ... guard hole, also reserved for hypervisor
> ffff880000000000 | -120    TB | ffffc7ffffffffff |   64 TB | direct mapping of all physical memory (page_offset_base)
> ffffc80000000000 |  -56    TB | ffffc8ffffffffff |    1 TB | ... unused hole
> ffffc90000000000 |  -55    TB | ffffe8ffffffffff |   32 TB | vmalloc/ioremap space (vmalloc_base)
> ffffe90000000000 |  -23    TB | ffffe9ffffffffff |    1 TB | ... unused hole
> ffffea0000000000 |  -22    TB | ffffeaffffffffff |    1 TB | virtual memory map (vmemmap_base)
> ffffeb0000000000 |  -21    TB | ffffebffffffffff |    1 TB | ... unused hole
> ffffec0000000000 |  -20    TB | fffffbffffffffff |   16 TB | KASAN shadow memory
> fffffc0000000000 |   -4    TB | fffffdffffffffff |    2 TB | ... unused hole
>                  |            |                  |         | vaddr_end for KASLR
> fffffe0000000000 |   -2    TB | fffffe7fffffffff |  0.5 TB | cpu_entry_area mapping
> fffffe8000000000 |   -1.5  TB | fffffeffffffffff |  0.5 TB | LDT remap for PTI
> 					^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^	
> ffffff0000000000 |   -1    TB | ffffff7fffffffff |  0.5 TB | %esp fixup stacks
> 
> 5-level virtual memory layout:
> 
> ff10000000000000 |  -60    PB | ff8fffffffffffff |   32 PB | direct mapping of all physical memory (page_offset_base)
> ff90000000000000 |  -28    PB | ff9fffffffffffff |    4 PB | LDT remap for PTI
> 					^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> ffa0000000000000 |  -24    PB | ffd1ffffffffffff | 12.5 PB | vmalloc/ioremap space (vmalloc_base)
> ffd2000000000000 |  -11.5  PB | ffd3ffffffffffff |  0.5 PB | ... unused hole
> ffd4000000000000 |  -11    PB | ffd5ffffffffffff |  0.5 PB | virtual memory map (vmemmap_base)
> ffd6000000000000 |  -10.5  PB | ffdeffffffffffff | 2.25 PB | ... unused hole
> ffdf000000000000 |   -8.25 PB | fffffdffffffffff |   ~8 PB | KASAN shadow memory
> fffffc0000000000 |   -4    TB | fffffdffffffffff |    2 TB | ... unused hole
>                  |            |                  |         | vaddr_end for KASLR
> fffffe0000000000 |   -2    TB | fffffe7fffffffff |  0.5 TB | cpu_entry_area mapping
> fffffe8000000000 |   -1.5  TB | fffffeffffffffff |  0.5 TB | ... unused hole
> ffffff0000000000 |   -1    TB | ffffff7fffffffff |  0.5 TB | %esp fixup stacks
