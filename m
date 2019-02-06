Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F3EC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90854218D9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549491572;
	bh=UmWDS1pzepHChoXfu1ErrHYFZxpiNV8/NuLO8r2C448=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iZOfj2h/ztTJ5bL3nLk57vAYynvB8wD2nyRInmwKC1qkI1QRsYrHkbyI5oDFmjZvC
	 VPzDCjMnuOOaDIYaP6QgTRF0Uc7Xk8iGJmcJb0CILOBN3gH/1pZLsemwL7LpTGCi9J
	 tSbPMHudlVd+RE6m5KfBMT/LTgLv6zWMVejm0TBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfBFWTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 17:19:30 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41463 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfBFWTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 17:19:30 -0500
Received: by mail-ot1-f66.google.com with SMTP id u16so14850593otk.8;
        Wed, 06 Feb 2019 14:19:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yEMlPZb9wFlBA+A+JCYFhFZZVCaC7CpKWtyJB090Qu8=;
        b=lT/YnyaYRMwj6iF0g7p865XovUxV7lpE9l44Sx4W8W7aKFo+n24dCp/gFzCk7N2BNE
         yiwGAZootwnRAm10GBVE1UorHj9rSaz6Ru8J2Bmu3xlgmgZ5M9uxvBjsD2NirnVzjqnO
         ALDCLZ4LjQf7XdCN786dT30B2R3FpKMNPpFlBnxgl/DQwHO5MFCkxjZqidvq1J/0e88S
         zqfrMQEzSutTi6ZPzOxBPOzgS2+8SOHpGl2RupTfQB2iSYBYdneciHYqFhISQgkZ5Cvk
         XuOeD+tffkEL8xp+ab9NusEa2yWy1398GSUW4O9+kNWxpu+xDKj3hZpsEOCnagEIEyjh
         N7PQ==
X-Gm-Message-State: AHQUAub83ga3L+JNWFwUwQHBA2IsJgEmvZmq8v9+3od3H0Lad2zXFRcA
        Ljddj8xwe9t6h78mT4QfuPOOOpvMrOSzUFhSSW0=
X-Google-Smtp-Source: AHgI3IZuCYEzDAL3liu1+FVQsnPf9hS0lsrPV49Prk5/8tInHSLAc0aE1lgNPdXcjE9yBWLhvWPeHJ+9TD5R5cdM/0Y=
X-Received: by 2002:a05:6808:902:: with SMTP id w2mr826315oih.84.1549491569775;
 Wed, 06 Feb 2019 14:19:29 -0800 (PST)
MIME-Version: 1.0
References: <CAAuoowhNsaXjBSHM9ZGeO_uwGVXprc8TS0SENGA3fKbg1xCWMQ@mail.gmail.com>
 <20190206212023.GA5353@amd>
In-Reply-To: <20190206212023.GA5353@amd>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 6 Feb 2019 23:19:18 +0100
Message-ID: <CAJZ5v0gZmSfN2pk50sKYr-exbJy8m3dY4Xnz6pcKMcbAX92yfA@mail.gmail.com>
Subject: Re: REGRESSION - System does not resume from suspend
To:     Pavel Machek <pavel@ucw.cz>
Cc:     =?UTF-8?B?0K/RgNC+0YHQu9Cw0LIg0KHQtdC80YfQtdC90LrQvg==?= 
        <ukrkyi@gmail.com>, Greg KH <greg@kroah.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Thomas Martitz <kugel@rockbox.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 6, 2019 at 10:20 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > Since kernel version 4.19, my computer is unable to resume from suspend to
> > RAM. I've run git bisect and filed bug report at
> > https://bugzilla.kernel.org/show_bug.cgi?id=201519
> > three months ago, however, I received no reaction. Bug is still present in
> > 5.0-rc5 kernel version. Is there any possibility to fix this?
>
> Thanks for all the work bisecting / etc... Note that you can get patch
> reverted if it causes regression, but it needs to be done over
> email. (If maintainer does not reply, up-to Linus).
>
> For the record, patch is:
>
> git bisect output:
> c62ec4610c40bcc44f2d3d5ed1c312737279e2f3 is the first bad commit
> commit c62ec4610c40bcc44f2d3d5ed1c312737279e2f3
> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Date:   Tue May 22 13:02:17 2018 +0200
>
>     PM / core: Fix direct_complete handling for devices with no
>     callbacks
> ...
>     Link: https://bugzilla.kernel.org/show_bug.cgi?id=199693
>         Fixes: 08810a4119aa (PM / core: Add NEVER_SKIP and
>         SMART_PREPARE driver flags)
>  Reported-by: Thomas Martitz <kugel@rockbox.org>
>  Tested-by: Thomas Martitz <kugel@rockbox.org>
>                     Cc: 4.15+ <stable@vger.kernel.org> # 4.15+
>  Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>  Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>  Reviewed-by: Johan Hovold <johan@kernel.org>
>
> And the patch was tagged for stable, which sounds like a lot of fun.

Not really.  This just restored previous behavior as the commit log says.

If the system breaks after this one, it most likely didn't work before
commit 08810a4119aa which was in 4.15 and c62ec4610c40bcc44f2 first
appeared in 4.17-rc1.

Unfortunately, it cannot be reverted without breaking other systems
that used to work before commit 08810a4119aa.
