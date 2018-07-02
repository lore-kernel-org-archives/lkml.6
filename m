Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4648CC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35DB24A5D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ULoY+Qaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F35DB24A5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933952AbeGBJXt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:23:49 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:35860 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933829AbeGBJXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:23:42 -0400
Received: by mail-yb0-f195.google.com with SMTP id s1-v6so4854629ybk.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 02:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2/EaDmROs0e3m2MKWJzIWMnwLyCQ7ElXJjfcbhG3Dko=;
        b=ULoY+QajKjjZYYNEOg/eWQxzpRs8ZT3JTtjjFHC6zvuhfGSifFN9i51qvC2q0/+Rnp
         QVBNGDUeNck3NoHhdVz8fGzlQXGEJvN8UihpuBjBiXmKUxxAPJKdvIED3LMhx6emO5K1
         aJjmG7u005TzSY+qywZPP1u15+4oJXPzOM1F0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2/EaDmROs0e3m2MKWJzIWMnwLyCQ7ElXJjfcbhG3Dko=;
        b=jONOtzGAxCwquT2Ta2Ucml++Ane+RW3Zx7myS3i2S0ykfrE1MXsYNy3Z2eI9QniJex
         mOfWhYKOkw0RWb+TVuEQU3y2VzqmTECWxWXYC1OdUo/YF9dldj0OoNxDEBm/HOQ6FAkX
         CstSUo2KsZW/v3M2+TqKnYCVbiCflIsUMCahFRWQZ15UC1VCEEGfmtdnexeP+KeZhLvd
         p8bfiuxg1W48SkTmoGN6HxqGc6DFt2ZW2heN3IAOV3SaqLGDTm9L6j89Pfb1KfnaqhzH
         zlp80kf7dsXaUUxVJncPDm9btuzcnuYBAp5j9LLeBsX6QFyuNPWxRPxa4rTVfg08yYLN
         NlSA==
X-Gm-Message-State: APt69E1lGXaO4+Lu8Fu94ecLjOVpdZ8LAZfBa7maTbowugXh9LtzML6a
        GsDTT3JB5Gr7kSdsleGCwK86SIk//3c=
X-Google-Smtp-Source: AAOMgpeld1cRh+auKIm5EcXnuSXqqrTUlzIqCx1Ze4tEZnIbSpD/c82Zr1diCbyitYQLa/HsM5+TmA==
X-Received: by 2002:a25:84d0:: with SMTP id x16-v6mr10786193ybm.307.1530523421568;
        Mon, 02 Jul 2018 02:23:41 -0700 (PDT)
Received: from mail-yb0-f175.google.com (mail-yb0-f175.google.com. [209.85.213.175])
        by smtp.gmail.com with ESMTPSA id p124-v6sm4521058ywf.85.2018.07.02.02.23.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 02:23:40 -0700 (PDT)
Received: by mail-yb0-f175.google.com with SMTP id e9-v6so4850737ybq.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 02:23:40 -0700 (PDT)
X-Received: by 2002:a25:207:: with SMTP id 7-v6mr2365584ybc.7.1530523419960;
 Mon, 02 Jul 2018 02:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180515075859.17217-1-stanimir.varbanov@linaro.org>
 <20180515075859.17217-13-stanimir.varbanov@linaro.org> <CAAFQd5Bj73zyi0vsaSJ2sam2TGm7agshXg+n+sa2c7HoqLRGUw@mail.gmail.com>
 <13c7aec1-2bb9-f449-6b7d-7ec93be4ec71@linaro.org> <CAAFQd5B8UVk3n7m+MV3t68vrDhtd9Hi_CnuYS-4QFaVdByOTyA@mail.gmail.com>
In-Reply-To: <CAAFQd5B8UVk3n7m+MV3t68vrDhtd9Hi_CnuYS-4QFaVdByOTyA@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 2 Jul 2018 18:23:28 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CddQBo2JRaab0uWdtkmetd=zDzVt=rM+vJZQ7DM-kLGA@mail.gmail.com>
Message-ID: <CAAFQd5CddQBo2JRaab0uWdtkmetd=zDzVt=rM+vJZQ7DM-kLGA@mail.gmail.com>
Subject: Re: [PATCH v2 12/29] venus: add common capability parser
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        vgarodia@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 4:06 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
> On Thu, May 31, 2018 at 1:21 AM Stanimir Varbanov
> <stanimir.varbanov@linaro.org> wrote:
> >
> > Hi Tomasz,
> >
> > On 05/24/2018 05:16 PM, Tomasz Figa wrote:
> > > Hi Stanimir,
> > >
> > > On Tue, May 15, 2018 at 5:08 PM Stanimir Varbanov <
[snip]
> > >
> > >> +                       break;
> > >> +               }
> > >> +
> > >> +               word++;
> > >> +               words_count--;
> > >
> > > If data is at |word + 1|, shouldn=E2=80=99t we increment |word| by |1=
 + |data
> > > size||?
> >
> > yes, that could be possible but the firmware packets are with variable
> > data length and don't want to make the code so complex.
> >
> > The idea is to search for HFI_PROPERTY_PARAM* key numbers. Yes it is no=
t
> > optimal but this enumeration is happen only once during driver probe.
> >
>
> Hmm, do we have a guarantee that we will never find a value that
> matches HFI_PROPERTY_PARAM*, but would be actually just some data
> inside the payload?

Ping?

Best regards,
Tomasz
