Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16254C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9EB62087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CjrTkkWm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbfAaIHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:07:00 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:38062 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfAaIHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:07:00 -0500
Received: by mail-io1-f67.google.com with SMTP id l14so1888633ioj.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 00:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A0He56KkFhp5ZIl8s6I9fmbf+QfArzRIPvglkqzxgWM=;
        b=CjrTkkWm3jmRCpehNtu7UoMB6XdOV9XE6KFA2sM53MLtFxb9nG0NAN7LxRZgyIkb5G
         uDCMDtDpAxLJoGWJTAOEIAbM+BvgiQYjx0l0imlP+2r19Zu845QEG/U+DGO5dFUEeTuH
         cdq2gdaVv+TJG9/8aEiwcH30wchOQtmMBj8dY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A0He56KkFhp5ZIl8s6I9fmbf+QfArzRIPvglkqzxgWM=;
        b=pG8Y4yuNTBFaiKGlH2//hu6jhE2xwck+sX8RkXzaP7J2GLaJanyhGwXzbQj3GbgFqa
         o+4MaSvVl6Bqi//3Fhgr18ZhbT2ewLtYfd99u1r797pAXakTy6BWREyzgPtbw7kJg7Bd
         VcJSDyeT5D9RqKrH3QWoXMDu82dqgbq4+XqYAuTYO5HHpYZOyT9+XPeHzNiHvNFPuOjq
         c1bB/ruk2pWIbmw7i/eapP9ZCWSt3cHQrGDvMhV/bap0UKNkZeezRtmnFFJx/vz/ouU+
         x86NnqPm2c2Dx+CbUFuNXvqTK408tFFmfbUJNjLTqp1l7JGyPSl8Z5YSpahsQYPhf3gm
         CRpA==
X-Gm-Message-State: AHQUAub/qDyUwzB4h/FMVEhTWSm3CkUsDem5LdEeOUdsatrkhjNtzLm7
        4Owosf1Cp0zQ+Qby9kThWpaVQsH20hCeQNU7ei7Q5A==
X-Google-Smtp-Source: AHgI3Ia4l2ps3pMzH0c5aBrpJNSv/MJkAQwXMvTGumrMoAnGF4GT80vm+KEzLSmV8F8/DKI4go6JDks6PZTnos74Boo=
X-Received: by 2002:a6b:c8c9:: with SMTP id y192mr18594117iof.183.1548922019024;
 Thu, 31 Jan 2019 00:06:59 -0800 (PST)
MIME-Version: 1.0
References: <1548229814-24913-1-git-send-email-vincent.guittot@linaro.org>
 <2577730.BvIW2u5g9k@aspire.rjw.lan> <CAPDyKFpNqANViRhmZXLTbwvP-Gn7Xt1JxKS4noyBH08h7Y0CcA@mail.gmail.com>
In-Reply-To: <CAPDyKFpNqANViRhmZXLTbwvP-Gn7Xt1JxKS4noyBH08h7Y0CcA@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 31 Jan 2019 09:06:48 +0100
Message-ID: <CAKfTPtBo745LS1hy7PHLOUG3cp_bWxaRXnq0EKDJeLptUuwH9A@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] Move pm_runtime accounted time to raw nsec
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019 at 08:44, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 31 Jan 2019 at 00:51, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Wednesday, January 23, 2019 8:50:12 AM CET Vincent Guittot wrote:
> > > Move pm_runtime accounted time to raw nsec. The subject of the patchset
> > > has changed as 1st patch o the previous versions has been queued by
> > > Rafael.
> > >
> > > Patch 1 set accounting_timestamp to 0 in pm_runtime_init and update it when enable.
> > > So we remove ordering constraint between timekeeping_init and pm_runtime_init
> > >
> > > Patch 2 moves time accounting on raw ns. This patch initially used
> > > ktime instead of raw ns but it was easier to move i915 driver on raw ns
> > > than on ktime.
> > >
> > > Change since v6:
> > > - move code that set accounting_timestamp in pm_runtime_enable
> > >
> > > Changes since v5:
> > > - removed patches already queued.
> > > - set accounting_timestamp to 0 in pm_runtime_init and update it when enable
> > >
> > > Changes since v4:
> > > -Update commit message
> > >
> > > Changes since v3:
> > > - Rebase on v4.20-rc7 without patch that has been queued by Rafael
> > > - Simplify the new interface pm_runtime_suspended_time()
> > >
> > > Changes since v2:
> > > - remove patch1 that has been queued by rafael
> > > - add new interface in pm_runtime to get accounted time
> > > - reorder patchset to prevent compilation error
> > >
> > > Changes since v1:
> > > - updated commit message of patch 1
> > > - Added patches 2 & 3 to move runtime_pm accounting on raw ns
> > >
> > > Thara Gopinath (1):
> > >   PM-runtime: Replace jiffies based accounting with ktime-based
> > >     accounting
> > >
> > > Vincent Guittot (1):
> > >   PM-runtime: update accounting_timestamp only when enable
> > >
> > >  drivers/base/power/runtime.c | 26 ++++++++++++++++----------
> > >  drivers/base/power/sysfs.c   | 11 ++++++++---
> > >  include/linux/pm.h           |  6 +++---
> > >  3 files changed, 27 insertions(+), 16 deletions(-)
> >
> > Both patches applied, thanks!
> >
>
> I had some comment on v6, none that needs to prevent this from being
> applied and that can't be addressed as improvements on top.

I had put this on hold until fixing regression with hrtimer but i'm
going to restart these improvements

>
> Feel free to add (if not too late) my:
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Kind regards
> Uffe
