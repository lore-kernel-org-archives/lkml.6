Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E5CC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3362208E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D6df/HQQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3362208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388733AbeHGJP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:15:27 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33462 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387493AbeHGJP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:15:27 -0400
Received: by mail-yw1-f68.google.com with SMTP id c135-v6so4558756ywa.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 00:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ulSTaWs1/rDROgk/VAFtRirranugEnB55n0Q+VOBir0=;
        b=D6df/HQQahsuEh44+TVMcwkcyeME49noFFvgjzsTGzPTo7MavLgsncgkyK0+1l8fAG
         YH2uaV09aB1RtY4qyrBX8VfoGjsMavfjNmeDUCtAgVplSCR1u8OmjgyAtiKFMRF7kc7C
         hlmTs0ZAbLdR1ZPGsQx3yJdhM0PiW4+R/Sm8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ulSTaWs1/rDROgk/VAFtRirranugEnB55n0Q+VOBir0=;
        b=J51xwE2mCyRHAk/7PwCi7T3ki3qjsbRbj0J4fAXrAqQJbui/M29GK7P2B1bjvCpn5y
         28VrxCdyBT5MnbaH/tOpARXElqdXQL4FCKKtEy5N33yRkLM2M007AbA8tQJc7vGewkTI
         z6uenXfmys9gm74iIFMsCanYFUghcEZeYBrxLXByy1a81AvtTXZhKdCTw+VSpufVPx1/
         CPB6JU75PcIqEAkvIBroORndfocVeHjryGUzZc/gXRPBZ9b4RDa/IVjV7qmqz2pdds80
         bO6/9WCQzuzmXZLR9ZJR1r0NMXUaiwy8Z+ASmB/rzm+K0cCuIM4cA7soo/AmLj56Re4G
         Nt7Q==
X-Gm-Message-State: AOUpUlF5AESVW1u4IFcUeEG16X5aF4YfqDDTgtMRAqLP4AIVleg5gxWC
        B157fm34DbthmSHUCRFaAz9P7XQp7OQ=
X-Google-Smtp-Source: AAOMgpf2zt3fOFIzo7TYS/GYUjDpMY2EG9tZAkXo3mC22rFX0elzl1BniG///a0QXe+OufWZ9y5/AA==
X-Received: by 2002:a81:52d3:: with SMTP id g202-v6mr9814567ywb.380.1533625351536;
        Tue, 07 Aug 2018 00:02:31 -0700 (PDT)
Received: from mail-yw1-f50.google.com (mail-yw1-f50.google.com. [209.85.161.50])
        by smtp.gmail.com with ESMTPSA id 64-v6sm242973ywg.106.2018.08.07.00.02.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 00:02:31 -0700 (PDT)
Received: by mail-yw1-f50.google.com with SMTP id 139-v6so4555506ywg.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 00:02:31 -0700 (PDT)
X-Received: by 2002:a81:5194:: with SMTP id f142-v6mr9165532ywb.46.1533624919918;
 Mon, 06 Aug 2018 23:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180724140621.59624-1-tfiga@chromium.org> <20180724140621.59624-2-tfiga@chromium.org>
 <37a8faea-a226-2d52-36d4-f9df194623cc@xs4all.nl> <CAAFQd5BgGEBmd8gNGc-qqtUtLo=Mh8U+TVTWRsKYMv1LmeBQMA@mail.gmail.com>
 <1532601401.4879.10.camel@pengutronix.de>
In-Reply-To: <1532601401.4879.10.camel@pengutronix.de>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 7 Aug 2018 15:55:08 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BttOq_-DRyj0jr5-WF84JJdBwTFciSoQqY0bsonJbDPA@mail.gmail.com>
Message-ID: <CAAFQd5BttOq_-DRyj0jr5-WF84JJdBwTFciSoQqY0bsonJbDPA@mail.gmail.com>
Subject: Re: [PATCH 1/2] media: docs-rst: Document memory-to-memory video
 decoder interface
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>, kamil@wypas.org,
        a.hajda@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>,
        jtp.park@samsung.com,
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 7:36 PM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> On Thu, 2018-07-26 at 19:20 +0900, Tomasz Figa wrote:
> [...]
> > > You might want to mention that if there are insufficient buffers, then
> > > VIDIOC_CREATE_BUFS can be used to add more buffers.
> > >
> >
> > This might be a bit tricky, since at least s5p-mfc and coda can only
> > work on a fixed buffer set and one would need to fully reinitialize
> > the decoding to add one more buffer, which would effectively be the
> > full resolution change sequence, as below, just with REQBUFS(0),
> > REQBUFS(N) replaced with CREATE_BUFS.
>
> The coda driver supports CREATE_BUFS on the decoder CAPTURE queue.
>
> The firmware indeed needs a fixed frame buffer set, but these buffers
> are internal only and in a coda specific tiling format. The content of
> finished internal buffers is copied / detiled into the external CAPTURE
> buffers, so those can be added at will.

Thanks for clarifying. I forgot about that internal copy indeed.

Best regards,
Tomasz
