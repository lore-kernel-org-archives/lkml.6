Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbeCODA6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 23:00:58 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:46756 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751556AbeCODA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 23:00:57 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="37834458"
Subject: Re: [RFC PATCH] ACPI / processor: Get accurate possible CPU count
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>, <ming.lei@redhat.com>
References: <20180314102847.30459-1-douly.fnst@cn.fujitsu.com>
 <CAHp75VfGPgbD8gBdvchBn5U8gH93zoHB9ja3KucUuxVNq+_MLg@mail.gmail.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <95c1590a-1645-ce0e-dea3-d8927bc97704@cn.fujitsu.com>
Date: Thu, 15 Mar 2018 11:00:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAHp75VfGPgbD8gBdvchBn5U8gH93zoHB9ja3KucUuxVNq+_MLg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: E46AD4D0EFF7.AC3DF
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

At 03/15/2018 01:24 AM, Andy Shevchenko wrote:
> On Wed, Mar 14, 2018 at 12:28 PM, Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
> 
>> +static void __init acpi_update_possible_map(void)
>> +{
>> +       unsigned int cpu, nr = 0;
>> +
> 
>> +       if (nr_cpu_ids <= nr_unique_ids)
>> +               return;
>> +
>> +       for_each_possible_cpu(cpu) {
>> +               if (nr >= nr_unique_ids)
>> +                       set_cpu_possible(cpu, false);
>> +               nr++;
>> +       }
> 
> IIUC this can be optimized to:
> 

Yes, I agree, It's smarter and clearer. Will use it.

Thanks,
	dou

> if (nr_unique_ids >= nr_cpu_ids)
>      return;
> 
> /* Don't yet figure out if it's superfluous */
> if (nr_unique_ids >= cpumask_last(cpu_possible_mask))
>      return;
> 
> for_each_cpu_wrap(cpu, cpu_possible_mask, nr_unique_ids)
>      set_cpu_possible(cpu, false);
> 



>> +       nr_cpu_ids = nr_unique_ids;
>> +       pr_info("Allowing %d possible CPUs\n", nr_cpu_ids);
>> +}
> 
