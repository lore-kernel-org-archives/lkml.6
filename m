Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A7BC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 04:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D780C2087E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 04:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D780C2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeIEJVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 05:21:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34491 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbeIEJVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 05:21:40 -0400
Received: by mail-ed1-f68.google.com with SMTP id u1-v6so5007393eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 21:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KAxx++B/J6mewqxzBId9AUHVd42GBcdAZFvqJPr/DGA=;
        b=VGsvEABeZ0BZlCsT2TyyG/YojOD/wrSvzYAKGnAghcJrHK22vV1vjf7GTDxBemcIIC
         7r752k2g1WWDVG3oj8pcYYQ8xxSt33M6M/QoSxuE/FQXQxLV+MBVRq80GnU9UAjGnDCV
         BQL7AdbGPbUwtv/z5wbWNG3YORz+iuon4KjIfndSY2LvCjIkyVz7PYGIUpBCnPIpwsld
         yIBY3Ty3nwmAaj7xGooGcKz1ImkRX0LfB1bawuVvzT27atWBAbD2EQv0A+27iRK/d/yN
         MZY0mCmz5ycDsRQemmThmc7kkJ2raBtPtUm7CBuiHY+Qu+SF3GvYID3PGewFlkJREJaV
         pmfg==
X-Gm-Message-State: APzg51DeGJoOlPciA2LOK0P1841dpqmhCAKM9FJ3j3aFXItQa/K1ZeG7
        JUSdfsnH5cF1LIkJfrIspuwhnQ==
X-Google-Smtp-Source: ANB0Vdajh9jUVKJjW0WdRKAWheGaMA8FpQmBHbMM6ohihwzinIwzEJClepjCygsja2BvKNlus9uJpw==
X-Received: by 2002:a50:b5a5:: with SMTP id a34-v6mr38812912ede.88.1536123197471;
        Tue, 04 Sep 2018 21:53:17 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id g20-v6sm491485edm.36.2018.09.04.21.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 21:53:16 -0700 (PDT)
Subject: Re: [PATCH 4.19 regression fix] printk: For early boot messages check
 loglevel when flushing the buffer
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Maninder Singh <maninder1.s@samsung.com>
References: <20180904180154.845-1-hdegoede@redhat.com>
 <20180905023522.GA1444@jagdpanzerIV>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <93901f2b-91ad-a910-7031-0040b827a3af@redhat.com>
Date:   Wed, 5 Sep 2018 06:53:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180905023522.GA1444@jagdpanzerIV>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05-09-18 04:35, Sergey Senozhatsky wrote:
> Hi,
> 
> On (09/04/18 20:01), Hans de Goede wrote:
>> Commit 375899cddcbb ("printk: make sure to print log on console."), moved
>> the checking of the loglevel of messages from flush time to the actual
>> log time.
>>
>> This introduces one problem, some early boot messages are printed before
>> parse_early_param() gets called and thus before kernel commandline options
>> such as quiet, loglevel and ignore_loglevel are parsed.
> 
> Do you use earlycon?

No, I'm seeing this with the regular/normal console stuff.

>> This causes e.g. the following messages to get printed on x86 systems,
>> despite the presence of the "quiet" option:
>>
>> [    0.000000] BIOS-provided physical RAM map:
>> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
>> ...
>> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000000874ffffff] usable
>>
>> This commit fixes this by setting a new LOG_CHK_LEVEL on early boot
>> messages and doing the loglevel check for these while flushing as before.
>>
> 
> Hmm, OK, chances are we need to re-think 375899cddcbb. It might be
> the case that we sort of broke CON_PRINTBUFFER handling.
> 
> 	console_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH
> 	register CON_PRINTBUFFER console
> 		-> no debug output
> 
> So I think that when console_unlock() re-flushes already seen logbuf
> messages to a newly registered exclusive [CON_PRINTBUFFER] console we
> probably need to look at the current console_loglevel in console_unlock()
> loop.

So if it breaks quiet and the above use-case maybe we should revert
375899cddcbb for now?

Regards,

Hans
