Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751399AbeFAIwx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:52:53 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42987 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbeFAIwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:52:49 -0400
X-Google-Smtp-Source: ADUXVKKEg6mpemYKC5Khp3GYU/QPNfLe6I7yuUY/FdEk8rO1moqQQJR0S0s4yqpbkw8mEB9EIv/IxA==
Date: Fri, 1 Jun 2018 04:52:45 -0400
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: linux-next: build failure after merge of the net-next tree
Message-ID: <20180601085243.3p33sctlpckcq7vl@ast-mbp>
References: <20180529132548.7f71c2ff@canb.auug.org.au>
 <20180531073855.29c23fce@canb.auug.org.au>
 <20180601135943.66b90890@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601135943.66b90890@canb.auug.org.au>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 01:59:43PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> On Thu, 31 May 2018 07:38:55 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > On Tue, 29 May 2018 13:25:48 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > After merging the net-next tree, today's linux-next build (x86_64
> > > allmodconfig) failed like this:
> > > 
> > > x86_64-linux-ld: unknown architecture of input file `net/bpfilter/bpfilter_umh.o' is incompatible with i386:x86-64 output
> > > 
> > > Caused by commit
> > > 
> > >   d2ba09c17a06 ("net: add skeleton of bpfilter kernel module")
> > > 
> > > In my builds, the host is PowerPC 64 LE ...
> > > 
> > > I have reverted that commit along with
> > > 
> > >   61a552eb487f ("bpfilter: fix build dependency")
> > >   13405468f49d ("bpfilter: don't pass O_CREAT when opening console for debug")
> > > 
> > > for today.  
> > 
> > I am still getting this failure (well, at least yesterday I did).
> 
> Still happened today.  My guess is that bpfilter_umh needs to be built
> with the kernel compiler (not the host compiler - since ir is meant to
> run on the some machine as the kernel, right?) but will require the
> kernel architecture libc etc
> 
> 
> I replaced the reverts above with the following:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 1 Jun 2018 13:33:28 +1000
> Subject: [PATCH] net: bpfilter: mark as BROKEN for now
> 
> This does not build in a cross compile environment
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  net/bpfilter/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/bpfilter/Kconfig b/net/bpfilter/Kconfig
> index a948b072c28f..ea4be72fdf6e 100644
> --- a/net/bpfilter/Kconfig
> +++ b/net/bpfilter/Kconfig
> @@ -2,6 +2,7 @@ menuconfig BPFILTER
>  	bool "BPF based packet filtering framework (BPFILTER)"
>  	default n
>  	depends on NET && BPF && INET
> +	depends on BROKEN

yeah. that's another option.
Sorry for delay. networking folks are traveling to netconf.
The issue is being discussed here:
https://patchwork.ozlabs.org/patch/921597/

Currently we're thinking how to add a check that hostcc's arch
is equal to cross-cc target arch and ideally equal to arch
of the host where it will be run.
