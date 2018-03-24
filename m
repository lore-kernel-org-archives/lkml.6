Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751837AbeCXAQ5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 20:16:57 -0400
Received: from mga01.intel.com ([192.55.52.88]:54951 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751600AbeCXAQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 20:16:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,352,1517904000";
   d="scan'208";a="26562921"
Date: Fri, 23 Mar 2018 17:17:20 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>, brice.goglin@gmail.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86,sched: allow topologies where NUMA nodes share an
 LLC
Message-ID: <20180324001720.GA26626@alison-desk.jf.intel.com>
References: <20180322204922.GA2337@alison-desk.jf.intel.com>
 <ea881957-db28-97f9-a923-a43e010d9e1b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea881957-db28-97f9-a923-a43e010d9e1b@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 05:42:41PM -0700, Tim Chen wrote:
> On 03/22/2018 01:49 PM, Alison Schofield wrote:
> >
> > +	 */
> > +	if (!topology_same_node(c, o) &&
> > +	    (c->x86_vendor == X86_VENDOR_INTEL &&
> > +	     c->x86_model == INTEL_FAM6_SKYLAKE_X)) {
> > +		/* Use NUMA instead of coregroups for scheduling: */
> > +		x86_has_numa_in_package = true;
> 
> x86_has_numa_in_package will only be set true for SKYLAKE in the above? 
> 
> This boolean probably should be set for (!topology_same_node(c, o) && match_die(c, o)) and not
> dependent on cpu family.  Only the return value should depend on cpu family.
> 
> Tim

Tim,

x86_has_numa_in_package is being set in set_cpu_sibling_map()  with the
same criteria you describe: (!topology_same_node(c, o) &&  match_die(c,
o))

Skylake in SNC mode takes that path and it gets set correctly, so I'm
thinking and seeing that the setting of it in match_llc() is redundant.

The intent of the patch is to skip the topology_sane() check to avoid
the warning message it spits out at boot time. 

This has me wondering if, aside from it being redundant, if it may be
incorrect? Should we set that boolean based on vendor/model alone in
match_llc().  I guess I need to understand what happens w a Skylake that
doesn't have SNC turned on. I can try that configuration next.

Thanks for reviewing!
alisons
> 
> 
> > +
> > +		/*
> > +		 * Return value doesn't actually matter because we
> > +		 * are throwing away coregroups for scheduling anyway.
> > +		 * Return false to bypass topology broken bug messages
> > +		 * and fixups in sched_domain().
> > +		 */
> > +		return false;
> > +	}
> > +
> > +	return topology_sane(c, o, "llc");
> >  }
> >  
> >  /*
> > @@ -454,12 +492,6 @@ static struct sched_domain_topology_level x86_topology[] = {
> >  	{ NULL, },
> >  };
> >  
> > -/*
> > - * Set if a package/die has multiple NUMA nodes inside.
> > - * AMD Magny-Cours and Intel Cluster-on-Die have this.
> > - */
> > -static bool x86_has_numa_in_package;
> > -
> >  void set_cpu_sibling_map(int cpu)
> >  {
> >  	bool has_smt = smp_num_siblings > 1;
> > 
> 
