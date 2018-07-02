Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831DEC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3966D253EA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nOapH71t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3966D253EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964912AbeGBKFr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:05:47 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:36490 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933969AbeGBKFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:05:41 -0400
Received: by mail-yb0-f195.google.com with SMTP id s1-v6so4892784ybk.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 03:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yQU3tMuDY/bQf/TtO/3eYfVyACOBjWH33SHhTUiRlyA=;
        b=nOapH71tLALTkIfMbrHwtPY7R/N8sm503YvGCSzGlrP0amse0Cnraw1sV4YTnIQsmF
         ldP+iuU9ChR++iocNtor51S1KE2vrBehz+vJ88auAkmLBI/DEJBUkfzG9KPFnf606Knd
         jkjEbb2QS6FcYVB0UIq4DGJUZ6/NvUzRXM/Ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yQU3tMuDY/bQf/TtO/3eYfVyACOBjWH33SHhTUiRlyA=;
        b=insaOdPAiPHD7DxTRLlsP4yfdBVOUlIR+SPu6T2jMc0o9hGIQ20wGOvEyOok3wbq82
         OomVCuUf1iu7Tf8XlY2xZv6055qAwNOkeBaNU3yHkiYn59B1JN/wWMRS/ueFhG4j0fI1
         55TC2LiuwjOwBHNWyPowrRQHnr2x1b9IWkqybJp6GIv5Bf/YpNACjyZfMmqwy98ktKCw
         VScpy6dK8ZcosRoLwsBbPMU54dJHKRBLOf5hi204XAQ/5kczct6uGk5b5pWbImH7QkVv
         vTmukhwW6LvylTekzM5WQyoRJ+QgP1ywgI83RPywRYYzkhmME5FU6T5SSX2e+lKdprLM
         /5ww==
X-Gm-Message-State: APt69E0CN7U0RxfMUb4XeHfbrbmZjkiULXybpPOsRF/sHcJ5J7tL2CUt
        BQC5v3aDYBp8CzHjh+JsPQcZqTf/soA=
X-Google-Smtp-Source: ADUXVKLenaOmTF6pqPWtvJrPZMoIye9ZAK3yEHQOVtAR/omxjBMy7Jl9F3hThpryYRmSWD1DVh3vyg==
X-Received: by 2002:a25:bc09:: with SMTP id i9-v6mr13273664ybh.15.1530525940420;
        Mon, 02 Jul 2018 03:05:40 -0700 (PDT)
Received: from mail-yb0-f178.google.com (mail-yb0-f178.google.com. [209.85.213.178])
        by smtp.gmail.com with ESMTPSA id f187-v6sm887365ywa.39.2018.07.02.03.05.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 03:05:39 -0700 (PDT)
Received: by mail-yb0-f178.google.com with SMTP id i9-v6so1278381ybo.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 03:05:39 -0700 (PDT)
X-Received: by 2002:a25:5386:: with SMTP id h128-v6mr12281818ybb.344.1530525938673;
 Mon, 02 Jul 2018 03:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180515075859.17217-1-stanimir.varbanov@linaro.org>
 <20180515075859.17217-13-stanimir.varbanov@linaro.org> <CAAFQd5Bj73zyi0vsaSJ2sam2TGm7agshXg+n+sa2c7HoqLRGUw@mail.gmail.com>
 <13c7aec1-2bb9-f449-6b7d-7ec93be4ec71@linaro.org> <CAAFQd5B8UVk3n7m+MV3t68vrDhtd9Hi_CnuYS-4QFaVdByOTyA@mail.gmail.com>
 <CAAFQd5CddQBo2JRaab0uWdtkmetd=zDzVt=rM+vJZQ7DM-kLGA@mail.gmail.com> <30d141b6-dffa-bf6a-dae8-79595c966a23@linaro.org>
In-Reply-To: <30d141b6-dffa-bf6a-dae8-79595c966a23@linaro.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 2 Jul 2018 19:05:27 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Aet4Hb62Jps6QPu+0fLsB=ruxH1qFwE93c_MWygvmXBw@mail.gmail.com>
Message-ID: <CAAFQd5Aet4Hb62Jps6QPu+0fLsB=ruxH1qFwE93c_MWygvmXBw@mail.gmail.com>
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

On Mon, Jul 2, 2018 at 6:59 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi Tomasz,
>
> On 07/02/2018 12:23 PM, Tomasz Figa wrote:
> > On Thu, May 31, 2018 at 4:06 PM Tomasz Figa <tfiga@chromium.org> wrote:
> >>
> >> On Thu, May 31, 2018 at 1:21 AM Stanimir Varbanov
> >> <stanimir.varbanov@linaro.org> wrote:
> >>>
> >>> Hi Tomasz,
> >>>
> >>> On 05/24/2018 05:16 PM, Tomasz Figa wrote:
> >>>> Hi Stanimir,
> >>>>
> >>>> On Tue, May 15, 2018 at 5:08 PM Stanimir Varbanov <
> > [snip]
> >>>>
> >>>>> +                       break;
> >>>>> +               }
> >>>>> +
> >>>>> +               word++;
> >>>>> +               words_count--;
> >>>>
> >>>> If data is at |word + 1|, shouldn=E2=80=99t we increment |word| by |=
1 + |data
> >>>> size||?
> >>>
> >>> yes, that could be possible but the firmware packets are with variabl=
e
> >>> data length and don't want to make the code so complex.
> >>>
> >>> The idea is to search for HFI_PROPERTY_PARAM* key numbers. Yes it is =
not
> >>> optimal but this enumeration is happen only once during driver probe.
> >>>
> >>
> >> Hmm, do we have a guarantee that we will never find a value that
> >> matches HFI_PROPERTY_PARAM*, but would be actually just some data
> >> inside the payload?
> >
> > Ping?
>
> OK, you are right there is guarantee that we not mixing keywords and

Did the auto-correction engine in my head got this correctly as "no
guarantee"? :)

> data. I can make parse_* functions to return how words they consumed and
> increment 'word' pointer with consumed words.

Yes, that or maybe just returning the pointer to the first word after
consumed data. Most of the looping functions already seem to have this
value, so it would have to be just returned. (vs having to subtract
from the start pointer)

Best regards,
Tomasz
