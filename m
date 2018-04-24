Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1524586369; cv=none;
        d=google.com; s=arc-20160816;
        b=tYlYU7vVLD7lHyDWDrhIHURZDLD/2YBrnLvDf8YLFt7Rmvcmv008iLGrKDE58oKsBA
         LPwD96jfh3h9w+B32vpmkenqMC8aM3R/a9VY+4BP2VwuyBUD0DYiOMzlALVBSmreUkXH
         GaeQ5BIDwRfpMuVTwFPaltMIwQrWdkcEAZoT3Ead8URslCa6JTtBpnnAS8fPutCsbP1T
         B0oNpo1WylWaBtA1sGScqcF/J40mVfoEy2CH18wwxAgSJwjGZMqNp5HsyiOD8WFo35zA
         5a1GD37znVaXfPC+ukdmVDEN3EFGN/bSMRT/cXM2cFpLaRxLkI+i6AKWZMedFzE296Ov
         hZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=glX7nKHzSEhQ3fT7S2133NPAGMBw9eCRlEjm1YkB6aE=;
        b=VnoXRKyHJvcuP+mnWvBzqtHLsKh63eME6TStWqyUMKJ0ezGginEB/hqKNn8UVM/qEy
         RPA8ohx6BIOhuzWVH4pdU/O0LIcQOAElbYAzLCxCGybFf9ACIngpMt2zBLD8c7FSUSEr
         5Fc9nKKajaa3sqksT61juifEL4KR9X98+p/dWVZM7I70uapRx7dLf0BHe3nofpLlQIoq
         s/pJvNRlaJfwV/6Myx6c2c1kJOvoeJFXkITkcNTen8MhpwGZ2GgpvW9q8APb655Q440J
         rMcU4Lqx9I4vLm1q6st33OCxWLRqUEENlYDsXvRnX8JRzzHq2bpDk0fQ/wtU6HJrIEfd
         w9Ww==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=c+Scxjto;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=c+Scxjto;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AB8JxZozY3CAxuLlxYscc8nmZb7WWeORdbiWyvKC0gPZsMxZYUNRd2JLX3zVFM9nS4xNzaITzAYvaIF3HiYw4yOaYcI=
MIME-Version: 1.0
In-Reply-To: <bed00d18-a4c1-5e8f-a15c-f2482e5ecb9a@ti.com>
References: <20180423183814.20615-1-brgl@bgdev.pl> <20180423183814.20615-6-brgl@bgdev.pl>
 <bed00d18-a4c1-5e8f-a15c-f2482e5ecb9a@ti.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 24 Apr 2018 18:12:48 +0200
Message-ID: <CAMRc=McK0DqXShuDHKY-qh-OpctjU41GWRvHX_biULkpt4F7Vw@mail.gmail.com>
Subject: Re: [RFC work-in-progress 5/7] !WIP ARM: davinci: convert da850 to
 using the davinci clocksource driver
To: Sekhar Nori <nsekhar@ti.com>
Cc: David Lechner <david@lechnology.com>, Kevin Hilman <khilman@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598563244496982650?=
X-GMAIL-MSGID: =?utf-8?q?1598644677210579758?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-04-24 10:10 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
> On Tuesday 24 April 2018 12:08 AM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>  arch/arm/mach-davinci/da850.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
>> index 3f27d46ca43f..712964383bc2 100644
>> --- a/arch/arm/mach-davinci/da850.c
>> +++ b/arch/arm/mach-davinci/da850.c
>> @@ -757,13 +757,28 @@ void __init da850_init(void)
>>       WARN(!da8xx_syscfg1_base, "Unable to map syscfg1 module");
>>  }
>>
>> +static struct platform_device da850_timer_device = {
>> +     .name                   = "timer-davinci",
>> +     .id                     = -1,
>> +};
>> +
>>  void __init da850_init_time(void)
>>  {
>>       struct clk *clk;
>> +     int ret;
>>
>>       clk = clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DA850_REF_FREQ);
>>
>>       davinci_timer_init(clk);
>> +
>> +     ret = clk_register_clkdev(clk, NULL, "timer-davinci");
>> +     if (ret) {
>> +             pr_err("%s: error registering ref_clk: %d", __func__, ret);
>> +             return;
>> +     }
>
> This part had to be added because you don't have clocks converted to
> early platform devices in your branch, right?
>
> Thanks,
> Sekhar

Yes. Also: I've stumbled upon some problems with the current
implementation of early platform drivers making simple conversion of
psc and pll to early devices impossible. I've mostly fixed them and
hope to be able to send something today or early tomorrow.

Bart
