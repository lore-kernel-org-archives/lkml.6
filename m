Return-Path: <kernel-hardening-return-12566-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELspMc6CoVTEj4DSRD64YLjezxzlRGBHuaa7e80b+TbkfWYpLe4YzkIbrq6p1JyYCmqmN23B
ARC-Seal: i=1; a=rsa-sha256; t=1520990234; cv=none;
        d=google.com; s=arc-20160816;
        b=vvwHUI7Hp5ntbqTfuFx67ud5tyLKrsXkB1mrn9gFqiLkZFsIzvRt+0Q9MKLqylRArP
         Kh/cbqTzsklpbyZcM39eGndJwF5u/sqEImF0eFlFpyAwtbLwyB9cn5fK5+jyl8zYbpvB
         k0aa6rhynkNi0vVrPgLIsmgSmctbIwfQsX206BWT7/H5TRp1x0P+4G8Bz97MkCgP5Rwn
         zBukvR9wk4u6eSy0IwctV/fF5A+Aucxl8mYnqCctejTzVy94A5yntDaZKdlRQiUJ3Pi6
         jY9MkPsFkjVdk3LI7zZaZleD4COxelDmW1fddZkltcrjwi4BZllXchQcYU9Z5ikt8u7e
         XhXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=gi8YNkS66CDqPFDEj5VXMvsuPpjrTxIIolROxVIkjqs=;
        b=oS4rgPVwBeF7LyAncyYzMgu43XIJaHE8h3X6bgMDcqqBJk3ibNqjSwlAH/+17gQ+3Q
         beTEGw3JIYktAjQGTdjmXCKQ4yoIh9d/NrobJQ+t3oZ5sRqCl0XaD+QNMlLPfSiUOS52
         jOUYJbO50hFw4/YHnoylobW7t0T4uOACotrUp/7GvURRu7OKO1Etrl1MJz73NwFgp+IH
         bLJGWp69Oi3n6JTV0Tp9iB7zoc4l3T8FDD/gIisDKZbdSetbVpw1RsaIyzkssuaeWJEO
         SgeNCR2XrfYgsJDeP/UeG1zp1q+Wh1/5AneeJOu/D2/45SF7ZqcDSWavPdIvM21QYnOu
         G0/A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12566-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12566-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12566-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12566-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 4/4] gpio: Remove VLA from stmpe driver
From: Laura Abbott <labbott@redhat.com>
To: Phil Reid <preid@electromag.com.au>,
 Linus Walleij <linus.walleij@linaro.org>, Kees Cook <keescook@chromium.org>,
 Patrice Chotard <patrice.chotard@st.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com
References: <20180310001021.6437-1-labbott@redhat.com>
 <20180310001021.6437-5-labbott@redhat.com>
 <9175611d-049d-ec28-0716-e45fccfd579f@electromag.com.au>
 <4e64bbae-e91b-f0c5-ff79-3dde8fbe2119@redhat.com>
Message-ID: <d37dbce5-43ca-b70a-41da-5ccfc673d3ac@redhat.com>
Date: Tue, 13 Mar 2018 18:16:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4e64bbae-e91b-f0c5-ff79-3dde8fbe2119@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594507326034109383?=
X-GMAIL-MSGID: =?utf-8?q?1594873855578516040?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/13/2018 05:18 PM, Laura Abbott wrote:
> On 03/13/2018 02:13 AM, Phil Reid wrote:
>> On 10/03/2018 08:10, Laura Abbott wrote:
>>> The new challenge is to remove VLAs from the kernel
>>> (see https://lkml.org/lkml/2018/3/7/621)
>>>
>>> This patch replaces a VLA with an appropriate call to kmalloc_array.
>>>
>>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>>> ---
>>>   drivers/gpio/gpio-stmpe.c | 7 ++++++-
>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpio/gpio-stmpe.c b/drivers/gpio/gpio-stmpe.c
>>> index f8d7d1cd8488..b7854850bcdb 100644
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
>>> +    status = kmalloc_array(num_banks, sizeof(*status), GFP_ATOMIC);
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
>> Doing this in an irq handler seems wrong.
>> Perhaps better if a buffer is pre-allocated in stmpe_gpio
>>
>>
> 
> Sure, I can pre-allocate the buffer in the probe.
> 
> Thanks,
> Laura

Actually I wonder if there would be concurrency problems if we
tried to pre-allocate a global buffer. But the IRQ handler
calls stmpe_block_read which takes a mutex to sleep so I think
doing the (small) kmalloc should be fine and I can change it to
a GFP_KERNEL.

Thanks,
Laura
