Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22770C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C082B2495A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IHljiO5l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C082B2495A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754624AbeFVWkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 18:40:02 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42393 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754439AbeFVWkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 18:40:00 -0400
Received: by mail-ed1-f66.google.com with SMTP id z21-v6so2051521edr.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 15:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7syiXxL8Hj762ubvL9X0THMWL3MTeI4scvt78LKPnmg=;
        b=IHljiO5lP54qAxdiyis8RkP9Yah3HNWo8FETgSxHGdzlfqGNerSfnwVbhPHr8R0nU1
         ghSBkErXWbkqb4NtfpKFjUe0H7DvMJcaqsg7XscvnzFEtFHSFhlyzzr2oI9q1h7/3zUE
         BNPS8KwkSSiR2D97yGhj8IdHUZjBpmVsKC3m8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7syiXxL8Hj762ubvL9X0THMWL3MTeI4scvt78LKPnmg=;
        b=RL4cO+24grL/OCrlZER9tQSJKsjseJrGhM2Kx6PB2VwHP9Y+/iFdy2sJKn95VgNUot
         ngYGSeXzqsy2FPm6SJh9yq0v1s1CvqN5bPq2QGV7u/cBQ5kpz2Mtzv7e0bEg8WHhXChn
         tS01Sh6UFS/4BEaXg8/2eeBgBzQjzYPUx5MSSeY/SzO87MtocDfjahnUT06G0iWcUPwO
         P0IWi19tjgmAwZjKtE7tzeQMrQHCXHbnbzNv7dPozr2Ewqe1OisxrKbMXfNE/d43bcTP
         r37gYu+G6Un4QKz/+LXMabWuF562MOX4yRf6Xc+U7D0TpcslN3Wg+pcMkV4zzTtUWBh2
         JhSA==
X-Gm-Message-State: APt69E0P1j/Wf5eDSq2l6UURZYJilIGDUqz78cNr9EqhXIqLZwtMruQM
        w3UqzYBbv8i1JOvdoxiMNL4My7JgyHs=
X-Google-Smtp-Source: ADUXVKJ76k94wpEmc9U6+MJIrQok5HJJ7vLmL1JxuUVwMmUUaHEhL3S1OfP0kUwlHEmmw9zQjLy1Zw==
X-Received: by 2002:a50:9497:: with SMTP id s23-v6mr3140117eda.118.1529707199299;
        Fri, 22 Jun 2018 15:39:59 -0700 (PDT)
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com. [74.125.82.41])
        by smtp.gmail.com with ESMTPSA id f2-v6sm3282898edq.28.2018.06.22.15.39.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 15:39:58 -0700 (PDT)
Received: by mail-wm0-f41.google.com with SMTP id o13-v6so3543800wmf.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 15:39:58 -0700 (PDT)
X-Received: by 2002:a1c:d2cb:: with SMTP id j194-v6mr2769261wmg.129.1529707197912;
 Fri, 22 Jun 2018 15:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180622022717.134300-1-swboyd@chromium.org> <20180622022717.134300-2-swboyd@chromium.org>
 <CAO-hwJJxSHqwEcypc-PVSDUoOSM4OHcOP18QJpoxq6OqKcbq-w@mail.gmail.com> <095738e5-eb31-905b-b496-0d78489e253d@redhat.com>
