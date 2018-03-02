Return-Path: <kkamagui@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520022595; cv=none;
        d=google.com; s=arc-20160816;
        b=0NjTfIr82fphb6FhNtteq35jHURY4BqJg/WKDbirqb9N/oUFuTpXVQXBNawcvYfh8O
         9C+OmM5J3wctcemCrTYfNLeDYR1DmyT+QqzmjCAXP3eKOUsKHDB+7Y5KBlCrFyi2GgqO
         7kpDbeTo9HVVXbVdzG+VfTyfWRlZMWAVpd59cXEBBmO9Ghx3kRu9LE3jp/0ka2pHhE5m
         KgnutaWWa0+ImBx/JpEL5dEdKpSJauwHHhmoXYAt42hxd8NgQAbbOB7bgOzG7QJPiKKE
         Sx+4kb9pl7DzukbvDIfdphMz2AbeZbtwlcUmGDTSLmhbv/z3bKmN72Ji+b5OOT8/L/Kl
         WNDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=P5C8hLkYRiC6MwFPp1AZiOsifMW2DtEoqsQsG4zW2bU=;
        b=re1FpB2ppgdovYL/sHZ62kV00N5dSG4uqD8Hgvl1e1ZjEqaDSfqbWsApPOrDfJhvjc
         mjq37Qae6nVpbNwgg3zoIFOZWwqpZsK23NXZc99PthZjclaFaWFZbHTs+tz86ub0RdnY
         SJMGj2Kk3E/qEKUrO6FEydpEUknNdGbF732ZCidvD66eSmEvNkHy+WzoZsVcpKfyLTVZ
         h7tPm3Rhgb6SV17NRV71tyReJ1OuAm4ks6XMlLiLCRY/HMZpt7jTwD9iEG0ZvE/9XGNT
         hZi38HABciu9DLTwQrnErpCXEuHJBOYjITEYDbVdaa8QkGk+QfLMkpXQ0QmhoQUUU1Bl
         m9ow==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FVOBWWx5;
       spf=pass (google.com: domain of kkamagui@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=kkamagui@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FVOBWWx5;
       spf=pass (google.com: domain of kkamagui@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=kkamagui@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvjG+NOCqQfhDLZb2boe4M2Agj7SIeaWi1a8PtPbR/5bZcadGsBFrjtE7FyEeojk8jOCM2cCCl2Q4POgwGM4N8=
MIME-Version: 1.0
In-Reply-To: <20180302121433.GC7406@pd.tnic>
References: <20180228203131.3176-1-kkamagui@gmail.com> <20180302121433.GC7406@pd.tnic>
From: Seunghun Han <kkamagui@gmail.com>
Date: Sat, 3 Mar 2018 05:29:54 +0900
Message-ID: <CAHjaAcRTSMH7TBci447mA9TdL==Mmn5UHVFjgd3QMAecLsguWw@mail.gmail.com>
Subject: Re: [PATCH V2] x86: mce: fix kernel panic when check_interval is changed
To: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593186374882748310?=
X-GMAIL-MSGID: =?utf-8?q?1593859213667334627?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi, Borislav.

Thank you for your good advice.
According to your advice, I will make and send PATCH v3.

Best regards.

Seunghun.

2018-03-02 21:14 GMT+09:00 Borislav Petkov <bp@alien8.de>:
> On Thu, Mar 01, 2018 at 05:31:31AM +0900, Seunghun Han wrote:
>> Changes since v1: add mce_sysfs_mutex according to review result.
>
> Ok, we're getting there.
>
>>  arch/x86/kernel/cpu/mcheck/mce.c | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
>> index 706584681a4c..bee0795a3b8c 100644
>> --- a/arch/x86/kernel/cpu/mcheck/mce.c
>> +++ b/arch/x86/kernel/cpu/mcheck/mce.c
>> @@ -55,6 +55,7 @@
>>  #include "mce-internal.h"
>>
>>  static DEFINE_MUTEX(mce_log_mutex);
>> +static DEFINE_MUTEX(mce_sysfs_mutex);
>>
>>  #define CREATE_TRACE_POINTS
>>  #include <trace/events/mce.h>
>> @@ -2045,8 +2046,11 @@ static void mce_enable_ce(void *all)
>>               return;
>>       cmci_reenable();
>>       cmci_recheck();
>> -     if (all)
>> +     if (all) {
>> +             mutex_lock(&mce_sysfs_mutex);
>>               __mcheck_cpu_init_timer();
>> +             mutex_unlock(&mce_sysfs_mutex);
>> +     }
>
> Instead of chasing all the places which need to grab the mutex, I was
> thinking of grabbing it in all those functions which modify MCA behavior
> non-trivially from sysfs. And those are:
>
> store_int_with_restart()
> set_ignore_ce()
> set_cmci_disabled()
>
> And you've done that already for store_int_with_restart() and I think
> doing the same in the other two will address the issue nicely and
> in the simplest way possible.
>
> All those sysfs operations should be synchronized anyway. Please reflect
> that in your commit message too.
>
> The aspect about DOS is not really important because you need to be root
> to write those so if you have root, there are gazillion ways to shoot
> yourself in the foot already.
>
>>  static struct bus_type mce_subsys = {
>> @@ -2132,8 +2136,14 @@ static ssize_t store_int_with_restart(struct device *s,
>>                                     struct device_attribute *attr,
>>                                     const char *buf, size_t size)
>>  {
>> +     unsigned long old_check_interval = check_interval;
>>       ssize_t ret = device_store_int(s, attr, buf, size);
>> +
>> +     if (check_interval == old_check_interval)
>> +             return ret;
>
> <---- newline here.
>
>> +     mutex_lock(&mce_sysfs_mutex);
>>       mce_restart();
>> +     mutex_unlock(&mce_sysfs_mutex);
>
> <---- newline here.
>
>>       return ret;
>>  }
>>
>> --
>> 2.16.2
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.
