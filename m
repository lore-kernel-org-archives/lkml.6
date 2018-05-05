Return-Path: <alexei.starovoitov@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525482061; cv=none;
        d=google.com; s=arc-20160816;
        b=ZqBdbm21q1WDk4k7HoyH+hO8toPIXQ4TNhtHI8LhZXXjBggfpM5hzWJiQv4zXUOCtR
         PM2rKxg6aGMNy1WWBTCF06RNMdUJRMzxkEpfWkpttWA0qzynXY+nUrYNgzXFux9asRS2
         Dfr+mqvgYcrsj99Xs09oR3Vt1aMbBnFyJK66mW/KtyOQfltBfjUHQqE84JIyCFpaaXcW
         fkBC3LrbLTeKvq3lEURK35Pm3sobFa7iW+fgof2r5DHcRAOtmJXP8qUqgZbuM6zmPCR/
         wUPonF8+hivE6ZKff627CXXsT3MsSkzMwpepTrdge82H4H3tdfTO0f5+Nq+uhsmiN9HR
         wwRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=3CyNBKwTx1k6VI7SWCX/1OJmHh/WQQE8oT2jjstU1Gk=;
        b=EQQNhsvrxJ7ReV+Arra26UXRRmHw+LUAyQMhOMltLjsYNYmM+MYllC4+IqeyThE+kh
         hqRNAs4R1qy/F8FLxH/29kbrO5huIhiLSexi6SYXSQ/6v+gtUQDHUnVl6yTyHCYcUYMy
         hJ2BqYgrOkAssZoHr1YgpFqlT40tXEBVfGjwRePBPMHQdvzBJTp5fXFCnHUySlvDZ4nt
         rWNqWRng6N/N0AZgXAMXbFLH1dkJJhmWEDRqiHL+EmB2KQaagLJL4RXUqqiwd5X11LAy
         2NZUufybGw/+lyMiQsbR3yb7dSNwEgl15ZnE+/QX+5hyYzSMnL68zni75bVsgRp9tILz
         8ehQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HkWdZENe;
       spf=pass (google.com: domain of alexei.starovoitov@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=alexei.starovoitov@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HkWdZENe;
       spf=pass (google.com: domain of alexei.starovoitov@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=alexei.starovoitov@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZqK0YTKfKol2SC+F18agcDFQp5I0mAxoyelCLvlisNgkSWfay5CcxdO3qRkDMMS1dBsWg2iZA==
Date: Fri, 4 May 2018 18:00:58 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Edward Cree <ecree@solarflare.com>
Cc: Alexei Starovoitov <ast@kernel.org>, davem@davemloft.net,
	daniel@iogearbox.net, torvalds@linux-foundation.org,
	gregkh@linuxfoundation.org, luto@amacapital.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH v2 net-next 2/4] net: add skeleton of bpfilter kernel
 module
Message-ID: <20180505010056.are63gsmf7yrlxpe@ast-mbp>
References: <20180503043604.1604587-1-ast@kernel.org>
 <20180503043604.1604587-3-ast@kernel.org>
 <c0ad0d12-418f-8dfd-ed2c-92e36316310b@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0ad0d12-418f-8dfd-ed2c-92e36316310b@solarflare.com>
User-Agent: NeoMutt/20180223
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599416225694736469?=
X-GMAIL-MSGID: =?utf-8?q?1599583878285895013?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 03:23:55PM +0100, Edward Cree wrote:
> On 03/05/18 05:36, Alexei Starovoitov wrote:
> > bpfilter.ko consists of bpfilter_kern.c (normal kernel module code)
> > and user mode helper code that is embedded into bpfilter.ko
> >
> > The steps to build bpfilter.ko are the following:
> > - main.c is compiled by HOSTCC into the bpfilter_umh elf executable file
> > - with quite a bit of objcopy and Makefile magic the bpfilter_umh elf file
> >   is converted into bpfilter_umh.o object file
> >   with _binary_net_bpfilter_bpfilter_umh_start and _end symbols
> >   Example:
> >   $ nm ./bld_x64/net/bpfilter/bpfilter_umh.o
> >   0000000000004cf8 T _binary_net_bpfilter_bpfilter_umh_end
> >   0000000000004cf8 A _binary_net_bpfilter_bpfilter_umh_size
> >   0000000000000000 T _binary_net_bpfilter_bpfilter_umh_start
> > - bpfilter_umh.o and bpfilter_kern.o are linked together into bpfilter.ko
> >
> > bpfilter_kern.c is a normal kernel module code that calls
> > the fork_usermode_blob() helper to execute part of its own data
> > as a user mode process.
> >
> > Notice that _binary_net_bpfilter_bpfilter_umh_start - end
> > is placed into .init.rodata section, so it's freed as soon as __init
> > function of bpfilter.ko is finished.
> > As part of __init the bpfilter.ko does first request/reply action
> > via two unix pipe provided by fork_usermode_blob() helper to
> > make sure that umh is healthy. If not it will kill it via pid.
> >
> > Later bpfilter_process_sockopt() will be called from bpfilter hooks
> > in get/setsockopt() to pass iptable commands into umh via bpfilter.ko
> >
> > If admin does 'rmmod bpfilter' the __exit code bpfilter.ko will
> > kill umh as well.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
...
> > +static void stop_umh(void)
> > +{
> > +	if (bpfilter_process_sockopt) {
> I worry about locking here.  Is it possible for two calls to
>  bpfilter_process_sockopt() to run in parallel, both fail, and thus both
>  call stop_umh()?  And if both end up calling shutdown_umh(), we double
>  fput().

I thought iptables sockopt is serialized earlier. Nope.
We need to grab the mutex to access these pipes.
Will fix.

Thanks for spelling nits. Will fix as well.
