Return-Path: <baolin.wang@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525414993; cv=none;
        d=google.com; s=arc-20160816;
        b=AHe4Fh4ZzccZBJTWUmAYvGzuIvS76SB344SA0cxa7U+OJMATy/OwY6xXYQFvjYv8+R
         ONGw+NFs1htnKJDs2Z3IvwrKmwRDnkPYG7+l443BZdARrTza34qrwtt47pSmB4KzR+0J
         2ZN+Er2S1wFajzwSlRR0rscMjur4d0vnfLmmo+OPH2SfEi7dLBCXTvRXXDhaS1HLRcDW
         TJHqw7ll1nS9nJaS38wFLXqLlYaSHVZniMrD5rZX9aCSvjOQCnKGeSjP1ep78Pv18dMT
         fNhvjyffQY27AeIFscMEmEaV9vL/eZjOyoo6tSUU0b/xaaBbhe6zDKqgvDLRFX9vsCng
         l1WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=tpDAjOk4CfkAwXnsVkyXW8Y7XibRYdiqMPiH5aZEV5g=;
        b=KTZ7P9Rtr/y/8CCY+qtYZLH/lDLtrNczcSM4vwstrVcwdjmC0+qMLttcJYjhjfdHOg
         R27K8YI5OiOYsigyYraN5uPxff6DNvUFtJWa6c+tAPO0cPZH+Zr4wBZkDv+MetPI5rey
         UF2v/2Ck9VQdwTe3brWOwQB0Eg3H2D9XpofIQVJPAsKHMNuhWmuVDGvutwgqQg497UUk
         wUfSow0HdkJK8iOL9Ymx9bZglpJSzqPBxo6rd6kld/KnWcyqnpnSOHPAx2tsqjtiYtOh
         NYDEZJDb+l4iOdxW8NqiYekea1qIju9NcjyCebuDITIVTEaSy5r8K9anjRo8IHdFHHfs
         wScg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=XScgim0Y;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=XScgim0Y;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZqXJ8L3zu7BbNR7vYwbEG91NzZk7ME8z3daH/yZHi1we1+JMujzGFN2lZ8gmQ+oGKjY3+V36nsJwFkfHseSiKM=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3TJ-5+22_CSYjdtL3pXEVHC7t_KzaOX6PG4X_1R1bMxQ@mail.gmail.com>
References: <c26982955db16b8f790e7f5f2a5b63e42bc78192.1525262725.git.baolin.wang@linaro.org>
 <e8ddeeea84626e43dcac4f0731992cbad932ce7a.1525262725.git.baolin.wang@linaro.org>
 <CAK8P3a3TJ-5+22_CSYjdtL3pXEVHC7t_KzaOX6PG4X_1R1bMxQ@mail.gmail.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Fri, 4 May 2018 14:23:13 +0800
Message-ID: <CAMz4ku+WbtBGGcmsYmMexxcBTJONHF3J-T8Sxo7wgHoZZCVt1w@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: Convert update_persistent_clock() to update_persistent_clock64()
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
X-GMAIL-MSGID: =?utf-8?q?1599513552285182792?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4 May 2018 at 06:31, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, May 2, 2018 at 10:53 PM, Baolin Wang <baolin.wang@linaro.org> wrote:
>> diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
>> index 17d4cd2..c4e2a1a 100644
>> --- a/arch/mips/include/asm/time.h
>> +++ b/arch/mips/include/asm/time.h
>> @@ -27,8 +27,8 @@
>>   *     rtc_mips_set_mmss - similar to rtc_set_time, but only min and sec need
>>   *                     to be set.  Used by RTC sync-up.
>>   */
>> -extern int rtc_mips_set_time(unsigned long);
>> -extern int rtc_mips_set_mmss(unsigned long);
>> +extern int rtc_mips_set_time(time64_t);
>> +extern int rtc_mips_set_mmss(time64_t);
>>
>
> I think these should just get removed, and each implementation replaced
> with a direct update_persistent_clock64() function.

I thought this was one minor modification that will reduce the risk of
introducing other issues, but as you suggested we can do some complete
cleanup by removing set_mmss/set_time. OK, I will do that.

>
>> -int update_persistent_clock(struct timespec now)
>> +int update_persistent_clock64(struct timespec64 now)
>>  {
>>         return rtc_mips_set_mmss(now.tv_sec);
>>  }
>
> And this one also removed

Sure.

>
>> @@ -69,7 +69,7 @@ int proc_dolasatrtc(struct ctl_table *table, int write,
>>                 if (rtctmp < 0)
>>                         rtctmp = 0;
>>         }
>> -       r = proc_dointvec(table, write, buffer, lenp, ppos);
>> +       r = proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
>>         if (r)
>>                 return r;
>>
>> @@ -224,7 +224,7 @@ int proc_lasat_prid(struct ctl_table *table, int write,
>>         {
>>                 .procname       = "rtc",
>>                 .data           = &rtctmp,
>> -               .maxlen         = sizeof(int),
>> +               .maxlen         = sizeof(time64_t),
>>                 .mode           = 0644,
>>                 .proc_handler   = proc_dolasatrtc,
>>         },
>
> Something seems wrong here: time64_t is not the same as 'unsigned long',
> and the 'rtctmp' variable is still 'unsigned int'. Not sure what the right fix
> would be (we don't seem to have a sysctl helper for s64), but the change
> here makes it worse.

After checking again, I agree with you. So I will keep the original code here.

-- 
Baolin.wang
Best Regards
