Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AH8x227oku2i0kDbTcahK1Zdz+9xtusMm7qbfAJko2wMU5zof1W18cz3XoFVjrn+jTxWKcioyLCk
ARC-Seal: i=1; a=rsa-sha256; t=1518438527; cv=none;
        d=google.com; s=arc-20160816;
        b=Gl+mlxqVFoMyqMm9UUwN8XZgWZAOwl31QDXy5Z0+dQCQ1DQ6fpIk1RuRP7GsZseBNV
         TQSgy8lh/hP3bsq1esAcnI9M03HYDzoWjauAmMqVESFrsR55VOu2nG5VLRXpDnv2JZGt
         zqvFjzoe9ui7ymd5sECiUEeKSuDXRXzNQfchIoOQpaUhL9HBiuY2z8v/pN/P4K1ryXCb
         2DJKL7vFPAKAU1CedEG4CIIz7wkECj/6+Jrbw5Ngo5NwJcOgA235jkoru3MIg+3bwUYt
         wk6d7TmkAcHUKcVGYNgHkJ+VYWFMEW8NzzN5DvlE+T3qWlLLXBFVsgryuUTHCv5RjIvd
         MWpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=9sEkPeAdmVjf66wcGkCcxiM+RLSM6Qzg6z3/xcO1XPk=;
        b=y8zuzedyf9fQboKPXDS30uabHFtAUQpDy+NC8tI1FlHLgvhfQq1EMtzh+/qJQmb6fB
         7UQla4qcfjQL/Q0Hl/nIOUtlqicEoAv/n3+8ti+WJHx6Ah0Y3wpEG1PFP41+HJsAsIG3
         CKT+02832AITVbV3G3hV5EzBkOIcYYyQjjNFl+o/yAsqL3eb2qZWVHJcRVZdFUL9PTl9
         SBQyKHkJ4e3YJ2W2BZw+gbJhTABF/Vohd8R1zwX6j5qNVpMOgLYbtm63IrrJjdCY0DHm
         JjSPLrgLg4XpCSj3A+awIhclhj7IIpKCNaY+CZvtfRMvHFsxpSPV/cZy7uyqLL7ELX9n
         NI7A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>, dietmar.eggemann@arm.com,
 juri.lelli@redhat.com, psodagud@codeaurora.org
Subject: Re: [PATCH] Revert "base: arch_topology: fix section mismatch build
 warnings"
To: Gaku Inami <gaku.inami.xh@renesas.com>, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org
References: <1517992328-3559-1-git-send-email-gaku.inami.xh@renesas.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <cd046554-4155-6ed9-8378-fb9ef9e6f9d2@arm.com>
Date: Mon, 12 Feb 2018 12:28:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1517992328-3559-1-git-send-email-gaku.inami.xh@renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591730231008876964?=
X-GMAIL-MSGID: =?utf-8?q?1592198197501700322?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 07/02/18 08:32, Gaku Inami wrote:
> This reverts commit 452562abb5b7 ("base: arch_topology: fix section
> mismatch build warnings"). It causes the notifier call hangs in some
> use-cases.
> 
> In some cases with using maxcpus, some of cpus are booted first and
> then the remaining cpus are booted. As an example, some users who want
> to realize fast boot up often use the following procedure.
> 
>   1) Define all CPUs on device tree (CA57x4 + CA53x4)
>   2) Add "maxcpus=4" in bootargs
>   3) Kernel boot up with CA57x4
>   4) After kernel boot up, CA53x4 is booted from user
> 
> When kernel init was finished, CPUFREQ_POLICY_NOTIFIER was not still
> unregisterd. This means that "__init init_cpu_capacity_callback()"
> will be called after kernel init sequence. To avoid this problem,
> it needs to remove __init{,data} annotations by reverting this commit.
> 
> Also, this commit was needed to fix kernel compile issue below.
> However, this issue was also fixed by another patch: commit 82d8ba717ccb
> ("arch_topology: Fix section miss match warning due to
> free_raw_capacity()") in v4.15 as well.
> Whereas commit 452562abb5b7 added all the missing __init annotations,
> commit 82d8ba717ccb removed it from free_raw_capacity().
> 

Ah I see commit 82d8ba717ccb made the commit 452562abb5b7 redundant
by removing the __init. Both attempt to solve the same problem in
different ways :)

Can you please add the the tag, so that it gets picked up accordingly ?

Fixes: 82d8ba717ccb ("arch_topology: Fix section miss match warning due
to free_raw_capacity()")


FWIW,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

> WARNING: vmlinux.o(.text+0x548f24): Section mismatch in reference
> from the function init_cpu_capacity_callback() to the variable
> .init.text:$x
> The function init_cpu_capacity_callback() references
> the variable __init $x.
> This is often because init_cpu_capacity_callback lacks a __init
> annotation or the annotation of $x is wrong.
> 
> Signed-off-by: Gaku Inami <gaku.inami.xh@renesas.com>
> ---
>  drivers/base/arch_topology.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 4de87b0..8bfd498 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -175,11 +175,11 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
>  }
>  
>  #ifdef CONFIG_CPU_FREQ
> -static cpumask_var_t cpus_to_visit __initdata;
> -static void __init parsing_done_workfn(struct work_struct *work);
> -static __initdata DECLARE_WORK(parsing_done_work, parsing_done_workfn);
> +static cpumask_var_t cpus_to_visit;
> +static void parsing_done_workfn(struct work_struct *work);
> +static DECLARE_WORK(parsing_done_work, parsing_done_workfn);
>  
> -static int __init
> +static int
>  init_cpu_capacity_callback(struct notifier_block *nb,
>  			   unsigned long val,
>  			   void *data)
> @@ -215,7 +215,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
>  	return 0;
>  }
>  
> -static struct notifier_block init_cpu_capacity_notifier __initdata = {
> +static struct notifier_block init_cpu_capacity_notifier = {
>  	.notifier_call = init_cpu_capacity_callback,
>  };
>  
> @@ -248,7 +248,7 @@ static int __init register_cpufreq_notifier(void)
>  }
>  core_initcall(register_cpufreq_notifier);
>  
> -static void __init parsing_done_workfn(struct work_struct *work)
> +static void parsing_done_workfn(struct work_struct *work)
>  {
>  	cpufreq_unregister_notifier(&init_cpu_capacity_notifier,
>  					 CPUFREQ_POLICY_NOTIFIER);
> 

-- 
Regards,
Sudeep
