Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF44C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712BD20882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ErO9o3wm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbfA3JZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:25:40 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38106 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730091AbfA3JZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:25:40 -0500
Received: by mail-ed1-f66.google.com with SMTP id h50so18391985ede.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 01:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5a7NvQkWOISkNnAGXM7TAeezdcdvrRYnkbW1NYEQoWw=;
        b=ErO9o3wmAG1rh48oPZST8SDvEgdzFIqMvwpSRCPjOjyqqlur6MUak6HZl+Oy26YyOg
         uLoFAHxWCHYNAoQG+tt2Ovu3T26/bRS/31WTOk8maA0APDQMX6nEL+fFYbomuxvo5X30
         qzsn/KqGl6vdguVGcIFERkIplb6ICppSv8F5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5a7NvQkWOISkNnAGXM7TAeezdcdvrRYnkbW1NYEQoWw=;
        b=VrLoLwZ1jj/vR7L3WdaPvMsGp9I8+IjMICQDFlH5SFaQX5M9uNLoDLoz5MNVnAtWLj
         ioKFT+EIEGlmMt3qYu1HyA1MzTPCIw+Ot5ezyhTD03slqZbU51aJfGpNS1Pawydh5EzL
         WRrVQxADUUzP1mgk+5uFopoMIKZxXEVHFiIyQu9Uhwe7tHxYkkH0cCSIMHBxZjuxdoJR
         zPueNgvTHyQ8AYLqDi1Pcgq8/dBqiVxnqP8u7ihC/zYgqO/91j2kXFj1S6+i+iO9DlNA
         CXXsmsB9aIbqSHlUnlhvJkKkeXMnY9aqaIpIW6rAHYHkvBzxXVNwWoK1KqzSeAieCa4M
         ptUA==
X-Gm-Message-State: AJcUukcL2zYbgh2ylOopyOxcN0Gd0tT8WVCuWjlqUefdOhF7//aAY2CI
        Qy2py7hwwTv/528SfawPIzSq52ClDrU4zNCu/Uh5mA==
X-Google-Smtp-Source: ALg8bN6eDeahTmyePeL/rIwr+a3UJTI5G0WFFLJFcWc/OJ7ixVMBE8XghKL8df0HI4K1ASmS9q50ZqOCKK7n/rNDyXA=
X-Received: by 2002:a17:906:4691:: with SMTP id a17mr25821356ejr.58.1548840338153;
 Wed, 30 Jan 2019 01:25:38 -0800 (PST)
MIME-Version: 1.0
References: <20190109055724.184692-1-pihsun@chromium.org> <CANdKZ0fRckMSUwHyChgBw162cVQe9_mnd_G9vwt=+CV+Y0WFfw@mail.gmail.com>
 <81115ad5-521e-557b-d229-1effb92068a4@linaro.org>
In-Reply-To: <81115ad5-521e-557b-d229-1effb92068a4@linaro.org>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Wed, 30 Jan 2019 17:25:27 +0800
Message-ID: <CANdKZ0eDwTgKoFsAOboCz=q+nsUWepecXA7wmR=jGhkWEzLvnA@mail.gmail.com>
Subject: Re: [PATCH] thermal: mtk: Allocate enough space for mtk_thermal.
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Michael.Kao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 3:44 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 30/01/2019 07:04, Peter Shih wrote:
> > Adding Michael Kao to cc list.
> >
> > On Wed, Jan 9, 2019 at 1:57 PM Pi-Hsun Shih <pihsun@chromium.org> wrote=
:
> >>
> >> The mtk_thermal struct contains a 'struct mtk_thermal_bank banks[];',
> >> but the allocation only allocates sizeof(struct mtk_thermal) bytes,
> >> which cause out of bound access with the ->banks[] member. Change it t=
o
> >> a fixed size array instead.
>
> Even if the fix is correct, it pushes back the bug later in time if a
> new board containing more than MAX_NUM_ZONES is introduced. I suggest to
> dynamically allocate the array with the 'num_banks' value.
>

For the current code structure, those mtk_thermal_data are statically decla=
red,
so if there's new board containing more than MAX_NUM_ZONES of bank_data, it
would actually be a compile error.

I'm fine with either way, but feel like that this is simpler than manually
calculating the size needed for allocation.

>
> >> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> >> ---
> >>  drivers/thermal/mtk_thermal.c | 7 +++++--
> >>  1 file changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_therm=
al.c
> >> index 0691f260f6eabe..ea11edb3fcced6 100644
> >> --- a/drivers/thermal/mtk_thermal.c
> >> +++ b/drivers/thermal/mtk_thermal.c
> >> @@ -159,6 +159,9 @@
> >>  #define MT7622_NUM_SENSORS_PER_ZONE    1
> >>  #define MT7622_TS1     0
> >>
> >> +/* The maximum number of banks */
> >> +#define MAX_NUM_ZONES          8
> >> +
> >>  struct mtk_thermal;
> >>
> >>  struct thermal_bank_cfg {
> >> @@ -178,7 +181,7 @@ struct mtk_thermal_data {
> >>         const int *sensor_mux_values;
> >>         const int *msr;
> >>         const int *adcpnp;
> >> -       struct thermal_bank_cfg bank_data[];
> >> +       struct thermal_bank_cfg bank_data[MAX_NUM_ZONES];
> >>  };
> >>
> >>  struct mtk_thermal {
> >> @@ -197,7 +200,7 @@ struct mtk_thermal {
> >>         s32 vts[MT8173_NUM_SENSORS];
> >>
> >>         const struct mtk_thermal_data *conf;
> >> -       struct mtk_thermal_bank banks[];
> >> +       struct mtk_thermal_bank banks[MAX_NUM_ZONES];
> >>  };
> >>
> >>  /* MT8173 thermal sensor data */
> >> --
> >> 2.20.1.97.g81188d93c3-goog
> >>
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
