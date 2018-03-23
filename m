Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1521821614; cv=none;
        d=google.com; s=arc-20160816;
        b=Qa7z/8BJ/hZ9EongTYDyJ4mFFF6GZBeQA1I+rNc9zUQTgGbfD6sPObd9lzi1BV5lZ9
         XdIKkTmkn5+qBE2aIl6s9KV8vmi5pu/tAdj4R/c1UsQLTDqeYvzzniT800UsTqpwlame
         /PWM5V/4uWYM4XAdC8NDBB616ezOGzvt0ksc2zhQl/ZFXgnaam+6JXPEjzlDP8Ij/K3j
         mSllwyYUFyfdbTxQtmvknPLW5q3CCRQ0LyBUV3SYTu0XWu/zqTOCNsxh3M3oSVXow4z8
         FXZ51VNJTsCPNPvIrgg8s7vizKrxsWpuPIr7eY5UewlCMsUrDK7P7iX/YhPoi3NjZOTE
         9HMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=L5Fam9ty/Y7BstsPNVxJ7mSYC22TQ1stGdOWM0SpDLU=;
        b=G92ydqNeZAxD8eDCEin+P6GWBueJ9y7suU35qg6+EBHVcnOl5luavWAyGjMs0tsB7S
         MCLwF0azRFcKVeJz435Slp4CuhvUTB/F5EsrOht1yCQ2ButSWPM48KJ3mABwH81aOYdF
         DMHn0aMJAuGTOEG8ppCBuQfWN20Br8SmWqk/ANF2e6JpvxqWNtVZgQiUElCqgabFZzyU
         F2fO9q35dJg8Gjw1/QmF+4zbRyeb+4KdyMe8SxXwINdsYETDHUcmZoNn8bcJrszDcaAt
         PUB8i9uixj6fCDvE/5/usL8QJteYxuEM60xmRR2sNbCIHhuB1PriwZ0GUnx0j3jPKaN0
         vGuQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=H8DfDlm6;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=H8DfDlm6;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AIpwx4+nUdFxvpe3GbDvIBkWmHkxbp2Gohvrjv/AvRX2rZt6+KqwtDCRLYlipxB0W6IMtwPtW3QYEXAk9vo4b2r6/wM=
MIME-Version: 1.0
In-Reply-To: <20180323152603.GA17081@kroah.com>
References: <20180319091721.18193-1-brgl@bgdev.pl> <CAHp75VevXq6NwpmvTU_2GzSdLjUQ47RLM__M3jNLBjZ1YoeQHw@mail.gmail.com>
 <CAMRc=MdKor4Hb-VWqczVgiatLU+HKW-u6D-1=b_xnvz_QJhO9g@mail.gmail.com>
 <CAHp75VfLzE===+4LpjyP5Zjzg7TCDiwf5udQEq-TtxjCbYXFpw@mail.gmail.com> <20180323152603.GA17081@kroah.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 23 Mar 2018 17:13:33 +0100
Message-ID: <CAMRc=MfbU=GLyxx0V1yeNNiD_ZQ8Ga+oS14tYWUcV9SGTSz4KA@mail.gmail.com>
Subject: Re: [PATCH 00/21] eeprom: at24: driver refactoring
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-i2c <linux-i2c@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595357052478188626?=
X-GMAIL-MSGID: =?utf-8?q?1595745621455519578?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-23 16:26 GMT+01:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> On Wed, Mar 21, 2018 at 04:52:19PM +0200, Andy Shevchenko wrote:
>> On Mon, Mar 19, 2018 at 5:21 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>> > 2018-03-19 15:43 GMT+01:00 Andy Shevchenko <andy.shevchenko@gmail.com>:
>> >> On Mon, Mar 19, 2018 at 11:17 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>> >>> This series contains what I hope to be a non-controversial refactoring
>> >>> of the at24 eeprom driver.
>> >>>
>> >>> Most changes revolve around at24_probe() which became quite complicated
>> >>> and hard to read.
>> >>>
>> >>> The only functional changes are: disabling the internal locking
>> >>> mechanisms of regmap (since we already take care of that in the driver)
>> >>> and removing an if checking if byte_len is a power of 2 (as we do
>> >>> support models for which it's not true).
>> >>>
>> >>> All other patches affect readability and code structure.
>> >>>
>> >>> Tested with a couple models and different both for device tree and
>> >>> platform data modes.
>> >>
>> >> Is there any available tree with that series applied?
>> >> I would test it on Intel Galileo Gen 2 which has ACPI enumerated AT24
>> >> EEPROM attached.
>> >>
>> >
>> > Yes, it's in my github tree:
>> >
>> >     https://github.com/brgl/linux    topic/at24/refactoring
>> >
>> > Thanks in advance for testing it!
>>
>> At least this didn't break AT24 on Intel Galileo Gen 2 board in ACPI mode.
>>
>> Tested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> All applied except for patch 4.
>
> thanks,
>
> greg k-h

Hi Greg,

I maintain this driver now and my pull requests usually go through
Wolfram's i2c tree (Cc'ed). I initially intended for this series to be
applied for 4.18. For 4.17 luckily the only other changes for at24 are
device tree bindings, so I guess we can keep it in misc-char, since
there are no conflicts.

Let me resend the corrected patch 4.

Best regards,
Bartosz Golaszewski
