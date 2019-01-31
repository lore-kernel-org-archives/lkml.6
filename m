Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D87C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E58020870
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NE6cufbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfAaGMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 01:12:33 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37484 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfAaGMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 01:12:31 -0500
Received: by mail-ed1-f66.google.com with SMTP id h15so1625696edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 22:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a2Dt2LYuEBuB7f9md+YiZOR34ueBE9xvYC6GBTDIs/c=;
        b=NE6cufbqKwQVX+V4pO1FelbUy1lZbGFxN6UZ/VA+oby+FiU67LePC52wygBrXgdkr2
         auI6tl2HkDkFEXU/1zlqnZ3fkXVR/bAMQRY30ZUrdNUH9SDg+YLnmpbDdl6EKnAvcP22
         m3TMGoT5olI/xaE56PajpERirO0VqF2CTcfu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a2Dt2LYuEBuB7f9md+YiZOR34ueBE9xvYC6GBTDIs/c=;
        b=tSDn2xxH+Y0rqmjBA2Trc2xKea9aZbahWqALArdw8+MSulkTPvEYw3plSsSuUfilfu
         dq7UwcxTBwOByMNOdhZUngZhdjpvCo9z/bhKUTEJ98AN35ouBDK9C+T90cg4A94orBYv
         VMfhzsQh0GAMAItxzaJCF0FPEuCT09lK0fF8qgxyzOLyhFDH0g8SwsaPQXGQW2tUSDcV
         KusQzjrEr6IreWDRi/8rCdBh88Au6OMyFdSohalM1MttjLvQNdERXROc3tH5j7/U/wOw
         JwDUIIFOdwO8JTFx7zgOicNxxbAHSO19LILj/gdP6jEuq18XllyqKW8QXYFV66HKfGvX
         8DnQ==
X-Gm-Message-State: AHQUAua02jFRCmdwlX8v7bXGVdDRnwuOiuCOB+VDO/7RRaE82/pNzJ9Z
        18Pg0etOJ6iWIMuWE5GtObbzSOhJCE6VnZF4qlHuJg==
X-Google-Smtp-Source: AHgI3IZeG6dvhout6AyJxAaT74iCgRBWXVuxknlEMDsRDtfaVMZSq+vRhjV0IltF7JCP2oR02TYuY0uvqgQ43UG1dZM=
X-Received: by 2002:a17:906:cb2:: with SMTP id k18-v6mr3862894ejh.129.1548915149858;
 Wed, 30 Jan 2019 22:12:29 -0800 (PST)
MIME-Version: 1.0
References: <20190121071833.43443-1-pihsun@chromium.org> <20190121071833.43443-6-pihsun@chromium.org>
 <20190130130738.GC4701@dell> <CAFqH_51-WCxyRpb6fDhm_y6gE+XsJo9Ezp-QZuAPAyxXqZgPdQ@mail.gmail.com>
In-Reply-To: <CAFqH_51-WCxyRpb6fDhm_y6gE+XsJo9Ezp-QZuAPAyxXqZgPdQ@mail.gmail.com>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Thu, 31 Jan 2019 14:12:19 +0800
Message-ID: <CANdKZ0dXUL=SgomS3NMgdQd8MDBJ3V-983jwr_AfxLqzTJRGHA@mail.gmail.com>
Subject: Re: [RFC v3 5/5] cros_ec: differentiate SCP from EC by feature bit.
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On Wed, Jan 30, 2019 at 11:06 PM Enric Balletbo Serra
<eballetbo@gmail.com> wrote:
>
> Hi Lee, Pi-Hsun,
>
> Missatge de Lee Jones <lee.jones@linaro.org> del dia dc., 30 de gen.
> 2019 a les 14:07:
> >
> > On Mon, 21 Jan 2019, Pi-Hsun Shih wrote:
> >
> > > Since a SCP and EC would both exist on a system, and use the cros_ec_=
dev
> > > driver, we need to differentiate between them for the userspace, or t=
hey
> > > would both be registered at /dev/cros_ec, causing a conflict.
> > >
> > > Cc: Enric Balletbo Serra <eballetbo@gmail.com>
> > > Cc: Guenter Roeck <groeck@chromium.org>
> > > Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> > > ---
> > > Changes from v2:
> > >  - No change.
> > >
> > > Changes from v1:
> > >  - New patch extracted from Patch 5.
> > > ---
> > >  drivers/mfd/cros_ec_dev.c            | 9 +++++++++
> > >  include/linux/mfd/cros_ec.h          | 1 +
> > >  include/linux/mfd/cros_ec_commands.h | 2 ++
> > >  3 files changed, 12 insertions(+)
> >
> > Just to clarify to the new Cc'ed list, I'm waiting on one of the
> > Chromium guys to review before I put my mucky paws over it.
> >
>
> Pi-Hsun, is this patchset still an RFC or you really want to see this
> merged ASAP? If I am not mistaken there is still some work in progress
> trying to push all the SCP stuff?
>
> Lee, personally I have some concerns. Looks like the cros_* family is
> increasing quickly lately (cros_ec, cros_pd, cros_scp, cros_ish,
> cros_fp ...) and I am wondering if we are really doing well all this.
> To be honest, I'd like to take a deeper look before merge this, btw I
> thought there was no hurry because of the RFC and I guess there are
> still some scp things that are missing. I might be wrong, and if
> that's not the case I can take a look deeper and the end of the week.
>
> Best regards,
>  Enric

I don't think we need this to be merged ASAP.

I feel that most of the todos are done though, so I'll drop the RFC
tag and resend a v4 (which also contains some bug fixes found when
testing).

>
>
> > --
> > Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> > Linaro Services Technical Lead
> > Linaro.org =E2=94=82 Open source software for ARM SoCs
> > Follow Linaro: Facebook | Twitter | Blog
