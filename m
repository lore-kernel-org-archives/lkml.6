Return-Path: <dietmar.eggemann@arm.com>
X-Google-Smtp-Source: AH8x226S0uDWKXheOgU9fWTMmzzfE1W6P7TWbGp4S9u0HiQP2H75QCAJV4pQdmvjGejPL5WsWa4o
ARC-Seal: i=1; a=rsa-sha256; t=1517996233; cv=none;
        d=google.com; s=arc-20160816;
        b=tPyfy3mrz+81omTSWXnfpsgkh3va+JvGhb9iIYuMFuAAsxjfXhjMgPj4Lo35Y2YdJ0
         LeUgd6q523/umC+czqX9KOnWX31Fguez4b+KStt3Ju47enp/e11APoAkVyJnsIMPTXo5
         U1DuvsYuJW5LQqQd3Os+2wEQl3JaSwgzdoGhA0eppYj8z/iYDqtdf+QJEPGu0ZyhdN/u
         ZMyQp5OYFb8z59fZ8ibD5lbPwDnNz5B1FJt+BYsSQ6zvNmeT+9PAx2Qc9Ro4iWeFgkDY
         S97VHqOnSoBxd/42e16+q4hbSRsM78L+pNKvRNXP4w8ZJ5nU4iFOW8/aVUtedR/DvtS6
         ZKYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=wnP9DS2S9Y5u3SavYTKjcurC8ZuouXZru+cr40JlRRI=;
        b=Th4VdHthyrnCPgvPF7g28PDs+fmAQm7PpwUePOHZzFseM7i+gxnIhJa5qWryyDas6m
         JEBuQBXJJkbwsYMBmFN8why3I3gn71EhcWwlFRdUldxOPge/nd4OteHsW8oa+12ap1cn
         CVhqow0qoGkGBILCwDzcLZHv3NheA+SQn58klxqHLhGf25e6Kw7RHjt00WMyb8d2Tspo
         qUp4JqxS7hraJtNFyrtlaBtlqRGJY/SCEcPb0lgjxlOUdHTZj/D/+YY39pggBv02267d
         Zigkdveb+DImFmOu6VysfcYnY62cE50xXcyj6z4rjorJG87hbbi7+u9XHov7z2HkP7Ha
         d4vg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dietmar.eggemann@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=dietmar.eggemann@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dietmar.eggemann@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=dietmar.eggemann@arm.com
Subject: Re: [PATCH] Revert "base: arch_topology: fix section mismatch build
 warnings"
To: Gaku Inami <gaku.inami.xh@renesas.com>, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org
Cc: sudeep.holla@arm.com, juri.lelli@redhat.com, psodagud@codeaurora.org
References: <1517992328-3559-1-git-send-email-gaku.inami.xh@renesas.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <ac48b648-997f-81b8-9049-3d2c1ab22f2c@arm.com>
Date: Wed, 7 Feb 2018 10:37:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1517992328-3559-1-git-send-email-gaku.inami.xh@renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591730231008876964?=
X-GMAIL-MSGID: =?utf-8?q?1591734418607549013?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Inami-san,

On 02/07/2018 09:32 AM, Gaku Inami wrote:
> This reverts commit 452562abb5b7 ("base: arch_topology: fix section
> mismatch build warnings"). It causes the notifier call hangs in some
> use-cases.
> 
> In some cases with using maxcpus, some of cpus are booted first and
> then the remaining cpus are booted. As an example, some users who want
> to realize fast boot up often use the following procedure.
> 
>    1) Define all CPUs on device tree (CA57x4 + CA53x4)
>    2) Add "maxcpus=4" in bootargs
>    3) Kernel boot up with CA57x4
>    4) After kernel boot up, CA53x4 is booted from user
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
> WARNING: vmlinux.o(.text+0x548f24): Section mismatch in reference
> from the function init_cpu_capacity_callback() to the variable
> .init.text:$x
> The function init_cpu_capacity_callback() references
> the variable __init $x.
> This is often because init_cpu_capacity_callback lacks a __init
> annotation or the annotation of $x is wrong.
> 
> Signed-off-by: Gaku Inami <gaku.inami.xh@renesas.com>

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

This also helps with cpufreq driver module loading. W/o this revert I 
get the following when trying to modprobe scpi-cpufreq on juno:

