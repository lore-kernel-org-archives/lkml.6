Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A28C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF6A21A0D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="VtAVr4ie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF6A21A0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeHHP1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 11:27:20 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:59020 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbeHHP1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 11:27:20 -0400
Received: from [192.168.0.67] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3BDA757;
        Wed,  8 Aug 2018 15:07:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1533733660;
        bh=64uBPjpVX1DC1DvHeg1MA2hgMJklS0qkRNhBjQaN1ek=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VtAVr4ie/JGsPH47TEXhv+1ZP/L/oGd0qo9zAzBEu2tmDWMzED1lhqjO+U60BUKve
         8ALpqy+StitKbZ+WmHtSGqLMaArquWJS0eDHHoI2j3OpCyLQXjs3vfbaZXZUgHDvXA
         rTPG2IKK3/oQEm8VWbYObu6lvIyP+04tt6HsdHoY=
Reply-To: kieran.bingham@ideasonboard.com
Subject: Re: [RFC PATCH v1] media: uvcvideo: Cache URB header data before
 processing
To:     Keiichi Watanabe <keiichiw@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        stern@rowland.harvard.edu, ezequiel@collabora.com,
        matwey@sai.msu.ru
References: <20180627103408.33003-1-keiichiw@chromium.org>
 <11886963.8nkeRH3xvi@avalon>
 <CAAFQd5CM63BQ1oxmrhZuxTVj7pc=6XUJKa-cJ3gFBHxiF3HPfQ@mail.gmail.com>
 <3411643.50e8mdYzJX@avalon>
 <CAD90VcbpeVatm33h2QwGnq_him5KkL1b6n8j0D_RyUyRi3osaQ@mail.gmail.com>
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kieran.bingham@ideasonboard.com; keydata=
 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
 sbsRB8KNNvVXBOVNwko86rQqF9drZuw=
Organization: Ideas on Board
Message-ID: <febb65c6-e4f0-5c78-952f-ae8bbb74d3c0@ideasonboard.com>
Date:   Wed, 8 Aug 2018 14:07:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAD90VcbpeVatm33h2QwGnq_him5KkL1b6n8j0D_RyUyRi3osaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 08/08/18 13:45, Keiichi Watanabe wrote:
> Hi Laurent, Kieran, Tomasz,
> 
> Thank you for reviews and suggestions.
> I want to do additional measurements for improving the performance.
> 
> Let me clarify my understanding:
> Currently, if the platform doesn't support coherent-DMA (e.g. ARM),
> urb_buffer is allocated by usb_alloc_coherent with
> URB_NO_TRANSFER_DMA_MAP flag instead of using kmalloc.
> This is because we want to avoid frequent DMA mappings, which are
> generally expensive.
> However, memories allocated in this way are not cached.
> 
> So, we wonder if using usb_alloc_coherent is really fast.
> In other words, we want to know which is better:
> "No DMA mapping/Uncached memory" v.s. "Frequent DMA mapping/Cached memory".
> 
> For this purpose, I'm planning to measure performance on ARM
> Chromebooks in the following conditions:
> 1. Current implementation with Kieran's patches
> 2. 1. + my patch
> 3. Use kmalloc instead
> 
> 1 and 2 are the same conditions I reported in the first mail on this thread.
> For condition 3, I only have to add "#define CONFIG_DMA_NONCOHERENT"
> at the beginning of uvc_video.c.

I'd be interested in numbers/performances both with and without my async
if possible too.

The async path can be easily disabled temporarily with the following
change: (perhaps this should be a module option?)

diff --git a/drivers/media/usb/uvc/uvc_video.c
b/drivers/media/usb/uvc/uvc_video.c
index 8bb6e90f3483..f9fbdc9bfa4b 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1505,7 +1505,8 @@ static void uvc_video_complete(struct urb *urb)
        }

        INIT_WORK(&uvc_urb->work, uvc_video_copy_data_work);
