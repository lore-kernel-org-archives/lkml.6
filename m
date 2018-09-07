Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7981DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280262075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GvQQ9KKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280262075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbeIGMsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:48:52 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:44209 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbeIGMsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:48:52 -0400
Received: by mail-yb1-f196.google.com with SMTP id l16-v6so5147946ybk.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 01:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HaLgSJILu3eg4JHLkb8cuHjhZl3dDP+pHPyiB7jDKA4=;
        b=GvQQ9KKbl6f4Gyz3Pb6j70QNAqyHqkL91QwJJBDPw5r8TriyqDWSeeNNiL+f7rzO7V
         5XD/WA1LsQzD72u1e0L08Zd/m0JfZoUvZna7ROXu574HOcYXKWbATedkhK52hfEutcMT
         RlWv77KkQmv5vDcgcriuxqgYpywrmD+QPEmz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HaLgSJILu3eg4JHLkb8cuHjhZl3dDP+pHPyiB7jDKA4=;
        b=s2VGFs5o0+zK/FaXhWZsy1tROStKPD6hlEgw6pJeq6GsH/3a93H1vKTDYqmT8EwYew
         5JFJpahhlmegCcCEOXR0Vr9ERcO5lZq7FwxdgKblgeZHsa68981CJ4nEK9OnIimfF6FT
         m+Zjzev8C+G6Z9rXcb74IyZBb3WR0lHFXZWcYT+SvUoAK+70v/lJrCIKxrBuhqrkZRgD
         1o5VFEXUHoJ82Mn/aUn3f0H2Owf77GtfoitArxHPSpcSkEMgt5qVfvzumCeWH74xdasz
         Yq238VeBpgGXBy7qkI5MKGMvXyoGjFWiDF2q63ZU1riAFDLqpmfbmZzkbI4W0DIa3z0k
         N9IQ==
X-Gm-Message-State: APzg51Bq1cwMF/NKMKvooCm7PxOK7/3ighdatPfXudVYNM/Dt3ZJER1M
        L3zzeQfkSwp4eC1aFvuRoC6udlxpZouw/w==
X-Google-Smtp-Source: ANB0VdaQae8Rk+GczMDf+MIDbAvV14OSo+nMZu9cWW2bMH0MzFP+hABPpVku0CwksqVpgkOqjNK4Vg==
X-Received: by 2002:a25:2517:: with SMTP id l23-v6mr3463107ybl.126.1536307744975;
        Fri, 07 Sep 2018 01:09:04 -0700 (PDT)
Received: from mail-yw1-f46.google.com (mail-yw1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id u67-v6sm2457203ywa.56.2018.09.07.01.09.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 01:09:03 -0700 (PDT)
Received: by mail-yw1-f46.google.com with SMTP id l189-v6so5091286ywb.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 01:09:03 -0700 (PDT)
X-Received: by 2002:a0d:e547:: with SMTP id o68-v6mr3371415ywe.403.1536307743324;
 Fri, 07 Sep 2018 01:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180831074743.235010-1-acourbot@chromium.org>
In-Reply-To: <20180831074743.235010-1-acourbot@chromium.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 7 Sep 2018 17:08:52 +0900
X-Gmail-Original-Message-ID: <CAAFQd5ApyTYdyo4Hpo=+60gD2Jm-aWJ9SJgjm4oM8i7E-h6Nog@mail.gmail.com>
Message-ID: <CAAFQd5ApyTYdyo4Hpo=+60gD2Jm-aWJ9SJgjm4oM8i7E-h6Nog@mail.gmail.com>
Subject: Re: [RFC PATCH] media: docs-rst: Document m2m stateless video decoder interface
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Pawel Osciak <posciak@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

+Maxime Ripard +Ezequiel Garcia +Nicolas Dufresne

On Fri, Aug 31, 2018 at 4:48 PM Alexandre Courbot <acourbot@chromium.org> wrote:
>
> This patch documents the protocol that user-space should follow when
> communicating with stateless video decoders. It is based on the
> following references:
>
> * The current protocol used by Chromium (converted from config store to
>   request API)
>
> * The submitted Cedrus VPU driver
>
> As such, some things may not be entirely consistent with the current
> state of drivers, so it would be great if all stakeholders could point
> out these inconsistencies. :)
>
> This patch is supposed to be applied on top of the Request API V18 as
> well as the memory-to-memory video decoder interface series by Tomasz
> Figa.
>
> It should be considered an early RFC.

Thanks a lot for working on this. I'll review this patch a bit later,
but let me post links to patches on which we had some earlier
discussions, to keep things together:

https://patchwork.kernel.org/patch/10462311/
https://patchwork.kernel.org/patch/10577969/

Also CCd folks who discussed there.

Best regards,
Tomasz
