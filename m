Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB85C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B608321A14
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MF1rFyqd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B608321A14
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933171AbeGCItc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:49:32 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:37578 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754475AbeGCIta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:49:30 -0400
Received: by mail-it0-f45.google.com with SMTP id p17-v6so2034005itc.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 01:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RzB8q4LAoU4FbqpVbFt4LkjkQjt49V0SJofrQDRBKfA=;
        b=MF1rFyqdxiSpltL3wZINeufBLyn294v9YvNg6y3p5itmzZNRxukpJeSIUA20PmXi8n
         wRwVnxud5OASY+mTNsxwj0ts0l/DCq54CTEW+0AZTnw6cf+ck2A2g6nFszg6ZkD8b9Uo
         8rXpGpGQaY9nkyZnKvNjFvu/Lr1LnYvgiSBIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RzB8q4LAoU4FbqpVbFt4LkjkQjt49V0SJofrQDRBKfA=;
        b=bsCg115QnGv9cm05Mw9XlEe2h9fSxuAi3t1uQj2cgL5mxxbyoex7Ga6BHgh52PC7w+
         du0haDeZDpI1lL0l6Ns5GYm01FJ/LXMZleYYMb5tKn9+jTCy3Ufr1h66KmLwM2bTbhiX
         dMm4mS2eDMjhh56WTov9lSEASoQHTtWYOFFdnLh+ErMMzvihT/sHzz5GEcvXEWW4ngNb
         WHGQW6tKJIsUy4qMnGxG7EKZl9nOTPAAzCqYrJtlUDatFnjFI4e6Q/K4/D+OcE5QXMz4
         ZOT5MDBZmeMjtv40Xx6W88tiHKJIRvmQFNp0NJzSi/ppo5yhOt+GaMa2g0kQt4/StSZH
         uj4w==
X-Gm-Message-State: APt69E3rkhYynESVIeZ+kEJ5Il90CtvDVI0nD8SjIeU71L4EY28W4Rr+
        jitz0lxbvcTLfEV5lQKZactOr5CB0AE=
X-Google-Smtp-Source: AAOMgpcZsd1F9QkYQEUjEcDQq71wJ/FKOnt008g/hq8uZ6AloEZzjxr4cVi/bumpXyWoyow3uVGWtw==
X-Received: by 2002:a02:cd2:: with SMTP id 79-v6mr8962563jan.100.1530607769598;
        Tue, 03 Jul 2018 01:49:29 -0700 (PDT)
Received: from mail-io0-f170.google.com (mail-io0-f170.google.com. [209.85.223.170])
        by smtp.gmail.com with ESMTPSA id r199-v6sm231762itb.8.2018.07.03.01.49.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 01:49:28 -0700 (PDT)
Received: by mail-io0-f170.google.com with SMTP id l25-v6so1006937ioh.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 01:49:27 -0700 (PDT)
X-Received: by 2002:a6b:3b87:: with SMTP id i129-v6mr15731922ioa.86.1530607767570;
 Tue, 03 Jul 2018 01:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
 <CAPBb6MXH7BpOXW++TxgsdRBr5C7PsHLO8jZtysGiNwUbkNW+BQ@mail.gmail.com> <6172d0e7-5557-7e2d-6ee7-e3d84050279b@linaro.org>
In-Reply-To: <6172d0e7-5557-7e2d-6ee7-e3d84050279b@linaro.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Tue, 3 Jul 2018 17:49:16 +0900
X-Gmail-Original-Message-ID: <CAPBb6MV6ApT_B1A3LKZuXG4Q2Y_M6fgH2hQ55qVWdZBuKFdBMQ@mail.gmail.com>
Message-ID: <CAPBb6MV6ApT_B1A3LKZuXG4Q2Y_M6fgH2hQ55qVWdZBuKFdBMQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/27] Venus updates
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, vgarodia@codeaurora.org,
        Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 12:25 AM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi Alex,
>
> Thanks for review comments!
>
> On 07/02/2018 11:45 AM, Alexandre Courbot wrote:
> > Hi Stanimir,
> >
> > Thanks for this very well organized series and sorry for not giving
> > feedback earlier.
> >
> > I have tested this version against the 4.14 Chrome OS kernel tree (+ a
> > few extra changes to comply with the codec API) and it was working
> > flawlessly.
> >
> > Therefore,
> >
> > Tested-by: Alexandre Courbot <acourbot@chromium.org>
>
> Thanks for testing!
>
> >
> > For the whole series.
> >
> > I have a few comments/questions on some patches, would be great if you
> > could take a look. Also wondering what is your plan regarding codec
> > API compliance? Do you plan to integrate it into the current series,
> > or work on it after merging this initial work? Both ways would be ok
> > as far as I am concerned.
>
> Unfortunately I'm not ready with codec API compliance (at least for
> Venus v1 & v3). I'm working on that intensively these days and I'd say
> with a good progress but I still have few issues/details which needs
> more attention and time.
>
> So I guess the plan minimum is to merge this series first.

I'm fine with that. That will also allow us to tune the Codec API spec
using this driver as reference.
