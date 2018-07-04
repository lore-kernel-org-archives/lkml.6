Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA30CC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FE723E1B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UYOYCHfn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55FE723E1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934338AbeGDJBS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:01:18 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:40572 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934165AbeGDJBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:01:15 -0400
Received: by mail-yb0-f196.google.com with SMTP id y11-v6so1814267ybm.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 02:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=USCZn2bS31NdF/GdGdE1+caSTssCM9tKfpxbUxjcCkQ=;
        b=UYOYCHfnnFFIAM8Hng/j3QCWZQnYCRYTGLeTjTgKKdLemgS/nOZgiXUvjwn4d51Tk8
         Lh9KBDnFti+Z+D5bxdR6xYMDyGwqdb0L3u81t1P9vZpmeXH4sn/5RBByXOd1XBpWp1VS
         IM59UoSNJ5yoKZ7wAXZF0FRzZMp61kWQZJAl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=USCZn2bS31NdF/GdGdE1+caSTssCM9tKfpxbUxjcCkQ=;
        b=nQtxmA6aPViKM6wvDxg/WeIO/TLJI7ZfZK9iAsYb0cpQTb2FKWhEb8P6aQHl0Lc4yP
         mwUtLtQ8apK7O2ma7+voNrVZTI9QTgzcU6k6IFMMw0gnmXmmOCl3RRG/WErBTMjuNrPV
         bK16KggLH5b7qu7YZxmamXRWX1yMTgXr1dYzF5XLokOpld4qFn/+Ua9jXbq0t4bWBUQX
         ODL11HPiruCvGPyQudU9zz1jfKGUBFkIQ/qq+KL/zMROO6G30z1MPMrBOwOtcIvpPxKS
         KgavaeN1mU9Ok3mSR1VWRqxNHXjWf0VjalIjCsPnVZOjbW163pQsrOQXPTzKwgwIXR1r
         84Tw==
X-Gm-Message-State: APt69E2sdQIcShjQYzISg2HN+vvxlHmQIkYsir16mQ/F2A6AYOn/j63I
        TCxXzkuDcFb30CuYEogmHj3Tcak1pRI=
X-Google-Smtp-Source: AAOMgpcVJHDZfg/pSo1Vf2vXeirQFNWSkwz5fQ8oGRew/xS0qNSsvjNi4jh19J14NdrpuEOD95jYCA==
X-Received: by 2002:a25:d1cc:: with SMTP id i195-v6mr504455ybg.183.1530694874465;
        Wed, 04 Jul 2018 02:01:14 -0700 (PDT)
Received: from mail-yb0-f174.google.com (mail-yb0-f174.google.com. [209.85.213.174])
        by smtp.gmail.com with ESMTPSA id p3-v6sm1193450ywh.36.2018.07.04.02.01.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 02:01:12 -0700 (PDT)
Received: by mail-yb0-f174.google.com with SMTP id x10-v6so1811405ybl.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 02:01:11 -0700 (PDT)
X-Received: by 2002:a25:5c41:: with SMTP id q62-v6mr521065ybb.332.1530694871256;
 Wed, 04 Jul 2018 02:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <1527884768-22392-1-git-send-email-vgarodia@codeaurora.org>
 <1527884768-22392-3-git-send-email-vgarodia@codeaurora.org>
 <20180601212117.GD11565@jcrouse-lnx.qualcomm.com> <CAAFQd5DH2i+8ZJ+s2XUnmFHwxXKLF6z_=w0Z-RFs=W9oVvrJgw@mail.gmail.com>
 <ca7567c1df773f1223d919fab28f1460@codeaurora.org>
In-Reply-To: <ca7567c1df773f1223d919fab28f1460@codeaurora.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 4 Jul 2018 18:00:59 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BvTNhafus4WcoPLiBTN8X3Ls+YA0OgpfnyadDayvVQxA@mail.gmail.com>
Message-ID: <CAAFQd5BvTNhafus4WcoPLiBTN8X3Ls+YA0OgpfnyadDayvVQxA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] media: venus: add a routine to set venus state
To:     vgarodia@codeaurora.org
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>, bjorn.andersson@linaro.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 4:59 PM Vikash Garodia <vgarodia@codeaurora.org> wrote:
> On 2018-06-04 18:24, Tomasz Figa wrote:
> > On Sat, Jun 2, 2018 at 6:21 AM Jordan Crouse <jcrouse@codeaurora.org>
> > wrote:
> >> On Sat, Jun 02, 2018 at 01:56:05AM +0530, Vikash Garodia wrote:
> > Given that this function is supposed to substitute existing calls into
> > qcom_scm_set_remote_state(), why not just do something like this:
> >
> >         if (qcom_scm_is_available())
> >                 return qcom_scm_set_remote_state(state, 0);
> >
> >         switch (state) {
> >         case TZBSP_VIDEO_SUSPEND:
> >                 writel_relaxed(1, reg_base + WRAPPER_A9SS_SW_RESET);
> >                 break;
> >         case TZBSP_VIDEO_RESUME:
> >                 venus_reset_hw(core);
> >                 break;
> >         }
> >
> >         return 0;
> This will not work as driver will write on the register irrespective of
> scm
> availability.

I'm sorry, where would it do so? The second line returns from the
function inf SCM is available, so the rest of the function wouldn't be
executed.

Best regards,
Tomasz
