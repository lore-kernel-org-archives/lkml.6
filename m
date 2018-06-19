Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D603C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E982083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E982083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966800AbeFSQyZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:54:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57727 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966510AbeFSQyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:54:24 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fVJt2-0000pO-F0; Tue, 19 Jun 2018 18:53:44 +0200
Date:   Tue, 19 Jun 2018 18:53:44 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
        jithu.joseph@intel.com, dave.hansen@intel.com, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 07/38] x86/intel_rdt: Initialize new resource group
 with sane defaults
In-Reply-To: <fa7e3fa0-cf3b-df77-4b45-988ec3420843@intel.com>
Message-ID: <alpine.DEB.2.21.1806191851520.10546@nanos.tec.linutronix.de>
References: <68030110df15615d95731fd354ff7adfb0476d37.1527593970.git.reinette.chatre@intel.com> <44af4ecef879e88ec1b74c5decbf5dccaf998866.1528405422.git.reinette.chatre@intel.com> <alpine.DEB.2.21.1806191418460.1684@nanos.tec.linutronix.de>
 <fa7e3fa0-cf3b-df77-4b45-988ec3420843@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2018, Reinette Chatre wrote:
> On 6/19/2018 5:31 AM, Thomas Gleixner wrote:
> > On Thu, 7 Jun 2018, Reinette Chatre wrote:
> >> +static void cbm_ensure_valid(u32 *_val, struct rdt_resource *r)
> >> +{
> >> +	unsigned long *val = (unsigned long *)_val;
> > 
> > I'm a bit worried about the u32 to unsigned long case here. I know that
> > cbm_len cannot exceed 32, but still. At least it wants a comment.
> 
> Will do.
> 
> I am planning to add the following to the next version.

Don't bother. I'm picking up the delta as I'm halfways through the whole
thing by now and if there is no major update pending from your side, I'm
going to merge it as is.

Thanks,

	tglx

> -->8--
> diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
> b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
> index bef736f6ba2f..7b4a09d81a30 100644
> --- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
> +++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
> @@ -2285,6 +2285,14 @@ static int mkdir_mondata_all(struct kernfs_node
> *parent_kn,
>   */
>  static void cbm_ensure_valid(u32 *_val, struct rdt_resource *r)
>  {
> +	/*
> +	 * Convert the u32 _val to an unsigned long required by all the bit
> +	 * operations within this function. No more than 32 bits of this
> +	 * converted value can be accessed because all bit operations are
> +	 * additionally provided with cbm_len that is initialized during
> +	 * hardware enumeration using five bits from the EAX register and
> +	 * thus never can exceed 32 bits.
> +	 */
>  	unsigned long *val = (unsigned long *)_val;
>  	unsigned int cbm_len = r->cache.cbm_len;
>  	unsigned long first_bit, zero_bit;
