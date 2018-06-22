Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C8AC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03BD623C30
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIBCT3xZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03BD623C30
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934292AbeFVCIZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 22:08:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934181AbeFVCIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 22:08:23 -0400
Received: from mail-yw0-f169.google.com (mail-yw0-f169.google.com [209.85.161.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA5C123C30;
        Fri, 22 Jun 2018 02:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529633303;
        bh=uqNCsLvZ4oYVeWTldEROQfN2ozzAbo55X2r86a3vvVI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=UIBCT3xZT2e1C4UJ/aocbCedPACoYqN/p53dz8Ib3cNpDOmzShf5MpKHRbWvvzchP
         AYorWD53rJyOq3f0Wb8CJUmm4AZaSdajc+GHwAHdRRYooTfk6yovJuA6o+EU56SF1O
         vU12ghwthWYKTQbaDBhHFPf9Jyt/eaAuSLvhFcXQ=
Received: by mail-yw0-f169.google.com with SMTP id b125-v6so1889567ywe.1;
        Thu, 21 Jun 2018 19:08:22 -0700 (PDT)
X-Gm-Message-State: APt69E2POMSGBjMZMNnaDK/VLQBqjookdW7jFsmPvVed2P2PuJ2xOAz6
        ZjY0piMIZqDn7S1+re36JGiXITIWlXx8DO2Dc2o=
X-Google-Smtp-Source: ADUXVKLooSbOpPNkdjijh0EONwTWOlmEA4UgDZ/cjXb64s1W5iX86lhlFPAfD2uFk1ryMiRNbgveHA0cbpfY3wiHQYw=
X-Received: by 2002:a81:94c5:: with SMTP id l188-v6mr13119536ywg.463.1529633302126;
 Thu, 21 Jun 2018 19:08:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:b89:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 19:07:41 -0700 (PDT)
In-Reply-To: <4617134.5euanDEBgJ@pcbe13614>
References: <4617134.5euanDEBgJ@pcbe13614>
From:   Alan Tull <atull@kernel.org>
Date:   Thu, 21 Jun 2018 21:07:41 -0500
X-Gmail-Original-Message-ID: <CANk1AXQ6cZnxN5tXckZektnbfWixPhS8+VitMZ4fcMyAcQzfqA@mail.gmail.com>
Message-ID: <CANk1AXQ6cZnxN5tXckZektnbfWixPhS8+VitMZ4fcMyAcQzfqA@mail.gmail.com>
Subject: Re: fpga: fpga_mgr_get() buggy ?
To:     federico.vaga@cern.ch
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 8:13 AM, Federico Vaga <federico.vaga@cern.ch> wrote:

Hi Federico,

Thanks for the analysis.  I'll probably not be able to look into this
very much until next week.  A few notes below.

> Hello,
>
> I believe that this patch
>
> fpga: manager: change api, don't use drvdata
> 7085e2a94f7df5f419e3cfb2fe809ce6564e9629
>
> is incomplete and buggy.
>
> I completely agree that drvdata should not be used by the FPGA manager
> or any other subsystem like that.
>
> What is buggy is the function fpga_mgr_get().
> That patch has been done to allow multiple FPGA manager instances to
> be linked to the same device (PCI it says). But function
> fpga_mgr_get() will return only the first found: what about the
> others?

I was thinking it was going to be one manager per device which makes
sense if the device corresponds to a single FPGA.  But I could see
that there could be valid use cases that had more than one FPGA such
as on a PCI card.

>
> Then, all load kernel-doc comments says:
>
> "This code assumes the caller got the mgr pointer from
> of_fpga_mgr_get() or fpga_mgr_get()"
>
> but that function does not allow me to get, for instance, the second
> FPGA manager on my card.
>
> Since, thanks to this patch I'm actually the creator of the
> fpga_manager structure,  I do not need to use fpga_mgr_get() to
> retrieve that data structure.
> Despite this, I believe we still need to increment the module
> reference counter (which is done by fpga_mgr_get()).
>
> We can fix this function by just replacing the argument from 'device'
> to 'fpga_manager' (the one returned by create() ).

At first thought, that's what I'd want.

> Alternatively, we
> can add an 'owner' field in "struct fpga_manager_ops" and 'get' it
> when we use it. Or again, just an 'owner' argument in the create()
> function.

It seems like we shouldn't have to do that.

> I'm proposing these alternatives because I'm not sure that
> this is correct:
>
>         if (!try_module_get(dev->parent->driver->owner))
>
> What if the device does not have a driver? Do we consider the
> following a valid use case?
>
>
> probe(struct device *dev) {
>   struct device *mydev;
>
>   mydev->parent = dev;
>   device_register(mydev);
>   fpga_mrg_create(mydev, ....);
> }

When would you want to do that?

Alan

>
>
> thanks :)
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
