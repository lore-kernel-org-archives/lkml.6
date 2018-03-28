Return-Path: <kernel-hardening-return-12797-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/txsXawXDzZfiucfLC73nrMtLzBHXvIpzDk0Pd/ZATGJppQVbCDKz5rBcNKAve4smOknss
ARC-Seal: i=1; a=rsa-sha256; t=1522258052; cv=none;
        d=google.com; s=arc-20160816;
        b=wee3tC8FU9KTeMb+iGUBv6XEQxLuWB2h4xW+AM3v16Hmf2IgGRoTG/kwx006ntBGUr
         tAkGR+BMAzutek8hY/s3eTM03FPptVYJ4kuuA3pAWnxQ+4ouOtPaiTWVyDU0qSv6skX3
         dUsDLwRjlhf4nnVUyxaEIVvTF5n6r4ZjDcxxL13tacQTL4ugHFBd2kg26pA3/SOFy7Ba
         sfd6SYWUty/hOSYqofNspxSwpWsFAWIv2ghixWkS3dPnvqcrTD+2jItBbz6dALgYlJ36
         gc7NC5X5WcK9L+Icd1P0ijhKrp/2ihrcoeRbBjCQ7ImlpogPnw4DmWeAfdXXJtQnmyhV
         qLyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=jYRj05PWGR0ZEkGV2hPsj+r4dS8rjyY3Lq/IrfYyOx0=;
        b=IwoZ+iZrGS7vOhB8S9223qYPhHeEYBTNuZ+G4I3mcsPTYugZ12a69Y1tQicCiJ6Xpo
         dYniIlD3BB3tYKSjrkWUTXkI5asPJCezDg2Da12reaaOn+OsQww6uLCLfu/e/sPVTtp1
         hRYkBqHq2RbhLSDRVdF0Sckhyu8Wq3IX2ureLdIfiixXiCFExkimuf1vE8x+mvi6ZxiM
         s772RiqPBFUPnbTFsPdHIOnwfBUFcu8CBIdHTTWZ251ucXbAM2foWcTUdXUiOGLPJWsx
         w2YySfAdbea39LcC9NBV7Z6g3tKWOKoetCa46FtXF/fH9Spgb5gl/HgObwXKmkUOO0pD
         DJew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12797-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12797-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12797-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12797-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 3/4] gpio: Remove VLA from xra1403 driver
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Kees Cook <keescook@chromium.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 kernel-hardening@lists.openwall.com
References: <20180310001021.6437-1-labbott@redhat.com>
 <20180310001021.6437-4-labbott@redhat.com>
 <CAMuHMdUfGp_rn_fMWdOfWxPvyE1Y9oemm2piXszFTvBi9sQ5Eg@mail.gmail.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <90ca44b5-52d0-be74-f36c-55d6f4a9bf25@redhat.com>
Date: Wed, 28 Mar 2018 10:27:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUfGp_rn_fMWdOfWxPvyE1Y9oemm2piXszFTvBi9sQ5Eg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594507318656304803?=
X-GMAIL-MSGID: =?utf-8?q?1596203260251850317?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/28/2018 12:27 AM, Geert Uytterhoeven wrote:
> Hi Laura,
> 
> On Sat, Mar 10, 2018 at 1:10 AM, Laura Abbott <labbott@redhat.com> wrote:
>> The new challenge is to remove VLAs from the kernel
>> (see https://lkml.org/lkml/2018/3/7/621)
>>
>> This patch replaces a VLA with an appropriate call to kmalloc_array.
>>
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
> 
> Thanks for your patch!
> 
>> --- a/drivers/gpio/gpio-xra1403.c
>> +++ b/drivers/gpio/gpio-xra1403.c
>> @@ -126,11 +126,16 @@ static void xra1403_dbg_show(struct seq_file *s, struct gpio_chip *chip)
>>   {
>>          int reg;
>>          struct xra1403 *xra = gpiochip_get_data(chip);
>> -       int value[xra1403_regmap_cfg.max_register];
> 
> Apparently xra1403_regmap_cfg.max_register is always 0x15?
> 
> What about adding
> 
>          #define XRA_LAST 15
> 
> at the top, and replacing both "XRA_IFR | 0x01" and
> xra1403_regmap_cfg.max_register by XRA_LAST instead?
> That would avoid doing yet another memory allocation over and over.
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 

I'm okay with making the change but I think Linus already picked
up the patch into his gpio trees. Linus, do you want a patch on
top of your -devel branch or should I just send a new patch?

Thanks,
Laura
