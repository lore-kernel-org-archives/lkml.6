Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA3AC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2269E208A4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2269E208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932719AbeFUNMP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:12:15 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46128 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbeFUNMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:12:13 -0400
Received: from 79.184.254.22.ipv4.supernova.orange.pl (79.184.254.22) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id c8e7fd08c0638708; Thu, 21 Jun 2018 15:12:11 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ravi Chandra Sadineni <ravisadineni@google.com>
Cc:     Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Len Brown <lenb@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Todd Broch <tbroch@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Benson Leung <bleung@google.com>,
        Furquan Shaikh <furquan@chromium.org>
Subject: Re: [PATCH V2] ACPI LID: increment wakeup count only when notified.
Date:   Thu, 21 Jun 2018 15:11:00 +0200
Message-ID: <1626382.ruNcc2KUiW@aspire.rjw.lan>
In-Reply-To: <CAOGSYL371YSqpqdzqHUC+UxvMtxTc0q=YFPRcT-SeSHO5Pepeg@mail.gmail.com>
References: <CAJZ5v0gXqyKQ5yTtqFYzv=KW2o+b4vGiUYiWWn+iT=zY-mU9xw@mail.gmail.com> <20180611175759.181681-1-ravisadineni@chromium.org> <CAOGSYL371YSqpqdzqHUC+UxvMtxTc0q=YFPRcT-SeSHO5Pepeg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, June 20, 2018 5:45:50 PM CEST Ravi Chandra Sadineni wrote:
> Hi Rafael,
> 
> Is this good to be merged ?

Not for 4.18, so please give me some time here.

> If you see any problem with the patch, can you
> please let me know.

I will.

Thanks,
Rafael


> On Mon, Jun 11, 2018 at 10:57 AM, Ravi Chandra Sadineni <
> ravisadineni@chromium.org> wrote:
> 
> > Currently ACPI LID increments wakeup count irrespective of the wake source.
> > This is because we call acpi_lid_initialize_state on every resume.
> > Userland deamons using wakeup_count to identify the potential wake
> > source for the last wake will be thrown off by this. Instead increment
> > the wakeup count only when there is a FIXED_HARDWARE/NOTFIY_STATUS event.
> >
> > Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> > ---
> >  V2: Increment the wakeup count only when the lid is open.
> >
> >  drivers/acpi/button.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> > index 2345a5ee2dbbc..d2fe03e4faf05 100644
> > --- a/drivers/acpi/button.c
> > +++ b/drivers/acpi/button.c
> > @@ -235,9 +235,6 @@ static int acpi_lid_notify_state(struct acpi_device
> > *device, int state)
> >                 button->last_time = ktime_get();
> >         }
> >
> > -       if (state)
> > -               acpi_pm_wakeup_event(&device->dev);
> > -
> >         ret = blocking_notifier_call_chain(&acpi_lid_notifier, state,
> > device);
> >         if (ret == NOTIFY_DONE)
> >                 ret = blocking_notifier_call_chain(&acpi_lid_notifier,
> > state,
> > @@ -366,7 +363,8 @@ int acpi_lid_open(void)
> >  }
> >  EXPORT_SYMBOL(acpi_lid_open);
> >
> > -static int acpi_lid_update_state(struct acpi_device *device)
> > +static int acpi_lid_update_state(struct acpi_device *device,
> > +                                bool is_notification)
> >  {
> >         int state;
> >
> > @@ -374,6 +372,9 @@ static int acpi_lid_update_state(struct acpi_device
> > *device)
> >         if (state < 0)
> >                 return state;
> >
> > +       if (state && is_notification)
> > +               acpi_pm_wakeup_event(&device->dev);
> > +
> >         return acpi_lid_notify_state(device, state);
> >  }
> >
> > @@ -384,7 +385,7 @@ static void acpi_lid_initialize_state(struct
> > acpi_device *device)
> >                 (void)acpi_lid_notify_state(device, 1);
> >                 break;
> >         case ACPI_BUTTON_LID_INIT_METHOD:
> > -               (void)acpi_lid_update_state(device);
> > +               (void)acpi_lid_update_state(device, false);
> >                 break;
> >         case ACPI_BUTTON_LID_INIT_IGNORE:
> >         default:
> > @@ -409,7 +410,7 @@ static void acpi_button_notify(struct acpi_device
> > *device, u32 event)
> >                         users = button->input->users;
> >                         mutex_unlock(&button->input->mutex);
> >                         if (users)
> > -                               acpi_lid_update_state(device);
> > +                               acpi_lid_update_state(device, true);
> >                 } else {
> >                         int keycode;
> >
> > --
> > 2.18.0.rc1.242.g61856ae69a-goog
> >
> >
> 


