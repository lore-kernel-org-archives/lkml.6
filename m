Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04DCC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F08620657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WRAkXFoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F08620657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbeKAUhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 16:37:15 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:56680 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbeKAUhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 16:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rVbgDuHN7Pn0GEhcjgdzcJ06Ges+6Ly+S+g7d6EOT9E=; b=WRAkXFoF6JhMkCyULyCNCapoU
        ZRLYTKVwcadM2hWtTXSywgyEbtKfIgGoSn8DSEPPVrH4pMQ3fFSH7Is7BqO38Ha4lhDmYFCIKXaf/
        goWmQGVAqKIvW1uogm6mXXMrMhODxMXmvIAcSjGiyPDUOfuSNZdrDOxBTuiq2tiRtjXTw=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:54620)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gIBFD-0004nG-FT; Thu, 01 Nov 2018 11:34:35 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gIBFA-0007eZ-8x; Thu, 01 Nov 2018 11:34:32 +0000
Date:   Thu, 1 Nov 2018 11:34:30 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, kstewart@linuxfoundation.org,
        rppt@linux.vnet.ibm.com, gregkh@linuxfoundation.org,
        tglx@linutronix.de, pombredanne@nexb.com, weiyongjun1@huawei.com,
        huawei.libin@huawei.com
Subject: Re: [PATCH] ARM:kexec:offline panic_smp_self_stop CPU
Message-ID: <20181101113430.GO30658@n2100.armlinux.org.uk>
References: <1541071249-15660-1-git-send-email-wangyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541071249-15660-1-git-send-email-wangyufen@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 07:20:49PM +0800, Wang Yufen wrote:
> From: Yufen Wang <wangyufen@huawei.com>
> 
> In case panic() and panic() called at the same time on different CPUS.
> For example:
> CPU 0:
>   panic()
>      __crash_kexec
>        machine_crash_shutdown
>          crash_smp_send_stop
>        machine_kexec
>          BUG_ON(num_online_cpus() > 1);
> 
> CPU 1:
>   panic()
>     local_irq_disable
>     panic_smp_self_stop
> 
> If CPU 1 calls panic_smp_self_stop() before crash_smp_send_stop(), kdump
> fails. CPU1 can't receive the ipi irq, CPU1 will be always online.
> I changed BUG_ON to WARN in kexec crash as arm64 does, kdump also fails.
> Because num_online_cpus() > 1, can't disable the L2 in _soft_restart.
> To fix this problem, this patch split out the panic_smp_self_stop()
> and add set_cpu_online(smp_processor_id(), false).

Thanks.

I think this may as well go into arch/arm/kernel/smp.c - it won't be
required for single-CPU systems, since there aren't "other" CPUs.

It's probably also worth a comment above the function as to why we
have this.

> 
> Signed-off-by: Yufen Wang <wangyufen@huawei.com>
> ---
>  arch/arm/kernel/setup.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 31940bd..151861f 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -602,6 +602,16 @@ static void __init smp_build_mpidr_hash(void)
>  }
>  #endif
>  
> +void panic_smp_self_stop(void)
> +{
> +	printk(KERN_DEBUG "CPU %u will stop doing anything useful since another CPU has paniced\n",
> +			smp_processor_id());
> +	set_cpu_online(smp_processor_id(), false);
> +	while (1)
> +		cpu_relax();
> +
> +}
> +
>  static void __init setup_processor(void)
>  {
>  	struct proc_info_list *list;
> -- 
> 2.7.4
> 
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
