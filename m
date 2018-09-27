Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88145C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E37215E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hHrcZrWk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E37215E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeI0SaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 14:30:04 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42803 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbeI0SaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 14:30:04 -0400
Received: by mail-io1-f66.google.com with SMTP id n18-v6so1757425ioa.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 05:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=D4mBad6E1sIK2FZdk/IK9lKP3Hi+wSC3OqnFd1c2cUk=;
        b=hHrcZrWkxb4Hgt5sJZWcPU7D5Mb86mEbmrGMAud1qNUU939E511s5kzoZYbY6JlFGI
         0xsLge9hxR+BidA7HSncQ4aRppXrropaRMg8SPT3anzPkaTXnXcBYAtYEafodcTL0r/H
         cc1LQExxSYNS3HunV+p+rWXMy4X9UUgGGFun0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=D4mBad6E1sIK2FZdk/IK9lKP3Hi+wSC3OqnFd1c2cUk=;
        b=rxuxdHB5LR1wBGxIdkMRkwfDnC7uNVztxKJWc8hxDPC3+bv30U5Zfom4jXzhzDgWdn
         JiPVXbGwItTquHFBgO3xw8by4UYUoE3p+iRaend/cNQNSc/rxkKLmBD64IwbeC0BMn4Z
         NjDTBE5AmDUJezLCPbmE4fzTpyKcze4orUFYMnft48pdyPQ7wOA2rQWX+yMqn7QcErEy
         wiTPiiQtKkxOaQRzaX20Ka2zX2OzJISkHE4QQgj7b3zr3zhUu6cRLrzWBXdCgIPHKfSR
         sCV4WQpu/sp165jSa9y8KyXDd8lasc3k8bxyXKuJ+FQsE6sa3Eja/15gBziHcOUdfmQE
         VjxA==
X-Gm-Message-State: ABuFfoj+oczzFqnIxoiQhby68Ft1alI8l3gCiOhsCkFJUj/798MjB3r9
        9FOzwuZHweOQLnBSsXEwyLCLudbkVAf7wUp0P4RHPA==
X-Google-Smtp-Source: ACcGV63G59a95znnwXzSUiUF9FZaUwZecT4Q5zGPI7OJs5y7eh1hWYrQED9Do6lvEPXIa+8n1M8I3P3Fw4E1NQI7qi0=
X-Received: by 2002:a6b:203:: with SMTP id 3-v6mr8337700ioc.131.1538050324351;
 Thu, 27 Sep 2018 05:12:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:6a18:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 05:11:23
 -0700 (PDT)
In-Reply-To: <20180927014040.GA183684@google.com>
References: <20180923203924.68452-1-yuzhao@google.com> <CAPDyKFqiUO-7O6bgrszuR3YKMkEoPT4976gvDKvUWpYuNp03ag@mail.gmail.com>
 <20180927014040.GA183684@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 27 Sep 2018 14:11:23 +0200
Message-ID: <CAPDyKFoWZwvm9Mb-pwKT0vKxhYJy98njRh_3dXxb7A5FtHmi4Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: add quirk for O2 Micro dev 0x8620 rev 0x01
To:     Yu Zhao <yuzhao@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 September 2018 at 03:40, Yu Zhao <yuzhao@google.com> wrote:
> On Thu, Sep 27, 2018 at 01:48:58AM +0200, Ulf Hansson wrote:
>> On 23 September 2018 at 22:39, Yu Zhao <yuzhao@google.com> wrote:
>> > This device reports SDHCI_CLOCK_INT_STABLE even though it's not
>> > ready to take SDHCI_CLOCK_CARD_EN. The symptom is that reading
>> > SDHCI_CLOCK_CONTROL after enabling the clock shows absence of the
>> > bit from the register (e.g. expecting 0x0000fa07 = 0x0000fa03 |
>> > SDHCI_CLOCK_CARD_EN but only observed the first operand).
>> >
>> > mmc1: Timeout waiting for hardware cmd interrupt.
>> > mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
>> > mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00000603
>> > mmc1: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
>> > mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
>> > mmc1: sdhci: Present:   0x01ff0001 | Host ctl: 0x00000001
>> > mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
>> > mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x0000fa03
>> > mmc1: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
>> > mmc1: sdhci: Int enab:  0x00ff0083 | Sig enab: 0x00ff0083
>> > mmc1: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000000
>> > mmc1: sdhci: Caps:      0x25fcc8bf | Caps_1:   0x00002077
>> > mmc1: sdhci: Cmd:       0x00000000 | Max curr: 0x005800c8
>> > mmc1: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
>> > mmc1: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
>> > mmc1: sdhci: Host ctl2: 0x00000008
>> > mmc1: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000
>> > mmc1: sdhci: ============================================
>> >
>> > The problem happens during wakeup from S3. Adding a delay quirk
>> > after power up reliably fixes the problem.
>> >
>> > Signed-off-by: Yu Zhao <yuzhao@google.com>
>>
>> Applied for next, thanks!
>>
>> Kind regards
>> Uffe
>>
>> > ---
>> >  drivers/mmc/host/sdhci-pci-o2micro.c | 2 ++
>> >  1 file changed, 2 insertions(+)
>> >
>> > diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
>> > index 77e9bc4aaee9..3e5ecf7ce101 100644
>> > --- a/drivers/mmc/host/sdhci-pci-o2micro.c
>> > +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
>> > @@ -490,6 +490,8 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>> >                 pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
>> >                 break;
>> >         case PCI_DEVICE_ID_O2_SEABIRD0:
>> > +               if (chip->pdev->revision == 0x01)
>> > +                       chip->quirks |= SDHCI_QUIRK_DELAY_AFTER_POWER;
>
> Hi Uffe,
>
> I apologize for the missing /* fall through */ here. Could you
> please add it in case it causes any static checker problem?
> Or I can send a v2.

I amended the change, no action needed. Thanks!

Kind regards
Uffe
