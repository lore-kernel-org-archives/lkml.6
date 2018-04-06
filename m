Return-Path: <f.fainelli@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523030107; cv=none;
        d=google.com; s=arc-20160816;
        b=zi/zoSM1uBZXwQxegqcIQ+qnZmauuV+f1HkZH8oGYLmGNG5x94ACcCgDTlegp4H5FE
         h/kRAmGsPGoK9E03hSwDnYdP8yOefXv69Hf89Y5SY0WZmZkMCCOYQilLiDnKCi5mCAol
         TAgoE2fKIXR9sAAraYtdqYznvm65P7MmJGZ5HTwlw8y2fD7U5wQpcBeA+6vhA7hXvbAN
         syIpTfRsSkqMzlC1vHkEibsMfBhFTDKYfi18wfjmwx34Hm+t7R499IKUwiQzL7Fd8J+9
         7cm0rdRR29dCFyWJF4LObYBE4lOdRiDZ6ixtxYdUa1Cr4tAfGSem0NqMKrY3ct7BCYvh
         umEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=knN048XaRrCQh+EkY0/eo1/Pq0FzvPkYAd2hyBAEYwo=;
        b=E3zI12VjNv34QKuaqEbqBfpcYJbfaavZm1kv1sfJz7q3kj4bP6mYXMjmePC+2B8AZZ
         fiqyl7p9vl6YxBRODbDrTZhya3p2VFHclv1YBbHvgAJf9TvDhKl+/uFw9CG4OSuTCqs/
         Gm+c3v0N6EZehdIr3VxSvDEyXNvChgiL47hNFQzJhtYClJfUVGr39AbTyDCPA/fT7CM2
         yyjcVfoKKpdOTHQFJwRRwIcIK1x1zpTzoYF0qKFck4/v97JJ6SnkDyY8n02MjUCJ/aMX
         Af1ClxgsGIqic8JNhUiGIps2IEmYQc8FxI9rwJIJ712TZHA3GumIdAQqHc7w8JnuvHEj
         h0Zw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=O/NTcbW2;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=O/NTcbW2;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+Sge0Wl/kR8CHF6joH17/7s3JQTcD15I9Vwhvz+Cz/AAmTGKpA3Jx9kmi766of/Bal6fttWw==
Subject: Re: [4.9, 137/145] spi: bcm-qspi: shut up warning about cfi header
 inclusion
To: Arnd Bergmann <arnd@arndb.de>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "# 3.4.x" <stable@vger.kernel.org>, Kamal Dasu <kdasu.kdev@gmail.com>
References: <20180223170742.426320243@linuxfoundation.org>
 <b9046b98-acb6-c828-661f-ab67696ff1b8@gmail.com>
 <20180406070938.GE8416@kroah.com>
 <CAK8P3a0_rCMvcaxsi-XeOcdFxQk_FkJ7prOS1ySRAscXXROtnA@mail.gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <21fcc6ff-d3f8-a863-224c-a31746c2db0c@gmail.com>
Date: Fri, 6 Apr 2018 08:55:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0_rCMvcaxsi-XeOcdFxQk_FkJ7prOS1ySRAscXXROtnA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593218652822449350?=
X-GMAIL-MSGID: =?utf-8?q?1597012818038370121?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 04/06/2018 12:22 AM, Arnd Bergmann wrote:
> On Fri, Apr 6, 2018 at 9:09 AM, gregkh@linuxfoundation.org
> <gregkh@linuxfoundation.org> wrote:
>> On Tue, Apr 03, 2018 at 10:46:07AM -0700, Florian Fainelli wrote:
>>> On 02/23/2018 10:27 AM, gregkh@linuxfoundation.org wrote:
>>>> 4.9-stable review patch.  If anyone has any objections, please let me know.
>>>>
>>>> ------------------
>>>>
>>>> From: Arnd Bergmann <arnd@arndb.de>
>>>>
>>>> When CONFIG_MTD_CFI is disabled, we get a warning for this spi driver:
>>>>
>>>> include/linux/mtd/cfi.h:76:2: #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work. [-Werror=cpp]
>>>>
>>>> The problem here is a layering violation that was fixed in mainline kernels with
>>>> a larger rework in commit 054e532f8f90 ("spi: bcm-qspi: Remove hardcoded settings
>>>> and spi-nor.h dependency"). We can't really backport that to stable kernels, so
>>>> this just adds a Kconfig dependency to make it either build cleanly or force it
>>>> to be disabled.
>>>
>>> Sorry for noticing so late, but this appears to be bogus, there is no
>>> MTD_NORFLASH symbol being defined in 4.9, in fact I can't find this
>>> Kconfig symbol in any kernel version, so this effectively results in the
>>> driver no longer being selectable, so this sure does silence the warning.
>>>
>>> Arnd, should we just send reverts of this patch for the affected kernel
>>> or should we be defining MTD_NORFLASH somehow? Am I missing something here?
>>
>> I'm going to revert this patch for now, thanks.
> 
> Yes, please do. Sorry for missing Florian's bug report. I looked at it again
> and found that it was never intended for backports to 4.9, as the regression
> addressed by the patch was originally merged into 4.14-rc1.

No worries, thanks both!
--
Florian
