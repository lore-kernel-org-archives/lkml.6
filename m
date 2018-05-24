Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965044AbeEXH0k (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 03:26:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35138 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964789AbeEXH0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 03:26:39 -0400
Date: Thu, 24 May 2018 15:26:27 +0800
From: Dave Young <dyoung@redhat.com>
To: Petr Tesarik <ptesarik@suse.cz>
Cc: dzickus@redhat.com, Neil Horman <nhorman@redhat.com>,
        Tony Luck <tony.luck@intel.com>, bhe@redhat.com,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] kdump: add default crashkernel reserve kernel config
 options
Message-ID: <20180524072627.GA1940@dhcp-128-65.nay.redhat.com>
References: <20180521025337.GA4627@dhcp-128-65.nay.redhat.com>
 <20180521120215.117d963a7619eb0d1f54bced@linux-foundation.org>
 <20180523070641.GA1689@dhcp-128-65.nay.redhat.com>
 <877enucqr0.fsf@xmission.com>
 <20180523222236.5a96732e@ezekiel.suse.cz>
 <20180524014905.GB2031@dhcp-128-65.nay.redhat.com>
 <20180524085708.31aa311d@ezekiel.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524085708.31aa311d@ezekiel.suse.cz>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/24/18 at 08:57am, Petr Tesarik wrote:
> On Thu, 24 May 2018 09:49:05 +0800
> Dave Young <dyoung@redhat.com> wrote:
> 
> > Hi Petr,
> > 
> > On 05/23/18 at 10:22pm, Petr Tesarik wrote:
> >[...]
> > > In short, if one size fits none, what good is it to hardcode that "one
> > > size" into the kernel image?  
> > 
> > I agreed with all the things that we can not know the exact memory
> > requirement for 100% use cases.  But that does not means this is useless
> > it is still useful for common use cases of no special and memory hog
> > requirements as I mentioned in another reply it can simplify the kdump
> > deployment for those people who do not need the special setup.
> 
> I still tend to disagree. This "common-case" reservation depends on
> things that are defined by user space. It surely does not make it
> easier to build a distribution kernel. Today, I get bug reports that
> the number calculated and added to the boot loader configuration by the
> installer is inaccurate. If I put a fixed number into a kernel config
> option, I will start getting bugs that this number is incorrect (for
> some systems).

The value is a best effort, it will never be 100% correct.  We did not
guarantee that.   The kernel config option value is just up to user.
So I'm thinking it as a good to have benefit.

> 
> > For example, if this is a workstation I just want to break into a shell
> > to collect some panic info, then I just need a very minimal initrd, then
> > the Kconfig will work just fine.
> 
> What is "a very minimal initrd"? Last time I had to make a significant
> adjustment to the estimation for openSUSE, this was caused by growing
> user-space requirements (systemd in this case, but I don't want to
> start flamewars on that topic, please).

Still I think we have agreement and same feeling about the userspace
memory requirement.   I think although it is hard, we have been still
trying to shrink the initramfs memory use.

Besides of distribution use,  why people can not use some minimal
initrd?  For example only a basic shell and some necessary tools and
basic storage eg. raw disks supported, and he/she can just collect the
panic infomation by himself in a shell.

> 
> Anyway, if you want to improve the "common case", then look how IBM
> tries to solve it for firmware-assisted dump (fadump) on powerpc:
> 
> https://patchwork.ozlabs.org/patch/905026/
> 
> The main idea is:
> 
> > Instead of setting aside a significant chunk of memory nobody can use,
> > [...] reserve a significant chunk of memory that the kernel is prevented
> > from using [...], but applications are free to use it.
> 
> That works great, because user space pages are filtered out in the
> common case, so they can be used freely by the panic kernel.

Good suggestion. I have been reading that posts already at the same time before I saw
this reply from you :)

That could be a good idea and worth to discuss more.  I cced Hari
already in the thread. Hari, is it possible for you to extend your
idea to general use, ie. shared by both kdump and fadump?  Anyway I
think that is another topic we can discuss separately.

> 
> Just my two cents,
> Petr T

Thanks
Dave
