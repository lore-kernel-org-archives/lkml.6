Return-Path: <kernel-hardening-return-12722-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtgnXkwY/k7uB5bg6I3QH9ls+8j/KGsEJF9Ab/OGOI/V4L1xE0ijbUhGElYfBD+ZuXhGABr
ARC-Seal: i=1; a=rsa-sha256; t=1521755040; cv=none;
        d=google.com; s=arc-20160816;
        b=ZU3nPBf1i8GdyFkRAOfZJohwwZgjwy1mmowGxb4PNsO10NFwPztBF0JvNhw+WY3NLF
         CrZyQLSU3Ax/6kxjawTgtsI+e+suLuzGUhOjIqTss7SqSM9qI33khAGCTSNGMBx5JC1H
         eWCnc89NHxYozenmYZkm7hU/8MboA/qqjRuotq14wgGB5Kd1UUFxajc0C1X2ihOYAftX
         a9QLlBGx0JFTfzGl3SluSimofKb9ZurDkFaUzh4tfKY6ilMvJHmBeg3ffIJeCoUyzF8x
         k89tqml/Tr3iFGofEE+RIEApDYQ0NFKzx5kPVsCwj0kJfGl/2L5IKD/H2zRuQQDC3ppL
         BXBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=WYPJwJ+VGR5QzPNH9TckmeyiBT5PXpFys3PWnv1QRtA=;
        b=sCNAw63QVojotN7XWzDSEynNf3/UV3ncxfBKpjbFQA8o3ibxOpPEmBjyX751tCCBnR
         YK9m9itDNOIGkoNeO1qAV5ktkwBCEi5Igufn3x1yYG8CNYAbkSAeUoCg38h1glezR4dt
         xyLNamx4lzmFVdqeuF6SFca4LvOGzAo1bDHdYoZYK/g3jOUHAGPYV2+K0/47qWFy7Cue
         QVS7Q5mNjmoKm/YZtxzvM5+40k7woGakDPErldSRYhAWdRQtlxf3FmkcHoHT8LEf7gmX
         kQBrJhvBPbo0QqRlj709j+so5fl0Fy1pzGciyT2qrDH/B1Q5ieXTpfJAP2XMPPtqwIBA
         SzfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12722-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12722-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12722-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12722-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCHv2 4/4] gpio: Remove VLA from stmpe driver
To: Phil Reid <preid@electromag.com.au>,
 Linus Walleij <linus.walleij@linaro.org>, Kees Cook <keescook@chromium.org>,
 Patrice Chotard <patrice.chotard@st.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com
References: <20180315180030.20001-1-labbott@redhat.com>
 <20180315180030.20001-5-labbott@redhat.com>
 <21a2e869-62fb-75ef-ae7b-a27e136696f7@electromag.com.au>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <90e40062-cedb-be32-ab17-56136c78dbad@redhat.com>
Date: Thu, 22 Mar 2018 14:43:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <21a2e869-62fb-75ef-ae7b-a27e136696f7@electromag.com.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595027652990122948?=
X-GMAIL-MSGID: =?utf-8?q?1595675813329608986?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/18/2018 06:29 PM, Phil Reid wrote:
> On 16/03/2018 02:00, Laura Abbott wrote:
>> The new challenge is to remove VLAs from the kernel
>> (see https://lkml.org/lkml/2018/3/7/621)
>>
>> This patch replaces a VLA with an appropriate call to kmalloc_array.
>>
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
>> v2: Switch to GFP_KERNEL. There was some discussion about if we should
>> be doing the allocation at all but given a) the allocation is pretty
>> small and b) we can possibly take a mutex in a called function I think
>> this is fine.
> 
> I still think it's a bad idea. It's simple to preallocate the buffer.
> But it's up to the maintainer.
> 

I'd feel a lot more confident about doing the global buffer with
guidance from the maintainer. But looking at the platform data, the
maximum number of GPIOs is 24, or 3 banks. Maybe we should just always
stack allocate the maximum since it's fairly small.

Thanks,
Laura

> 
>> ---
>>   drivers/gpio/gpio-stmpe.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpio/gpio-stmpe.c b/drivers/gpio/gpio-stmpe.c
>> index f8d7d1cd8488..c2bb20ace6f5 100644
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
>> +    status = kmalloc_array(num_banks, sizeof(*status), GFP_KERNEL);
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
> 
