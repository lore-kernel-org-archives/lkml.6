Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752214AbeENRzO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 13:55:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751515AbeENRzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 13:55:13 -0400
Date: Mon, 14 May 2018 14:55:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Hunter, Adrian" <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH RFC 01/19] kallsyms: Simplify update_iter_mod()
Message-ID: <20180514175509.GV13491@kernel.org>
References: <1525866228-30321-1-git-send-email-adrian.hunter@intel.com>
 <1525866228-30321-2-git-send-email-adrian.hunter@intel.com>
 <20180510130157.GA22679@krava>
 <363DA0ED52042842948283D2FC38E4649C13DE10@IRSMSX106.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <363DA0ED52042842948283D2FC38E4649C13DE10@IRSMSX106.ger.corp.intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 10, 2018 at 05:02:18PM +0000, Hunter, Adrian escreveu:
> > -----Original Message-----
> > From: Jiri Olsa [mailto:jolsa@redhat.com]
> > Sent: Thursday, May 10, 2018 4:02 PM
> > To: Hunter, Adrian <adrian.hunter@intel.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>; Arnaldo Carvalho de Melo
> > <acme@kernel.org>; Ingo Molnar <mingo@redhat.com>; Peter Zijlstra
> > <peterz@infradead.org>; Andy Lutomirski <luto@kernel.org>; H. Peter
> > Anvin <hpa@zytor.com>; Andi Kleen <ak@linux.intel.com>; Alexander
> > Shishkin <alexander.shishkin@linux.intel.com>; Dave Hansen
> > <dave.hansen@linux.intel.com>; Joerg Roedel <joro@8bytes.org>; linux-
> > kernel@vger.kernel.org; x86@kernel.org
> > Subject: Re: [PATCH RFC 01/19] kallsyms: Simplify update_iter_mod()
> > 
> > On Wed, May 09, 2018 at 02:43:30PM +0300, Adrian Hunter wrote:
> > > Simplify logic in update_iter_mod().
> > >
> > > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > > ---
> > >  kernel/kallsyms.c | 20 ++++++--------------
> > >  1 file changed, 6 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c index
> > > a23e21ada81b..eda4b0222dab 100644
> > > --- a/kernel/kallsyms.c
> > > +++ b/kernel/kallsyms.c
> > > @@ -510,23 +510,15 @@ static int update_iter_mod(struct kallsym_iter
> > > *iter, loff_t pos)  {
> > >  	iter->pos = pos;
> > >
> > > -	if (iter->pos_ftrace_mod_end > 0 &&
> > > -	    iter->pos_ftrace_mod_end < iter->pos)
> > > -		return get_ksymbol_bpf(iter);
> > > -
> > > -	if (iter->pos_mod_end > 0 &&
> > > -	    iter->pos_mod_end < iter->pos) {
> > > -		if (!get_ksymbol_ftrace_mod(iter))
> > > -			return get_ksymbol_bpf(iter);
> > > +	if ((!iter->pos_mod_end || iter->pos_mod_end > pos) &&
> > > +	    get_ksymbol_mod(iter))
> > >  		return 1;
> > 
> > hum, should that be iter-> pos_mod_end >= pos ?
> 
> But module_get_kallsym() returned -1 when pos_mod_end was set to pos.

After looking at the reset_iter(), etc, i.e. the lifetime of reading
/proc/kallsyms, I _think_ this is ok, but if it works already, why
simplify it? Because it paves the way for later changes in this function
in this patchset? If so, please state that, and then spelling out why
this is better than before helps with reviewing, please expand on this
cset comment log.

- Arnaldo
 
> > 
> > 
> > > -	}
> > >
> > > -	if (!get_ksymbol_mod(iter)) {
> > > -		if (!get_ksymbol_ftrace_mod(iter))
> > > -			return get_ksymbol_bpf(iter);
> > > -	}
> > > +	if ((!iter->pos_ftrace_mod_end || iter->pos_ftrace_mod_end >
> > pos) &&
> > > +	    get_ksymbol_ftrace_mod(iter))
> > 
> > same here? iter->pos_ftrace_mod_end >= pos
> > 
> > jirka
> > 
> > > +		return 1;
> > >
> > > -	return 1;
> > > +	return get_ksymbol_bpf(iter);
> > >  }
> > >
> > >  /* Returns false if pos at or past end of file. */
> > > --
> > > 1.9.1
> > >
