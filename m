Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EA4C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05032080C
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ERQqNQEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05032080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbeKTMcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 07:32:42 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34027 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbeKTMcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 07:32:41 -0500
Received: by mail-vs1-f66.google.com with SMTP id y27so202865vsi.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 18:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6tCd7f7dfWkR5QuuAAyEt5b8a3BTlmCqhT/JnjjfRkE=;
        b=ERQqNQEjoAQh2qpITAZZMOWnNcnT+qq6a7L2BGJrdgJE3F+ZvuY3EJhYfQWdNABlp4
         LRidCuLrmzP0Evz5iqmGx2wOicraPlP7b5ZldccDV6EQKizeft4MZq+OweY7Rv4cP+7W
         CmSYJN+Cwu8i/9OgxOPOb2QxzvfXzsS4dA8BI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6tCd7f7dfWkR5QuuAAyEt5b8a3BTlmCqhT/JnjjfRkE=;
        b=UfymNorTV4OLLk9yaz6tO80zJkVt4j7wDCPvP2Cn4qPg7bi9u/bLBhXtjbbN9qNnqT
         QgQ9m3GW3mohN9Kj1NNe9qZbzdvy2RnNI6aY7n8MpuCrf+qIBiCMIsLTPLF3ZlTUP5m1
         TQZHhpjOP/0bDrdobwSSBjr3ZZTL6BdOV3Cue5KyQJUtdG21mHeKwT6J74up4ffXf+TA
         mRFSvcsNjzAX2sMXFLXL3Ek17NaDiRSR9dZjLZ1LSd6fStWiJz5kWPrNH5lJUWo8chxW
         uq8jJ9THmY6mg58ha/oX+JR0YSiHasUWM/fmZfpohHJ4P9/vJ8YzxdT/TD/bLSagnZWp
         dAVA==
X-Gm-Message-State: AGRZ1gII8HdbOMScd/l9pu4LC0+2h3gmV32v7A5R639anPvapwDRS2h3
        nc4EmKf9DwPD4acXGM4PhEzF2ABEIjI=
X-Google-Smtp-Source: AJdET5cUo26agnc7tOJ5YeJ6qlEM3m/cNNy4n6E2va9nDsAoOFPi2gSNN407ars395qVUhP8mfbo5g==
X-Received: by 2002:a67:4985:: with SMTP id d5mr50113vsg.41.1542679560856;
        Mon, 19 Nov 2018 18:06:00 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id r73sm9554684vsc.12.2018.11.19.18.05.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 18:05:59 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id e7so198354vsc.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 18:05:59 -0800 (PST)
X-Received: by 2002:a67:dd11:: with SMTP id y17mr48778vsj.111.1542679558308;
 Mon, 19 Nov 2018 18:05:58 -0800 (PST)
MIME-Version: 1.0
References: <20181120002654.1891-1-dianders@chromium.org> <20181120002654.1891-7-dianders@chromium.org>
 <3c226e1e-f707-c005-8c46-c0445f60a9a8@gmail.com>
In-Reply-To: <3c226e1e-f707-c005-8c46-c0445f60a9a8@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 19 Nov 2018 18:05:46 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XYJuvRCVRWqP5cn-AmJ8t6sGmG3Yazj3WSu9=7kYODWA@mail.gmail.com>
Message-ID: <CAD=FV=XYJuvRCVRWqP5cn-AmJ8t6sGmG3Yazj3WSu9=7kYODWA@mail.gmail.com>
Subject: Re: [PATCH 7/7] regulator: core: Remove loop disabling supplies in regulator_force_disable()
To:     digetx@gmail.com
Cc:     Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, ryandcase@chromium.org,
        David Collins <collinsd@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 19, 2018 at 4:58 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> On 20.11.2018 3:26, Douglas Anderson wrote:
> > In regulator_force_disable() there was a strange loop that looked like:
> >
> >   while (rdev->open_count--)
> >     regulator_disable(rdev->supply);
> >
> > I'm not totally sure what the goal was for this loop, but it seems
> > wrong to me.  If anything I think maybe we should have been looping
> > over our use_count, but even that might be a little strange.  For now
> > let's just remove the code and we can add something back in if someone
> > can explain what's expected.
> >
> > Fixes: f8702f9e4aa7 ("regulator: core: Use ww_mutex for regulators locking")
>
> Seems this "fixes" tag is incorrect, isn't it? The "ww_mutex" patch didn't touch this code.

Yes, I think you're right.  Originally I added it because I thought
that the "ww_mutex" patch should have touched this too, but I'm wrong.
I'll remove the "Fixes" tag if/when I send out v2.

-Doug
