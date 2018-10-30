Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3A1C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF972080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLxXlZ9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF972080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbeJaFDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 01:03:51 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43106 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbeJaFDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 01:03:51 -0400
Received: by mail-qk1-f195.google.com with SMTP id r71so8110326qkr.10;
        Tue, 30 Oct 2018 13:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=RpTo1KM0PRBTIdeibAxOamsQPtaTgRc/rVpIA1Y7jxI=;
        b=mLxXlZ9FdIyl49+VmVfhD8nx3bpU/aBaM3XgI6kO+rQfhK5cYX/Fo5ITW04Akdum16
         O3jGu4gdMuaakN6VqHiGQgGzFAkiOTAsoNAbZwa73SvZ1wH/RGjQkr8847MEn4atSe6k
         /k9cyI1vS6HTCt4lsgKUKvr/nRS/EXt6ghEusgYqYMZPHUmZnphRew1JS44cmlcHAxaj
         uqiWpb1vIlSVtBGhZ7Nt4SilbHL2dHgcb1Axs/02IKdGGXbl4ZaLWsu77ogIa0sjXOCK
         DW+v1MNWOOub51DgC5ScygStbA8DThdsBDb7xZixEgaQ2N9p4itErswFAp9JFjAVqhqc
         qXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=RpTo1KM0PRBTIdeibAxOamsQPtaTgRc/rVpIA1Y7jxI=;
        b=JgAJPa5sjYqjv2+A2yAZNLNNc5bQwQQqWpnaBTt4hI0nrAVTqWxPJxHb9/xzxnVLSk
         EkB6B7oUyMdmYffa69xqHKAybBKuqV6ZblXdnVNPA88CnvjQdKqWm995dJGePuXWZbIU
         DXRolg3TyU4PK8J/bNrvzOmpBP5x6tmvgicRNOm4yTSTXtyXAnjv/xTL5/YmSzREfSqZ
         i7pUGPZlyftF5Ec9AKYpBVXWj4G83/3H8R0eIGD3sgyAMiTg1V0+thpRDDJ6rwP9gq72
         LEYHkeouWz6aqxDuWOenOzOeCLlkOXxfBUswpaPC2gT+l7H9jR6DWbflecFWP5RAj0oA
         LkPg==
X-Gm-Message-State: AGRZ1gKSAYQjktEnLhfqgKeH6Jli3Kd9YpiRuv5scb6ZlY2hTeyiaS9o
        AxgBq18NGzayvmcj/B0D1J9+FvVd9ps7rSfOFPo=
X-Google-Smtp-Source: AJdET5f+U8CdFKdL1vTgsVWutGUwn2DgKxDedsgjEZJhh1YVjH5XD54vbVKdWYOX2c66FFoMj3M6CopX0Yk+k7tf4tU=
X-Received: by 2002:a37:4116:: with SMTP id o22-v6mr123885qka.107.1540930135735;
 Tue, 30 Oct 2018 13:08:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:988d:0:0:0:0:0 with HTTP; Tue, 30 Oct 2018 13:08:54
 -0700 (PDT)
In-Reply-To: <CAOGqxeVfZaJWCVvjNq6_N_eQBvW-8z7NaOmRcQb6hE_c416v6A@mail.gmail.com>
References: <CAOGqxeVfZaJWCVvjNq6_N_eQBvW-8z7NaOmRcQb6hE_c416v6A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 30 Oct 2018 21:08:54 +0100
X-Google-Sender-Auth: pv2tco8mjbSvl20gHyF3lxxk040
Message-ID: <CAK8P3a3M5ppNKwthz5NcCrXc74r1aG9aJhQXzaP-Fa5a81U8yw@mail.gmail.com>
Subject: Re: [PATCH V2 4/6] usb: ohci-platform: Add support for Broadcom STB SoC's
To:     Alan Cooper <alcooperx@gmail.com>
Cc:     ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alban Bedel <albeu@free.fr>, Alex Elder <elder@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Avi Fishman <avifishman70@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        David Miller <davem@davemloft.net>,
        DTML <devicetree@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        gregkh <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        James Hogan <jhogan@kernel.org>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Johan Hovold <johan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        USB list <linux-usb@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, Roger Quadros <rogerq@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/18, Alan Cooper <alcooperx@gmail.com> wrote:
>> On 10/24/18 3:11 AM, Arnd Bergmann wrote:
>>
>> On Wed, Oct 17, 2018 at 11:30 PM Al Cooper <alcooperx@gmail.com> wrote:
>>
>> Add support for Broadcom STB SoC's to the ohci platform driver.
>>
>> Signed-off-by: Al Cooper <alcooperx@gmail.com>
>> ---
>>  drivers/usb/host/ohci-platform.c | 35
>> +++++++++++++++++++++++++++++------
>>  include/linux/usb/ohci_pdriver.h |  1 +
>>  2 files changed, 30 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/usb/host/ohci-platform.c
> b/drivers/usb/host/ohci-platform.c
>> index 65a1c3fdc88c..363d6fa676a5 100644
>> --- a/drivers/usb/host/ohci-platform.c
>> +++ b/drivers/usb/host/ohci-platform.c
>> @@ -22,6 +22,7 @@
>>  #include <linux/module.h>
>>  #include <linux/err.h>
>>  #include <linux/of.h>
>> +#include <linux/of_device.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/reset.h>
>> @@ -99,12 +100,24 @@ static int ohci_platform_probe(struct
> platform_device *dev)
>>         if (usb_disabled())
>>                 return -ENODEV;
>>
>> -       /*
>> -        * Use reasonable defaults so platforms don't have to provide
> these
>> -        * with DT probing on ARM.
>> -        */
>> -       if (!pdata)
>> -               pdata = &ohci_platform_defaults;
>> +       if (!pdata) {
>> +               const struct usb_ohci_pdata *match_pdata;
>> +
>> +               match_pdata = of_device_get_match_data(&dev->dev);
>> +               if (match_pdata) {
>> +                       pdata = devm_kzalloc(&dev->dev, sizeof(*pdata),
>> +                                            GFP_KERNEL);
>> +                       if (!pdata)
>> +                               return -ENOMEM;
>> +                       *pdata = *match_pdata;
>>
>> It looks like you copy the const pdata to get a non-const version.
>> Have you tried
>> propagating the 'const' modifier so that users can rely on that here?
>
> The problem is that the const pdata from of_device_get_match() needs to be
> saved in device->platform_data which is not a const pointer (and can't be
> changed). How can I propagate the "const" to solve the problem?

Ah, I see your problem, and unfortunately don't have an easy answer.

You could split up the structure between a constant part and a non-constant
part, and have the latter be what gets put into the platform_data, but that
wouldn't really be much nicer than what you have here.

You could use devm_kmemdup() to save a few lines to simplify your
code without any other changes maybe, but it doesn't solve the
fact that the mismatch between platform_data being non-const and
of_match_data being const is a bit ugly.

        Arnd
