Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A10C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9647322436
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9647322436
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752511AbeGDOIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:08:10 -0400
Received: from foss.arm.com ([217.140.101.70]:37954 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751761AbeGDOIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:08:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3AA018A;
        Wed,  4 Jul 2018 07:08:08 -0700 (PDT)
Received: from red-moon (unknown [10.1.206.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F9EA3F5A0;
        Wed,  4 Jul 2018 07:08:06 -0700 (PDT)
Date:   Wed, 4 Jul 2018 15:09:55 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     'Bjorn Helgaas' <bhelgaas@google.com>,
        "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'driverdev-devel@linuxdriverproject.org'" 
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "'vkuznets@redhat.com'" <vkuznets@redhat.com>,
        "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>
Subject: Re: [PATCH v2] PCI: hv: Disable/enable irq rather than bh in
 hv_compose_msi_msg()
Message-ID: <20180704140955.GA12863@red-moon>
References: <KL1P15301MB0006BE5DB7C3C45386E4327FBF4C0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <KL1P15301MB0006BE5DB7C3C45386E4327FBF4C0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 01, 2018 at 06:22:23PM +0000, Dexuan Cui wrote:
> 
> Commit de0aa7b2f97d ("PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()")
> uses local_bh_disable()/enable(), because hv_pci_onchannelcallback() can
> also run in tasklet context as the channel event callback, and here we
> want to avoid the race.
> 
> With CONFIG_PROVE_LOCKING=y in the recent mainline, or old kernels that
> don't have commit f71b74bca637 ("irq/softirqs: Use lockdep to assert IRQs
> are disabled/enabled"), when the upper layer irq code calls
> hv_compose_msi_msg() with local irq DISABLED, we'll see a warning at the
> beginning of __local_bh_enable_ip():
> 
> IRQs not enabled as expected
>   WARNING: CPU: 0 PID: 408 at kernel/softirq.c:162 __local_bh_enable_ip
> 
> The warning exposes an issue in de0aa7b2f97d: local_bh_enable() can
> potentially call do_softirq(), which is not supposed to run when local
> irq is DISABLED. Let's fix this by using local_irq_save()/restore()
> instead.
> 
> Note: hv_pci_onchannelcallback() is not a hot path because it's only
> called when the PCI device is hot added and removed, which is infrequent.
> 
> Fixes: de0aa7b2f97d ("PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: <stable@vger.kernel.org>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> ---
> 
> A trimmed version of the warning is:
> 
> IRQs not enabled as expected
> WARNING: CPU: 0 PID: 408 at kernel/softirq.c:162 __local_bh_enable_ip+0xb0/0xe0
> Call Trace:
>  hv_compose_msi_msg+0x209/0x462 [pci_hyperv]
>  irq_chip_compose_msi_msg+0x41/0x50
>  msi_domain_activate+0x1a/0x40
>  __irq_domain_activate_irq+0x59/0x90
>  irq_domain_activate_irq+0x25/0x40
>  __setup_irq+0x3ec/0x730
> request_threaded_irq+0xfa/0x1a0
> mlx4_init_eq_table+0x3c3/0x5f0 [mlx4_core]
> mlx4_setup_hca+0x1db/0x750 [mlx4_core]
> mlx4_load_one+0xad2/0x13b0 [mlx4_core]
> mlx4_init_one+0x578/0x710 [mlx4_core]
> local_pci_probe+0x1e/0x50
> work_for_cpu_fn+0x10/0x20
> process_one_work+0x1d4/0x5a0
> worker_thread+0x1cb/0x3d0
> kthread+0xf5/0x130
> 
> 
> Changes since v1:
> 	Updated the changelog only (fixed typos and some inaccuracy)
> 
> 
>  drivers/pci/controller/pci-hyperv.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Applied to pci/controller-fixes, to be tentatively sent for an
upcoming -rc, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index ba1d4b5..eb20296 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1073,6 +1073,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  	struct pci_bus *pbus;
>  	struct pci_dev *pdev;
>  	struct cpumask *dest;
> +	unsigned long flags;
>  	struct compose_comp_ctxt comp;
>  	struct tran_int_desc *int_desc;
>  	struct {
> @@ -1164,14 +1165,15 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  		 * the channel callback directly when channel->target_cpu is
>  		 * the current CPU. When the higher level interrupt code
>  		 * calls us with interrupt enabled, let's add the
> -		 * local_bh_disable()/enable() to avoid race.
> +		 * local_irq_save()/restore() to avoid race:
> +		 * hv_pci_onchannelcallback() can also run in tasklet.
>  		 */
> -		local_bh_disable();
> +		local_irq_save(flags);
>  
>  		if (hbus->hdev->channel->target_cpu == smp_processor_id())
>  			hv_pci_onchannelcallback(hbus);
>  
> -		local_bh_enable();
> +		local_irq_restore(flags);
>  
>  		if (hpdev->state == hv_pcichild_ejecting) {
>  			dev_err_once(&hbus->hdev->device,
> -- 
> 2.7.4
> 