In-Reply-To: <095738e5-eb31-905b-b496-0d78489e253d@redhat.com>
From:   Dmitry Torokhov <dtor@chromium.org>
Date:   Fri, 22 Jun 2018 15:39:46 -0700
X-Gmail-Original-Message-ID: <CAE_wzQ9bOd4Ee06UbBY8NePRdtsF5wX7awmJqozn0FBhRBfkdA@mail.gmail.com>
Message-ID: <CAE_wzQ9bOd4Ee06UbBY8NePRdtsF5wX7awmJqozn0FBhRBfkdA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] HID: i2c-hid: Use devm to allocate i2c_hid struct
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        swboyd@chromium.org, Jiri Kosina <jikos@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        andriy.shevchenko@linux.intel.com,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 2:13 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 22-06-18 09:16, Benjamin Tissoires wrote:
> > On Fri, Jun 22, 2018 at 4:27 AM, Stephen Boyd <swboyd@chromium.org> wrote:
> >> Use devm here to save some lines and prepare for bulk regulator usage in
> >> this driver. Otherwise, when we devm bulk get regulators we'll free the
> >> containing i2c_hid structure and try to put regulator pointers from
> >> freed memory.
> >>
> >> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >> Cc: Hans de Goede <hdegoede@redhat.com>
> >> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> Cc: Dmitry Torokhov <dtor@chromium.org>
> >> Cc: Doug Anderson <dianders@chromium.org>
> >> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> >> ---
> >>   drivers/hid/i2c-hid/i2c-hid.c | 9 +++------
> >>   1 file changed, 3 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> >> index c1652bb7bd15..c7d6738dc524 100644
> >> --- a/drivers/hid/i2c-hid/i2c-hid.c
> >> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> >> @@ -1002,18 +1002,18 @@ static int i2c_hid_probe(struct i2c_client *client,
> >>                  return client->irq;
> >>          }
> >>
> >> -       ihid = kzalloc(sizeof(struct i2c_hid), GFP_KERNEL);
> >> +       ihid = devm_kzalloc(&client->dev, sizeof(*ihid), GFP_KERNEL);
> >
> > IIRC, I never made the switch towards devm for i2c_hid because at the
> > time there was a "all or nothing" rule regarding devm.
>
> I'm not aware of any such rule. Sure ideally everything should use
> devm, because it makes life just so much easier. But I've seen mixed
> use in plenty of cases.

When mixing managed and unmanaged resources you need to be extremely
careful to make sure they are released in proper order. There were
many naive conversions that would convert just part of resources to
devm and end up, let's say, powering down rails of a device or turning
off clocks while interrupts are still registered, which causes errors
if interrupt fires, and so on. I usually request people to do either
full conversion or leave the driver alone.

That said, using devm to allocate the "main" driver structure is usually safe.

>
> With that said converting fully to devm is not necessarily a bad
> idea.
>
> Regards,
>
> Hans
>
>
> > But given that the regulator already has a devm inside, I think we are
> > screwed here and we should probably try to devm-ize the module.
> >
> > I seem to remember that someone posted a devm version of
> > hid_allocate_device/hid-add_device, but I don't think this ever went
> > upstream (because no use).

There is always devm_add_action_or_reset() to inject custom actions
into devm stack to work around lacking devm APIs.

> >
> > Otherwise, for the series:
> > Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >
> > Cheers,
> > Benjamin
> >
> >
> >
> >>          if (!ihid)
> >>                  return -ENOMEM;
> >>
> >>          if (client->dev.of_node) {
> >>                  ret = i2c_hid_of_probe(client, &ihid->pdata);
> >>                  if (ret)
> >> -                       goto err;
> >> +                       return ret;
> >>          } else if (!platform_data) {
> >>                  ret = i2c_hid_acpi_pdata(client, &ihid->pdata);
> >>                  if (ret)
> >> -                       goto err;
> >> +                       return ret;
> >>          } else {
> >>                  ihid->pdata = *platform_data;
> >>          }
> >> @@ -1126,7 +1126,6 @@ static int i2c_hid_probe(struct i2c_client *client,
> >>
> >>   err:
> >>          i2c_hid_free_buffers(ihid);
> >> -       kfree(ihid);
> >>          return ret;
> >>   }
> >>
> >> @@ -1150,8 +1149,6 @@ static int i2c_hid_remove(struct i2c_client *client)
> >>
> >>          regulator_disable(ihid->pdata.supply);
> >>
> >> -       kfree(ihid);
> >> -
> >>          return 0;
> >>   }
> >>
> >> --
> >> Sent by a computer through tubes
> >>
