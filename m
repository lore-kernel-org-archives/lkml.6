Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752699AbeBVIHf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 03:07:35 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:33857 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751687AbeBVIHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 03:07:34 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="37167914"
Subject: Re: [PATCH] smpboot: correctly update number of booted cores
To: Samuel Neves <sneves@dei.uc.pt>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <hpa@zytor.com>, <x86@kernel.org>,
        <jgross@suse.com>, <luto@kernel.org>, <prarit@redhat.com>,
        <ak@linux.intel.com>, <vkuznets@redhat.com>,
        <linux-kernel@vger.kernel.org>
References: <20180221205036.5244-1-sneves@dei.uc.pt>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <12fc2cb0-aeb8-a74e-2524-1ca97fa043a8@cn.fujitsu.com>
Date: Thu, 22 Feb 2018 16:07:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180221205036.5244-1-sneves@dei.uc.pt>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 4A4E948AE762.ACBCE
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



At 02/22/2018 04:50 AM, Samuel Neves wrote:
> Without this fix, /proc/cpuinfo will display an incorrect amount
> of CPU cores, after bringing them offline and online again, as
> exemplified below:
> 
> $ cat /proc/cpuinfo | grep cores
> cpu cores	: 4
> cpu cores	: 8
> cpu cores	: 8
> cpu cores	: 20
> cpu cores	: 4
> cpu cores	: 3
> cpu cores	: 2
> cpu cores	: 2
> 
> This patch fixes this by always zeroing the booted_cores variable
> upon turning off a logical CPU.
> 
> Signed-off-by: Samuel Neves <sneves@dei.uc.pt>

Yes, tested it in Qemu with 15 hot-pluggable CPUs, like below
   ...
   -smp 1,maxcpus=16,sockets=2,cores=4,threads=2
   ...

When a new CPU bringups a new core, for each core in package, Linux 
increments the booted_cores for this new cpu in set_cpu_sibling_map().
Due to the uncleared booted_cores, this incorrect number of CPU cores
will be shown.

Tested-by: Dou Liyang <douly.fnst@cn.fujitsu.com>

> ---
>   arch/x86/kernel/smpboot.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 9eee25d07586..ff99e2b6fc54 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1437,6 +1437,7 @@ static void remove_siblinginfo(int cpu)
>   	cpumask_clear(topology_sibling_cpumask(cpu));
>   	cpumask_clear(topology_core_cpumask(cpu));
>   	c->cpu_core_id = 0;
> +	c->booted_cores = 0;
>   	cpumask_clear_cpu(cpu, cpu_sibling_setup_mask);
>   	recompute_smt_state();
>   }
> 
