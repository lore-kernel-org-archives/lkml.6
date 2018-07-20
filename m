Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C466ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B2720673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gKh9EB79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B2720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbeGTLnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 07:43:25 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:37100 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbeGTLnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 07:43:25 -0400
Received: by mail-yb0-f195.google.com with SMTP id r3-v6so4463488ybo.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 03:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9KzDb9stgx9l2CJByrnMYfMZEin6YTqcaj9BIPOPqdU=;
        b=gKh9EB79tT9HY87oJ/7W7DxOtfRhBjPOSwBYDddtlieNtyZhkqDjH72H+nKNR4Z1US
         DVG2rb2/elrliGpZpyxg2sMOPwbj2IN26UDKj4WTXXvYWtJnjKmqojk+fBB3x35oVmBl
         jp7Fah5aTnKpN88BTWM0KEbcvATLWShycTQi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9KzDb9stgx9l2CJByrnMYfMZEin6YTqcaj9BIPOPqdU=;
        b=fmw34Azy8QTa/qEc1ZTpS92ezAwKxuAxUR0lZ8e+RuW8VZrbtacxmMm3QpQF4LLU1U
         IGnMcP3pCfwBP3uxG7y4TQ9O58QK27J3JUTOKExhPUP0gEqdcLurTQ8zqSQNm2Vvkgsf
         N4pZwv0ZeWL0J5rjeLRgAbYUK8FSc9pSALXhvtl5hW9Tt8dkNzlhwKofbWf/Afgs5qqy
         HhtvlxpVwYeE1z9DYhrDchH+U/TZE5dXt6ErDvFS402YJr8Fza8gHjbZTHqZ3MN0Jk6l
         JhvP5CLY9hQPAv+iqvLnWHQKpwSjNt66rQxuHoLh2VQRUSOpU5MuutrboMeYS3RdM0Rv
         DO2A==
X-Gm-Message-State: AOUpUlE9kvLkUY/F/Vdrx+Melojvt63QwPwNEkKb4GhfzeyQ8Oe5aVIn
        hFnFR6GvC09EpBiBOEjeJ8xVxiYExCE=
X-Google-Smtp-Source: AAOMgpfEx3RbjNk2TCB9lokuUv/ftbsjSnmrNHRsIFlXA+X4R+p8W9CG76pj3Biklarpp2xd8lScOA==
X-Received: by 2002:a25:3105:: with SMTP id x5-v6mr710186ybx.468.1532084143511;
        Fri, 20 Jul 2018 03:55:43 -0700 (PDT)
Received: from mail-yb0-f178.google.com (mail-yb0-f178.google.com. [209.85.213.178])
        by smtp.gmail.com with ESMTPSA id f64-v6sm747762ywd.58.2018.07.20.03.55.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 03:55:41 -0700 (PDT)
Received: by mail-yb0-f178.google.com with SMTP id c3-v6so4453089ybi.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 03:55:41 -0700 (PDT)
X-Received: by 2002:a25:4b01:: with SMTP id y1-v6mr675748yba.344.1532084140544;
 Fri, 20 Jul 2018 03:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <eb2b495fe7e8bbeaf3f9e2814be4923583482852.camel@collabora.com> <Pine.LNX.4.44L0.1807171643120.1344-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1807171643120.1344-100000@iolanthe.rowland.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 20 Jul 2018 19:55:29 +0900
X-Gmail-Original-Message-ID: <CAAFQd5D4YHOkMhyTmpPzpp9aPNoZtJMHgU1xmvb4PoPRaOFrbg@mail.gmail.com>
Message-ID: <CAAFQd5D4YHOkMhyTmpPzpp9aPNoZtJMHgU1xmvb4PoPRaOFrbg@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: usb: pwc: Don't use coherent DMA buffers for
 ISO transfer
To:     stern@rowland.harvard.edu
Cc:     Ezequiel Garcia <ezequiel@collabora.com>, matwey@sai.msu.ru,
        hdegoede@redhat.com, Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        rostedt@goodmis.org, mingo@redhat.com, isely@pobox.com,
        bhumirks@gmail.com, colin.king@canonical.com,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 5:51 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Tue, 17 Jul 2018, Ezequiel Garcia wrote:
>
> > Hi Matwey,
> >
> > First of all, sorry for the delay.
> >
> > Adding Alan and Hans. Guys, do you have any feedback here?
>
> ...
>
> > > > So, what is the benefit of using consistent
> > > > for these URBs, as opposed to streaming?
> > >
> > > I don't know, I think there is no real benefit and all we see is a
> > > consequence of copy-pasta when some webcam drivers were inspired by
> > > others and development priparily was going at x86 platforms.
> >
> > You are probably right about the copy-pasta.
> >
> > >  It would
> > > be great if somebody corrected me here. DMA Coherence is quite strong
> > > property and I cannot figure out how can it help when streaming video.
> > > The CPU host always reads from the buffer and never writes to.
> > > Hardware perepherial always writes to and never reads from. Moreover,
> > > buffer access is mutually exclusive and separated in time by Interrupt
> > > fireing and URB starting (when we reuse existing URB for new request).
> > > Only single one memory barrier is really required here.
> > >
> >
> > Yeah, and not setting URB_NO_TRANSFER_DMA_MAP makes the USB core
> > create DMA mappings and use the streaming API. Which makes more
> > sense in hardware without hardware coherency.
>
> As far as I know, the _only_ advantage to using coherent DMA in this
> situation is that you then do not have to pay the overhead of
> constantly setting up and tearing down the streaming mappings.  So it
> depends very much on the platform: If coherent buffers are cached then
> it's a slight win and otherwise it's a big lose.

Isn't it about usb_alloc_coherent() being backed by DMA coherent API
(dma_alloc_coherent/attrs()) and ending up allocating uncached (or
write-combine) memory for devices with non-coherent DMAs? I'm not sure
how this memory is used by this driver, but if it reads from it using
CPU, uncached mapping might be significantly slower than cached
mapping of memory allocated with kmalloc().

Best regards,
Tomasz
