Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9327ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C87C2098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C87C2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732560AbeISVKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:10:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728054AbeISVKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:10:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0FD99C05093A;
        Wed, 19 Sep 2018 15:31:47 +0000 (UTC)
Received: from [10.36.117.87] (ovpn-117-87.ams2.redhat.com [10.36.117.87])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 388C67DEF0;
        Wed, 19 Sep 2018 15:31:45 +0000 (UTC)
Subject: Re: [PATCH/RFC v4 2/2] vfio: platform: Add generic reset controller
 support
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alex Williamson <alex.williamson@redhat.com>,
        KVM list <kvm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180917163955.19023-1-geert+renesas@glider.be>
 <20180917163955.19023-3-geert+renesas@glider.be>
 <b7c4f5d1-020b-4a64-d511-b8e89f8c9196@redhat.com>
 <CAMuHMdXM9eog_+1oV_YCmSbOfBSFWOXy+YXwKGvfJA65rDqtzA@mail.gmail.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <9dc74e23-2f57-7db3-6fb6-4f75ed61575f@redhat.com>
Date:   Wed, 19 Sep 2018 17:31:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXM9eog_+1oV_YCmSbOfBSFWOXy+YXwKGvfJA65rDqtzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 19 Sep 2018 15:31:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 9/19/18 2:54 PM, Geert Uytterhoeven wrote:
> Hi Eric,
> 
> On Wed, Sep 19, 2018 at 2:36 PM Auger Eric <eric.auger@redhat.com> wrote:
>> On 9/17/18 6:39 PM, Geert Uytterhoeven wrote:
>>> Vfio-platform requires dedicated reset support, provided either by ACPI,
>>> or, on DT platforms, by a device-specific reset driver matching against
>>> the device's compatible value.
>>>
>>> On many SoCs, devices are connected to an SoC-internal reset controller.
>>> If the reset hierarchy is described in DT using "resets" properties, or
>>> in lookup tables in platform code, such devices can be reset in a
>>> generic way through the reset controller subsystem.  Hence add support
>>> for this, avoiding the need to write device-specific reset drivers for
>>> each single device on affected SoCs.
>>>
>>> Devices that do require a more complex reset procedure can still provide
>>> a device-specific reset driver, as that takes precedence.
>>>
>>> Note that this functionality depends on CONFIG_RESET_CONTROLLER=y, and
>>> becomes a no-op (as in: "No reset function found for device") if reset
>>> controller support is disabled.
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
>>> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> 
>>> --- a/drivers/vfio/platform/vfio_platform_common.c
>>> +++ b/drivers/vfio/platform/vfio_platform_common.c
> 
>>> @@ -128,8 +131,16 @@ static int vfio_platform_get_reset(struct vfio_platform_device *vdev)
>>>               vdev->of_reset = vfio_platform_lookup_reset(vdev->compat,
>>>                                                       &vdev->reset_module);
>>>       }
>>> +     if (vdev->of_reset)
>>> +             return 0;
>>> +
>>> +     rstc = reset_control_get_dedicated(vdev->device, NULL);
>>> +     if (!IS_ERR(rstc)) {
>>> +             vdev->reset_control = rstc;
>>> +             return 0;
>>> +     }
>>>
>>> -     return vdev->of_reset ? 0 : -ENOENT;
>>> +     return PTR_ERR(rstc);
>> This changes the returned value as seen by the user (probe returned
>> valud). Can we keep -ENOENT in case of no reset controller found?
> 
> On success, it still returns 0.
> On failure, it forwards the error from reset_control_get_dedicated(), which
> is IMHO better than replacing it by -ENOENT: we try to propagate error
> codes as much as possible.  It could e.g. return -EPROBE_DEFER.
> 
> Is there anything that relies on the function returning -ENOENT?
None I am aware of actually. I was afraid about compatibility break but
here we would change an errno by another one so maybe that's not a big
deal at that stage of vfio_platform usage?

Thanks

Eric
> 
>> Otherwise looks good to me with the new "dedicated" reset semantics.
> 
> Thanks!
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
