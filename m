Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90ADC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78EB620881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfA2KGG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:06:06 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44212 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfA2KGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:06:06 -0500
Received: by mail-qt1-f193.google.com with SMTP id n32so21509807qte.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 02:06:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pTB1bWieBlGNlw8L8vm610TRvXf/JX26pHTEbBNtKqE=;
        b=L1kx2lpmp/WgOGQpTI+XcrG7Zi8xdmXsuctt01NfuV0B/52ouRHHzQyOq4f5u/RP3t
         9QpqGPeSsf0oXIawcBRpO6y1OE/YosK5PPieG6CYswIsFi+i59OLdwvox8WwxMXrLz45
         kgjER4KGziiLBITDab4SR0WFlRbkZ6Uhqlk7kykHYt02xlw6EZfM/yxSFQjn5/icBxX/
         nOTDVSsvtiKY3j/mBMX8ythr8IMaLlZikS+eUkHd1NmOkcRsNtn0gmkXZZLrAoJapGyL
         UCgvI3sTbXdK7/1iVIFQA3o8AgsX16D3XBSNeUwgLpNa7QvIW1cAnIOOEIN5YVJdJFaj
         39mg==
X-Gm-Message-State: AJcUukfrqhl9z3PLeGmSWX9u+1y6xlG8KY2aTYHT0Wz+oN+DLCw/8OTS
        9L5YqPoxNck6KZWaITWQ1QDHAT8vV6egIjLZ4cvsjA==
X-Google-Smtp-Source: ALg8bN46NupPZUaNpdrVCe07tvcQBxgfwLXXDcLJNVinTIvdJ3YDHp9ey1WdBj44xSP8zE/wvaMyp8FGFGSCuEHj2ts=
X-Received: by 2002:a0c:d174:: with SMTP id c49mr23448511qvh.231.1548756365185;
 Tue, 29 Jan 2019 02:06:05 -0800 (PST)
MIME-Version: 1.0
References: <20190107072429.23828-1-kai.heng.feng@canonical.com>
 <CAO-hwJKo=EaPoXJLGUvjq3QRng1V1NkO7A5zYGojbPyxxyJYHA@mail.gmail.com> <D7C6B90F-641A-495B-9E05-78BF4F56B552@canonical.com>
In-Reply-To: <D7C6B90F-641A-495B-9E05-78BF4F56B552@canonical.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 29 Jan 2019 11:05:53 +0100
Message-ID: <CAO-hwJ+CF-obuUK9T=x0ggJRLBNmM3H6-FfKjv2y0LT96C=TUg@mail.gmail.com>
Subject: Re: [PATCH v3] HID: i2c-hid: Ignore input report if there's no data
 present on Elan touchpanels
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 4:30 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
>
>
> > On Jan 18, 2019, at 23:50, Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
> >
> > Hi Kai-Heng,
> >
> > On Mon, Jan 7, 2019 at 8:24 AM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> >>
> >> While using Elan touchpads, the message floods:
> >> [  136.138487] i2c_hid i2c-DELL08D6:00: i2c_hid_get_input: incomplete report (14/65535)
> >>
> >> Though the message flood is annoying, the device it self works without
> >> any issue. I suspect that the device in question takes too much time to
> >> pull the IRQ back to high after I2C host has done reading its data.
> >>
> >> Since the host receives all useful data, let's ignore the input report
> >> when there's no data.
> >>
> >> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >
> > Thanks for the v3.
> >
> > This patch has just been brought to my attention, and I have one
> > question before applying it:
> > are those messages (without your patch) occurring all the time, or
> > just after resume?
>
> All the time.
>
> The touchpad works fine though. The entire report is 0xff, so it can be
> safely ignored.

Couple of things:
- I have forgotten to tell you that I have applied this patch in
for-5.1/i2c-hid, it will be pushed to linux-next today.
- Dell told me that a BIOS fix was solving the issue. We can still
quarry the patch, but there should not be a strong need for it when
users upgrade their BIOS.

Cheers,
Benjamin

>
> >
> > I wonder if the pm_suspend delay we talked about in the other thread
> > would fix that issue in a cleaner way.
>
> I’ve replied in another thread, unfortunately it can’t.
>
> We can introduce msleep() between each commands though, but I don’t
> think it’s good either.
>
> Kai-Heng
>
> >
> > Cheers,
> > Benjamin
> >
> >> ---
> >> v3:
> >> Fix compiler error/warnings.
> >>
> >> v2:
> >> Use dev_warn_once() to warn the user about the situation.
> >>
> >> drivers/hid/i2c-hid/i2c-hid-core.c | 9 +++++++++
> >> 1 file changed, 9 insertions(+)
> >>
> >> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> >> index 8555ce7e737b..2f940c1de616 100644
> >> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> >> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> >> @@ -50,6 +50,7 @@
> >> #define I2C_HID_QUIRK_NO_IRQ_AFTER_RESET       BIT(1)
> >> #define I2C_HID_QUIRK_NO_RUNTIME_PM            BIT(2)
> >> #define I2C_HID_QUIRK_DELAY_AFTER_SLEEP                BIT(3)
> >> +#define I2C_HID_QUIRK_BOGUS_IRQ                        BIT(4)
> >>
> >> /* flags */
> >> #define I2C_HID_STARTED                0
> >> @@ -179,6 +180,8 @@ static const struct i2c_hid_quirks {
> >>                I2C_HID_QUIRK_DELAY_AFTER_SLEEP },
> >>        { USB_VENDOR_ID_LG, I2C_DEVICE_ID_LG_8001,
> >>                I2C_HID_QUIRK_NO_RUNTIME_PM },
> >> +       { USB_VENDOR_ID_ELAN, HID_ANY_ID,
> >> +                I2C_HID_QUIRK_BOGUS_IRQ },
> >>        { 0, 0 }
> >> };
> >>
> >> @@ -503,6 +506,12 @@ static void i2c_hid_get_input(struct i2c_hid *ihid)
> >>                return;
> >>        }
> >>
> >> +       if (ihid->quirks & I2C_HID_QUIRK_BOGUS_IRQ && ret_size == 0xffff) {
> >> +               dev_warn_once(&ihid->client->dev, "%s: IRQ triggered but "
> >> +                             "there's no data\n", __func__);
> >> +               return;
> >> +       }
> >> +
> >>        if ((ret_size > size) || (ret_size < 2)) {
> >>                dev_err(&ihid->client->dev, "%s: incomplete report (%d/%d)\n",
> >>                        __func__, size, ret_size);
> >> --
> >> 2.17.1
> >>
>
