Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49834C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17465206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17465206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbeLEKYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:24:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60010 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbeLEKYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:24:15 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 744D0308ED44;
        Wed,  5 Dec 2018 10:24:15 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-63.pek2.redhat.com [10.72.12.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D51D860E3F;
        Wed,  5 Dec 2018 10:24:11 +0000 (UTC)
Date:   Wed, 5 Dec 2018 18:24:07 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com
Subject: Re: [PATCH 2/2 v2] kdump,vmcoreinfo: Export the value of sme mask to
 vmcoreinfo
Message-ID: <20181205102407.GB6940@dhcp-128-65.nay.redhat.com>
References: <20181202030839.29945-1-lijiang@redhat.com>
 <20181202030839.29945-3-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181202030839.29945-3-lijiang@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 05 Dec 2018 10:24:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/18 at 11:08am, Lianbo Jiang wrote:
> For AMD machine with SME feature, makedumpfile tools need to know
> whether the crash kernel was encrypted or not. If SME is enabled
> in the first kernel, the crash kernel's page table(pgd/pud/pmd/pte)
> contains the memory encryption mask, so need to remove the sme mask
> to obtain the true physical address.
> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  arch/x86/kernel/machine_kexec_64.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index 4c8acdfdc5a7..1860fe24117d 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -352,10 +352,24 @@ void machine_kexec(struct kimage *image)
>  
>  void arch_crash_save_vmcoreinfo(void)
>  {
> +	u64 sme_mask = sme_me_mask;
> +
>  	VMCOREINFO_NUMBER(phys_base);
>  	VMCOREINFO_SYMBOL(init_top_pgt);
>  	vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
>  			pgtable_l5_enabled());
> +	/*
> +	 * Currently, the local variable 'sme_mask' stores the value of
> +	 * sme_me_mask(bit 47), and also write the value of sme_mask to
> +	 * the vmcoreinfo.
> +	 * If need, the bit(sme_mask) might be redefined in the future,
> +	 * but the 'bit63' will be reserved.
> +	 * For example:
> +	 * [ misc	   ][ enc bit  ][ other misc SME info       ]
> +	 * 0000_0000_0000_0000_1000_0000_0000_0000_0000_0000_..._0000
> +	 * 63   59   55   51   47   43   39   35   31   27   ... 3
> +	 */
> +	VMCOREINFO_NUMBER(sme_mask);

#define VMCOREINFO_NUMBER(name) \
        vmcoreinfo_append_str("NUMBER(%s)=%ld\n", #name, (long)name)

VMCOREINFO_NUMBER is defined as above, so it looks questionable to add
more users of that for different data types although it may work in real
world.

A new macro like below may be better, may need to choose a better name
though:
_VMCOREINFO_NUMBER(name, format, type)
so you can pass the format specifier and data types explictly


>  
>  #ifdef CONFIG_NUMA
>  	VMCOREINFO_SYMBOL(node_data);
> -- 
> 2.17.1
> 

Thanks
Dave
