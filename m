Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754966AbeDCJw5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 05:52:57 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59135 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754583AbeDCJwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 05:52:55 -0400
Date: Tue, 3 Apr 2018 11:52:49 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Vikas Shivappa <vikas.shivappa@linux.intel.com>
cc: vikas.shivappa@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com,
        sai.praneeth.prakhya@intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com
Subject: Re: [PATCH 3/6] x86/intel_rdt/mba_sc: Add initialization support
In-Reply-To: <1522362376-3505-4-git-send-email-vikas.shivappa@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1803301154580.1478@nanos.tec.linutronix.de>
References: <1522362376-3505-1-git-send-email-vikas.shivappa@linux.intel.com> <1522362376-3505-4-git-send-email-vikas.shivappa@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Mar 2018, Vikas Shivappa wrote:
> +void setup_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm)
> +{
> +	int i;
> +
> +	/*
> +	 * Initialize the Control MSRs to having no control.
> +	 * For Cache Allocation: Set all bits in cbm
> +	 * For Memory Allocation: Set b/w requested to 100%
> +	 * and the b/w in MB to U32_MAX
> +	 */
> +	for (i = 0; i < r->num_closid; i++, dc++, dm++) {
> +		*dc = r->membw.bw_byte ? MBA_BW_MAX_MB : r->default_ctrl;
> +		*dm = r->default_ctrl;

No! Please stop duct taping your stuff into the existing code. So far the
ctrl value was the same as the value which was actually written into the
MSR. With your new mode you have to split that up into the user supplied
value and the value which gets written into the MSR.

So the right thing to do is to separate the user value and the MSR value
first and independent of the mode. Then the new mode falls into place
naturally because r->default_ctrl and r->default_msrval are set up at mount
time with the values which correspond to the mount mode. 

Thanks,

	tglx
