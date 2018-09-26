Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83B4C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD7F21533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J17poNW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD7F21533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbeIZX4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:56:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33113 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeIZX4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:56:35 -0400
Received: by mail-lj1-f196.google.com with SMTP id l19-v6so11544023ljb.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 10:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cHHyistBNGDf6xlJba0AJfXRzWFM32OzKmEMegs3LgM=;
        b=J17poNW+Sy3L+V7VrEsr43/PS/ft/hrSDZMOYeabaoD7XVnNJpoSjxt/yMiFm7xAb5
         iXWZbKn8ktuv1UM6+XD9VyTamPbgjIGwOLiw23zO8o7+b25LcPosvJVexU8lloiJAmxr
         dFJQFNpJhbL9o11JC6ONF390sd/t78QwyU7AY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cHHyistBNGDf6xlJba0AJfXRzWFM32OzKmEMegs3LgM=;
        b=oIoTea78RrI+IMLa72bq/HnxsqjXO48XDB3VfGqYxd8edFgbXN2BIktLmDTHzvPWea
         FBgKPO0FjHuLydzNmJYrMCfZs+YwdRRZ1/ma/tsosKeLKUn702Iim2SUxUo9LyqXSkkz
         IUpGlTq1NgqqJn/IgKpeLGRj5y4B0VPACLoSmFsiXzUQfPQoYkddciJ/N/Nsjp7bbqwt
         Kx2X5q5Z+xXQdejKyGMIvk3D58zGjRyTHbgwWk+ERNa/JhCo5rEcCQF9prbBNSTUIoHJ
         ThYk0wRsRlDa9fTT20zTDVSVdpBrDYkDIJDHkJTiWLybU+AW21AysSADVOkC2wFfTtKS
         Hz0w==
X-Gm-Message-State: ABuFfoi/X7wEi63F8Af49Cq7vko9v2T5MDQXLEiG7WA66bR/FZtjlkn/
        EKzDOs3PqPfmNCJl0LHDMeUvTajxBi0=
X-Google-Smtp-Source: ACcGV63STc0kRG/waJALfO9r4mhjlgwWVhAy1i6epp0b29RICd+UXfiHTRBRq3BS0pG6/RsLrbwmGg==
X-Received: by 2002:a2e:58e:: with SMTP id 136-v6mr5468993ljf.130.1537983751239;
        Wed, 26 Sep 2018 10:42:31 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id j21-v6sm1085484lja.51.2018.09.26.10.42.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 10:42:29 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id p6-v6so26040791ljc.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 10:42:29 -0700 (PDT)
X-Received: by 2002:a2e:1248:: with SMTP id t69-v6mr4983531lje.129.1537983749198;
 Wed, 26 Sep 2018 10:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180808224454.243790-1-evgreen@chromium.org> <6dd8a547-7260-09b8-9096-8a1564b08e70@intel.com>
 <8fd05b2d-fa48-78af-6f1c-7e485c1008f6@intel.com> <CAD=FV=W7h_3LwV-P5_E58-3qOo7Y-yQDTDfSLoU1+3c_6ZF0cg@mail.gmail.com>
 <yq1h8idgj5y.fsf@oracle.com> <CAD=FV=WNHDd8icQi3wtFV98w1zdEd-QqFn1PrZeXQWgYt4Yo1w@mail.gmail.com>
In-Reply-To: <CAD=FV=WNHDd8icQi3wtFV98w1zdEd-QqFn1PrZeXQWgYt4Yo1w@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 26 Sep 2018 10:41:52 -0700
X-Gmail-Original-Message-ID: <CAE=gft57aP3Qx-zdHR1UsJwS7JjVEpVvmCSTk3ctWrRF2=W4ww@mail.gmail.com>
Message-ID: <CAE=gft57aP3Qx-zdHR1UsJwS7JjVEpVvmCSTk3ctWrRF2=W4ww@mail.gmail.com>
Subject: Re: [PATCH v4] scsi: ufs: Make sysfs attributes writable
To:     Doug Anderson <dianders@chromium.org>
Cc:     martin.petersen@oracle.com,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        jejb@linux.vnet.ibm.com, stanislav.nijnikov@wdc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bart.VanAssche@wdc.com, adrian.hunter@intel.com,
        sayali <sayalil@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 6:46 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Martin,
>
> On Tue, Sep 25, 2018 at 6:08 PM Martin K. Petersen
> <martin.petersen@oracle.com> wrote:
> >
> > Doug,
> >
> > > I came across this patch and Evan's other one and noticed that they
> > > haven't been applied though a batch of other SCSI patches for 4.20
> > > were applied about a week ago.  Martin: is there something about these
> > > patches that needs to change before they can land?
> >
> > I have simply been awaiting some sort of consensus on the various
> > competing approaches. Lots of patches posted with tiny incremental fixes
> > but very little discussion about the merits of one over the other.
>
> Ah, perfect information!  Thank you!  I was just confused because I
> didn't understand all the status and it just looked like silence here.
>
> Maybe someone on this thread can start a discussion with all the
> stakeholders (people who have been involved in competing patches or
> other tiny bits and pieces) and summarize their view of the current
> status?  Maybe that would help get the ball rolling again?
>

Ah, I did not realize that's what was being gated on.

These patches complement, rather than compete with, the other patches
out there. There are two components to completely provisioning a UFS
device: writing the configuration descriptors, and setting
attributes/flags. My original series [1] did contain support for the
provisioning portion, but I opted to leave that to Sayali's patch [2]
that uses configfs, rather than duplicate effort. Sayali's other patch
[3] does handle setting the reference clock frequency, which has some
overlap with this patch in that both set bRefClkFreq. But this patch
and the flag patch [4] are still needed for provisioning activity like
locking the descriptors down once they're set up, and enable other
device experimentation. In other words, they're independent.

There was also another independent fix [5] for devices that start in
sleep mode, which Linux currently can't handle. That patch got no
reviews, which is a shame, and I should probably resend as multiple
patches or at least with some additional information.

-Evan

[1] https://lkml.org/lkml/2018/5/29/969
[2] https://lkml.org/lkml/2018/9/14/293
[3] https://lkml.org/lkml/2018/9/14/292
[4] https://patchwork.kernel.org/patch/10570811/
[5] https://lkml.org/lkml/2018/8/10/669
