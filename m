Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3715FECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5AB520661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KMYuT974"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5AB520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbeGTMVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 08:21:38 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:39889 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbeGTMVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 08:21:38 -0400
Received: by mail-yb0-f194.google.com with SMTP id k124-v6so4492786ybk.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 04:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J9a2aU9NvxhFScVBSoJn1INAlVasF0taOD+jKhgcVgM=;
        b=KMYuT974hVc8eubgQEf/yAB/7d38VBhSMeM47WeHd8jpXGB/JprFozhfCYdsNy8GHS
         ndm97PvZ5/VtrGp2xaNNKpswOT5Er1XhQd+9vzwWnaXPfJlY+gCVjnUUKp7UgxkJ/sPl
         OcpGWdFg8G0G3RRCVXLSwcwGGUKDv7E1jLFKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J9a2aU9NvxhFScVBSoJn1INAlVasF0taOD+jKhgcVgM=;
        b=JSALRS2kWUWPAgM1yn/FFlDbkKcq0Dei7ls18g0sgwf1w8BWshbA07xHuNYI00qda8
         ir88PeMHUAkzwL6u0zg8pFASxbWBvF/VX2NzvZuXaEBiscb8Fb2EvMa4b95dqLUijP3j
         Kp9udBrYIfJ12E/j8hYIE2Ufxug5gMLsnvPDPqSZMkLSQMSMqfi8pKxkfjCW25ZwIxhi
         fsu9k8A20bYS4OVpSn8MRMOHddCmdB0fp8uMAI4MyNmXWUDsJOPWi3XUY3zXo2GcWDhF
         oXcBo+V1Y7qW9D+3OoSKvSgKtqbwre8bVwVvR7SAUISAXBn+cKmRXvDF+cyOvgBdH3Xl
         GFIQ==
X-Gm-Message-State: AOUpUlGmeBdU+U7Jzi8frpQW6YKsxL6GGLVno3RCalC+YcJ4rEYi6XDX
        9G1M7o9NWuB5JnZVNiSkxHPvets2nnM=
X-Google-Smtp-Source: AAOMgpd7EKTY8WM8tFyvlX8Dirwm2hoPvsAtrouPe8aBVCjbj3iPS6n8k+UlZsMlzm2t8UpoM1AebQ==
X-Received: by 2002:a25:d7ce:: with SMTP id o197-v6mr783595ybg.175.1532086427464;
        Fri, 20 Jul 2018 04:33:47 -0700 (PDT)
Received: from mail-yb0-f170.google.com (mail-yb0-f170.google.com. [209.85.213.170])
        by smtp.gmail.com with ESMTPSA id q3-v6sm748940ywh.95.2018.07.20.04.33.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 04:33:46 -0700 (PDT)
Received: by mail-yb0-f170.google.com with SMTP id s8-v6so4493985ybe.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 04:33:45 -0700 (PDT)
X-Received: by 2002:a25:5709:: with SMTP id l9-v6mr809164ybb.226.1532086425074;
 Fri, 20 Jul 2018 04:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <eb2b495fe7e8bbeaf3f9e2814be4923583482852.camel@collabora.com>
 <Pine.LNX.4.44L0.1807171643120.1344-100000@iolanthe.rowland.org>
 <CAAFQd5D4YHOkMhyTmpPzpp9aPNoZtJMHgU1xmvb4PoPRaOFrbg@mail.gmail.com> <CAJs94EY4x7GWuT1tF4cPquLRDFR060CuZAxS75nhOf0deYbG2w@mail.gmail.com>
In-Reply-To: <CAJs94EY4x7GWuT1tF4cPquLRDFR060CuZAxS75nhOf0deYbG2w@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 20 Jul 2018 20:33:33 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Bwokm4GH5qXTDFCyH=cN2T-r5bR4F036-TGA+CK77MCA@mail.gmail.com>
Message-ID: <CAAFQd5Bwokm4GH5qXTDFCyH=cN2T-r5bR4F036-TGA+CK77MCA@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: usb: pwc: Don't use coherent DMA buffers for
 ISO transfer
To:     "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Ezequiel Garcia <ezequiel@collabora.com>, hdegoede@redhat.com,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        rostedt@goodmis.org, mingo@redhat.com,
        Mike Isely <isely@pobox.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Colin King <colin.king@canonical.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        keiichiw@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 8:23 PM Matwey V. Kornilov <matwey@sai.msu.ru> wrote:
>
> 2018-07-20 13:55 GMT+03:00 Tomasz Figa <tfiga@chromium.org>:
> > On Wed, Jul 18, 2018 at 5:51 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> >>
> >> On Tue, 17 Jul 2018, Ezequiel Garcia wrote:
> >>
> >> > Hi Matwey,
> >> >
> >> > First of all, sorry for the delay.
> >> >
> >> > Adding Alan and Hans. Guys, do you have any feedback here?
> >>
> >> ...
> >>
> >> > > > So, what is the benefit of using consistent
> >> > > > for these URBs, as opposed to streaming?
> >> > >
> >> > > I don't know, I think there is no real benefit and all we see is a
> >> > > consequence of copy-pasta when some webcam drivers were inspired by
> >> > > others and development priparily was going at x86 platforms.
> >> >
> >> > You are probably right about the copy-pasta.
> >> >
> >> > >  It would
> >> > > be great if somebody corrected me here. DMA Coherence is quite strong
> >> > > property and I cannot figure out how can it help when streaming video.
> >> > > The CPU host always reads from the buffer and never writes to.
> >> > > Hardware perepherial always writes to and never reads from. Moreover,
> >> > > buffer access is mutually exclusive and separated in time by Interrupt
> >> > > fireing and URB starting (when we reuse existing URB for new request).
> >> > > Only single one memory barrier is really required here.
> >> > >
> >> >
> >> > Yeah, and not setting URB_NO_TRANSFER_DMA_MAP makes the USB core
> >> > create DMA mappings and use the streaming API. Which makes more
> >> > sense in hardware without hardware coherency.
> >>
> >> As far as I know, the _only_ advantage to using coherent DMA in this
> >> situation is that you then do not have to pay the overhead of
> >> constantly setting up and tearing down the streaming mappings.  So it
> >> depends very much on the platform: If coherent buffers are cached then
> >> it's a slight win and otherwise it's a big lose.
> >
> > Isn't it about usb_alloc_coherent() being backed by DMA coherent API
> > (dma_alloc_coherent/attrs()) and ending up allocating uncached (or
> > write-combine) memory for devices with non-coherent DMAs? I'm not sure
>
> Yes, this is what exactly happens at armv7l platforms.

Okay, thanks. So this seems to be exactly the same thing that is
happening in the UVC driver. There is quite a bit of random accesses
to extract some header fields and then a big memcpy into VB2 buffer to
assemble final frame.

If we don't want to pay the cost of creating and destroying the
streaming mapping, we could map (dma_map_single()) once, set
transfer_dma of URB and URB_NO_TRANSFER_DMA_MAP and then just
synchronize the caches (dma_sync_single()) before submitting/after
completing the URB.

Best regards,
Tomasz
