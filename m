Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754003AbeCGBug (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 20:50:36 -0500
Received: from exmail.andestech.com ([59.124.169.137]:10727 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753525AbeCGBuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 20:50:35 -0500
Date: Wed, 7 Mar 2018 09:47:47 +0800
From: Alan Kao <alankao@andestech.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        "sw-dev@groups.riscv.org" <sw-dev@groups.riscv.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Greentime Ying-Han =?utf-8?B?SHUo6IOh6Iux5ryiKQ==?="
        <greentime@andestech.com>,
        "Zong Zong-Xian =?utf-8?B?TGko5p2O5a6X5oayKQ==?="
        <zong@andestech.com>
Subject: Re: ftrace: Proposal for an Alternative RecordMcount framework
Message-ID: <20180307014746.GA25460@andestech.com>
References: <20180227100425.GB20904@andestech.com>
 <20180227161252.25162d81@vmware.local.home>
 <20180301020507.GA24550@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180301020507.GA24550@andestech.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w271lJIp022774
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 10:05:07AM +0800, Alan Kao wrote:
> On Wed, Feb 28, 2018 at 05:12:52AM +0800, Steven Rostedt wrote:
> > On Tue, 27 Feb 2018 18:04:26 +0800
> > Alan Kao <alankao@andestech.com> wrote:
> >  
> > > 1. During the final linking stages, do "objdump vmlinux.o | grep ..." [2]
> > 
> > Note, doing it at that stage takes the longest time. It makes small
> > changes much longer to compile. That said...
> >
> 
> What if we can have some option to *disable* all the recordmcount.pl lauches
> after every .o?  There will be only an oneshot grep for a near-complete
> vmlinux binary.
> 
> > > 2. Form the output as an ELF objecj
> > > 3. Link the object to __mcount_loc_start symbol
> > > 4. Done
> > > 
> > > With the similar reason as the patch [3], we should mark _mcount to be
> > > a weak symbol to prevent it from being relaxed later.
> > > 
> > > We would like to know your opinion and comments on this.
> > > Thanks!
> > 
> > What about just having your arch use recordmcount.c instead? It doesn't
> > do any grepping. It is an elf reader and modifier and modifies the .o
> > file directly.
> 
> Thanks for the hint.  But after a quick scan, it seems that recordmcount.c
> processes .o files in a per-file basis, which means that we will still
> suffer from the linker relaxation problem.
> 
> > 
> > Note, I will be rewriting that code in the near future too, to
> > consolidate it with objtool.
> > 
> > -- Steve
> 
> Please allow me to state the problem more clearly here.  I hope this helps.
> 
> 1. locations of mcount are recorded in a per-file basis.
> 2. to optimize the binary, the linker turns on some aggressive
>    options, including relaxation.
> 3. the optimizations changes the original offset.
> 4. already recorded mcount call-sites no longer point to their
>    real positions.
> 5. still a linked vmlinux is made.
> 6. dynamic ftrace breaks the real logic in the kernel space,
>    panics happen.
> 
> Thanks,
> Alan

Any comments on this?

BTW, the introduced framework has no effects on any other architectures that
works fine.  This feature should be configurable and turned on only when the
arch has aggressive link-time optimizations.

If you consider this appropriate, I will send the patch to this once it gets 
ready.  Currently this is targeting at RISC-V and upcoming NDS32.

Thanks,
Alan
