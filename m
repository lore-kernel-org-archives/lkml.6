Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966608AbeEJRCY convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 13:02:24 -0400
Received: from mga04.intel.com ([192.55.52.120]:58553 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966267AbeEJRCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 13:02:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,386,1520924400";
   d="scan'208";a="49832207"
From: "Hunter, Adrian" <adrian.hunter@intel.com>
To: Jiri Olsa <jolsa@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH RFC 01/19] kallsyms: Simplify update_iter_mod()
Thread-Topic: [PATCH RFC 01/19] kallsyms: Simplify update_iter_mod()
Thread-Index: AQHT54sxOfba0k7bcUaDpk8bhwj2bqQo3k2AgABQbyA=
Date: Thu, 10 May 2018 17:02:18 +0000
Message-ID: <363DA0ED52042842948283D2FC38E4649C13DE10@IRSMSX106.ger.corp.intel.com>
References: <1525866228-30321-1-git-send-email-adrian.hunter@intel.com>
 <1525866228-30321-2-git-send-email-adrian.hunter@intel.com>
 <20180510130157.GA22679@krava>
In-Reply-To: <20180510130157.GA22679@krava>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzRjMWFlNjYtNWZmZC00NjM4LWJmMTYtYzg3Y2ZmODZhYWQyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoic1wva2FjdWZrQUxneXU4NEJZR1JtQUkyemdTOXpWZENycUdwQ0l3QWp1NU95djI0RFQ3ME5mN3hFQk80Mk1PbkUifQ==
x-originating-ip: [163.33.239.180]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Jiri Olsa [mailto:jolsa@redhat.com]
> Sent: Thursday, May 10, 2018 4:02 PM
> To: Hunter, Adrian <adrian.hunter@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>; Arnaldo Carvalho de Melo
> <acme@kernel.org>; Ingo Molnar <mingo@redhat.com>; Peter Zijlstra
> <peterz@infradead.org>; Andy Lutomirski <luto@kernel.org>; H. Peter
> Anvin <hpa@zytor.com>; Andi Kleen <ak@linux.intel.com>; Alexander
> Shishkin <alexander.shishkin@linux.intel.com>; Dave Hansen
> <dave.hansen@linux.intel.com>; Joerg Roedel <joro@8bytes.org>; linux-
> kernel@vger.kernel.org; x86@kernel.org
> Subject: Re: [PATCH RFC 01/19] kallsyms: Simplify update_iter_mod()
> 
> On Wed, May 09, 2018 at 02:43:30PM +0300, Adrian Hunter wrote:
> > Simplify logic in update_iter_mod().
> >
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > ---
> >  kernel/kallsyms.c | 20 ++++++--------------
> >  1 file changed, 6 insertions(+), 14 deletions(-)
> >
> > diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c index
> > a23e21ada81b..eda4b0222dab 100644
> > --- a/kernel/kallsyms.c
> > +++ b/kernel/kallsyms.c
> > @@ -510,23 +510,15 @@ static int update_iter_mod(struct kallsym_iter
> > *iter, loff_t pos)  {
> >  	iter->pos = pos;
> >
> > -	if (iter->pos_ftrace_mod_end > 0 &&
> > -	    iter->pos_ftrace_mod_end < iter->pos)
> > -		return get_ksymbol_bpf(iter);
> > -
> > -	if (iter->pos_mod_end > 0 &&
> > -	    iter->pos_mod_end < iter->pos) {
> > -		if (!get_ksymbol_ftrace_mod(iter))
> > -			return get_ksymbol_bpf(iter);
> > +	if ((!iter->pos_mod_end || iter->pos_mod_end > pos) &&
> > +	    get_ksymbol_mod(iter))
> >  		return 1;
> 
> hum, should that be iter-> pos_mod_end >= pos ?

But module_get_kallsym() returned -1 when pos_mod_end was set to pos.

> 
> 
> > -	}
> >
> > -	if (!get_ksymbol_mod(iter)) {
> > -		if (!get_ksymbol_ftrace_mod(iter))
> > -			return get_ksymbol_bpf(iter);
> > -	}
> > +	if ((!iter->pos_ftrace_mod_end || iter->pos_ftrace_mod_end >
> pos) &&
> > +	    get_ksymbol_ftrace_mod(iter))
> 
> same here? iter->pos_ftrace_mod_end >= pos
> 
> jirka
> 
> > +		return 1;
> >
> > -	return 1;
> > +	return get_ksymbol_bpf(iter);
> >  }
> >
> >  /* Returns false if pos at or past end of file. */
> > --
> > 1.9.1
> >
