Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072FEECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71512098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71512098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732557AbeISVGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:06:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41962 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731661AbeISVGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:06:54 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 507AF3091D66;
        Wed, 19 Sep 2018 15:28:27 +0000 (UTC)
Received: from [10.36.117.87] (ovpn-117-87.ams2.redhat.com [10.36.117.87])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E3ACC178E;
        Wed, 19 Sep 2018 15:28:22 +0000 (UTC)
Subject: Re: [PATCH/RFC v4 1/2] reset: Add support for dedicated reset
 controls
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
 <20180917163955.19023-2-geert+renesas@glider.be>
 <727f9a0b-79bb-dea9-1da7-12ef58e8081b@redhat.com>
 <CAMuHMdUFY8CMfb9P=8Tox31_dUzau-jB7YHgYo6jffQ4L7GBqA@mail.gmail.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <6a0b6cc8-d299-0f9b-46bc-ebbd9e5b76e9@redhat.com>
Date:   Wed, 19 Sep 2018 17:28:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUFY8CMfb9P=8Tox31_dUzau-jB7YHgYo6jffQ4L7GBqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 19 Sep 2018 15:28:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 9/19/18 3:16 PM, Geert Uytterhoeven wrote:
> Hi Eric,
> 
> On Wed, Sep 19, 2018 at 2:09 PM Auger Eric <eric.auger@redhat.com> wrote:
>> On 9/17/18 6:39 PM, Geert Uytterhoeven wrote:
>>> In some SoCs multiple hardware blocks may share a reset control.
>>> The existing reset control API for shared resets will only assert such a
>>> reset when the drivers for all hardware blocks agree.
>>> The existing exclusive reset control API still allows to assert such a
>>> reset, but that impacts all other hardware blocks sharing the reset.
>>>
>>> Sometimes a driver needs to reset a specific hardware block, and be 100%
>>> sure it has no impact on other hardware blocks.  This is e.g. the case
>>> for virtualization with device pass-through, where the host wants to
>>> reset any exported device before and after exporting it for use by the
>>> guest, for isolation.
>>>
>>> Hence a new flag for dedicated resets is added to the internal methods,
>>> with a new public reset_control_get_dedicated() method, to obtain an
>>> exclusive handle to a reset that is dedicated to one specific hardware
>>> block.
>>>
>>> This supports both DT-based and lookup-based reset controls.
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> ---
>>> v4:
>>>   - New.
>>>
>>> Notes:
>>>   - Dedicated lookup-based reset controls were not tested,
>>>   - Several internal functions now take 3 boolean flags, and should
>>>     probably be converted to take a bitmask instead,
>>>   - I think __device_reset() should call __reset_control_get() with
>>>     dedicated=true.  However, that will impact existing users,
>>
>> why should it?
> 
> device_reset{,_optional}() are supposed to reset the passed device.
> If the reset is not dedicated, doing so will reset other devices, too.
ok, that's not obvious too me but I am not familiar enough with the API
and existing callers.
> 
>>> --- a/drivers/reset/core.c
>>> +++ b/drivers/reset/core.c
>>> @@ -459,9 +459,38 @@ static void __reset_control_put_internal(struct reset_control *rstc)
>>>       kref_put(&rstc->refcnt, __reset_control_release);
>>>  }
>>>
>>> +static bool __of_reset_is_dedicated(const struct device_node *node,
>>> +                                 const struct of_phandle_args args)
>>> +{
>>> +     struct of_phandle_args args2;
>>> +     struct device_node *node2;
>>> +     int index, ret;
>>> +
>>> +     for_each_node_with_property(node2, "resets") {
>>> +             if (node == node2)
>>> +                     continue;
>>> +
>>> +             for (index = 0; ; index++) {
>>> +                     ret = of_parse_phandle_with_args(node2, "resets",
>>> +                                                      "#reset-cells", index,
>>> +                                                      &args2);
>>> +                     if (ret)
>>> +                             break;
>>> +
>>> +                     if (args2.np == args.np &&
>>> +                         args2.args_count == args.args_count &&
>>> +                         !memcmp(args2.args, args.args,
>>> +                                 args.args_count * sizeof(args.args[0])))
>>> +                             return false;
>> You need to call of_node_put(args2.np) (see of_parse_phandle_with_args
>> kernel doc)
> 
> Thanks, nice catch!
> 
>> Isn't it sufficient to check device_node handles are equal?
> 
> That would make it work with #reset-cells == 0 only.
> If #reset-cells > 0, the reset line specifier includes extra arguments.
> 
> On the Renesas SoCs I'm using, there's a single reset controller, so
> args.np is always the same.  The actual reset line is specified by
> args.args[0].  See the "resets" properties in e.g.
> https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/tree/arch/arm64/boot/dts/renesas/r8a7795.dtsi
OK get it now. Thank you for the explanations.

Best Regards

Eric
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
