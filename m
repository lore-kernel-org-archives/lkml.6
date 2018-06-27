Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442DBC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0FE248E6
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1WBfto+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF0FE248E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966092AbeF0VXy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 17:23:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966033AbeF0VXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 17:23:49 -0400
Received: from mail-yw0-f182.google.com (mail-yw0-f182.google.com [209.85.161.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81098244E3;
        Wed, 27 Jun 2018 21:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530134628;
        bh=C3PpiBRhgcJvs3jsJWwbiZzWKfAkJRfGton/zYKcjM8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=1WBfto+yDbfYaFNhg2XZ1zKGEfk2WFmCaUYdExdV2BkJCd+zZVpO9/B73cSxB864i
         1qOeRcg4zjQwSkN3O2XS8I7P0dnw80ZJxU+HFPC5pf3PbHlOVWpGgRCL0SVf68tfNh
         BhBOV9NVki1xQZedXXbvwsuAN+GcjFJC5MelEFaw=
Received: by mail-yw0-f182.google.com with SMTP id t18-v6so1225144ywg.2;
        Wed, 27 Jun 2018 14:23:48 -0700 (PDT)
X-Gm-Message-State: APt69E3ysjZargR2Zc8wveQbEx90Tbb+GVfXt0uRe+I3EyTd6iRyIFgO
        +ETZqh9yTM4tenUdTYGU6gM5ZEfG1/tZGJozc3Q=
X-Google-Smtp-Source: AAOMgpe3on8tTmDaw7TyABPNf1JA9oI5Tv/Fyqwb7/f6aMkOZ9jiqTnIFuoivA7ygPDsnnr1AlxyJQvLkgJBylWDuc0=
X-Received: by 2002:a0d:d451:: with SMTP id w78-v6mr531153ywd.370.1530134627741;
 Wed, 27 Jun 2018 14:23:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:8182:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 14:23:07
 -0700 (PDT)
In-Reply-To: <1569671.PEFH9RgftX@pcbe13614>
References: <4617134.5euanDEBgJ@pcbe13614> <22840601.TEhG8FuRZq@pcbe13614>
 <CANk1AXRFK8CYn_c7ckpJeXpFbc-CcZ+xzZiJzUsiDUUS7ancPA@mail.gmail.com> <1569671.PEFH9RgftX@pcbe13614>
From:   Alan Tull <atull@kernel.org>
Date:   Wed, 27 Jun 2018 16:23:07 -0500
X-Gmail-Original-Message-ID: <CANk1AXSmDWb=up_xDwvSg1SLS0iv6spcpcv42fSpM7+=Cy06wQ@mail.gmail.com>
Message-ID: <CANk1AXSmDWb=up_xDwvSg1SLS0iv6spcpcv42fSpM7+=Cy06wQ@mail.gmail.com>
Subject: Re: fpga: fpga_mgr_get() buggy ?
To:     federico.vaga@cern.ch
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 4:25 AM, Federico Vaga <federico.vaga@cern.ch> wrote:
> Hi Alan,
>
> On Tuesday, 26 June 2018 23:00:46 CEST Alan Tull wrote:
>> On Fri, Jun 22, 2018 at 2:53 AM, Federico Vaga
>> <federico.vaga@cern.ch> wrote:
>>
>> Hi Federico,
>>
>> >> > What is buggy is the function fpga_mgr_get().
>> >> > That patch has been done to allow multiple FPGA manager
>> >> > instances
>> >> > to be linked to the same device (PCI it says). But function
>> >> > fpga_mgr_get() will return only the first found: what about the
>> >> > others?
>>
>> I've had more time with this, I agree with you.  I didn't intend to
>> limit us to one manager per parent device.
>>
>> >> > Then, all load kernel-doc comments says:
>> >> >
>> >> > "This code assumes the caller got the mgr pointer from
>> >> > of_fpga_mgr_get() or fpga_mgr_get()"
>> >> >
>> >> > but that function does not allow me to get, for instance, the
>> >> > second FPGA manager on my card.
>> >> >
>> >> > Since, thanks to this patch I'm actually the creator of the
>> >> > fpga_manager structure,  I do not need to use fpga_mgr_get() to
>> >> > retrieve that data structure.
>> >> > Despite this, I believe we still need to increment the module
>> >> > reference counter (which is done by fpga_mgr_get()).
>> >> >
>> >> > We can fix this function by just replacing the argument from
>> >> > 'device' to 'fpga_manager' (the one returned by create() ).
>> >>
>> >> At first thought, that's what I'd want.
>> >>
>> >> > Alternatively, we
>> >> > can add an 'owner' field in "struct fpga_manager_ops" and 'get'
>> >> > it
>> >> > when we use it. Or again, just an 'owner' argument in the
>> >> > create()
>> >> > function.
>> >>
>> >> It seems like we shouldn't have to do that.
>> >
>> > Why?
>>
>> OK yes, I agree; the kernel has a lot of examples of doing this.
>>
>> I'll have to play with it, I'll probably add the owner arg to the
>> create function, add owner to struct fpga_manager, and save.
>
> I have two though about this.
>
> 1. file_operation like approach. The onwer is associated to the FPGA
> manager operation. Whenever the FPGA manager wants to use an operation
> it get/put the module owner of these operations (because this is what
> we need to protect). With this the user is not directly involved, read
> it as less code, less things to care about. And probably there is no
> need for fpga_manager_get().

How does try_module_get fit into this scheme?  I think this proposal
#1 is missing the point of what the reference count increment is meant
to do.  Or am I misunderstanding?  How does that keep the module from
being unloaded 1/3 way through programming a FPGA?  IIUC you are
saying that the reference count would be incremented before doing the
manager ops .write_init, then decremented again afterwards,
incremented before each call to .write, decremented afterwards, then
the same for .write_complete.

>
> 2. fpga_manager onwer, we can still play the game above but
> conceptually, from the user point of view, I see it like the driver
> that creates the fpga_manager instance becomes the owner of it.

I think that's what's happening.  And can continue to happen, adding
the owner parameter to fpga_mgr_create.

> I
> think that this is not true,

How do you figure that?  fpga_mgr_create() is called with pdev->dev
from each of the FPGA manager's probe functions.  It stores dev as the
parent: mgr->dev.parent = dev;

> the fpga_manager structure is completely
> used by the FPGA manager module and the driver use it as a token to
> access the FPGA manager API. I hope my point is clear :)
>
> I'm more for the solution 1.
>
>> >> > I'm proposing these alternatives because I'm not sure that
>> >> >
>> >> > this is correct:
>> >> >         if (!try_module_get(dev->parent->driver->owner))
>> >> >
>> >> > What if the device does not have a driver? Do we consider the
>> >> > following a valid use case?
>> >> >
>> >> >
>> >> > probe(struct device *dev) {
>> >> >
>> >> >   struct device *mydev;
>> >> >
>> >> >   mydev->parent = dev;
>> >> >   device_register(mydev);
>> >> >   fpga_mrg_create(mydev, ....);
>> >> >
>> >> > }
>>
>> Sure
>>
>> >> When would you want to do that?
>> >
>> > Not sure when, I'm in the middle of some other development and I
>> > stumbled into this issue. But of course I can do it ... at some
>> > point>
>> > :)
>>
>> I was meaning to ask something else.
>
> I see, you meant the example about the "virtual device" without
> driver. I do not have a true example, but this is a possible case I
> think we should support it or not (check this on register())

I think we should support this use, yes.

Alan

>
>> I don't mind writing this and would be interested in your review/
>> feedback.  Thanks again for seeing this and for the thoughtful
>> analysis.
>
> I'm here for any feedback/review :)
