Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A13C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E87920856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E87920856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeICOBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:01:20 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33811 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbeICOBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:01:19 -0400
Received: by mail-qk1-f196.google.com with SMTP id d15-v6so5262696qkc.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 02:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HzPAfJHRH2vuB5kj44tvr1lmM61iDkH+ElWLqma24TE=;
        b=o8g0Bcu4j1v4B31gkdppoh/+VznZ8gezgmpxkDnq8O4T3PFuVE+81pJNoI2GYxwoWV
         LzZYGDpO4sVDl5qej2b0Nibe4kPVcH+vIGTDprrUJU/V5FqNOPU/5PDO6R1PLpMndz7s
         U/GLwIpVr+ij/qDWRcmK1xGkwDXSvj1j3LVSxYqFuw4cQ9byCH4bnL0RPS+L0qu/+hnp
         JKliEXwLO637rmUnCxWN2TrxP5GlP0LVxXBCknHgNngtOjWRN3K1D2HgRbTsbDm5tkmk
         xoTgEtodUIL3qTy9nfmBOG+avdsSppIKs2vZKelLNnrlHk2PX+C5GA6to1RNR3c5ZXWg
         XdNg==
X-Gm-Message-State: APzg51CcvozSbizbUXMikMNys63JcDynzi/BgUM15sHnMq4saxzD9hMT
        OGSjxCGDHCa/VtIX1ah3p0HWeZh4Ba3rvJXDnaGP1A==
X-Google-Smtp-Source: ANB0VdZV/NI+gU0UQleS63akljRqImswkw0y4XIxFcaFX2gn3FweSX3LXCWrdHiKUHdpVeaOMjj2A112UOYrCLbVGz4=
X-Received: by 2002:ae9:c30b:: with SMTP id n11-v6mr9969107qkg.194.1535967718581;
 Mon, 03 Sep 2018 02:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180831095417.8541-1-benjamin.tissoires@redhat.com> <4687e76a-d9a8-4a20-194b-526bb345cf73@redhat.com>
In-Reply-To: <4687e76a-d9a8-4a20-194b-526bb345cf73@redhat.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 3 Sep 2018 11:41:47 +0200
Message-ID: <CAO-hwJKABBJExKciVt5R-8bjBtUe+uSc0Z_ikc35jbf1zrNpog@mail.gmail.com>
Subject: Re: [PATCH] HID: i2c-hid: enforce I2C_HID_QUIRK_RESEND_REPORT_DESCR
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, kai.heng.feng@canonical.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 12:04 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 31-08-18 11:54, Benjamin Tissoires wrote:
> > The spec states that the HID devices should allow
> > the host to query the HID descriptor at any time.
> >
> > Some devices require the HID descriptor to be set
> > on resume, or they will fail.
> >
> > Instead of having a growing list of blacklisted devices
> > make the call part of the general resume process
> > so we can remove this list.
> >
> > Tested on a Dell XPS 9360 and a Surface 3.
> >
> > link: https://bugzilla.redhat.com/show_bug.cgi?id=1622695
> >
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> I agree we should just do this everywhere:
>
> Acked-by: Hans de Goede <hdegoede@redhat.com>

Jiri, please hold with this patch, Canonical might have found a better
solution. Simply not resetting the device after S3 might be the trick.

Cheers,
Benjamin

>
> Regards,
>
> Hans
>
> > ---
> >   drivers/hid/i2c-hid/i2c-hid.c | 16 ++++------------
> >   1 file changed, 4 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> > index 57126f6837bb..17ec57c62a0b 100644
> > --- a/drivers/hid/i2c-hid/i2c-hid.c
> > +++ b/drivers/hid/i2c-hid/i2c-hid.c
> > @@ -47,7 +47,7 @@
> >   /* quirks to control the device */
> >   #define I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV    BIT(0)
> >   #define I2C_HID_QUIRK_NO_IRQ_AFTER_RESET    BIT(1)
> > -#define I2C_HID_QUIRK_RESEND_REPORT_DESCR    BIT(2)
> > +/* reserved: I2C_HID_QUIRK_RESEND_REPORT_DESCR       BIT(2) */
> >
> >   /* flags */
> >   #define I2C_HID_STARTED             0
> > @@ -170,12 +170,6 @@ static const struct i2c_hid_quirks {
> >               I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV },
> >       { I2C_VENDOR_ID_HANTICK, I2C_PRODUCT_ID_HANTICK_5288,
> >               I2C_HID_QUIRK_NO_IRQ_AFTER_RESET },
> > -     { I2C_VENDOR_ID_RAYD, I2C_PRODUCT_ID_RAYD_3118,
> > -             I2C_HID_QUIRK_RESEND_REPORT_DESCR },
> > -     { USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS10FB_TOUCH,
> > -             I2C_HID_QUIRK_RESEND_REPORT_DESCR },
> > -     { I2C_VENDOR_ID_RAYD, I2C_PRODUCT_ID_RAYD_4B33,
> > -             I2C_HID_QUIRK_RESEND_REPORT_DESCR },
> >       { 0, 0 }
> >   };
> >
> > @@ -1245,11 +1239,9 @@ static int i2c_hid_resume(struct device *dev)
> >        * after resume, after this it will be back normal.
> >        * otherwise it issues too many incomplete reports.
> >        */
> > -     if (ihid->quirks & I2C_HID_QUIRK_RESEND_REPORT_DESCR) {
> > -             ret = i2c_hid_command(client, &hid_report_descr_cmd, NULL, 0);
> > -             if (ret)
> > -                     return ret;
> > -     }
> > +     ret = i2c_hid_command(client, &hid_report_descr_cmd, NULL, 0);
> > +     if (ret)
> > +             return ret;
> >
> >       if (hid->driver && hid->driver->reset_resume) {
> >               ret = hid->driver->reset_resume(hid);
> >
