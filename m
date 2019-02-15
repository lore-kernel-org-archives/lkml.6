Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7ECBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58262192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fH6s1uam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbfBOPml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:42:41 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38470 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfBOPml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:42:41 -0500
Received: by mail-vs1-f68.google.com with SMTP id t7so6037680vsq.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 07:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=21Fx0jkAMtJpbFhfsGHadPS2RCbybIZVUEaYg4IA3YM=;
        b=fH6s1uamWAlEArpmX8T7mVLUOhyVUTUbxl0BK9PmhZWQf1BjDfMXgwKWtBpfJTbyvw
         SLMEH38zwLXFz3/gPsmCFhF/4H66jynqFmOusL2JS0RvwI7KxkYfEfGO7WTl7L+9LYZg
         IDiZ/svA6Hcf7vTLPvmP/INGazfgn5bgg5Ov4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=21Fx0jkAMtJpbFhfsGHadPS2RCbybIZVUEaYg4IA3YM=;
        b=i8wzBgA8EDyngkG7S2sMosf9dAsvv36MKO5X+egSjH6k7Q/nWLTOmMFx/iLoIdahZL
         S97kteB4QIoSe7uE3TuJTtsaWehLeDxT9p14g4+hWlcm6RcoHxUMtYL6i94KfAVAli0y
         I3LQIQYY1560MF+Z4Hwh+X3AlC/P5JiG+KobhWEyYzAfDZFTp3ixwwy9cWWsBquH7eBm
         d7bsryF1p9LqiyKx0kN0qRXR7fZjOEmHgfK45nzDrDbPJ2ZuWqujHPdJH1DjOfx1mAi5
         EdH3BWz/zQ6fYYp6RLNbglTGBJLD+qbNC+rD1CYXe/0/wkH34k22q96KHt2db3FuJCyr
         n7ag==
X-Gm-Message-State: AHQUAuZ0GusYT4JC3yqDorAVFM/2oHeuPbaWEGv8nJBzImN2V9QbCDXy
        tBwmZDuwTKMkyn76uU9lbtAPzcu+7gk=
X-Google-Smtp-Source: AHgI3IYybiZ4Y0XHWtbeFN0rvAE0F06Xh4hEn3SssUfPwN4evS0SncZWfmbG7q+pXv8ZmU1OMX/ZzA==
X-Received: by 2002:a67:c86:: with SMTP id 128mr5427866vsm.221.1550245359519;
        Fri, 15 Feb 2019 07:42:39 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id l123sm1097781vsd.26.2019.02.15.07.42.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 07:42:37 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id v26so3356629uap.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 07:42:37 -0800 (PST)
X-Received: by 2002:ab0:70b7:: with SMTP id q23mr4845751ual.15.1550245357144;
 Fri, 15 Feb 2019 07:42:37 -0800 (PST)
MIME-Version: 1.0
References: <20190214181249.2749-1-dianders@chromium.org> <20190214181249.2749-2-dianders@chromium.org>
 <CAPDyKFpXc+0rAHOgKN+QDK0MH-4efUZJ8asuBkAwg+w73huzOw@mail.gmail.com>
In-Reply-To: <CAPDyKFpXc+0rAHOgKN+QDK0MH-4efUZJ8asuBkAwg+w73huzOw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 15 Feb 2019 07:42:25 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XMGzWD=rEPshz_QHkcmqMhu87cn2n0i+ZOzPbgcHccxg@mail.gmail.com>
Message-ID: <CAD=FV=XMGzWD=rEPshz_QHkcmqMhu87cn2n0i+ZOzPbgcHccxg@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM / Domains: Mark "name" const in dev_pm_domain_attach_by_name()
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Feb 15, 2019 at 2:28 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 14 Feb 2019 at 19:13, Douglas Anderson <dianders@chromium.org> wrote:
> >
> > As of the patch ("PM / Domains: Mark "name" const in
> > genpd_dev_pm_attach_by_name()") it's clear that the name in
> > dev_pm_domain_attach_by_name() can be const.  Mark it as so.  This
> > allows drivers to pass in a name that was declared "const" in a
> > driver.
> >
> > Fixes: 27dceb81f445 ("PM / Domains: Introduce dev_pm_domain_attach_by_name()")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Perhaps fold $subject patch into patch1, they seems highly related.
> Anyway, no strong opinion here.

Sure, either way is fine with me so I'll wait until someone tells me
for sure one way or the other.  I'm also happy if they just get
squashed together when applied if that's easier.  I originally kept
them separate since the two APIs were originally added in separate
patches so it seemed consistent to do the bugfixes in separate
patches.  ;-)

-Doug
