Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752525AbeEQP7u (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 11:59:50 -0400
Received: from mail1.microway.com ([50.245.10.177]:45574 "EHLO microway.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751047AbeEQP7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 11:59:48 -0400
Subject: Re: [bisected] rcu_sched detected stalls - 4.15 or newer kernel with
 some Xeon skylake CPUs and extended APIC
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <831e8a53-05d1-edfb-6287-fecfba22b8bd@microway.com>
 <b346f6d2-dd4e-d19b-099e-633045e88f4b@microway.com>
 <alpine.DEB.2.21.1805152208590.1605@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1805161642040.1627@nanos.tec.linutronix.de>
 <cb8012ab-2599-90fd-ca9f-6d1baeea5b12@microway.com>
 <alpine.DEB.2.21.1805171418210.1947@nanos.tec.linutronix.de>
From: Rick Warner <rick@microway.com>
Message-ID: <df100e7c-ffd9-5afe-41c2-fb00f43bc255@microway.com>
Date: Thu, 17 May 2018 11:59:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1805171418210.1947@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Success!

This resolved the issue.  Thanks Thomas!

Rick

On 05/17/18 08:36, Thomas Gleixner wrote:
> Rick,
>
> On Wed, 16 May 2018, Rick Warner wrote:
>
>> I've attached the dmesg output with the kernel parameter and supplied patch.
> Thanks for providing the data. I think I know what's wrong here. Does the
> patch below fix your problem?
>
> While you test, I go looking for a big brown paperbag.
>
> Thanks,
>
> 	tglx
>
> 8<----------------
>
> --- a/arch/x86/kernel/apic/x2apic_cluster.c
> +++ b/arch/x86/kernel/apic/x2apic_cluster.c
> @@ -124,6 +124,7 @@ static void init_x2apic_ldr(void)
>  			goto update;
>  	}
>  	cmsk = cluster_hotplug_mask;
> +	cmsk->clusterid = cluster;
>  	cluster_hotplug_mask = NULL;
>  update:
>  	this_cpu_write(cluster_masks, cmsk);
