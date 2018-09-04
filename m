Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45358C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA36320659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA36320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeIDW1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 18:27:22 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40717 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeIDW1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 18:27:21 -0400
Received: by mail-wm0-f67.google.com with SMTP id 207-v6so5128520wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 11:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tq4Pzyp5zungYf832L8OkMKvK1HBfvUtT56c2vcSvjs=;
        b=YQLvrj//X981Hh/KPx+/jOtXEKPlspHxXDLsVykomAmpqiC/T6Jkq4KQwh2YFmjV+X
         r8rZw3HJ5s1wlOJ8DKvLF9ckL/pZ0KkIke2BQA1Qc9VKXB9+9pQ7uicSxNlEm2/K83mK
         k/2zyoRJKe+tAsBWrPNMp/Xdh6G89jd7JWLTq9pgpEcj6hYS27l2YQ5TSbuCiM+JTIVv
         v8MG9pW/+ndHwMjugPmgLdDyijFAYwESylYESzT/sYTPtTfR98R3wLb0fiRR4wQNPzj6
         vfxBzknPIYRezqU/h6tF3SnDPucppGVFFKaqWFe9TCeDQWdduhsTSnTgyKcJfEkeV/py
         43qQ==
X-Gm-Message-State: APzg51D0KAHYvPPavH9bpwXvU/hKRvitWjNpwvUn/VHGBeZNYqzcIZgu
        8/C9pBSSKF/JakIvvIqVHB/DTw==
X-Google-Smtp-Source: ANB0Vda6cXihV+zc6PZuwbbG0Lr1Z6RnMr7wbCduSPtTcRzbFcVOtIHsI9M8GWv9+PBMtSu+VdZX1A==
X-Received: by 2002:a1c:8893:: with SMTP id k141-v6mr8797768wmd.36.1536084068841;
        Tue, 04 Sep 2018 11:01:08 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id y128-v6sm17237660wmy.26.2018.09.04.11.01.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 11:01:08 -0700 (PDT)
Subject: Re: [PATCH] x86/setup: Deal with "quiet" commandline option earlier
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Maninder Singh <maninder1.s@samsung.com>
References: <20180904144225.14831-1-hdegoede@redhat.com>
 <20180904144225.14831-2-hdegoede@redhat.com>
 <71db02a8-2732-85ee-bb66-14ac26f24eaf@redhat.com>
Message-ID: <d75ef785-d640-d396-43d3-95359096cd6a@redhat.com>
Date:   Tue, 4 Sep 2018 20:01:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <71db02a8-2732-85ee-bb66-14ac26f24eaf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04-09-18 17:25, Hans de Goede wrote:
> Hi,
> 
> On 04-09-18 16:42, Hans de Goede wrote:
>> X86's setup_arch() calls parse_early_param() somewhat late, to make
>> sure that everything is setup correcty to deal with earlyprintk over
>> the EHCI debug port.
>>
>> This means that a number of pr_info-s get done before
>> "early_param("quiet", quiet_kernel)" from init/main.c gets processed.
>>
>> Until commit 375899cddcbb ("printk: make sure to print log on console.")
>> this was not a problem because the printk code would evaluate the
>> console_loglevel vs the message-loglevel when flushing the buffer.
>>
>> After this commit the check is done at the time that pr_info is actually
>> called and the console_loglevel at calling time.
>>
>> This causes the following messages to get printed with the "quiet" option:
>>
>> [    0.000000] BIOS-provided physical RAM map:
>> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
>> ...
>> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000000874ffffff] usable
>>
>> This commit fixes this by making x86's setup_arch() explicitly check for
>> quiet early on.
>>
>> Cc: Petr Mladek <pmladek@suse.com>
>> Cc: Maninder Singh <maninder1.s@samsung.com>
>> Fixes: 375899cddcbb ("printk: make sure to print log on console.")
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Self-nack, I accidentally still had the revert of commit
> 375899cddcbb ("printk: make sure to print log on console.") in
> my tree while testing…
> 
> In order for my approach to work, we need to deal with the quiet
> option even earlier, before the first pr_notice in init/main.c,
> which requires access to the commandline before setup_arch()
> which is the function which fills the boot_command_line on
> several architectures.
> 
> So I think we need to look at a different approach.
> 
> I have one more idea, if that does not work out I think we
> just need to revert 375899cddcbb ("printk: make sure to print log on console.")

Ok, I have come up with a better, arch neutral fix, which no fully
lives in printk.c. I will keep the To/Cc of the new patch the same
to keep everyone in the loop.

Regards,

Hans


>> ---
>>   arch/x86/kernel/setup.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
>> index b4866badb235..38f66b14cf3d 100644
>> --- a/arch/x86/kernel/setup.c
>> +++ b/arch/x86/kernel/setup.c
>> @@ -93,6 +93,7 @@
>>   #include <asm/processor.h>
>>   #include <asm/bugs.h>
>>   #include <asm/kasan.h>
>> +#include <asm/cmdline.h>
>>   #include <asm/vsyscall.h>
>>   #include <asm/cpu.h>
>> @@ -864,6 +865,16 @@ void __init setup_arch(char **cmdline_p)
>>       boot_cpu_data.x86_phys_bits = MAX_PHYSMEM_BITS;
>>   #endif
>> +#if !defined CONFIG_CMDLINE_BOOL || !defined CONFIG_CMDLINE_OVERRIDE
>> +    /*
>> +     * We call parse_early_param() somewhat late, see x86_configure_nx()
>> +     * comment. Deal with "quiet" here to suppress printing of early
>> +     * boot messages when quiet has been requested.
>> +     */
>> +    if (cmdline_find_option_bool(boot_command_line, "quiet"))
>> +        console_loglevel = CONSOLE_LOGLEVEL_QUIET;
>> +#endif
>> +
>>       /*
>>        * If we have OLPC OFW, we might end up relocating the fixmap due to
>>        * reserve_top(), so do this before touching the ioremap area.
>>
