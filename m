Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BB2C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D5C2086C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfBGSPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:15:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47272 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbfBGSPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:15:17 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2908634CC;
        Thu,  7 Feb 2019 18:15:16 +0000 (UTC)
Received: from w520.home (ovpn-116-24.phx2.redhat.com [10.3.116.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC4076012D;
        Thu,  7 Feb 2019 18:15:14 +0000 (UTC)
Date:   Thu, 7 Feb 2019 11:15:14 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     lantianyu1986@gmail.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, joro@8bytes.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, vkuznets@redhat.com, sashal@kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH V3 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
Message-ID: <20190207111514.425d137b@w520.home>
In-Reply-To: <1549553629-8414-3-git-send-email-Tianyu.Lan@microsoft.com>
References: <1549553629-8414-1-git-send-email-Tianyu.Lan@microsoft.com>
        <1549553629-8414-3-git-send-email-Tianyu.Lan@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 07 Feb 2019 18:15:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Feb 2019 23:33:48 +0800
lantianyu1986@gmail.com wrote:

> From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> 
> On the bare metal, enabling X2APIC mode requires interrupt remapping
> function which helps to deliver irq to cpu with 32-bit APIC ID.
> Hyper-V doesn't provide interrupt remapping function so far and Hyper-V
> MSI protocol already supports to deliver interrupt to the CPU whose
> virtual processor index is more than 255. IO-APIC interrupt still has
> 8-bit APIC ID limitation.
> 
> This patch is to add Hyper-V stub IOMMU driver in order to enable
> X2APIC mode successfully in Hyper-V Linux guest. The driver returns X2APIC
> interrupt remapping capability when X2APIC mode is available. Otherwise,
> it creates a Hyper-V irq domain to limit IO-APIC interrupts' affinity
> and make sure cpus assigned with IO-APIC interrupt have 8-bit APIC ID.
> 
> Define 24 IO-APIC remapping entries because Hyper-V only expose one
> single IO-APIC and one IO-APIC has 24 pins according IO-APIC spec(
> https://pdos.csail.mit.edu/6.828/2016/readings/ia32/ioapic.pdf).
> 
> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> ---
> Change since v2:
>        - Improve comment about why save IO-APIC entry in the irq chip data.
>        - Some code improvement.
>        - Improve statement in the IOMMU Kconfig.
> 
> Change since v1:
>       - Remove unused pr_fmt
>       - Make ioapic_ir_domain as static variable
>       - Remove unused variables cfg and entry in the hyperv_irq_remapping_alloc()
>       - Fix comments
> ---
>  drivers/iommu/Kconfig         |   8 ++
>  drivers/iommu/Makefile        |   1 +
>  drivers/iommu/hyperv-iommu.c  | 194 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/irq_remapping.c |   3 +
>  drivers/iommu/irq_remapping.h |   1 +
>  5 files changed, 207 insertions(+)
>  create mode 100644 drivers/iommu/hyperv-iommu.c
...
> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> new file mode 100644
> index 0000000..d8572c5
> --- /dev/null
> +++ b/drivers/iommu/hyperv-iommu.c
...
> +static int __init hyperv_prepare_irq_remapping(void)
> +{
> +	struct fwnode_handle *fn;
> +	int i;
> +
> +	if (!hypervisor_is_type(x86_hyper_type) ||
> +	    !x2apic_supported())
> +		return -ENODEV;
> +
> +	fn = irq_domain_alloc_named_id_fwnode("HYPERV-IR", 0);
> +	if (!fn)
> +		return -ENOMEM;
> +
> +	ioapic_ir_domain =
> +		irq_domain_create_hierarchy(arch_get_ir_parent_domain(),
> +				0, IOAPIC_REMAPPING_ENTRY, fn,
> +				&hyperv_ir_domain_ops, NULL);
> +
> +	irq_domain_free_fwnode(fn);
> +
> +	/*
> +	 * Hyper-V doesn't provide irq remapping function for
> +	 * IO-APIC and so IO-APIC only accepts 8-bit APIC ID.
> +	 * Cpu's APIC ID is read from ACPI MADT table and APIC IDs
> +	 * in the MADT table on Hyper-v are sorted monotonic increasingly.
> +	 * APIC ID reflects cpu topology. There maybe some APIC ID
> +	 * gaps when cpu number in a socket is not power of two. Prepare
> +	 * max cpu affinity for IOAPIC irqs. Scan cpu 0-255 and set cpu
> +	 * into ioapic_max_cpumask if its APIC ID is less than 256.
> +	 */
> +	for (i = 0; i < 256; i++)
> +		if (cpu_physical_id(i) < 256)
> +			cpumask_set_cpu(i, &ioapic_max_cpumask);

This looks sketchy.  What if NR_CPUS is less than 256?  Thanks,

Alex

> +
> +	return 0;
> +}
