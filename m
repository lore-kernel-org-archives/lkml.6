Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF77C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203B7216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F1esG1jm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203B7216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbeI1Fh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:37:58 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34747 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeI1Fh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 01:37:58 -0400
Received: by mail-lj1-f196.google.com with SMTP id f8-v6so4075938ljk.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 16:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H2s5GCw1GT4ZrUyJaOfk7DOsbdebI1eX9q1IxtdMl58=;
        b=F1esG1jmw0sPY5Qod+TJ+6hjY3rl7hYNUbZeXkNqanBKyw59Mq3gB2WEC3MdZB/K16
         4e4i77sNNDZmJHrXrzpmtkoI6juTzhgCZflt1Zkuo/ScSg5swqCW/toEh0Nbd0UMIELg
         zgT24Q51pEuIXvExUJI4KzNphyxXDN8wcAlUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H2s5GCw1GT4ZrUyJaOfk7DOsbdebI1eX9q1IxtdMl58=;
        b=p8UQskgVFRka8RzDHzBloJB5gwK9IfemieGJw+nWW2d6MYV/aLV1tH+X28tEEXaEyC
         /HsFaZsZjGuoZDondxhqgHeDkzoHa5RYYbxyczkFrLtWzK7dEB+C+qPpwAu3LhDK6g13
         s37EvhwQzN3hNbj3WNKqp7EOdBVhrR3ZnEyfO5U26ChSWecD79K6fTCZgf7D33bSxaLs
         UxHs2xq+4TPwhKfxVGIYPpdFDHsrbO49bAMD+SITtNHIkNeZ3JHdjiHplmK3XnWOHhS6
         M6qeUs/KpUNciU64mLvURDu2Y3Ig4Wh4xdju1va1tdpi+KxyHGtJxyMGFjpVpDXyOyMH
         d/DQ==
X-Gm-Message-State: ABuFfoh3kZ7eFhOqi1Xx3RmjiFDCavbRt1gOR9trkfvXIzv69PLXGdK8
        8cUJldZMZ1PSiCvBjhy28EfaSR9C0js=
X-Google-Smtp-Source: ACcGV60nvJKcHOPJ1JUiAnmJJKjB6GecW1d0vmAdzpdRrw1BLL3bAgTwGZ3KmdUuPOp4+MP/tQCn4Q==
X-Received: by 2002:a2e:810e:: with SMTP id d14-v6mr1872267ljg.170.1538090233183;
        Thu, 27 Sep 2018 16:17:13 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id a18-v6sm653427ljk.80.2018.09.27.16.17.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 16:17:11 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id y17-v6so4031469ljy.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 16:17:10 -0700 (PDT)
X-Received: by 2002:a2e:9c89:: with SMTP id x9-v6mr9724169lji.110.1538090230315;
 Thu, 27 Sep 2018 16:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180808224454.243790-1-evgreen@chromium.org> <6dd8a547-7260-09b8-9096-8a1564b08e70@intel.com>
 <8fd05b2d-fa48-78af-6f1c-7e485c1008f6@intel.com> <CAD=FV=W7h_3LwV-P5_E58-3qOo7Y-yQDTDfSLoU1+3c_6ZF0cg@mail.gmail.com>
 <yq1h8idgj5y.fsf@oracle.com> <CAD=FV=WNHDd8icQi3wtFV98w1zdEd-QqFn1PrZeXQWgYt4Yo1w@mail.gmail.com>
 <CAE=gft57aP3Qx-zdHR1UsJwS7JjVEpVvmCSTk3ctWrRF2=W4ww@mail.gmail.com>
 <SN6PR04MB4925DAB09EED762CDCCBBF47FC140@SN6PR04MB4925.namprd04.prod.outlook.com>
 <20180927140133.GA22096@infradead.org>
In-Reply-To: <20180927140133.GA22096@infradead.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 27 Sep 2018 16:16:33 -0700
X-Gmail-Original-Message-ID: <CAE=gft5sgayo8CUOp7WfA5Vs1Pp2YR0OayyUvxOMtHEXzDJwRw@mail.gmail.com>
Message-ID: <CAE=gft5sgayo8CUOp7WfA5Vs1Pp2YR0OayyUvxOMtHEXzDJwRw@mail.gmail.com>
Subject: Re: [PATCH v4] scsi: ufs: Make sysfs attributes writable
To:     hch@infradead.org
Cc:     Avri.Altman@wdc.com, Doug Anderson <dianders@chromium.org>,
        martin.petersen@oracle.com,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        jejb@linux.vnet.ibm.com, Stanislav.Nijnikov@wdc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bart.VanAssche@wdc.com, adrian.hunter@intel.com,
        sayali <sayalil@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 7:01 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Sep 27, 2018 at 06:32:47AM +0000, Avri Altman wrote:
> > Also, in this context there is the series in
> > https://www.spinics.net/lists/linux-scsi/msg123479.html
> > which allows to send UPIUs via a bsg device.
> >
> > It's not a provisioning series per-se like Evan's and Sayali's.
> > It covers the provisioning functionality,
> > But also allow to send task management UPIU, and UIC commands,
> > Which can be used for testing and validation.
>
> And as someone having been involved with review of a few different
> UFS provisioning bits this is what I think we should be merging.
>
> Instead of being in a rat race of adding ever new sysfs or configfs
> attributes for things that don't matter to normal driver operation
> I'd rather have a relatively clean pass through interface and move
> policy to userspace.  Especially given that there are plenty of
> vendor specific commands at these levels as well.

There's no policy in my patches (nor Sayali's), nor are there any
vendor-specific commands here. The sysfs interface has exposed knobs
defined by the UFS specification, which to me seems like the kernel
providing a sane abstraction of device functionality. I don't see
there being a rat race, as these attributes and the config descriptor
are all that's needed to provision a device, and any reasonable future
versions of the UFS spec would likely be backwards compatible with
respect to attributes and flags.

The patches Avri linked to seem fine as well, but I don't see why
there's not room for both the "roll your own driver completely in user
mode" approach, and the "kernel provides a reasonable abstraction of
device functionality" approach to co-exist. We do the same sort of
thing for simple buses like I2C for example, where you can both write
a kernel driver or do bus transactions directly from user mode.

-Evan
