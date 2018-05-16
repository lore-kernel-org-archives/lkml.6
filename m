Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbeEPVex (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 17:34:53 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:44250 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbeEPVev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 17:34:51 -0400
X-Google-Smtp-Source: AB8JxZoZaCfs9oml0JXudrc5PL0Ey3Yt1OTXs5bnpWOEDB4r3lVmivamQG4qfnjKINGfFf3RXmk2OintogazwG3bvxU=
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpKGhLrj-px1E3C_tq3_2GAxWpzSgr5TXJU7s8-jokf9g@mail.gmail.com>
References: <20180515090110.26820-1-peng.fan@nxp.com> <CAPDyKFpKGhLrj-px1E3C_tq3_2GAxWpzSgr5TXJU7s8-jokf9g@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 16 May 2018 23:34:50 +0200
X-Google-Sender-Auth: zFTxo7n29QdpHmN6HMYeHYV3V_s
Message-ID: <CAJZ5v0h7zaNtSC6UCLJ8xEGKMSuBiZ_oAyB8bk1ROWCuH_-K4g@mail.gmail.com>
Subject: Re: [RFC] platform: detach from PM domains on shutdown
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 11:52 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 15 May 2018 at 11:01, Peng Fan <peng.fan@nxp.com> wrote:
>> When reboot Linux, the PM domains attached to a device
>> are not shutdown. To SoCs which relys on reset the whole SoC,
>> there is no need to shutdown PM domains, but to Linux running
>> in a virtual machine with devices pass-through, we could not
>> reset the whole SoC. Currently we need Linux to shutdown its
>> PM domains when reboot.
>
> I am not sure I understand exactly why the PM domain needs to be
> shutdown for these cases, could you please elaborate a bit on that.
>
> BTW, what platform are you running on and also what PM domains are being used?
>
> Anyway, it seems like there may be need for certain cases, but
> certainly not all - especially since it may slow down the shutdown
> process, when not needed.
>
> Can we make this runtime configurable, via sysfs or whatever that makes sense!?
>
>>
>> commit 2d30bb0b3889 ("platform: Do not detach from PM domains on shutdown"),
>> removes what this patch tries to add, because of a warning.
>> commit e79aee49bcf9 ("PM: Avoid false-positive warnings in dev_pm_domain_set()")
>> already fixes the false alarm warning. So let's detach the power domain
>> to shutdown PM domains after driver shutdown.
>>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>
>> I do not find a better place to shutdown power domain when reboot Linux,
>> so add back the line that commit 2d30bb0b3889 removes, because it is
>> a false alarm warning as commit e79aee49bcf9 describes.
>>
>>  drivers/base/platform.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
>> index 8075ddc70a17..a5929f24dc3c 100644
>> --- a/drivers/base/platform.c
>> +++ b/drivers/base/platform.c
>> @@ -616,6 +616,7 @@ static void platform_drv_shutdown(struct device *_dev)
>>
>>         if (drv->shutdown)
>>                 drv->shutdown(dev);
>> +       dev_pm_domain_detach(_dev, true);
>
> This would somewhat work, but only for platform devices. To make this
> fully work, we need to call dev_pm_domain_detach() from amba, spi, etc
> as well.
>
> Perhaps another option to manage this more generally, an without
> having detach devices, could be to extend the struct dev_pm_domain
> with a new callback, "->shutdown()" and then make the driver core call
> it from device_shutdown().

I'm sensing a possible ordering slippery slope with this (it will only
work if all of the drivers/bus types etc do the right thing in their
->shutdown callbacks so nothing depends on the domain going forward).

> Typically, for genpd, I would probably count the number of calls being
> made to ->shutdown() per PM domain, then when it reaches the number of
> attached devices to it, allow to power off it.
>
> Let's see what Rafael thinks about it.

I'm not sure about the use case.  The hypervisor should be able to
take care of turning power domains off on the client OS reboot in
theory.  If the client OS leaving the hypervisor needs to worry about
what state it leaves behind, the design of the hypervisor is sort of
questionable IMO.