root@juno:/lib/modules# modprobe scpi-cpufreq
[  171.994851] Unable to handle kernel paging request at virtual address 
ffff000008f57708
[  172.002708] Mem abort info:
[  172.005471]   ESR = 0x96000007
[  172.008507]   Exception class = DABT (current EL), IL = 32 bits
[  172.014391]   SET = 0, FnV = 0
[  172.017410]   EA = 0, S1PTW = 0
[  172.020528] Data abort info:
[  172.023384]   ISV = 0, ISS = 0x00000007
[  172.027190]   CM = 0, WnR = 0
[  172.030139] swapper pgtable: 4k pages, 48-bit VAs, pgd = 0000000015b245a1
[  172.036867] [ffff000008f57708] *pgd=00000009ffffe003, 
*pud=00000009ffffd003, *pmd=00000009ffffb003, *pte=0000000000000000
[  172.047737] Internal error: Oops: 96000007 [#1] PREEMPT SMP
[  172.053250] Modules linked in: scpi_cpufreq(+)
[  172.057656] CPU: 1 PID: 2439 Comm: modprobe Not tainted 
4.15.0-10759-ge237f98a9c13 #1
[  172.065405] Hardware name: ARM Juno development board (r0) (DT)
[  172.071265] pstate: a0000005 (NzCv daif -PAN -UAO)
[  172.076012] pc : notifier_call_chain+0x34/0x90
[  172.080411] lr : __blocking_notifier_call_chain+0x50/0x78
[  172.085752] sp : ffff00000dc4b750
[  172.089029] x29: ffff00000dc4b750 x28: ffff80097526b808
[  172.094291] x27: 0000000000000040 x26: ffff0000090bbc30
[  172.099551] x25: ffff00000913d000 x24: ffff00000913df98
[  172.104811] x23: 0000000000000000 x22: ffff00000dc4b840
[  172.110071] x21: ffff00000dc4b840 x20: 0000000000000000
[  172.115330] x19: 00000000ffffffff x18: 0000000000000000
[  172.120589] x17: 0000aaaaad4b02b0 x16: ffff00000814e9b8
[  172.125848] x15: ffffffffffffffff x14: 0000000000000000
[  172.131107] x13: ffff80097526b968 x12: ffff80097526b968
[  172.136366] x11: 0000000000000000 x10: 0000000000000000
[  172.141625] x9 : 0000000000000000 x8 : ffff8009753c1e00
[  172.146884] x7 : 00000000000cf850 x6 : ffff000008f57708
[  172.152143] x5 : 00000000ffffffff x4 : 0000000000000000
[  172.157402] x3 : 00000000ffffffff x2 : ffff00000dc4b840
[  172.162661] x1 : ffff000008f57708 x0 : ffff0000090bbcd8
[  172.167922] Process modprobe (pid: 2439, stack limit = 
0x000000005740a6c4)
[  172.174724] Call trace:
[  172.177143]  notifier_call_chain+0x34/0x90
[  172.181196]  __blocking_notifier_call_chain+0x50/0x78
[  172.186195]  blocking_notifier_call_chain+0x14/0x20
[  172.191025]  cpufreq_set_policy+0x8c/0x1e0
[  172.195077]  cpufreq_init_policy+0x58/0x90
[  172.199130]  cpufreq_online+0x3d4/0x658
[  172.202924]  cpufreq_add_dev+0x78/0x88
[  172.206635]  subsys_interface_register+0x84/0xc8
[  172.211203]  cpufreq_register_driver+0x150/0x1d0
[  172.215778]  scpi_cpufreq_probe+0x28/0x80 [scpi_cpufreq]
[  172.221036]  platform_drv_probe+0x58/0xc0
[  172.225003]  driver_probe_device+0x224/0x308
[  172.229227]  __driver_attach+0xac/0xb0
[  172.232935]  bus_for_each_dev+0x54/0x98
[  172.236729]  driver_attach+0x20/0x28
[  172.240265]  bus_add_driver+0x108/0x228
[  172.244060]  driver_register+0x60/0xf8
[  172.247769]  __platform_driver_register+0x40/0x48
[  172.252427]  scpi_cpufreq_platdrv_init+0x18/0x1000 [scpi_cpufreq]
[  172.258459]  do_one_initcall+0x38/0x120
[  172.262255]  do_init_module+0x58/0x1b8
[  172.265964]  load_module+0x1ed8/0x21e8
[  172.269672]  SyS_finit_module+0xc0/0xd0
[  172.273466]  el0_svc_naked+0x20/0x24
[  172.277004] Code: 54000320 2a0303f3 aa0203f6 aa0403f4 (f9400023)
[  172.283035] ---[ end trace f70b068835918c13 ]---
Segmentation fault

[...]
