Return-Path: <boris.ostrovsky@oracle.com>
X-Google-Smtp-Source: AH8x227InsYtK2J+YMqKlq/EExufD6fy08KsZpnWsZMx5/HV+rJuQAaeSfDoKwtAscoAukzowhgs
ARC-Seal: i=1; a=rsa-sha256; t=1518051584; cv=none;
        d=google.com; s=arc-20160816;
        b=NFXOfZ1DvC7B5Kobj3XhaZd+bQxILGI8aiZwKWyeP3qFqlUOdbWHjNI62Ung3Gmra6
         NKrl4/P6rVQeyQyf+VstE1vnnX3qNKcpVmdvi4ZFQrSMmLjQZbkoHZTmMruymcOEFkrt
         Z4NfKMDpbnNDqhs89kBGRifjjqdvUDGB8cznqZj91rfmpejT5lNzm//1VD2beHofwMR9
         k5YVFaDjSRF0IM/15JJFis171QFUxCqXModgOADrLxTNaDONTzU00ZzMY9zCVuP23Tu2
         vKWd4PfsYbg5ZG13irhJt7rO8dakknSNvnrcG+2MMEe+MyAZTuogsDohTvC/aXEI0b9d
         JBgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=y1hSRFCzOFH+BQXW/q7CHRyRkwVGuruavV+qn7fbpnc=;
        b=YQIfK5SWvbN0yHiti+CBaNiDTLgXrCGlhKmqpIoBTj7GvN6Vb17Qz7wpd2UO1OgM9z
         mJzNJscu9sTwLEyuuN2WBKeZ+egI8ximSTETjVsBWoWo8nQxKSdZRwOmXikZbQqZKTBH
         2ACWWaIQpEXsnqoB0jT/7qnSpvywL0Xp5Wln2vRmhW1VzY9sV5tr6Aj9B+cEiuxyRY5d
         BiyCnpwc2pUMYfghpecX78jLAtBC341dF2hexl+vFE4qahkv9VWcCC0Wg/m7anPI2jnG
         ssVIDE/Eg8MaVY/puyh+PrtOQhPey/6a5bSkslYZRZ0enRd6hB84PX/8UQPhwv2ZZ9Qs
         zKaw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=UgnJNp33;
       spf=pass (google.com: domain of boris.ostrovsky@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=boris.ostrovsky@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=UgnJNp33;
       spf=pass (google.com: domain of boris.ostrovsky@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=boris.ostrovsky@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Subject: Re: [PATCH] x86/xen: Calculate __max_logical_packages on PV domains
To: Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, xen-devel@lists.xenproject.org,
        simon@invisiblethingslab.com
References: <20180207234923.13544-1-prarit@redhat.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <5607eaea-5cc3-31a4-9685-1d7dd147f564@oracle.com>
Date: Wed, 7 Feb 2018 19:59:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180207234923.13544-1-prarit@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8798 signatures=668663
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802080007
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591788037595473599?=
X-GMAIL-MSGID: =?utf-8?q?1591792458686884541?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 02/07/2018 06:49 PM, Prarit Bhargava wrote:
> The kernel panics on PV domains because native_smp_cpus_done() is
> only called for HVM domains.
> 
> Calculate __max_logical_packages for PV domains.
> 
> Fixes: b4c0a7326f5d ("x86/smpboot: Fix __max_logical_packages estimate")
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Tested-and-reported-by: Simon Gaiser <simon@invisiblethingslab.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
> Cc: Prarit Bhargava <prarit@redhat.com>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: xen-devel@lists.xenproject.org


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

(+ Simon)

> ---
>   arch/x86/include/asm/smp.h |  1 +
>   arch/x86/kernel/smpboot.c  | 10 ++++++++--
>   arch/x86/xen/smp.c         |  2 ++
>   3 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
> index 461f53d27708..a4189762b266 100644
> --- a/arch/x86/include/asm/smp.h
> +++ b/arch/x86/include/asm/smp.h
> @@ -129,6 +129,7 @@ static inline void arch_send_call_function_ipi_mask(const struct cpumask *mask)
>   void cpu_disable_common(void);
>   void native_smp_prepare_boot_cpu(void);
>   void native_smp_prepare_cpus(unsigned int max_cpus);
> +void calculate_max_logical_packages(void);
>   void native_smp_cpus_done(unsigned int max_cpus);
>   void common_cpu_up(unsigned int cpunum, struct task_struct *tidle);
>   int native_cpu_up(unsigned int cpunum, struct task_struct *tidle);
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 6f27facbaa9b..767573b7f2db 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1281,11 +1281,10 @@ void __init native_smp_prepare_boot_cpu(void)
>   	cpu_set_state_online(me);
>   }
>   
> -void __init native_smp_cpus_done(unsigned int max_cpus)
> +void __init calculate_max_logical_packages(void)
>   {
>   	int ncpus;
>   
> -	pr_debug("Boot done\n");
>   	/*
>   	 * Today neither Intel nor AMD support heterogenous systems so
>   	 * extrapolate the boot cpu's data to all packages.
> @@ -1293,6 +1292,13 @@ void __init native_smp_cpus_done(unsigned int max_cpus)
>   	ncpus = cpu_data(0).booted_cores * topology_max_smt_threads();
>   	__max_logical_packages = DIV_ROUND_UP(nr_cpu_ids, ncpus);
>   	pr_info("Max logical packages: %u\n", __max_logical_packages);
> +}
> +
> +void __init native_smp_cpus_done(unsigned int max_cpus)
> +{
> +	pr_debug("Boot done\n");
> +
> +	calculate_max_logical_packages();
>   
>   	if (x86_has_numa_in_package)
>   		set_sched_topology(x86_numa_in_package_topology);
> diff --git a/arch/x86/xen/smp.c b/arch/x86/xen/smp.c
> index 77c959cf81e7..7a43b2ae19f1 100644
> --- a/arch/x86/xen/smp.c
> +++ b/arch/x86/xen/smp.c
> @@ -122,6 +122,8 @@ void __init xen_smp_cpus_done(unsigned int max_cpus)
>   
>   	if (xen_hvm_domain())
>   		native_smp_cpus_done(max_cpus);
> +	else
> +		calculate_max_logical_packages();
>   
>   	if (xen_have_vcpu_info_placement)
>   		return;
> 
