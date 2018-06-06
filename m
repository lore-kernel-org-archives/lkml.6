Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TR64essH"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E52A8605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932349AbeFFHAr (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 03:00:47 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:40902 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932290AbeFFHAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 03:00:44 -0400
X-Google-Smtp-Source: ADUXVKLCwxuAkfvug4Nfv2/8IL+/lghfa4o+d4bJ7NjHssZoVHquNinoFWUl7k01JveJNeerL8fKDpRDPApfO1aKE/k=
MIME-Version: 1.0
In-Reply-To: <20180604182612.72699-1-ravisadineni@chromium.org>
References: <20180604182612.72699-1-ravisadineni@chromium.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Jun 2018 09:00:43 +0200
X-Google-Sender-Auth: r7gwPg2AQtN6nTcibNTaP6zk2Oo
Message-ID: <CAJZ5v0jBTpUzqEj1CeQ0CKH7zVRkgj1qJffoSujEZWi0HXABXw@mail.gmail.com>
Subject: Re: [PATCH] ACPI LID: increment wakeup count only when notified.
To: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Ravi Chandra Sadineni <ravisadineni@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Todd Broch <tbroch@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Benson Leung <bleung@google.com>,
        Furquan Shaikh <furquan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 8:26 PM, Ravi Chandra Sadineni
<ravisadineni@chromium.org> wrote:
> Currently ACPI LID increments wakeup count irrespective of the wake source.
> This is because we call acpi_lid_initialize_state on every resume.

I don't quite understand the connection between the two sentences
above.  Care to clarify?

> Userland deamons using wakeup_count to identify the potential wake
> source for the last wake will be thrown off by this. Instead increment
> the wakeup count only when there is a FIXED_HARDWARE/NOTFIY_STATUS event.
>
> Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> ---
>  drivers/acpi/button.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index f1cc4f9d31cd9..d40fef7241f08 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -235,9 +235,6 @@ static int acpi_lid_notify_state(struct acpi_device *device, int state)
>                 button->last_time = ktime_get();
>         }
>
> -       if (state)
> -               acpi_pm_wakeup_event(&device->dev);
> -
>         ret = blocking_notifier_call_chain(&acpi_lid_notifier, state, device);
>         if (ret == NOTIFY_DONE)
>                 ret = blocking_notifier_call_chain(&acpi_lid_notifier, state,
> @@ -417,6 +414,7 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
>                 /* fall through */
>         case ACPI_BUTTON_NOTIFY_STATUS:
>                 input = button->input;
> +               acpi_pm_wakeup_event(&device->dev);

Not really.

There already is an acpi_pm_wakeup_event() call in the else branch below.

>                 if (button->type == ACPI_BUTTON_TYPE_LID) {
>                         mutex_lock(&button->input->mutex);
>                         users = button->input->users;
> @@ -426,7 +424,6 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
>                 } else {
>                         int keycode;
>
> -                       acpi_pm_wakeup_event(&device->dev);
>                         if (button->suspended)
>                                 break;
>
> --
