Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbeCVXUo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 19:20:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50844 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751694AbeCVXUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 19:20:43 -0400
Date: Fri, 23 Mar 2018 00:20:30 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Luck@alison-desk.jf.intel.com, Tony <tony.luck@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
        David Rientjes <rientjes@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>, brice.goglin@gmail.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86,sched: allow topologies where NUMA nodes share an
 LLC
Message-ID: <20180322232030.GA4043@hirez.programming.kicks-ass.net>
References: <20180322204922.GA2337@alison-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322204922.GA2337@alison-desk.jf.intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 01:49:22PM -0700, Alison Schofield wrote:
> +	/*
> +	 * Some Intel CPUs enumerate an LLC that is shared by
> +	 * multiple NUMA nodes.  The LLC on these systems is
> +	 * shared for off-package data access but private to the
> +	 * NUMA node (half of the package) for on-package access.
> +	 *
> +	 * CPUID can only enumerate the cache as being shared *or*
> +	 * unshared, but not this particular configuration.  The
> +	 * CPU in this case enumerates the cache to be shared
> +	 * across the entire package (spanning both NUMA nodes).
> +	 */
> +	if (!topology_same_node(c, o) &&
> +	    (c->x86_vendor == X86_VENDOR_INTEL &&
> +	     c->x86_model == INTEL_FAM6_SKYLAKE_X)) {
> +		/* Use NUMA instead of coregroups for scheduling: */
> +		x86_has_numa_in_package = true;
> +
> +		/*
> +		 * Return value doesn't actually matter because we
> +		 * are throwing away coregroups for scheduling anyway.
> +		 * Return false to bypass topology broken bug messages
> +		 * and fixups in sched_domain().
> +		 */
> +		return false;

IIRC that return value _does_ matter because the resulting mask still
ends up user visible in sysfs.

IIRC I went over with this dhansen a week or so ago, but I cannot now
recall what we settled on as being the right return value and for what
reason.
