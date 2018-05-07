Return-Path: <baolin.wang@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525679868; cv=none;
        d=google.com; s=arc-20160816;
        b=obrHhzYaQ0z0n81OgzoADjzOEF9tZ0v4BjKoYaateWHp+yqxyS3wuo1v4yyHnjETZV
         3YfTrtZlRm6jZxYle0UKtwcK7JUaLLcR1ix3pGM66vmTQUn82ECwEm1TwkfEFB3cUGxt
         UeaXTSkI0/Xc7MG6EuC4tYBbpOeKxIO6M4bvuWXp3oxThyWLq/fpop5MF3v9oKa7DQVj
         AcvnsZNo9+NnXIVn6LHJcLrLQfEYzbHrFVDaSVDxEPnbz2vP7MJpbKnUVQIOPry3ym+s
         emeAlUg1HNYp/dUlXf8D4YrzNQnF3tkIuBBcCTACe2mwaNYAV01+ZZRGpwoltToAqL2W
         qVKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=/VzuEq7u+284TbkrLjTHvh+qrVteUcrV4bO1LSCVkAc=;
        b=NQmlp8J9pVacHjGBBHpxxNex04AsJIMY4MlaPi6GQ+ssvQVwCAFc1jOgUHybdlaqmF
         cDA2rd6ttjuLYkLMaX1P//OdW1LRksCzJZbZ0LMMsSb5nu6nNCpsNr52bcWRbeIAN1T7
         +FxdRNZGH4lszFhdHem7xgMKBxLXDyMZdyZsoNd3tir0rsczWke2p9bt0qmTKlUlshYk
         RoUlUapGu9dvD/drp1xomEmpTX0XTDsMgigTU0E9B1Z65i7U1AYolphOQ/Nhc81OQqxj
         ZiQ2idrqYea9Wqbf95wKssbRPAd++oALlodBNpx3Ur15LCMaPqzX/w0fsmAm+j7jiFU2
         z5Pw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=kzenOqN4;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=kzenOqN4;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZqNVsHDoBkEq5u8b7yXL9VWFcFhCdc5PeXdzqva5QInZFfFFZJolYRgJQAe+s67zwkC5ZAaymfoJ19JZJnWEUc=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2eXo6MkLLkzQVDtk_W+2x+68iphsX3MXAtzpTYDaREiQ@mail.gmail.com>
References: <c26982955db16b8f790e7f5f2a5b63e42bc78192.1525417306.git.baolin.wang@linaro.org>
 <2d0bcca30f61036e413ba01c686ce6506f187462.1525417306.git.baolin.wang@linaro.org>
 <CAK8P3a2eXo6MkLLkzQVDtk_W+2x+68iphsX3MXAtzpTYDaREiQ@mail.gmail.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Mon, 7 May 2018 15:57:47 +0800
Message-ID: <CAMz4kuJBw3MFvdju7MoLxcW8wJuBbhiXe_TQut2dw2_dpAVQZw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] MIPS: Convert update_persistent_clock() to update_persistent_clock64()
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
	James Hogan <jhogan@kernel.org>, chenhc@lemote.com,
	Kate Stewart <kstewart@linuxfoundation.org>, gregkh <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>,
	Mark Brown <broonie@kernel.org>, Paul Burton <paul.burton@mips.com>,
	Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599409843687594194?=
X-GMAIL-MSGID: =?utf-8?q?1599791293183208396?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 6 May 2018 at 11:04, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, May 4, 2018 at 3:07 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>> Since struct timespec is not y2038 safe on 32bit machines, this patch
>> converts update_persistent_clock() to update_persistent_clock64() using
>> struct timespec64.
>>
>> The rtc_mips_set_time() and rtc_mips_set_mmss() interfaces were using
>> 'unsigned long' type that is not y2038 safe on 32bit machines, moreover
>> there is only one platform implementing rtc_mips_set_time() and two
>> platforms implementing rtc_mips_set_mmss(), so we can just make them each
>> implement update_persistent_clock64() directly, to get that helper out
>> of the common mips code by removing rtc_mips_set_time() and
>> rtc_mips_set_mmss() interfaces.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>
> Looks good overall, but I still found a bug and one minor issue. With
> those fixed,
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
>> diff --git a/arch/mips/dec/time.c b/arch/mips/dec/time.c
>> index 9e992cf..934db6f 100644
>> --- a/arch/mips/dec/time.c
>> +++ b/arch/mips/dec/time.c
>> @@ -59,14 +59,15 @@ void read_persistent_clock64(struct timespec64 *ts)
>>  }
>>
>>  /*
>> - * In order to set the CMOS clock precisely, rtc_mips_set_mmss has to
>> + * In order to set the CMOS clock precisely, update_persistent_clock64 has to
>>   * be called 500 ms after the second nowtime has started, because when
>>   * nowtime is written into the registers of the CMOS clock, it will
>>   * jump to the next second precisely 500 ms later.  Check the Dallas
>>   * DS1287 data sheet for details.
>>   */
>> -int rtc_mips_set_mmss(unsigned long nowtime)
>> +int update_persistent_clock64(struct timespec64 now)
>>  {
>> +       time64_t nowtime = now.tv_sec;
>>         int retval = 0;
>>         int real_seconds, real_minutes, cmos_minutes;
>>         unsigned char save_control, save_freq_select;
>
>
> It looks like you now get an invalid 64-bit division in here,
> you have to change it to either use div_u64_rem() or possibly
> time64_to_tm() or rtc_time64_to_tm() (the latter requires
> CONFIG_RTC_LIB).

I will use div_u64_rem() to calculate real_seconds and real_minutes.

>
>> diff --git a/arch/mips/lasat/ds1603.c b/arch/mips/lasat/ds1603.c
>> index d75c887..061815e 100644
>> --- a/arch/mips/lasat/ds1603.c
>> +++ b/arch/mips/lasat/ds1603.c
>> @@ -98,7 +98,7 @@ static void rtc_write_byte(unsigned int byte)
>>         }
>>  }
>>
>> -static void rtc_write_word(unsigned long word)
>> +static void rtc_write_word(time64_t word)
>>  {
>>         int i;
>>
>
> I would say this function should take a 'u32' argument (or keep the
> unsigned long) to match the name and implementation, but then have a
> type cast in the caller with a comment about the loss of range and overflow
> in y2106.

OK.

>
>> diff --git a/arch/mips/lasat/sysctl.c b/arch/mips/lasat/sysctl.c
>> index 6f74224..76f7b62 100644
>> --- a/arch/mips/lasat/sysctl.c
>> +++ b/arch/mips/lasat/sysctl.c
>> @@ -73,8 +73,12 @@ int proc_dolasatrtc(struct ctl_table *table, int write,
>>         if (r)
>>                 return r;
>>
>> -       if (write)
>> -               rtc_mips_set_mmss(rtctmp);
>> +       if (write) {
>> +               ts.tv_sec = rtctmp;
>> +               ts.tv_nsec = 0;
>> +
>> +               update_persistent_clock64(ts);
>> +       }
>>
> ... and probably also a comment here to explain that we can't actually use
> the full 64-bit range because of HW limits.
>

OK. Thanks for your comments.

-- 
Baolin.wang
Best Regards
