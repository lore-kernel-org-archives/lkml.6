Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AIpwx4/uhlNv1EzCNcFuuHuePtrvoJadvrYCkLWS69Hw4qIoexMelqh2YVLjbK0c4ERaEzEvPePg
ARC-Seal: i=1; a=rsa-sha256; t=1524767605; cv=none;
        d=google.com; s=arc-20160816;
        b=GnU6l8nEfF5/GUFb+HJFi3b35dR0pzZptUtpPUBnYI4mgxvJINCA9rwnJ//EtgnBhH
         wjhXBNlFoSWRyFp6Q5gRTb0uhlF5rq+3/qFpZHmeXLkHJFtqX+zSC09NEi6FfMyRltXi
         a+rD4sE1oc04o/+FWtmbXl6omkXr/GsoHNsNOzU+8Y89xQWR+at+D/1tISBU/7qF4NlY
         X0BgP7o26SLVONSFnmyTW79UY0i/8Jb212HZAiFY/5NbVsKqV/gSnXepq/g9xgY/GTaS
         rf0l/FBMG344jThnZYnDyQx8eaXPLmWiWfT1wTkzssQhUx4PvNTf42xPmPVaCErk4j1n
         9m1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=sj3pHDpN8L0r00XyqvOLlCz7DmRuiFhgblfVSORkaxA=;
        b=vMsZlbjUuw3qObyqwad1/2BayKmzwAPXUhi99mvIAGCSUJt4xkKVIyp6Jt076Ub2Ct
         UofMADiPN0NOrUk++nLt322KVkHfMstGk39f6tVQtxbnAfuy0mZ6yScV+CmDeTZsxQiU
         hL5FWYFQhLMWAPRcIEosQ6ZB7C5vDNOgRvFqDr52zbK8CHtqvG5K5iZhmFcWYu+ZB1vq
         QKqjN3rj+iKrwCAArj5YUsOBkz7WceaTqWiCnARACoKJMKYvkwRaxsHQCucm8EXU6UyG
         ZIr9xDUD22xXMYgdWpHvuvvFvP9q/o1q/MbDfQoOwKaijfLR4BODdLl0MlaS+9i8tgP+
         2ISQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
Subject: Re: [PATCH v8 04/13] arm64/acpi: Create arch specific cpu to acpi id
 helper
To: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Lorenzo.Pieralisi@arm.com,
 hanjun.guo@linaro.org, rjw@rjwysocki.net, Will.Deacon@arm.com,
 Catalin.Marinas@arm.com, gregkh@linuxfoundation.org, Mark.Rutland@arm.com,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 wangxiongfeng2@huawei.com, vkilari@codeaurora.org, ahs3@redhat.com,
 Dietmar.Eggemann@arm.com, Morten.Rasmussen@arm.com, palmer@sifive.com,
 lenb@kernel.org, john.garry@huawei.com, austinwc@codeaurora.org,
 tnowicki@caviumnetworks.com, jhugo@qti.qualcomm.com, timur@qti.qualcomm.com,
 ard.biesheuvel@linaro.org
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <20180425233121.13270-5-jeremy.linton@arm.com>
 <16324b54-42d4-d9bc-6d57-de52431dc209@arm.com>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <ee956bd3-37d7-b9ac-af55-dc297397476d@arm.com>
Date: Thu, 26 Apr 2018 13:33:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <16324b54-42d4-d9bc-6d57-de52431dc209@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766316038693524?=
X-GMAIL-MSGID: =?utf-8?q?1598834716459771087?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 04/26/2018 05:27 AM, Sudeep Holla wrote:
> 
> 
> On 26/04/18 00:31, Jeremy Linton wrote:
>> Its helpful to be able to lookup the acpi_processor_id associated
>> with a logical cpu. Provide an arm64 helper to do this.
>>
> 
> As I pointed out in the earlier version, this patch is not required.
> The acpi_id stored in the acpi_processor can be used for this.
> Won't the below change make it work ? I can't think of any reason why it
> shouldn't.

So, I only noticed your previous email last night on the mail archive, 
as I was applying your review/ack tags and couldn't find a response for 
this patch, seem the spam/etc filters need some further tweaking!

At that point, I was pretty sure the suggestion wasn't going to work out 
of the box as a lot of this code is running fairly early in the boot 
process. I spent a bit of time and plugged the change in to verify that 
assertion, and yes the per_cpu processor/acpi bits aren't setup early 
enough to be used by much of this code. It is being called from 
init_cpu_topology()/smp_prepare_cpus() which precedes 
do_basic_setup/do_initcalls() which is what runs the acpi_init() 
sequence which ends up eventually allocating the required data 
structures. So without restructuring the core boot sequence, this seems 
like a reasonable solution.


Thanks,


> 
> Regards,
> Sudeep
> 
> -->8
> 
> diff --git i/drivers/acpi/pptt.c w/drivers/acpi/pptt.c
> index 0fc4b2654665..f421f58b4ae6 100644
> --- i/drivers/acpi/pptt.c
> +++ w/drivers/acpi/pptt.c
> @@ -432,7 +432,7 @@ static void cache_setup_acpi_cpu(struct
> acpi_table_header *table,
>   {
>          struct acpi_pptt_cache *found_cache;
>          struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
> -       u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
> +       u32 acpi_cpu_id = per_cpu(processors, cpu)->acpi_id;
>          struct cacheinfo *this_leaf;
>          unsigned int index = 0;
>          struct acpi_pptt_processor *cpu_node = NULL;
> 
