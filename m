Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752507AbeDSKHw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 06:07:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:38911 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751386AbeDSKHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 06:07:51 -0400
Date: Thu, 19 Apr 2018 12:07:45 +0200
From: Borislav Petkov <bp@suse.de>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        robh+dt@kernel.org, dan.j.williams@intel.com, nicolas.pitre@linaro.org,
        josh@joshtriplett.org, Thomas Gleixner <tglx@linutronix.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v3 2/3] resource: add walk_system_ram_res_rev()
Message-ID: <20180419100745.GC3896@pd.tnic>
References: <20180419001848.3041-1-bhe@redhat.com>
 <20180419001848.3041-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180419001848.3041-3-bhe@redhat.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 08:18:47AM +0800, Baoquan He wrote:
> This function, being a variant of walk_system_ram_res() introduced in
> commit 8c86e70acead ("resource: provide new functions to walk through
> resources"), walks through a list of all the resources of System RAM
> in reversed order, i.e., from higher to lower.
> 
> It will be used in kexec_file code.

Of course, what is missing is the big *WHY* you need this to happen this
way...

>  /*
> + * This function, being a variant of walk_system_ram_res(), calls the @func
> + * callback against all memory ranges of type System RAM which are marked as
> + * IORESOURCE_SYSTEM_RAM and IORESOUCE_BUSY in reversed order, i.e., from
> + * higher to lower.
> + */
> +int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
> +				int (*func)(struct resource *, void *))
> +{
> +	unsigned long flags;
> +	struct resource *res;
> +	int ret = -1;
> +
> +	flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> +
> +	read_lock(&resource_lock);
> +	list_for_each_entry_reverse(res, &iomem_resource.child, sibling) {

... and the other thing that I'm not clear on is why are you
slapping this function just like that instead of extending
__walk_iomem_res_desc() to do reverse direction too?

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
