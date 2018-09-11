Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0B8C43143
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 03:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FFA206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 03:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lLxro/gg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FFA206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbeIKIuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 04:50:14 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40480 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbeIKIuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 04:50:14 -0400
Received: by mail-yw1-f66.google.com with SMTP id z143-v6so8691875ywa.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 20:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=istT2wjiviuI+NO1FLzN8hLHTX87ry+/t9zxJtjij/g=;
        b=lLxro/ggYoreTi13tEvZUS0ISldrHlz6oGCtKE9O/uQSs8kMLFsZxKiWhtGdZIzCoN
         /xFa1UMsSuSO8s5e9lx3PnR/cIFfdQZ86q9UMhP64Hz/2s33IbL+cuMTfmDJG0u8ybUv
         z4LiREeJgfEddL6f7Aq0e9e1bANehMdwPUaOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=istT2wjiviuI+NO1FLzN8hLHTX87ry+/t9zxJtjij/g=;
        b=K+rurct9hkzDKIAmAzrIt6OoNG3/ks4gfwrP076kKXBOJsyITTXd5xQ3B0cH/LfN9J
         mOArCUEv4ENFyZCU8d2rC19QTTnMosi0G62OYBL9wyQ/OS3N9lmuPG4kx6BdkgWrLdyZ
         E/T0jr8+hUCI0iUBqrPHJwqqir292SsavjoBRJ0C6lkYI/3UV0PbqB5oypXUuzRWeILY
         QVbQ1LcnjsHaGkjlZXzUxiHFZWJS7Qdt1uJjbxB3EIKwdf56e9T7m6U56Jf+PpeRaQ97
         5C4ZAlUKOXfaee97/j1ERMOg13gdEA+P4rrl2NsR1wnNxVS+aYzOc+E6yv24VS2BYON4
         Ll1A==
X-Gm-Message-State: APzg51C5jJ9nfs+P0/C8VSrfpRzvWIUYxWpNMMTBA7rR7CySkOJwyw/w
        gcA8zmn5JV+cAQy2XxSQh0Rs5e7CfPhplA==
X-Google-Smtp-Source: ANB0VdZjkOyE83mLXWFo5ZG3JmoH+pMd2qI6u9dcduajUxMzE/QW5yGr97q9xeqPy68NSTlRdFzdOQ==
X-Received: by 2002:a81:3856:: with SMTP id f83-v6mr11286260ywa.81.1536637976954;
        Mon, 10 Sep 2018 20:52:56 -0700 (PDT)
Received: from mail-yw1-f54.google.com (mail-yw1-f54.google.com. [209.85.161.54])
        by smtp.gmail.com with ESMTPSA id r84-v6sm8680031ywe.10.2018.09.10.20.52.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 20:52:55 -0700 (PDT)
Received: by mail-yw1-f54.google.com with SMTP id x83-v6so8705557ywd.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 20:52:55 -0700 (PDT)
X-Received: by 2002:a0d:fdc4:: with SMTP id n187-v6mr11862280ywf.443.1536637974787;
 Mon, 10 Sep 2018 20:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180724140621.59624-1-tfiga@chromium.org> <bed0d45d-d5c0-d2dc-03d7-eedf99246182@xs4all.nl>
In-Reply-To: <bed0d45d-d5c0-d2dc-03d7-eedf99246182@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 11 Sep 2018 12:52:43 +0900
X-Gmail-Original-Message-ID: <CAAFQd5C3pMyVBokWs4QS-O3jckFXY-7eG-ayD357v8TDyU5zTA@mail.gmail.com>
Message-ID: <CAAFQd5C3pMyVBokWs4QS-O3jckFXY-7eG-ayD357v8TDyU5zTA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Document memory-to-memory video codec interfaces
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>, kamil@wypas.org,
        a.hajda@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>,
        jtp.park@samsung.com, Philipp Zabel <p.zabel@pengutronix.de>,
        =?UTF-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <andrew-ct.chen@mediatek.com>, todor.tomov@linaro.org,
        nicolas@ndufresne.ca,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dave.stevenson@raspberrypi.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 6:14 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> Hi Tomasz,
>
> On 07/24/2018 04:06 PM, Tomasz Figa wrote:
> > This series attempts to add the documentation of what was discussed
> > during Media Workshops at LinuxCon Europe 2012 in Barcelona and then
> > later Embedded Linux Conference Europe 2014 in D=C3=BCsseldorf and then
> > eventually written down by Pawel Osciak and tweaked a bit by Chrome OS
> > video team (but mostly in a cosmetic way or making the document more
> > precise), during the several years of Chrome OS using the APIs in
> > production.
> >
> > Note that most, if not all, of the API is already implemented in
> > existing mainline drivers, such as s5p-mfc or mtk-vcodec. Intention of
> > this series is just to formalize what we already have.
> >
> > It is an initial conversion from Google Docs to RST, so formatting is
> > likely to need some further polishing. It is also the first time for me
> > to create such long RST documention. I could not find any other instanc=
e
> > of similar userspace sequence specifications among our Media documents,
> > so I mostly followed what was there in the source. Feel free to suggest
> > a better format.
> >
> > Much of credits should go to Pawel Osciak, for writing most of the
> > original text of the initial RFC.
>
> I'm adding this here as a result of an irc discussion, since it applies
> to both encoders and decoders:
>
> How to handle non-square pixel aspect ratios?
>
> Decoders would have to report it through VIDIOC_CROPCAP, so this needs
> to be documented when the application should call this, but I don't
> think we can provide this information today for encoders.

Thanks for heads up. Will document that VIDIOC_CROPCAP needs to return it.

Best regards,
Tomasz
