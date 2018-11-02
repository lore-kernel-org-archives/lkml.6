Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10501C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 09:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1DB2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 09:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GJ1kpg/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1DB2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbeKBTCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 15:02:08 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:43162 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbeKBTCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 15:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VBi9d8IQqS7mQMg939rFFgU58+VfaxHoIjOfJuhliyg=; b=GJ1kpg/a7hvmpTzM9rtfaT8VS
        RwXX2VozPSYBBpT8d6RtDhkFx4XTB3mZHg7zlwm/Yfsyz3ikGtjlYAQ+hOvoJY+mNMqEjDucyk8zC
        MGrEh5FtgjKo33jcjyi5lcKdsqYvvyBUboNDUhBDpK1HSb4Ctu9uaBUxzNjHVDnlHYXcc=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:60143)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gIWAn-0001ex-0Z; Fri, 02 Nov 2018 09:55:25 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gIWAg-0004pk-5E; Fri, 02 Nov 2018 09:55:18 +0000
Date:   Fri, 2 Nov 2018 09:55:14 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     wangyufen <wangyufen@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, kstewart@linuxfoundation.org,
        rppt@linux.vnet.ibm.com, gregkh@linuxfoundation.org,
        tglx@linutronix.de, pombredanne@nexb.com, weiyongjun1@huawei.com,
        huawei.libin@huawei.com
Subject: Re: [PATCH v2] ARM:kexec:offline panic_smp_self_stop CPU
Message-ID: <20181102095513.GQ30658@n2100.armlinux.org.uk>
References: <1541071249-15660-1-git-send-email-wangyufen@huawei.com>
 <20181101113430.GO30658@n2100.armlinux.org.uk>
 <5BDBB6FF.6080907@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5BDBB6FF.6080907@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 10:31:27AM +0800, wangyufen wrote:
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
> To fix this problem, this patch split out the panic_smp_self_stop()
> and add set_cpu_online(smp_processor_id(), false).

Looks fine now, please send it to the patch system (details in my
signature.)  Thanks.

> 
> Signed-off-by: Yufen Wang <wangyufen@huawei.com>
> ---
>  arch/arm/kernel/smp.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 9000d8b..d7b86e4 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -682,6 +682,21 @@ void smp_send_stop(void)
>  		pr_warn("SMP: failed to stop secondary CPUs\n");
>  }
>  
> +/* In case panic() and panic() called at the same time on CPU1 and CPU2,
> + * and CPU 1 calls panic_smp_self_stop() before crash_smp_send_stop()
> + * CPU1 can't receive the ipi irqs from CPU2, CPU1 will be always online,
> + * kdump fails. So split out the panic_smp_self_stop() and add
> + * set_cpu_online(smp_processor_id(), false).
> + */
> +void panic_smp_self_stop(void)
> +{
> +	pr_debug("CPU %u will stop doing anything useful since another CPU has paniced\n",
> +	         smp_processor_id());
> +	set_cpu_online(smp_processor_id(), false);
> +	while (1)
> +		cpu_relax();
> +}
> +
>  /*
>   * not supported here
>   */
> -- 
> 2.7.4
> 
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
