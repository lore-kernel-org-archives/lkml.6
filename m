Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA460C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 06:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B749217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 06:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548225378;
	bh=G5Nu4KC7aStnJzW0q9qVjgb6XlNxD99cdWE8vkurDDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0QsMy2rdLMKDMZqbKhp0GdstTiH+SZgHhOAbLJf/PVI1Jr5LUS9B4HnpwBGUTzEKo
	 FNjoeIm/Jv5bQcNZ90Cq1X445KFiG/e1Sit/TTm17Dc3N+Rwo40CKinlgKkuFE3Czl
	 AHXTwD6r4Gyk7Q1s2vewMAckYywkP8wvdPmYr2x4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfAWGgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 01:36:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:47220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfAWGgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 01:36:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FC7321019;
        Wed, 23 Jan 2019 06:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548225376;
        bh=G5Nu4KC7aStnJzW0q9qVjgb6XlNxD99cdWE8vkurDDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=casrl0U5nas/enHkzSRvgaUVeJVq+TZtafTwtP3BT2VYquywPywwiqSY1u1+B+8ts
         DUfgXOVVJ5yG4I2YwKF1MVGyanD1kuZOqpCzKja8Of051oLkISnvfW4nBn5F5s1OKp
         UxqRmKl0M4mDhl6SfaDXpET4R4B4Z767n1528PiU=
Date:   Wed, 23 Jan 2019 07:36:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Torokhov <dtor@google.com>
Cc:     Rajat Jain <rajatja@google.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alex Hung <alex.hung@canonical.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>,
        chethan.tumkur.narayan@intel.com,
        "Ghorai, Sukumar" <sukumar.ghorai@intel.com>
Subject: Re: [PATCH v4 1/5] usb: split code locating ACPI companion into port
 and device
Message-ID: <20190123063613.GA25652@kroah.com>
References: <20181117010748.24347-1-rajatja@google.com>
 <20190118223407.64818-1-rajatja@google.com>
 <C103ADA0-68A0-4571-AE47-1744E64E0D7E@holtmann.org>
 <CACK8Z6FzWTZ_SYCBqGsOcf2xzSp3+W9HD-1inyRtJ=Wqsww8Pw@mail.gmail.com>
 <CAE_wzQ8C4KTpLWVvw4J-YhjzrUDOW4c+4bJmGStTR=BEdidkWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE_wzQ8C4KTpLWVvw4J-YhjzrUDOW4c+4bJmGStTR=BEdidkWQ@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 02:42:26PM -0800, Dmitry Torokhov wrote:
> On Tue, Jan 22, 2019 at 2:29 PM Rajat Jain <rajatja@google.com> wrote:
> >
> > Hi Marcel,
> >
> > On Sat, Jan 19, 2019 at 11:51 AM Marcel Holtmann <marcel@holtmann.org> wrote:
> > >
> > > Hi Rajat,
> > >
> > > > In preparation for handling embedded USB devices let's split
> > > > usb_acpi_find_companion() into usb_acpi_find_companion_for_device() and
> > > > usb_acpi_find_companion_for_port().
> > > >
> > > > Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> > > > Signed-off-by: Rajat Jain <rajatja@google.com>
> > > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Tested-by: Sukumar Ghorai <sukumar.ghorai@intel.com>
> > > > ---
> > > > v4: Add Acked-by and Tested-by in signatures.
> > > > v3: same as v1
> > > > v2: same as v1
> > > >
> > > > drivers/usb/core/usb-acpi.c | 133 +++++++++++++++++++-----------------
> > > > 1 file changed, 72 insertions(+), 61 deletions(-)
> > >
> > > what is the plan here? I take this via bluetooth-next tree?
> >
> > Yes, I'd think that would be the best plan. Dmitry / Greg - do you
> > have any objections / suggestions?
> 
> That's up to Greg, but since he'd acked the patches I'd assume he's OK
> with taking it through bluetooth. As an option Marcel could cut an
> immutable branch off 4.20 with the first 2 patches so that he and Greg
> can both pull it into their main branches and then git will do the
> right thing when Linus pulls from them. Lee uses quite a bit of them
> in MFD and other maintainers are known to occasionally make them for
> work that needs to be shared between trees.

I don't need to take these, they can all go through one tree, which is
why I gave my ack to the patch.

thanks,

greg k-h
