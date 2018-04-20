Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AIpwx4+0D83j+TQ6iFCgILwBWmnY4t3YftlJQ1AmiNsUmezYeDlpK2XhHLpHx8GOugcfsHTO12ST
ARC-Seal: i=1; a=rsa-sha256; t=1524241247; cv=none;
        d=google.com; s=arc-20160816;
        b=qhh5S+UeVTOfyg5SlZcY+vrDWT5xlgiGV42hmr+KzYx4+op7hXdLlmBH3B3tyOHFr1
         DWqXp/97qXCqGwCMDICjm5Quwg5uxTP9ozsLGWdas7Ne9w1R7UjDEmwo1S2DrbJVmY2V
         jQN1V7m8udBpEEfIe8PNHnDJ7RgxOLHpglwPbnbUkJBzTCGuiDq9nhNUWjF62yLdnbR6
         iuDFTD8IREZYVX5lGTqD3FqjVHm36F5//zpgNxHb/DpiAq0SflIW4CtL/ZdZ+iwPdD8c
         vWg0OWyp4HKupqLAnbw1PNm4OLcSgDX+e9dsq52YVkP8XOQBhc3roFfbdKMuZsKmufqN
         /8IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=TmrcIJjWqNO1QtAdQ3oA0nErtU1/1hpVzRP4zwKEfRg=;
        b=Ok/h9SW4eO9kZ0oss7PLrUltWiJ+o2gx8JIbEWMkY1V4F/X9FNGEBCQuBEeJQsvvdV
         Yjv5zpEqGkDijDneRswqhihUyIm9WhLe7lAEWoDVGoe1cP2DDsXgVtGK6JdYjm93Gxh0
         Bb74xCO/GfLeRAz+xuC0htZjSV8c4TVznCIxY7eBb1RO8igyeesLXqrE8VnbVwsTGj/A
         RSWb50TuQVXk/dVgLqgg2+IEex4vrMauhO01XQlD8UeU4kXqwYJLiM2KPLTE6dQ0nyzm
         t7OI5xxKjeH+pmfPHgSKnWaLFjDadbJxN+JfAZiZsISikBcctgRqi/x2mGHQ1h0IKPWw
         T4XQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=HVlUDk4w;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=l4DV6guH;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=HVlUDk4w;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=l4DV6guH;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 86086601CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH] alpha: io: reorder barriers to guarantee writeX() and
 iowriteX() ordering #2
To: linux-alpha@vger.kernel.org, arnd@arndb.de, timur@codeaurora.org,
 sulrich@codeaurora.org, Matt Turner <mattst88@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kate Stewart <kstewart@linuxfoundation.org>, linux-kernel@vger.kernel.org
References: <1523917017-28084-1-git-send-email-okaya@codeaurora.org>
 <b9d845ad-62af-d300-53d9-2b62f5da6c44@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <2fd54f7c-ff73-5935-a253-c924f4373cc6@codeaurora.org>
Date: Fri, 20 Apr 2018 12:20:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <b9d845ad-62af-d300-53d9-2b62f5da6c44@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597942817277668063?=
X-GMAIL-MSGID: =?utf-8?q?1598282790471498440?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Matt,

On 4/17/2018 2:43 PM, Sinan Kaya wrote:
> On 4/16/2018 6:16 PM, Sinan Kaya wrote:
>> memory-barriers.txt has been updated with the following requirement.
>>
>> "When using writel(), a prior wmb() is not needed to guarantee that the
>> cache coherent memory writes have completed before writing to the MMIO
>> region."
>>
>> Current writeX() and iowriteX() implementations on alpha are not
>> satisfying this requirement as the barrier is after the register write.
>>
>> Move mb() in writeX() and iowriteX() functions to guarantee that HW
>> observes memory changes before performing register operations.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> Reported-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  arch/alpha/kernel/io.c | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> Sorry for catching this late but this also needs to go to 4.17 after
> review.
> 
> I missed the writel() implementation on arch/alpha/kernel/io.c file
> on my first patch.
> 

Can you also queue this for 4.17?

There are already drivers checked into 4.17 that dropped the unnecessary
barriers. 

I really hate to see Alpha broken because of this.

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
