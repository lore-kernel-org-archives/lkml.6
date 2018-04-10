Return-Path: <labbott@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523386147; cv=none;
        d=google.com; s=arc-20160816;
        b=BvE8xcKLRMY7uIJwRp6iphoSkudi55xIXPgeswGL3Yp3b8zdGoi38UJkUMtiGUc6C+
         RcmDIil0vxfWU/CWQQ/HmlVZIAKzopc1tU4IevcprTWW7RQCnEzCPDZ/jmxVx/MMgw2B
         UN22IfXOK6iEhn6l+HXofABof3vgfVqBMaBlxJxvLDFky2jh3SVSYVbhDoN1XrTRyFcK
         Hqh/SLKqF6su/y7RLf2c3XqEBAUoKjuuyWJTnhK4joV6w5OQ47WmCcSeO6C/MQW3hHbB
         oH15PJfkhH/4CdPNO3bejQvHix0WmUyDs0cL/EFotUKzGMsRdNUpeKuaG0nWrjBif2tg
         aEbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=3e7WjB7R03D7D8WOBg9xEyvx4TXO3Wd88HH4z9b/XxM=;
        b=ujhwGKr+fuBcNnyPX14nJCa/KYQ7sPRaQX3aR7LaFeRBiWUKzB4VuZfM9nFOh5SPE4
         Vz4sWv3cbCGu//0VFFEMm4xEbGdcCK2rWWRV52jqLq1zHM+yBQ/SFNJZUtBnq3CXk0nJ
         odh/1pnSI6EM640PnJOpINO4lutHlOjLA53Frsn7RS8Db1tFLdTRZe5dFdc1wD1bTdYA
         7sgVrotw7GIKxykjZtNHo2egPF9DhuKim9ZeTbnbxSZdoaaXzwrUxyHEWXLVmItLzeRB
         jdWF+GEuecRV/7dcgf6hD6yVBlJT6YZuxM6JX1Ug1G+TSWVEUMYOGrudmgYh5PWaoHVY
         pfBw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of labbott@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=labbott@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of labbott@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=labbott@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AIpwx4/HqS7Pft1woScEh9IiFV/1OfUscNyBxmDT53GT+yRsk+CFutPFW13ysXvR7LHgv5GXejU9xQ==
Subject: Re: [PATCH] misc: tifm: Remove VLA
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alex Dubov <oakad@yahoo.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>
References: <20180409210732.3919-1-labbott@redhat.com>
 <CAK8P3a3Yo0riMroM3x4EVz8FkMakdPkkJ-mCTYW0qOji+MCCiQ@mail.gmail.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <799e8f9a-0aa1-6f5d-8421-7c768d70f562@redhat.com>
Date: Tue, 10 Apr 2018 11:49:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3Yo0riMroM3x4EVz8FkMakdPkkJ-mCTYW0qOji+MCCiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597304272703650108?=
X-GMAIL-MSGID: =?utf-8?q?1597386153666034366?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/10/2018 12:57 AM, Arnd Bergmann wrote:
> On Mon, Apr 9, 2018 at 11:07 PM, Laura Abbott <labbott@redhat.com> wrote:
>> There's an ongoing effort to remove VLAs[1] from the kernel to eventually
>> turn on -Wvla. The single VLA can either take a value of 2 or 4 so switch
>> to the upper bound.
>>
>> [1] https://lkml.org/lkml/2018/3/7/621
>>
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
>>   drivers/misc/tifm_7xx1.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/misc/tifm_7xx1.c b/drivers/misc/tifm_7xx1.c
>> index e5f108713dd8..690eaaea5ce4 100644
>> --- a/drivers/misc/tifm_7xx1.c
>> +++ b/drivers/misc/tifm_7xx1.c
>> @@ -239,7 +239,8 @@ static int tifm_7xx1_resume(struct pci_dev *dev)
>>          unsigned long timeout;
>>          unsigned int good_sockets = 0, bad_sockets = 0;
>>          unsigned long flags;
>> -       unsigned char new_ids[fm->num_sockets];
>> +       /* Maximum number of entries is 4 */
>> +       unsigned char new_ids[4];
>>          DECLARE_COMPLETION_ONSTACK(finish_resume);
>>
> 
> I like the idea of removing all the VLAs, but this one appears to make
> the code less robust rather than more: In case of an unexpected
> fm->num_sockets value, we now not only overflow the kernel stack
> area but also the local variable into the neighboring stack slots.
> 
> Maybe add an extra overflow check?
> 

Sure.

>         Arnd
> 
> diff --git a/drivers/misc/tifm_7xx1.c b/drivers/misc/tifm_7xx1.c
> index e5f108713dd8..c702cd92d396 100644
> --- a/drivers/misc/tifm_7xx1.c
> +++ b/drivers/misc/tifm_7xx1.c
> @@ -239,9 +239,12 @@ static int tifm_7xx1_resume(struct pci_dev *dev)
>          unsigned long timeout;
>          unsigned int good_sockets = 0, bad_sockets = 0;
>          unsigned long flags;
> -       unsigned char new_ids[fm->num_sockets];
> +      /* Maximum number of entries is 4 */
> +       unsigned char new_ids[4];
>          DECLARE_COMPLETION_ONSTACK(finish_resume);
> 
> +       if (WARN_ON(fm->num_sockets > ARRAY_SIZE(new_ids)))
> +               return -ENXIO;
> +
>          pci_set_power_state(dev, PCI_D0);
>          pci_restore_state(dev);
>          rc = pci_enable_device(dev);
> 