-       queue_work(stream->async_wq, &uvc_urb->work);
+//     queue_work(stream->async_wq, &uvc_urb->work);
+       uvc_video_copy_data_work(&uvc_urb->work);
 }

 /*


I do suspect that even with cached buffers, it's probably likely we
should still consider the async patches to move the memcopy out of
interrupt context.

--
Regards

Kieran




> 
> Does this plan sound reasonable?
> 
> Best regards,
> Keiichi
> On Wed, Aug 8, 2018 at 5:42 PM Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
>>
>> Hi Tomasz,
>>
>> On Wednesday, 8 August 2018 07:08:59 EEST Tomasz Figa wrote:
>>> On Tue, Jul 31, 2018 at 1:00 AM Laurent Pinchart wrote:
>>>> On Wednesday, 27 June 2018 13:34:08 EEST Keiichi Watanabe wrote:
>>>>> On some platforms with non-coherent DMA (e.g. ARM), USB drivers use
>>>>> uncached memory allocation methods. In such situations, it sometimes
>>>>> takes a long time to access URB buffers.  This can be a cause of video
>>>>> flickering problems if a resolution is high and a USB controller has
>>>>> a very tight time limit. (e.g. dwc2) To avoid this problem, we copy
>>>>> header data from (uncached) URB buffer into (cached) local buffer.
>>>>>
>>>>> This change should make the elapsed time of the interrupt handler
>>>>> shorter on platforms with non-coherent DMA. We measured the elapsed
>>>>> time of each callback of uvc_video_complete without/with this patch
>>>>> while capturing Full HD video in
>>>>> https://webrtc.github.io/samples/src/content/getusermedia/resolution/.
>>>>> I tested it on the top of Kieran Bingham's Asynchronous UVC series
>>>>> https://www.mail-archive.com/linux-media@vger.kernel.org/msg128359.html.
>>>>> The test device was Jerry Chromebook (RK3288) with Logitech Brio 4K.
>>>>> I collected data for 5 seconds. (There were around 480 callbacks in
>>>>> this case.) The following result shows that this patch makes
>>>>> uvc_video_complete about 2x faster.
>>>>>
>>>>>            | average | median  | min     | max     | standard deviation
>>>>> w/o caching| 45319ns | 40250ns | 33834ns | 142625ns| 16611ns
>>>>> w/  caching| 20620ns | 19250ns | 12250ns | 56583ns | 6285ns
>>>>>
>>>>> In addition, we confirmed that this patch doesn't make it worse on
>>>>> coherent DMA architecture by performing the same measurements on a
>>>>> Broadwell Chromebox with the same camera.
>>>>>
>>>>>            | average | median  | min     | max     | standard deviation
>>>>> w/o caching| 21026ns | 21424ns | 12263ns | 23956ns | 1932ns
>>>>> w/  caching| 20728ns | 20398ns |  8922ns | 45120ns | 3368ns
>>>>
>>>> This is very interesting, and it seems related to https://
>>>> patchwork.kernel.org/patch/10468937/. You might have seen that discussion
>>>> as you got CC'ed at some point.
>>>>
>>>> I wonder whether performances couldn't be further improved by allocating
>>>> the URB buffers cached, as that would speed up the memcpy() as well. Have
>>>> you tested that by any chance ?
>>>
>>> We haven't measure it, but the issue being solved here was indeed
>>> significantly reduced by using cached URB buffers, even without
>>> Kieran's async series. After we discovered the latter, we just
>>> backported it and decided to further tweak the last remaining bit, to
>>> avoid playing too much with the DMA API in code used in production on
>>> several different platforms (including both ARM and x86).
>>>
>>> If you think we could change the driver to use cached buffers instead
>>> (as the pwc driver mentioned in another thread), I wouldn't have
>>> anything against it obviously.
>>
>> I think there's a chance that performances could be further improved.
>> Furthermore, it would lean to simpler code as we wouldn't need to deal with
>> caching headers manually. I would however like to see numbers before making a
>> decision.
>>
>> --
>> Regards,
>>
>> Laurent Pinchart
>>
>>
>>

-- 
Regards
--
Kieran
