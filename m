Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753123AbeE3OP6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:15:58 -0400
Received: from mga03.intel.com ([134.134.136.65]:16177 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751844AbeE3OP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:15:57 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,460,1520924400";
   d="scan'208";a="58915787"
Date: Wed, 30 May 2018 22:17:29 +0800
From: Feng Tang <feng.tang@intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alek.du@intel.com
Subject: Re: [RFC 2/2] x86, tsc: Enable clock for ealry printk timestamp
Message-ID: <20180530141729.5xulqmhjibynbm5d@shbuild888>
References: <1527672059-6225-1-git-send-email-feng.tang@intel.com>
 <1527672059-6225-2-git-send-email-feng.tang@intel.com>
 <CAHp75Vcii2=TDxBWeOve05peyiYiPeMu_ocBvj5SJ8UB+94eNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vcii2=TDxBWeOve05peyiYiPeMu_ocBvj5SJ8UB+94eNQ@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thanks for the review.

On Wed, May 30, 2018 at 04:25:07PM +0300, Andy Shevchenko wrote:
> On Wed, May 30, 2018 at 12:20 PM, Feng Tang <feng.tang@intel.com> wrote:
> > To show time info in kernel log earlier and help optimizing kernel
> > boot time, printk adds a debug hook "boot_printk_clock_fn()"  for
> > capable platform which has accurate clock in early boot phase.
> >
> > This patch will add early param setup option, so that user can
> > chose to provide a tsc based early printk clock simply by adding
> > in command line: "boot_tsc=xxxxM" (xxxxM is the stable TSC freq).
> 
> > +
> 
> This line is not needed.
Ok, will remove it.

> 
> > +       cur_tsc = rdtsc();
> > +       cur_tsc -= boot_tsc_offset;
> 
> In one expression?
Agree

> 
> > +       if (!p)
> > +               return -EINVAL;
> > +
> 
> I'm not sure it's needed at all.
> 
> > +       boot_tsc_mhz = div64_u64(tsc_hz, 1024 * 1024);
> 
> Hmm... 1024*1024 != 1000 * 1000. So, hz -> mhz here (as by suffixes)
> looks weird.

The memparse is mostly for memory stuff which takes 1M as 1024*1024,
but for TSC frequency 1M means 1000*1000,  and the code is trying to
do some awkward translation. 

But you are right, this code will break if user doesn't use expression
with 'm".

> 
> > +       if (boot_tsc_mhz == 0)
> > +               return -EINVAL;
> 
> > +       pr_info("TSC has run for %lld us\n",
> > +               div64_u64(boot_tsc_offset, boot_tsc_mhz));
> > +
> > +       /* Setup the early printk clock */
> > +       boot_printk_clock_fn = boot_tsc_clock;
> 
> > +       pr_info("TSC: Setup early printk timestamp with %lldM TSC.",
> > +               boot_tsc_mhz);
> 
> Perhaps remove period (above doesn't have it) and move this to one line?

You mean merge the two pr_info line? yes, we can do that. 


Thanks,
Feng
