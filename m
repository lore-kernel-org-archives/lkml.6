Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4489C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EEC1208D4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kl/sKrCm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EEC1208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbeHHSsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:48:23 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:35167 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeHHSsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:48:22 -0400
Received: by mail-yw1-f68.google.com with SMTP id s68-v6so1988706ywg.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 09:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c4aG9S+P6qHJ+LF4J6q6NTKioRqfs9B17s0YLTLIgak=;
        b=kl/sKrCmOF1rJHYAutIa03UorDMEIJXEaufAAAQvKICoXQLGwGav4ws1Um3VNBAgHw
         pLX2nrV4W5UT7OXErREoKnDb8mfY7DZWQhxfI1F9usVFe0eojF4/9IysrYQFU8HD4RXE
         VWajuxv/iyGvptQipKPn35Ka+5uFkpEOsEIJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c4aG9S+P6qHJ+LF4J6q6NTKioRqfs9B17s0YLTLIgak=;
        b=SxG2W38Ifv7gJBkOAGvioDBv1Ps3cgYsC25pBWqCr3JVawMaWzVI7cUHo0yw9KMrd+
         XbQJDJBEvx+jK08dLNQD1UTfxW2VyBk3oox5jWGiVPOZHfJfr1LdzzlZMZ57Y5EqYP+T
         OUnbooWQKlA764iTYvFVH8EX16Xe8FkF/THml49e3R7sGeJbwvpHk4PlOQeLZqlrMe0i
         aeh5scbKeGNyAwqblPnHtmMfX8kopa9C13SWC/1/AGtQqcNsXvOTTmUXFBvq9icNACIf
         6aSi8NrJ3zc+bPPV4qAo0jgAM4tO7HrcrXuU6PLwnvLo4LHsdkmgG0zVtatJaaJ3rojJ
         K43Q==
X-Gm-Message-State: AOUpUlG3ZcMGWB5hReBy0rk0lTY8449M4BEJDVpMaT19vjF6xNSbTzHr
        JZ2l+jgqG1u1FbGPtQoGWT3TYoNcZds=
X-Google-Smtp-Source: AA+uWPxsijp5Ss1YbLIqdIZq2DHE/oGvJbh+8WIyyLKwAlV/1KxCB2tOBcMRpwBYmFPffHU8bvCJGg==
X-Received: by 2002:a0d:e9c1:: with SMTP id s184-v6mr1870506ywe.506.1533745675913;
        Wed, 08 Aug 2018 09:27:55 -0700 (PDT)
Received: from mail-yw1-f46.google.com (mail-yw1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id 203-v6sm2202587ywv.34.2018.08.08.09.27.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 09:27:55 -0700 (PDT)
Received: by mail-yw1-f46.google.com with SMTP id s68-v6so1988633ywg.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 09:27:54 -0700 (PDT)
X-Received: by 2002:a81:5403:: with SMTP id i3-v6mr1745919ywb.365.1533745674387;
 Wed, 08 Aug 2018 09:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <Pine.LNX.4.44L0.1808081015110.1466-100000@iolanthe.rowland.org> <1959555.Z0pJAWgXVZ@avalon>
In-Reply-To: <1959555.Z0pJAWgXVZ@avalon>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 9 Aug 2018 01:27:42 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AFSFKeMhdpW5PusrtcvD1f9DSu7_MQQyy6fB=HbHvVLw@mail.gmail.com>
Message-ID: <CAAFQd5AFSFKeMhdpW5PusrtcvD1f9DSu7_MQQyy6fB=HbHvVLw@mail.gmail.com>
Subject: Re: [RFC PATCH v1] media: uvcvideo: Cache URB header data before processing
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>, keiichiw@chromium.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Douglas Anderson <dianders@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 9, 2018 at 1:21 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hello,
>
> On Wednesday, 8 August 2018 17:20:21 EEST Alan Stern wrote:
> > On Wed, 8 Aug 2018, Keiichi Watanabe wrote:
> > > Hi Laurent, Kieran, Tomasz,
> > >
> > > Thank you for reviews and suggestions.
> > > I want to do additional measurements for improving the performance.
> > >
> > > Let me clarify my understanding:
> > > Currently, if the platform doesn't support coherent-DMA (e.g. ARM),
> > > urb_buffer is allocated by usb_alloc_coherent with
> > > URB_NO_TRANSFER_DMA_MAP flag instead of using kmalloc.
> >
> > Not exactly.  You are mixing up allocation with mapping.  The speed of
> > the allocation doesn't matter; all that matters is whether the memory
> > is cached and when it gets mapped/unmapped.
> >
> > > This is because we want to avoid frequent DMA mappings, which are
> > > generally expensive. However, memories allocated in this way are not
> > > cached.
> > >
> > > So, we wonder if using usb_alloc_coherent is really fast.
> > > In other words, we want to know which is better:
> > > "No DMA mapping/Uncached memory" v.s. "Frequent DMA mapping/Cached
> > > memory".
>
> The second option should also be split in two:
>
> - cached memory with DMA mapping/unmapping around each transfer
> - cached memory with DMA mapping/unmapping at allocation/free time, and DMA
> sync around each transfer
>
> The second option should in theory lead to at least slightly better
> performances, but tests with the pwc driver have reported contradictory
> results. I'd like to know whether that's also the case with the uvcvideo
> driver, and if so, why.

I thought that the results from retesting on pwc, after making sure
that cpu frequency stays the same all the time, actually clarified
this and indeed map once, sync repeatedly was the fastest?

Best regards,
Tomasz
