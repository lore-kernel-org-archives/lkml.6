Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbeDGAQ4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 20:16:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:25669 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751528AbeDGAQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 20:16:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,417,1517904000";
   d="scan'208";a="214590782"
Date: Fri, 6 Apr 2018 17:17:01 -0700
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
Subject: Re: [PATCH v4] x86,sched: allow topologies where NUMA nodes share an
 LLC
Message-ID: <20180407001701.GA18897@alison-desk.jf.intel.com>
References: <20180403211230.GA12842@alison-desk.jf.intel.com>
 <2d00edef-c8bf-2fc6-c342-274a0681e225@linux.intel.com>
 <20180404173848.GA10518@alison-desk.jf.intel.com>
 <d179ced2-e862-0a67-e653-39c0cb55dbaf@linux.intel.com>
 <20180404190045.GA11617@alison-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404190045.GA11617@alison-desk.jf.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 12:00:45PM -0700, Alison Schofield wrote:
> On Wed, Apr 04, 2018 at 11:42:11AM -0700, Tim Chen wrote:
> > On 04/04/2018 10:38 AM, Alison Schofield wrote:
> > > On Wed, Apr 04, 2018 at 10:24:49AM -0700, Tim Chen wrote:
> > >> On 04/03/2018 02:12 PM, Alison Schofield wrote:
> > >>
> > >>> +
> > >>> +	/*
> > >>> +	 * topology_sane() considers LLCs that span NUMA nodes to be
> > >>> +	 * insane and will display a warning message. Bypass the call
> > >>> +	 * to topology_sane() for snc_cpu's to avoid that warning.
> > >>> +	 */
> > >>> +
> > >>> +	if (!topology_same_node(c, o) && x86_match_cpu(snc_cpu)) {
> > >>> +		/* Indicate that package has NUMA nodes inside: */
> > >>> +		x86_has_numa_in_package = true;
> > >>
> > >> Why does the x86_has_numa_in_package has to be set here when it would have
> > >> been done later in set_cpu_sibling_map?
> > > 
> > > Tim,
> > > I had that same thought when you commented on it previously. After 
> > > discussing w DaveH, decided that match_llc() and match_die(c,0)
> > > could be different and chose to be (cautiously) redundant.
> > > alisons
> > 
> > If it is redundant, I suggest it be removed, and only added if
> > there is truly a case where the current logic 
> > 
> >                 if (match_die(c, o) && !topology_same_node(c, o))
> >                         x86_has_numa_in_package = true;
> > 
> > fails.  And also the modification of this logic should be at the
> > same place for easy code maintenance. 
> 
> That makes good sense. I'll look to define the difference or remove
> the redundancy.
> 
> alisons
I found not reason for the redundancy via experimentation w my Skylake,
nor through code examination. I've removed it in v5. I'll see if
anyone claims theoretical case.
alisons
> 
> > 
> > Tim  
> > 
> > > 
> > > 
> > > 
> > >>
> > >>> +
> > >>> +		/*
> > >>> +		 * false means 'c' does not share the LLC of 'o'.
> > >>> +		 * Note: this decision gets reflected all the way
> > >>> +		 * out to userspace.
> > >>> +		 */
> > >>> +
> > >>> +		return false;
> > >>
> > >> Thanks.
> > >>
> > >> Tim
> > 
