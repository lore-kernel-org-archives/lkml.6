Return-Path: <kernel-hardening-return-12724-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49tnkgmm8OZAfOqUkyODfhLX7ZxwjIA+uhHhCsGtiplAOZwDutnf1si8k1eVnjnZw75rLlg
ARC-Seal: i=1; a=rsa-sha256; t=1521768519; cv=none;
        d=google.com; s=arc-20160816;
        b=i7WX1eMgFgXFY6VDtrg5RieGZRTWbi4HXc1x8rIsFdur5SuhLqmBOfX/WzhwprJOjK
         fpQKGbSMhT4GUR4y6wEov/KAgnlf+eeKS7Ko25m+Bapq4CMwEnWhUtEpxXPEilYaacS+
         0Luy+DkHBwpJKFbRZrnmj0g50LYRntmt8IcFSHeQG+7UDC+9z+UTIgSioFJzuq3UPxy0
         RjPiakU1RzSdfHJuqxwqbYdDHNy0fIYFFF3C36uRib+7J0UXJEhVbmTintxUK+dofgxh
         uOKTOBXn7XI8aqynEwmUtuJVjyVxm3w1cQga6zP98e0wnjzBrgo0WFRhkYTv+sFxCG2X
         iMxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=bu/vGcmtz2BzNvc/oePdF0NzpE7Sbt+L55B+gubagyo=;
        b=qNv3sdeTWAOGKDboNa0QfJx+pC7UhDsVHaWZN8dUvK42qYONmn0VqnP9EPlmC1LHUJ
         98xgzBxZ/1kJ7WKQXVtv7q+dKyKr+/fbwqP7aGOZI0H7XC85WmDTLgReOKmIgQxNZHOc
         5BfhLAxadkHRl/0YMbdeVSVHACidCpWNreiaeZllzpdMgmfeMPkLxQcJh+TQIj/I9wlE
         si7W7FiyAE7K4XfYbHq4TlOHoUQS0M5/QhOv6VCn5lb8cl+Pbroc0HYF53Uq7b6a4aXL
         1bGt8+j/T8NBCSj7JbWAoAYamXGk0xmiA1qtbcIdj1uZ0lrk4XRFgDHulmHVsa1GLRXW
         GTTA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12724-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12724-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12724-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12724-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCHv2 4/4] gpio: Remove VLA from stmpe driver
To: Laura Abbott <labbott@redhat.com>,
  Linus Walleij <linus.walleij@linaro.org>, Kees Cook <keescook@chromium.org>,
  Patrice Chotard <patrice.chotard@st.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
  kernel-hardening@lists.openwall.com
References: <20180315180030.20001-1-labbott@redhat.com>
 <20180315180030.20001-5-labbott@redhat.com>
 <21a2e869-62fb-75ef-ae7b-a27e136696f7@electromag.com.au>
 <90e40062-cedb-be32-ab17-56136c78dbad@redhat.com>
From: Phil Reid <preid@electromag.com.au>
Message-ID: <e7ec40ec-99cd-8078-3238-db024589d08b@electromag.com.au>
Date: Fri, 23 Mar 2018 09:28:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <90e40062-cedb-be32-ab17-56136c78dbad@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595027652990122948?=
X-GMAIL-MSGID: =?utf-8?q?1595689946893610333?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 23/03/2018 05:43, Laura Abbott wrote:
> On 03/18/2018 06:29 PM, Phil Reid wrote:
>> On 16/03/2018 02:00, Laura Abbott wrote:
>>> The new challenge is to remove VLAs from the kernel
>>> (see https://lkml.org/lkml/2018/3/7/621)
>>>
>>> This patch replaces a VLA with an appropriate call to kmalloc_array.
>>>
>>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>>> ---
>>> v2: Switch to GFP_KERNEL. There was some discussion about if we should
>>> be doing the allocation at all but given a) the allocation is pretty
>>> small and b) we can possibly take a mutex in a called function I think
>>> this is fine.
>>
>> I still think it's a bad idea. It's simple to preallocate the buffer.
>> But it's up to the maintainer.
>>
> 
> I'd feel a lot more confident about doing the global buffer with
> guidance from the maintainer. But looking at the platform data, the
> maximum number of GPIOs is 24, or 3 banks. Maybe we should just always
> stack allocate the maximum since it's fairly small.

That's the other way to go.


>>> ---
>>>   drivers/gpio/gpio-stmpe.c | 7 ++++++-
>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpio/gpio-stmpe.c b/drivers/gpio/gpio-stmpe.c
>>> index f8d7d1cd8488..c2bb20ace6f5 100644
>>> --- a/drivers/gpio/gpio-stmpe.c
>>> +++ b/drivers/gpio/gpio-stmpe.c
>>> @@ -369,10 +369,14 @@ static irqreturn_t stmpe_gpio_irq(int irq, void *dev)
>>>       struct stmpe *stmpe = stmpe_gpio->stmpe;
>>>       u8 statmsbreg;
>>>       int num_banks = DIV_ROUND_UP(stmpe->num_gpios, 8);
>>> -    u8 status[num_banks];
>>> +    u8 *status;
>>>       int ret;
>>>       int i;
>>> +    status = kmalloc_array(num_banks, sizeof(*status), GFP_KERNEL);
>>> +    if (!status)
>>> +        return IRQ_NONE;
>>> +
>>>       /*
>>>        * the stmpe_block_read() call below, imposes to set statmsbreg
>>>        * with the register located at the lowest address. As STMPE1600
>>> @@ -424,6 +428,7 @@ static irqreturn_t stmpe_gpio_irq(int irq, void *dev)
>>>           }
>>>       }
>>> +    kfree(status);
>>>       return IRQ_HANDLED;
>>>   }
>>>
>>
>>
> 
> 
> 


-- 
Regards
Phil Reid
