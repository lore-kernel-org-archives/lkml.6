Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E784ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A51120652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fE3XC5e/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A51120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sai.msu.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbeGTMpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 08:45:53 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39701 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbeGTMpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 08:45:53 -0400
Received: by mail-oi0-f65.google.com with SMTP id d189-v6so20853951oib.6;
        Fri, 20 Jul 2018 04:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=3KBhkYM0//pFIijGA7jXwPIu8+FxotN64wPWzocx7wg=;
        b=fE3XC5e//jxx4W0WkPyLjCSTIjgE0s9RMd50WcQ9ii5cNvz3VLjjaSByRHM84fYoas
         rblk3TVP7PjyvQsZEspLqSSPdjVUDwkcRCGWw7nr3yhsETrJHm9lHWWnMOgOHka//sd7
         By+f+QenW3An2m2kAth1As7qFmsx2lqBQ/jcw7uaS7ZjBtzOO3FyDtIQBe/8akzOUHDR
         QNKahoLMKHSzV2WzjxjtlLH+H5baVljsuXdmxu2ov4hjrOaNQAxTFflCawMO/eZHMMW6
         6J5cknRPlTlhFMqMkkQX+896ilqxHUMJ5WRJxkTApoAW3lrFYSM5/izcOP1nKpbu7nOs
         fqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=3KBhkYM0//pFIijGA7jXwPIu8+FxotN64wPWzocx7wg=;
        b=WFeu6LTZzJfUk0o7zTF5UzowNdxtb8rVS26HUkFOmsSwfBqW58+FmyElcp0+VfD3PU
         hnppf25ZIc8tsMqCU7QQPtyeacyyCD+Q865vJ33u5cA2ZSBFg1U6aOW0F8xty77fHa+i
         LGFP56zWf5o2v3U8lGGwX44JT1sQks+OeTzkVwVeFJJZ6LfZY7Yvjp2NvnBAtAJSTAyl
         eh7IXu3jVMsnPH8vZV0vAKR+CJ153AXLm24IFApyGASfXmjkIiih/PcGvgbAhEa25yR9
         fm8Ncn1iHdjMszugDxk8IYSJgT6ubdRBXS9asZs2wxxxzJ/ilqy72Jfa8OTkrvlL3MwV
         OXMw==
X-Gm-Message-State: AOUpUlFwVlHM8n8i1DKi9F1kjfZ1GpjDpFvHf8cIXUHxBWymlnH4sI1K
        3FA7Rd6eV4SR+tzOxpyFeaWcUYxTlVhexeVPyDM=
X-Google-Smtp-Source: AAOMgpdNHlYRy53nLXxQeTsb1tS+4BYefJqFqoB2yVum+m17NZ/LOVINK184IqGEKSGO4EiqlA2yy9SppROaHrEIv3I=
X-Received: by 2002:aca:c514:: with SMTP id v20-v6mr1889441oif.153.1532087878629;
 Fri, 20 Jul 2018 04:57:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:734:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 04:57:38 -0700 (PDT)
In-Reply-To: <CAAFQd5Bwokm4GH5qXTDFCyH=cN2T-r5bR4F036-TGA+CK77MCA@mail.gmail.com>
References: <eb2b495fe7e8bbeaf3f9e2814be4923583482852.camel@collabora.com>
 <Pine.LNX.4.44L0.1807171643120.1344-100000@iolanthe.rowland.org>
 <CAAFQd5D4YHOkMhyTmpPzpp9aPNoZtJMHgU1xmvb4PoPRaOFrbg@mail.gmail.com>
 <CAJs94EY4x7GWuT1tF4cPquLRDFR060CuZAxS75nhOf0deYbG2w@mail.gmail.com> <CAAFQd5Bwokm4GH5qXTDFCyH=cN2T-r5bR4F036-TGA+CK77MCA@mail.gmail.com>
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
Date:   Fri, 20 Jul 2018 14:57:38 +0300
X-Google-Sender-Auth: eXTOxP4BxIwtNT6Qg6-ENoFIeiM
Message-ID: <CAJs94EaXpiHaJS0M7SxUtmjNAL869sPe9XpC1rorHgJOum-Oog@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: usb: pwc: Don't use coherent DMA buffers for
 ISO transfer
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
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

2018-07-20 14:33 GMT+03:00 Tomasz Figa <tfiga@chromium.org>:
> On Fri, Jul 20, 2018 at 8:23 PM Matwey V. Kornilov <matwey@sai.msu.ru> wrote:
>>
>> 2018-07-20 13:55 GMT+03:00 Tomasz Figa <tfiga@chromium.org>:
>> > On Wed, Jul 18, 2018 at 5:51 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>> >>
>> >> On Tue, 17 Jul 2018, Ezequiel Garcia wrote:
>> >>
>> >> > Hi Matwey,
>> >> >
>> >> > First of all, sorry for the delay.
>> >> >
>> >> > Adding Alan and Hans. Guys, do you have any feedback here?
>> >>
>> >> ...
>> >>
>> >> > > > So, what is the benefit of using consistent
>> >> > > > for these URBs, as opposed to streaming?
>> >> > >
>> >> > > I don't know, I think there is no real benefit and all we see is a
>> >> > > consequence of copy-pasta when some webcam drivers were inspired by
>> >> > > others and development priparily was going at x86 platforms.
>> >> >
>> >> > You are probably right about the copy-pasta.
>> >> >
>> >> > >  It would
>> >> > > be great if somebody corrected me here. DMA Coherence is quite strong
>> >> > > property and I cannot figure out how can it help when streaming video.
>> >> > > The CPU host always reads from the buffer and never writes to.
>> >> > > Hardware perepherial always writes to and never reads from. Moreover,
>> >> > > buffer access is mutually exclusive and separated in time by Interrupt
>> >> > > fireing and URB starting (when we reuse existing URB for new request).
>> >> > > Only single one memory barrier is really required here.
>> >> > >
>> >> >
>> >> > Yeah, and not setting URB_NO_TRANSFER_DMA_MAP makes the USB core
>> >> > create DMA mappings and use the streaming API. Which makes more
>> >> > sense in hardware without hardware coherency.
>> >>
>> >> As far as I know, the _only_ advantage to using coherent DMA in this
>> >> situation is that you then do not have to pay the overhead of
>> >> constantly setting up and tearing down the streaming mappings.  So it
>> >> depends very much on the platform: If coherent buffers are cached then
>> >> it's a slight win and otherwise it's a big lose.
>> >
>> > Isn't it about usb_alloc_coherent() being backed by DMA coherent API
>> > (dma_alloc_coherent/attrs()) and ending up allocating uncached (or
>> > write-combine) memory for devices with non-coherent DMAs? I'm not sure
>>
>> Yes, this is what exactly happens at armv7l platforms.
>
> Okay, thanks. So this seems to be exactly the same thing that is
> happening in the UVC driver. There is quite a bit of random accesses
> to extract some header fields and then a big memcpy into VB2 buffer to
> assemble final frame.
>
> If we don't want to pay the cost of creating and destroying the
> streaming mapping, we could map (dma_map_single()) once, set
> transfer_dma of URB and URB_NO_TRANSFER_DMA_MAP and then just
> synchronize the caches (dma_sync_single()) before submitting/after
> completing the URB.

Thank you. Now it is becoming clearer to me. Please allow me some time
to try to sketch the implementation.

>
> Best regards,
> Tomasz
>



-- 
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Russia
119234, Moscow, Universitetsky pr-k 13, +7 (495) 9392382
