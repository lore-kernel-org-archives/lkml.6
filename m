Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751714AbeCWAmo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 20:42:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:35513 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751551AbeCWAmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 20:42:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,347,1517904000";
   d="scan'208";a="44560829"
Subject: Re: [PATCH v2] x86,sched: allow topologies where NUMA nodes share an
 LLC
To: Alison Schofield <alison.schofield@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
        Luck@alison-desk.jf.intel.com, Tony <tony.luck@intel.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>, brice.goglin@gmail.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20180322204922.GA2337@alison-desk.jf.intel.com>
From: Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <ea881957-db28-97f9-a923-a43e010d9e1b@linux.intel.com>
Date: Thu, 22 Mar 2018 17:42:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20180322204922.GA2337@alison-desk.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/22/2018 01:49 PM, Alison Schofield wrote:
>
> +	 */
> +	if (!topology_same_node(c, o) &&
> +	    (c->x86_vendor == X86_VENDOR_INTEL &&
> +	     c->x86_model == INTEL_FAM6_SKYLAKE_X)) {
> +		/* Use NUMA instead of coregroups for scheduling: */
> +		x86_has_numa_in_package = true;

x86_has_numa_in_package will only be set true for SKYLAKE in the above? 

This boolean probably should be set for (!topology_same_node(c, o) && match_die(c, o)) and not
dependent on cpu family.  Only the return value should depend on cpu family.

Tim


> +
> +		/*
> +		 * Return value doesn't actually matter because we
> +		 * are throwing away coregroups for scheduling anyway.
> +		 * Return false to bypass topology broken bug messages
> +		 * and fixups in sched_domain().
> +		 */
> +		return false;
> +	}
> +
> +	return topology_sane(c, o, "llc");
>  }
>  
>  /*
> @@ -454,12 +492,6 @@ static struct sched_domain_topology_level x86_topology[] = {
>  	{ NULL, },
>  };
>  
> -/*
> - * Set if a package/die has multiple NUMA nodes inside.
> - * AMD Magny-Cours and Intel Cluster-on-Die have this.
> - */
> -static bool x86_has_numa_in_package;
> -
>  void set_cpu_sibling_map(int cpu)
>  {
>  	bool has_smt = smp_num_siblings > 1;
> 
