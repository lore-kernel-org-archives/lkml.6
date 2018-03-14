Return-Path: <kernel-hardening-return-12565-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuUtrX8MFeuEmG6oLEdtVXlqqxQcZFfNaPxCdVZzvguskamruenyCJKwFbBB0HBRHlPqQmT
ARC-Seal: i=1; a=rsa-sha256; t=1520986728; cv=none;
        d=google.com; s=arc-20160816;
        b=HSaHSoFZYTFETKUrdsEyHlb3/aOmm40qOhV9u43G50KOT22DVn0YX8AIkPaVLEfolD
         SnxyqYfXqkt8FMV9yLfJwY0lKo1IO6O09iqocLD5AsM+Dvk936Icy6KCgMY4M/iAqnnw
         N61bFjDPBwFevvUvCEcNNSjF0T6uO9v+wUb9HCkAueOTj7c4o71/dkbrR2ZRxFik1tHG
         E4LrOH/MDfMZKO9OIPoWH2Nuu4TP/PAm+XFxodnaw+L17Tc4+q8KMiPhvVtxdZOGYqH6
         q+gX3WQOnYQvKvUpRzqTusLI6ARmWHTX0YGBx57KZw+gG49vzRkM5VkFLETFU8UaKn2c
         a8WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=mdY2p0D+b0virh/3/wlRN9oZbQIou1TZv+VAOAEbH6w=;
        b=HRn4uZfkfEAzaTiE5Sk9lXdK7GQ3T3kbrarGNK7PfFL85UX0O9qWl+QfyEoD2UF9ad
         c807pBgXGRjhw6kZWsIfk/jqYxF41Azc7C/PZT2QAHP/JW6ITe9zJQVsJGrjqHYUgs8V
         J5R6HAlp4gVY7flkFbS7rRffDfg8U80fy7z7kDZ3V8jZ0/hgGVpnml7co5jEhiwSnoh8
         cxMb3vP3sUFlByak+2TogXj36CUhT3fqMoaKJ+TT/2PsjMmArL2DOno6qhCkq2dtFMyW
         fT4aCwstHzVONt5xJzidI8AskJDsSlh3dGsjSBxzyzmDfsOH9ReDfYe3JBy+71vRHMMQ
         cBPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12565-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12565-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12565-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12565-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 4/4] gpio: Remove VLA from stmpe driver
To: Phil Reid <preid@electromag.com.au>,
 Linus Walleij <linus.walleij@linaro.org>, Kees Cook <keescook@chromium.org>,
 Patrice Chotard <patrice.chotard@st.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com
References: <20180310001021.6437-1-labbott@redhat.com>
 <20180310001021.6437-5-labbott@redhat.com>
 <9175611d-049d-ec28-0716-e45fccfd579f@electromag.com.au>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <4e64bbae-e91b-f0c5-ff79-3dde8fbe2119@redhat.com>
Date: Tue, 13 Mar 2018 17:18:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <9175611d-049d-ec28-0716-e45fccfd579f@electromag.com.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594507326034109383?=
X-GMAIL-MSGID: =?utf-8?q?1594870180015795328?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/13/2018 02:13 AM, Phil Reid wrote:
> On 10/03/2018 08:10, Laura Abbott wrote:
>> The new challenge is to remove VLAs from the kernel
>> (see https://lkml.org/lkml/2018/3/7/621)
>>
>> This patch replaces a VLA with an appropriate call to kmalloc_array.
>>
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
>>   drivers/gpio/gpio-stmpe.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpio/gpio-stmpe.c b/drivers/gpio/gpio-stmpe.c
>> index f8d7d1cd8488..b7854850bcdb 100644
>> --- a/drivers/gpio/gpio-stmpe.c
>> +++ b/drivers/gpio/gpio-stmpe.c
>> @@ -369,10 +369,14 @@ static irqreturn_t stmpe_gpio_irq(int irq, void *dev)
>>       struct stmpe *stmpe = stmpe_gpio->stmpe;
>>       u8 statmsbreg;
>>       int num_banks = DIV_ROUND_UP(stmpe->num_gpios, 8);
>> -    u8 status[num_banks];
>> +    u8 *status;
>>       int ret;
>>       int i;
>> +    status = kmalloc_array(num_banks, sizeof(*status), GFP_ATOMIC);
>> +    if (!status)
>> +        return IRQ_NONE;
>> +
>>       /*
>>        * the stmpe_block_read() call below, imposes to set statmsbreg
>>        * with the register located at the lowest address. As STMPE1600
>> @@ -424,6 +428,7 @@ static irqreturn_t stmpe_gpio_irq(int irq, void *dev)
>>           }
>>       }
>> +    kfree(status);
>>       return IRQ_HANDLED;
>>   }
>>
> 
> Doing this in an irq handler seems wrong.
> Perhaps better if a buffer is pre-allocated in stmpe_gpio
> 
> 

Sure, I can pre-allocate the buffer in the probe.

Thanks,
Laura
