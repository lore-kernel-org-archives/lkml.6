Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED23C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2421220864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U7glQIXi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2421220864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405111AbeKVTKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:10:21 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46578 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393077AbeKVTKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:10:21 -0500
Received: by mail-oi1-f194.google.com with SMTP id x202so6801229oif.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 00:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7mSGmv89ydUt+j/JGzq5hjT2Fh76K11w7H3mzkHIh/A=;
        b=U7glQIXilZCXNnVJgxMXG+v2FPYhMO/ncwJ+QqV5TKIhG8CzkAyBmNnHkAQ8athwCo
         RtTweJEyYgX0dU203jHSKOa0ye418s6dY9SqhPrTEaOrL5ou8GErduBDy93u3IvKuVJM
         KRLU9yg/x1A68owTpWYanFANrFgx2bG//xYyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7mSGmv89ydUt+j/JGzq5hjT2Fh76K11w7H3mzkHIh/A=;
        b=V66HI4HgZoy3WynSNFhcFb1jgyASlNCZMPUwjrw9COXjVN5ALSMFFCZ8zvwTn47Gn8
         kXfNTs89vzPhIb28bbChHgYSA11GlqWy9O3VW3OoDCl58aZBtiyW2eWpLISuMhrQ221u
         Q9gXA4UbpjhVthkHa+oYnQJ53kWJAvb1IVG7TuVW9MYLUAuQBMR2cTtbskRg+gLKOCCK
         PgYefYiykvQpH9/Urrb6TntmHvs1Al5woFvSnyrCAwpm7qWj8RsDmmx2e1b2ypD9bptZ
         SZoWxFXtY3QkZByBjXCx5FzK8JDm+FmKI6RJpqHylDlonvwzLN3Swqt+u0uIcQXauzrD
         DBPQ==
X-Gm-Message-State: AGRZ1gKezsvZtNkXiemMECCqEjRdaLzmbRoFnidkmta+If+6ajUkcBIF
        KTOAqODO+UmGeCxHWzn0f1072m+ZEEcOOw==
X-Google-Smtp-Source: AJdET5dbSZlDRBVYd/fZt/EEaJWjF3IKCu4arImgvPrrxZ2UBnDMoKQokjB1ewlVtBzcxqCSnhfDGA==
X-Received: by 2002:aca:3506:: with SMTP id c6-v6mr5295737oia.308.1542875515637;
        Thu, 22 Nov 2018 00:31:55 -0800 (PST)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com. [209.85.210.48])
        by smtp.gmail.com with ESMTPSA id x9sm307658otq.73.2018.11.22.00.31.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 00:31:55 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id t5so7415836otk.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 00:31:54 -0800 (PST)
X-Received: by 2002:a9d:1715:: with SMTP id i21mr5552699ota.149.1542875514326;
 Thu, 22 Nov 2018 00:31:54 -0800 (PST)
MIME-Version: 1.0
References: <20181113093048.236201-1-acourbot@chromium.org>
 <CAKQmDh-91tHP1VxLisW1A3GR9G7du3F-Y2XrrgoFU=gvhGoP6w@mail.gmail.com>
 <CAPBb6MWJ1Qu9YoRRusOGiC7dioMkgvU=1dCF6XZ4xDUxp7ri9A@mail.gmail.com> <463ac42b795933a54daa8d2bbba3ff1ac2b733db.camel@ndufresne.ca>
In-Reply-To: <463ac42b795933a54daa8d2bbba3ff1ac2b733db.camel@ndufresne.ca>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Thu, 22 Nov 2018 17:31:43 +0900
X-Gmail-Original-Message-ID: <CAPBb6MVzqqgUD5faN06=s-UNA9obxjiBQdMDNDK7m=m3=Utk3w@mail.gmail.com>
Message-ID: <CAPBb6MVzqqgUD5faN06=s-UNA9obxjiBQdMDNDK7m=m3=Utk3w@mail.gmail.com>
Subject: Re: [PATCH] media: venus: fix reported size of 0-length buffers
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 1:49 AM Nicolas Dufresne <nicolas@ndufresne.ca> wro=
te:
>
> Le mercredi 14 novembre 2018 =C3=A0 13:12 +0900, Alexandre Courbot a =C3=
=A9crit :
> > On Wed, Nov 14, 2018 at 3:54 AM Nicolas Dufresne <nicolas@ndufresne.ca>=
 wrote:
> > >
> > >
> > > Le mar. 13 nov. 2018 04 h 30, Alexandre Courbot <acourbot@chromium.or=
g> a =C3=A9crit :
> > > > The last buffer is often signaled by an empty buffer with the
> > > > V4L2_BUF_FLAG_LAST flag set. Such buffers were returned with the
> > > > bytesused field set to the full size of the OPB, which leads
> > > > user-space to believe that the buffer actually contains useful data=
. Fix
> > > > this by passing the number of bytes reported used by the firmware.
> > >
> > > That means the driver does not know on time which one is last. Why no=
t just returned EPIPE to userspace on DQBUF and ovoid this useless roundtri=
p ?
> >
> > Sorry, I don't understand what you mean. EPIPE is supposed to be
> > returned after a buffer with V4L2_BUF_FLAG_LAST is made available for
> > dequeue. This patch amends the code that prepares this LAST-flagged
> > buffer. How could we avoid a roundtrip in this case?
>
> Maybe it has changed, but when this was introduced, we found that some
> firmware (Exynos MFC) could not know which one is last. Instead, it
> gets an event saying there will be no more buffers.
>
> Sending buffers with payload size to 0 just for the sake of setting the
> V4L2_BUF_FLAG_LAST was considered a waste. Specially that after that,
> every polls should return EPIPE. So in the end, we decided the it
> should just unblock the userspace and return EPIPE.
>
> If you look at the related GStreamer code, it completely ignores the
> LAST flag. With fake buffer of size 0, userspace will endup dequeuing
> and throwing away. This is not useful to the process of terminating the
> decoding. To me, this LAST flag is not useful in this context.

Note that this patch does not interfere with DQBUF returning -EPIPE
after the last buffer has been dequeued. It just fixes an invalid size
that was returned for the last buffer.

Note also that if I understand the doc properly, the kernel driver
*must* set the V4L2_BUF_FLAG_LAST on the last buffer. With Venus the
last buffer is signaled by the firmware with an empty buffer. That's
not something we can change or predict earlier, so in order to respect
the specification we need to return that empty buffer. After that
DQBUF will behave as expected (returning -EPIPE), so GStreamer should
be happy as well.

Without the proposed fix however, GStreamer would receive the last
buffer with an incorrect size, and thus interpret random data as a
frame.

So to me this fix seems to be both correct, and needed. Isn't it?

Cheers,
Alex.
