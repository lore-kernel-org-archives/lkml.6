Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73E7C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 04:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B29AF2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 04:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfAGEwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 23:52:10 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:45578 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfAGEwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 23:52:10 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 3632828DE0;
        Sun,  6 Jan 2019 23:52:02 -0500 (EST)
Date:   Mon, 7 Jan 2019 15:52:38 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Michael Ellerman <mpe@ellerman.id.au>
cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v8 24/25] powerpc: Adopt nvram module for PPC64
In-Reply-To: <8736q5xst1.fsf@concordia.ellerman.id.au>
Message-ID: <alpine.LNX.2.21.1901071533060.30@nippy.intranet>
References: <cover.1545784679.git.fthain@telegraphics.com.au> <2fe2b8e6395aeacfafcbde590a50922d4e632189.1545784679.git.fthain@telegraphics.com.au> <CAK8P3a2p91XJfJuSCZqRLRgC-aP3LR1tMK2DDxTiSuD8_FOg8Q@mail.gmail.com>
 <8736q5xst1.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2019, Michael Ellerman wrote:

> Arnd Bergmann <arnd@arndb.de> writes:
> > On Wed, Dec 26, 2018 at 1:43 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> >
> >> +static ssize_t ppc_nvram_get_size(void)
> >> +{
> >> +       if (ppc_md.nvram_size)
> >> +               return ppc_md.nvram_size();
> >> +       return -ENODEV;
> >> +}
> >
> >> +const struct nvram_ops arch_nvram_ops = {
> >> +       .read           = ppc_nvram_read,
> >> +       .write          = ppc_nvram_write,
> >> +       .get_size       = ppc_nvram_get_size,
> >> +       .sync           = ppc_nvram_sync,
> >> +};
> >
> > Coming back to this after my comment on the m68k side, I notice that
> > there is now a double indirection through function pointers. Have you
> > considered completely removing the operations from ppc_md instead
> > by having multiple copies of nvram_ops?
> >
> > With the current method, it does seem odd to have a single
> > per-architecture instance of the exported structure containing
> > function pointers. This doesn't give us the flexibility of having
> > multiple copies in the kernel the way that ppc_md does, but it adds
> > overhead compared to simply exporting the functions directly.
> 
> Yeah TBH I'm not convinced the arch ops is the best solution.
> 
> Why can't each arch just implement the required ops functions? On ppc
> we'd still use ppc_md but that would be a ppc detail.
> 
> Optional ops are fairly easy to support by providing a default
> implementation, eg. instead of:
> 
> +	if (arch_nvram_ops.get_size == NULL)
> +		return -ENODEV;
> +
> +	nvram_size = arch_nvram_ops.get_size();
> +	if (nvram_size < 0)
> +		return nvram_size;
> 
> 
> We do in some header:
> 
> #ifndef arch_nvram_get_size
> static inline int arch_nvram_get_size(void)
> {
> 	return -ENODEV;
> }
> #endif
> 
> And then:
> 
> 	nvram_size = arch_nvram_get_size();
> 	if (nvram_size < 0)
> 		return nvram_size;
> 
> 
> But I haven't digested the whole series so maybe I'm missing something?
> 

The reason why that doesn't work boils down to introspection. (This was 
mentioned elsewhere in this email thread.) For example, we presently have 
code like this,

ssize_t nvram_get_size(void)
{
       if (ppc_md.nvram_size)
               return ppc_md.nvram_size();
       return -1;
}
EXPORT_SYMBOL(nvram_get_size);

This construction means we get to decide at run-time which of the NVRAM 
functions should be used. (Whereas your example makes a build-time decision.)

The purpose of arch_nvram_ops is much the same. That is, it does for m68k 
and x86 what ppc_md already does for ppc32 and ppc64. (And once these 
platforms share an API like this, they can share more driver code, and 
reduce duplicated code.)

The approach taken in this series was to push the arch_nvram_ops approach 
as far as possible, because by making everything fit into that regime it 
immediately became apparent where architectures and platforms have 
diverged, creating weird inconsistencies like the differences in sync 
ioctl behaviour between ppc32 and ppc64 for core99. (Early revisions of 
this series exposed more issues like bugs and dead code that got addressed 
elsewhere.)

Problem is, as Arnd pointed out, powerpc doesn't need both kinds of ops 
struct. So I'm rewriting this series in such a way that powerpc doesn't 
have to implement both. This rewrite is going to look totally different 
for powerpc (though not for x86 or m68k) so you might want to wait for me 
to post v9 before spending more time on code review.

Thanks.

-- 

> cheers
> 
