Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5FBECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FBE02084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYoKUmQQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FBE02084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730096AbeGRU1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 16:27:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728929AbeGRU1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 16:27:30 -0400
Received: from mail-yw0-f174.google.com (mail-yw0-f174.google.com [209.85.161.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FB542084E;
        Wed, 18 Jul 2018 19:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531943286;
        bh=wfBQ+XBa2tQ8Oi4OD2R1KFRyyV5yXdfsnPZL1RhcgVo=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=dYoKUmQQztBrf5dOJoJknTQzHwcW6S7bzFjnVZEPnIveAAS1qzneYuo6p3t6sAjOs
         SG3Xbys7xDpGJiuh1wlGQFz/yXHXJHMUaTKmM/6iRq/+UAP0Bxm0ckfETJCppZnYKG
         NWf2QtrW3GpoSpvQyjxE3yRP9pIif2vDBDjESB98=
Received: by mail-yw0-f174.google.com with SMTP id j68-v6so2181579ywg.1;
        Wed, 18 Jul 2018 12:48:06 -0700 (PDT)
X-Gm-Message-State: AOUpUlErhY62nEWLmKOLtXCTdUHBFyvPc3yW59DQfQ0dvevVRn4OOBs6
        hxqQQGdGBOLtN34HHFqui2rqyYdlxg/JZ+8Bsnw=
X-Google-Smtp-Source: AAOMgpcEr3tuSQxS5OaOcSjXeo2ws9X+rpdR9IMbR11iHd6qvrRSYzGDCsAEmAnRBUnT0fGABZp+hV0D/rk5ffflzwI=
X-Received: by 2002:a81:94c5:: with SMTP id l188-v6mr3682691ywg.463.1531943285314;
 Wed, 18 Jul 2018 12:48:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:8182:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 12:47:24
 -0700 (PDT)
In-Reply-To: <2419388.jt6midSiEu@pcbe13614>
References: <4617134.5euanDEBgJ@pcbe13614> <1569671.PEFH9RgftX@pcbe13614>
 <CANk1AXSmDWb=up_xDwvSg1SLS0iv6spcpcv42fSpM7+=Cy06wQ@mail.gmail.com> <2419388.jt6midSiEu@pcbe13614>
From:   Alan Tull <atull@kernel.org>
Date:   Wed, 18 Jul 2018 14:47:24 -0500
X-Gmail-Original-Message-ID: <CANk1AXSd7V03w=uPuo+HiibxmD9_JwaTZyx4uRJ_OfXB4o-_Cw@mail.gmail.com>
Message-ID: <CANk1AXSd7V03w=uPuo+HiibxmD9_JwaTZyx4uRJ_OfXB4o-_Cw@mail.gmail.com>
Subject: Re: fpga: fpga_mgr_get() buggy ?
To:     federico.vaga@cern.ch
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 2:50 AM, Federico Vaga <federico.vaga@cern.ch> wrote:
> On Wednesday, 27 June 2018 23:23:07 CEST Alan Tull wrote:
>> On Wed, Jun 27, 2018 at 4:25 AM, Federico Vaga
> <federico.vaga@cern.ch> wrote:
>> > Hi Alan,
>> >
>> > On Tuesday, 26 June 2018 23:00:46 CEST Alan Tull wrote:
>> >> On Fri, Jun 22, 2018 at 2:53 AM, Federico Vaga
>> >> <federico.vaga@cern.ch> wrote:
>> >>
>> >> Hi Federico,
>> >>
>> >> >> > What is buggy is the function fpga_mgr_get().
>> >> >> > That patch has been done to allow multiple FPGA manager
>> >> >> > instances
>> >> >> > to be linked to the same device (PCI it says). But function
>> >> >> > fpga_mgr_get() will return only the first found: what about
>> >> >> > the
>> >> >> > others?

Looking at this further, no code change is needed in the FPGA API to
support multiple managers.  A FPGA manager driver is a self-contained
platform driver.  The PCI driver for a board that contains multiple
FPGAs should create a platform device for each manager and save each
of those devs in its pdata.

>> >> >> > Then, all load kernel-doc comments says:
>> >> >> >
>> >> >> > "This code assumes the caller got the mgr pointer from
>> >> >> > of_fpga_mgr_get() or fpga_mgr_get()"
>> >> >> >
>> >> >> > but that function does not allow me to get, for instance,
>> >> >> > the
>> >> >> > second FPGA manager on my card.

fpga_mgr_get() will do what you want if your PCI driver creates a
platform device per FPGA manager as mentioned above.

>> >> >> > Since, thanks to this patch I'm actually the creator of the
>> >> >> > fpga_manager structure,  I do not need to use fpga_mgr_get()
>> >> >> > to
>> >> >> > retrieve that data structure.

The creator of the FPGA mgr structure is the low level FPGA manager
driver, not the PCIe driver.

>> >> >> > Despite this, I believe we still need to increment the
>> >> >> > module
>> >> >> > reference counter (which is done by fpga_mgr_get()).

This is only done in the probe function of a FPGA region driver.

>> >> >> >
>> >> >> > We can fix this function by just replacing the argument from
>> >> >> > 'device' to 'fpga_manager' (the one returned by create() ).
>> >> >>
>> >> >> At first thought, that's what I'd want.
>> >> >>
>> >> >> > Alternatively, we
>> >> >> > can add an 'owner' field in "struct fpga_manager_ops" and
>> >> >> > 'get'
>> >> >> > it
>> >> >> > when we use it. Or again, just an 'owner' argument in the
>> >> >> > create()
>> >> >> > function.
>> >> >>
>> >> >> It seems like we shouldn't have to do that.
>> >> >
>> >> > Why?
>> >>
>> >> OK yes, I agree; the kernel has a lot of examples of doing this.
>> >>
>> >> I'll have to play with it, I'll probably add the owner arg to the
>> >> create function, add owner to struct fpga_manager, and save.
>> >
>> > I have two though about this.
>> >
>> > 1. file_operation like approach. The onwer is associated to the
>> > FPGA manager operation. Whenever the FPGA manager wants to use an
>> > operation it get/put the module owner of these operations
>> > (because this is what we need to protect). With this the user is
>> > not directly involved, read it as less code, less things to care
>> > about. And probably there is no need for fpga_manager_get().
>>
>> How does try_module_get fit into this scheme?  I think this proposal
>> #1 is missing the point of what the reference count increment is
>> meant to do.  Or am I misunderstanding?  How does that keep the
>> module from being unloaded 1/3 way through programming a FPGA?
>> IIUC you are saying that the reference count would be incremented
>> before doing the manager ops .write_init, then decremented again
>> afterwards, incremented before each call to .write, decremented
>> afterwards, then the same for .write_complete.
>
> I'm not saying to do module_get/put just around the mops->XXX(): it's
> too much. Just where you have this comment:
>
> "This code assumes the caller got the mgr pointer from
> of_fpga_mgr_get() or fpga_mgr_get()"
>
> Because, currently, it's here where we do module_get()

No it's not.

fpga_mgr_get() or of_fpga_mgr_get() is called when the region is
created such as in of-fpga-region's probe.  That way, as long as the
region exists, the manager won't be unloaded.  If someone wants to
start unloading modules, they need to unload higher level ones first,
so they'll have to unload the region before mgr.

>
> Most mops are invoked within a set of static functions which are
> called only by few exported functions. I'm suggesting to do
> module_get/put in those exported function at the beginning (get) and
> and the end (put) because we know that within these functions, here
> and there, we will use mops which are owned by a different module.
> We do not want the module owner of the mops to disappear while someone
> is doing fpga_mgr_load(). For example, inside fpga_mgr_load() we use
> most of the mops, so we 'get' the module at the beginning and 'put' it
> at the end. The same for fpga_region_program_fpga().

If we do it the way you are suggesting, then someone can unload the
manager module without unloading the region.  The region code will be
in for a nasty surprise when programming is attempted.

> Like this we do not have to ask users to do fpga_mgr_get()/put().

The only user who has to do this is a region's probe function.

I'm assuming that only fpga_region is using fpga_mgr_load() and
anybody who is creating a region uses fpga_region_program_fpga().
That's what I want to encourage anyway.  I should probably move
fpga_mgr_load to a private header.

>
> <Parenthesis>
> fpga_region_program_fpga() does not do (today) fpga_mgr_get() because
> it assumes, but it is not enforced, that both fpga_region and fpga_mgr
> are child of the same device.

fpga_region_program_fpga() doesn't do fpga_mgr_get() becuase
fpga_mgr_get() happens when the fpga_region probes.  The assumption I
am making is that nobody other than a region is calling
fpga_manager_load().  I should create a fpga_private.h and move
fpga_manager_load() out of fpga-mgr.h to make that official.

> Probably this is true 99.99% of the
> time.
> Let me open in parallel another point: why fpga_region is not a child
> of fpga_manager?

FPGA regions are children of FPGA bridges.

Alan
