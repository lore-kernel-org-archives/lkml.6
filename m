Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF7BC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B4D208B6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OQT5FRnv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B4D208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932839AbeGDKJQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:09:16 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:37245 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753086AbeGDKJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:09:14 -0400
Received: by mail-yb0-f193.google.com with SMTP id r3-v6so1886345ybo.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 03:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R3cWu474ymuEoYNONjfkwKBl+keLvoqVqI1f43OwFMg=;
        b=OQT5FRnvSLOLyXc4zuI4QQVwVIrXmBsXCzRj7Xxux4f9TvxyjDuA/9m7DeYYjy0/il
         9LwCNttyjXzhu8UjZRwKgACAKnARsNJEeLhm1Q0VGyXGYHis631IdF3IumzWfGIQlj/Q
         qTXzMLo8hcbEL/dsGmerAanomxtNp+UCLe9Bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R3cWu474ymuEoYNONjfkwKBl+keLvoqVqI1f43OwFMg=;
        b=bGIjYL/KqD3oD/jabEkS2R/Q0U4O/306rH0OBFT/k8BqTwl79oJSxdfLGf/E0mRfcA
         Y8eK8Sq5ZVbXc7qyUBQBnzVxWTDE8QF2s/O+3YaFvU1TVJ+Eb44KjlOftmmTMwm2vZeT
         U/t9R1pvu2VUndQLSb+UlphzvkpQCYpnKe2S0kdJs/9K4sSoqbDkOl2jeS7RQXNLKp94
         hzDdZfAHBOCL6AUIHV1MxbvYJ5Ij6e+uYjVLt6YnPu1jW1ny0pZGMeX3tkTpBAFY3MFU
         y0PPj1aLfRBemB2ETrOFD7UFWk7gyA5YVTmfdJjiga/G9++QnTCUips+WrB37fzplnTW
         axxg==
X-Gm-Message-State: APt69E3LI9ExJv5XRBCtkfquTKtA2NAo5xoz/8RA9ubnaKGbKjClf8tp
        dggGsk95rzNat5LoK2MGacUimEGYZHw=
X-Google-Smtp-Source: AAOMgpdTL3otPppQuYN+hJ3F1IOXWsesgweJMi6iEmo2hjrKJ3pXCqAUhK8N5bgDk2iz+LQt+is46Q==
X-Received: by 2002:a25:b091:: with SMTP id f17-v6mr600533ybj.167.1530698953420;
        Wed, 04 Jul 2018 03:09:13 -0700 (PDT)
Received: from mail-yb0-f172.google.com (mail-yb0-f172.google.com. [209.85.213.172])
        by smtp.gmail.com with ESMTPSA id m19-v6sm2376167ywd.90.2018.07.04.03.09.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 03:09:12 -0700 (PDT)
Received: by mail-yb0-f172.google.com with SMTP id s14-v6so1878851ybp.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 03:09:11 -0700 (PDT)
X-Received: by 2002:a25:7456:: with SMTP id p83-v6mr609320ybc.500.1530698951342;
 Wed, 04 Jul 2018 03:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <1527884768-22392-1-git-send-email-vgarodia@codeaurora.org>
 <1527884768-22392-3-git-send-email-vgarodia@codeaurora.org>
 <20180601212117.GD11565@jcrouse-lnx.qualcomm.com> <CAAFQd5DH2i+8ZJ+s2XUnmFHwxXKLF6z_=w0Z-RFs=W9oVvrJgw@mail.gmail.com>
 <ca7567c1df773f1223d919fab28f1460@codeaurora.org> <CAAFQd5BvTNhafus4WcoPLiBTN8X3Ls+YA0OgpfnyadDayvVQxA@mail.gmail.com>
 <5560573ed426b03ad7676ac14a291e70@codeaurora.org>
In-Reply-To: <5560573ed426b03ad7676ac14a291e70@codeaurora.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 4 Jul 2018 19:08:59 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Bsh22v7jp8CAO-qQEa6kLk4Qws37DmLZUytAJbUjOCWw@mail.gmail.com>
Message-ID: <CAAFQd5Bsh22v7jp8CAO-qQEa6kLk4Qws37DmLZUytAJbUjOCWw@mail.gmail.com>
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
        Alexandre Courbot <acourbot@chromium.org>,
        linux-media-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 6:41 PM Vikash Garodia <vgarodia@codeaurora.org> wrote:
>
> On 2018-07-04 14:30, Tomasz Figa wrote:
> > On Wed, Jul 4, 2018 at 4:59 PM Vikash Garodia <vgarodia@codeaurora.org>
> > wrote:
> >> On 2018-06-04 18:24, Tomasz Figa wrote:
> >> > On Sat, Jun 2, 2018 at 6:21 AM Jordan Crouse <jcrouse@codeaurora.org>
> >> > wrote:
> >> >> On Sat, Jun 02, 2018 at 01:56:05AM +0530, Vikash Garodia wrote:
> >> > Given that this function is supposed to substitute existing calls into
> >> > qcom_scm_set_remote_state(), why not just do something like this:
> >> >
> >> >         if (qcom_scm_is_available())
> >> >                 return qcom_scm_set_remote_state(state, 0);
> >> >
> >> >         switch (state) {
> >> >         case TZBSP_VIDEO_SUSPEND:
> >> >                 writel_relaxed(1, reg_base + WRAPPER_A9SS_SW_RESET);
> >> >                 break;
> >> >         case TZBSP_VIDEO_RESUME:
> >> >                 venus_reset_hw(core);
> >> >                 break;
> >> >         }
> >> >
> >> >         return 0;
> >> This will not work as driver will write on the register irrespective
> >> of
> >> scm
> >> availability.
> >
> > I'm sorry, where would it do so? The second line returns from the
> > function inf SCM is available, so the rest of the function wouldn't be
> > executed.
>
> Ah!! you are right. That would work as well.
> I am ok with either way, but would recommend to keep it the existing way
> as it makes it little more readable.

I personally think the early exit is more readable, as it clearly
separates the SCM and non-SCM part.

Best regards,
Tomasz
