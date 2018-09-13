Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09699C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 06:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31DF204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 06:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31DF204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbeIMMDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 08:03:43 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37116 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbeIMMDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 08:03:42 -0400
Received: by mail-ot1-f68.google.com with SMTP id o13-v6so306618otl.4;
        Wed, 12 Sep 2018 23:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xi017HFD/HhBVnFaH/DJ3TkuIXV8T6S/rSN0hwxObTc=;
        b=RUJRsrz4QzpfFE5wxIm7mS3cXgaED/6MxJPfBXGbn2VrEGfhCV9ihsBkZEWde7Ip5A
         JslyH3k/rL1JNknztJRE9L8N9aYbMD/q/v6UzHJrrBq8QH5+4LLTbHtpdzPnua0SpMt9
         HBW9WJbOl9War8C7KNFZBXj0V2US/M4g+n7AxAp2VhjuKSOhV0kK/6HJ35V+B+VgEoRk
         0N2kB52jRPf0AgOrzKpHmDd8/+/H2MTJVxIxTbnGMMAsSh363Uw82TnnF0e34QyLrWMs
         Igh7qMmRmBPyFFHqTIos6SF16DB85JQk3Y7QT0mCwcqXxV952glpAqBBQBS88ffmJN8h
         Z85A==
X-Gm-Message-State: APzg51BJ6WA7auAODQM2NwgMxxCWKOW6cT2287ZVs6VIxdDB0ZPQMKqp
        z8Kv8mM15t5BCk1dIxUrCGWup+fsamKwlGpPlaE=
X-Google-Smtp-Source: ANB0VdaBl26xYz1eNwgrE8mqQWL0MT9nxPkjO40Odu/7uaLpXM/JqG7nyCZzKklxjy8zdqA3EIkVJxCNukmuPeRxbao=
X-Received: by 2002:a9d:2645:: with SMTP id a63-v6mr358732otb.270.1536821734655;
 Wed, 12 Sep 2018 23:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180912161101.2634-1-vkuznets@redhat.com>
In-Reply-To: <20180912161101.2634-1-vkuznets@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Sep 2018 08:55:22 +0200
Message-ID: <CAJZ5v0jmNFaH3JUVS9W_1ofXcD=8U8Y9enPi+j+9U=6cBVxfJQ@mail.gmail.com>
Subject: Re: [PATCH] hyper-v: Fix wakeup from suspend-to-idle
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 6:11 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> It makes little sense but still possible to put Hyper-V guests into
> suspend-to-idle state. To wake them up two wakeup sources were registered
> in the past: hyperv-keyboard and hid-hyperv. However, since
> commit eed4d47efe95 ("ACPI / sleep: Ignore spurious SCI wakeups from
> suspend-to-idle") pm_wakeup_event() from these devices is ignored. Switch
> to pm_wakeup_hard_event() API as these devices are actually the only
> possible way to wakeup Hyper-V guests.
>
> Fixes: eed4d47efe95 (ACPI / sleep: Ignore spurious SCI wakeups from suspend-to-idle)
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/hid/hid-hyperv.c              | 2 +-
>  drivers/input/serio/hyperv-keyboard.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
> index b372854cf38d..704049e62d58 100644
> --- a/drivers/hid/hid-hyperv.c
> +++ b/drivers/hid/hid-hyperv.c
> @@ -309,7 +309,7 @@ static void mousevsc_on_receive(struct hv_device *device,
>                 hid_input_report(input_dev->hid_device, HID_INPUT_REPORT,
>                                  input_dev->input_buf, len, 1);
>
> -               pm_wakeup_event(&input_dev->device->device, 0);
> +               pm_wakeup_hard_event(&input_dev->device->device);
>
>                 break;
>         default:
> diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
> index 47a0e81a2989..a8b9be3e28db 100644
> --- a/drivers/input/serio/hyperv-keyboard.c
> +++ b/drivers/input/serio/hyperv-keyboard.c
> @@ -177,7 +177,7 @@ static void hv_kbd_on_receive(struct hv_device *hv_dev,
>                  * state because the Enter-UP can trigger a wakeup at once.
>                  */
>                 if (!(info & IS_BREAK))
> -                       pm_wakeup_event(&hv_dev->device, 0);
> +                       pm_wakeup_hard_event(&hv_dev->device);
>
>                 break;
>
> --
> 2.14.4
>
