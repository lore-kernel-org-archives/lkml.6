Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754420AbeDITkk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 15:40:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46470 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754312AbeDITkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 15:40:37 -0400
Date: Mon, 9 Apr 2018 16:40:32 -0300
From: Arnaldo Carvalho de Melo <acme@redhat.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, lizhijian@cn.fujitsu.com,
        sandipan@linux.vnet.ibm.com
Subject: Re: [PATCH] tools: restore READ_ONCE() C++ compatibility
Message-ID: <20180409194032.GA7184@redhat.com>
References: <20180404163445.16492-1-mark.rutland@arm.com>
 <20180409171041.6qfabrccsqu4bdlc@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409171041.6qfabrccsqu4bdlc@lakrids.cambridge.arm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 09, 2018 at 06:10:41PM +0100, Mark Rutland escreveu:
> Hi Arnaldo,
> 
> As Sandipan gave a Tested-by for this, are you happy to pick it up as a
> fix for v4.17?
> 
> Or would you prefer that I resend this?

I forgot about this fix, but was exposed to it while processing
Sandipan's patches for fixing up builtin clang support, so I ended up
adding the following patch:

https://git.kernel.org/acme/c/ad0902e0c400

This sidesteps this issue by removing the sequence of includes that ends
up including the compiler.h from a C++ file.

Now 'make LIBCLANGLLVM=1 -C tools/perf' works, but I'll look at the
patch below, probably it will save some time in the future if we get to
include compiler.h from C++ code again...

Take a look at my perf/urgent branch, that I just asked Ingo to pull.

- Arnaldo
 
> Thanks,
> Mark.
> 
> On Wed, Apr 04, 2018 at 05:34:45PM +0100, Mark Rutland wrote:
> > Our userspace <linux/compiler.h> defines READ_ONCE() in a way that clang
> > doesn't like, as we have an anonymous union in which neither field is
> > initialized.
> > 
> > WRITE_ONCE() is fine since it initializes the __val field. For
> > READ_ONCE() we can keep clang and GCC happy with a dummy initialization
> > of the __c field, so let's do that.
> > 
> > At the same time, let's split READ_ONCE() and WRITE_ONCE() over several
> > lines for legibility, as we do in the in-kernel <linux/compiler.h>.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Fixes: 6aa7de059173a986 ("locking/atomics: COCCINELLE/treewide: Convert trivial ACCESS_ONCE() patterns to READ_ONCE()/WRITE_ONCE()")
> > Reported-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> > Reported-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
> > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/include/linux/compiler.h | 20 +++++++++++++++-----
> >  1 file changed, 15 insertions(+), 5 deletions(-)
> > 
> > Hi,
> > 
> > This is fallout from my automated ACCESS_ONCE() removal, and I'm not that
> > familiar with using clang for perf.
> > 
> > In local testing, this fixes READ_ONCE() when compiling with clang, but I
> > subsequently hit some other issues which I believe are down to LLVM API
> > changes.
> > 
> > Zhijian, Sandipan, does this patch work for you?
> > 
> > Thanks,
> > Mark.
> > 
> > diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
> > index 04e32f965ad7..1827c2f973f9 100644
> > --- a/tools/include/linux/compiler.h
> > +++ b/tools/include/linux/compiler.h
> > @@ -151,11 +151,21 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
> >   * required ordering.
> >   */
> >  
> > -#define READ_ONCE(x) \
> > -	({ union { typeof(x) __val; char __c[1]; } __u; __read_once_size(&(x), __u.__c, sizeof(x)); __u.__val; })
> > -
> > -#define WRITE_ONCE(x, val) \
> > -	({ union { typeof(x) __val; char __c[1]; } __u = { .__val = (val) }; __write_once_size(&(x), __u.__c, sizeof(x)); __u.__val; })
> > +#define READ_ONCE(x)					\
> > +({							\
> > +	union { typeof(x) __val; char __c[1]; } __u =	\
> > +		{ .__c = { 0 } };			\
> > +	__read_once_size(&(x), __u.__c, sizeof(x));	\
> > +	__u.__val;					\
> > +})
> > +
> > +#define WRITE_ONCE(x, val)				\
> > +({							\
> > +	union { typeof(x) __val; char __c[1]; } __u =	\
> > +		{ .__val = (val) }; 			\
> > +	__write_once_size(&(x), __u.__c, sizeof(x));	\
> > +	__u.__val;					\
> > +})
> >  
> >  
> >  #ifndef __fallthrough
> > -- 
> > 2.11.0
> > 
