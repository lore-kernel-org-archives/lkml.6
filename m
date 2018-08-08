Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24038C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 04:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA12F216EE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 04:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I0/5x9b4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA12F216EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbeHHG07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 02:26:59 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35452 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbeHHG0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 02:26:54 -0400
Received: by mail-yw1-f67.google.com with SMTP id s68-v6so623332ywg.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 21:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=94KF+AYQu2rrtsxjoN7wGD+zafk7idyGe1qu8AVDk1Q=;
        b=I0/5x9b4KwL2UxUEdlkNb74zVnQxf7fdXCp9OK7nhz5Set2auxWZe2lgLCe55aw7qf
         FfpjGcMKM2QbkoAKzlQepAdKQZDfGJJwIG60cW5P8zZ+024HOn5XIL5Ql2Fw0pJZv8k/
         /cQxEJcOS7g14lJWd0wy+os3u7uHL5DuBA46s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=94KF+AYQu2rrtsxjoN7wGD+zafk7idyGe1qu8AVDk1Q=;
        b=fupvBqUZ3sadKGI7EkaNkOqC5sMVi/vnx9cmYinMu4dcO0ZaKeqNYAX3HsYUlFHB2m
         r9ORJl5YWiZLbM7YcNK2UnZdGTkzbpUzhkGcYom/X4lCB7ZbgFAk0pDSKj7YEd8BmyE5
         E2KY+oRPcYO18KnuIysh22d4ecqxnqcDw1rN70kWc0zOzuj/6tIqrs20vwPI6zh7IxiL
         6pyxwsxF42Sj3XbtPGI4xlU+hVagUsMgI+N/0nqWuT6f+WCZdUUnGHhy7MqUwo0vturY
         DmboT+6P/eZC66+C0LjCGCqpokxZDOpoNh66XJn0eClpNG25YWkk4g+OyoJlkKT1fIuW
         rQHg==
X-Gm-Message-State: AOUpUlG8tJi1MBySse9L30uNSh5xnL9E83kSS6dl+UATbDlUkxHJQkyb
        cjlA460qyfrtl1NP+m9dSx7nHL1KVao=
X-Google-Smtp-Source: AA+uWPw5/6HSOXbmaYAHv2U8ELZgW2YGdnXT0RuHLd85+UI0YTWgIP1zDqTiHbcHzrzlJJKPLx+jBg==
X-Received: by 2002:a25:ba8b:: with SMTP id s11-v6mr598620ybg.87.1533701353220;
        Tue, 07 Aug 2018 21:09:13 -0700 (PDT)
Received: from mail-yw1-f48.google.com (mail-yw1-f48.google.com. [209.85.161.48])
        by smtp.gmail.com with ESMTPSA id w143-v6sm2634207yww.49.2018.08.07.21.09.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 21:09:12 -0700 (PDT)
Received: by mail-yw1-f48.google.com with SMTP id c135-v6so628951ywa.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 21:09:11 -0700 (PDT)
X-Received: by 2002:a81:5403:: with SMTP id i3-v6mr568902ywb.365.1533701351056;
 Tue, 07 Aug 2018 21:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180627103408.33003-1-keiichiw@chromium.org> <11886963.8nkeRH3xvi@avalon>
In-Reply-To: <11886963.8nkeRH3xvi@avalon>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 8 Aug 2018 13:08:59 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CM63BQ1oxmrhZuxTVj7pc=6XUJKa-cJ3gFBHxiF3HPfQ@mail.gmail.com>
Message-ID: <CAAFQd5CM63BQ1oxmrhZuxTVj7pc=6XUJKa-cJ3gFBHxiF3HPfQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1] media: uvcvideo: Cache URB header data before processing
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     keiichiw@chromium.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Douglas Anderson <dianders@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 1:00 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Keiichi,
>
> (CC'ing Alan, Ezequiel and Matwey)
>
> Thank you for the patch.
>
> On Wednesday, 27 June 2018 13:34:08 EEST Keiichi Watanabe wrote:
> > On some platforms with non-coherent DMA (e.g. ARM), USB drivers use
> > uncached memory allocation methods. In such situations, it sometimes
> > takes a long time to access URB buffers.  This can be a cause of video
> > flickering problems if a resolution is high and a USB controller has
> > a very tight time limit. (e.g. dwc2) To avoid this problem, we copy
> > header data from (uncached) URB buffer into (cached) local buffer.
> >
> > This change should make the elapsed time of the interrupt handler
> > shorter on platforms with non-coherent DMA. We measured the elapsed
> > time of each callback of uvc_video_complete without/with this patch
> > while capturing Full HD video in
> > https://webrtc.github.io/samples/src/content/getusermedia/resolution/.
> > I tested it on the top of Kieran Bingham's Asynchronous UVC series
> > https://www.mail-archive.com/linux-media@vger.kernel.org/msg128359.html.
> > The test device was Jerry Chromebook (RK3288) with Logitech Brio 4K.
> > I collected data for 5 seconds. (There were around 480 callbacks in
> > this case.) The following result shows that this patch makes
> > uvc_video_complete about 2x faster.
> >
> >            | average | median  | min     | max     | standard deviation
> >
> > w/o caching| 45319ns | 40250ns | 33834ns | 142625ns| 16611ns
> > w/  caching| 20620ns | 19250ns | 12250ns | 56583ns | 6285ns
> >
> > In addition, we confirmed that this patch doesn't make it worse on
> > coherent DMA architecture by performing the same measurements on a
> > Broadwell Chromebox with the same camera.
> >
> >            | average | median  | min     | max     | standard deviation
> >
> > w/o caching| 21026ns | 21424ns | 12263ns | 23956ns | 1932ns
> > w/  caching| 20728ns | 20398ns |  8922ns | 45120ns | 3368ns
>
> This is very interesting, and it seems related to https://
> patchwork.kernel.org/patch/10468937/. You might have seen that discussion as
> you got CC'ed at some point.
>
> I wonder whether performances couldn't be further improved by allocating the
> URB buffers cached, as that would speed up the memcpy() as well. Have you
> tested that by any chance ?

We haven't measure it, but the issue being solved here was indeed
significantly reduced by using cached URB buffers, even without
Kieran's async series. After we discovered the latter, we just
backported it and decided to further tweak the last remaining bit, to
avoid playing too much with the DMA API in code used in production on
several different platforms (including both ARM and x86).

If you think we could change the driver to use cached buffers instead
(as the pwc driver mentioned in another thread), I wouldn't have
anything against it obviously.

Best regards,
Tomasz
