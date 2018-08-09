Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66571C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DEC120883
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIh9T53w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DEC120883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sai.msu.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbeHILmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 07:42:31 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34045 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbeHILmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 07:42:31 -0400
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so8704328ois.1;
        Thu, 09 Aug 2018 02:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=3+yh/LCE+gFQAaCYosmmo2U52vbDcAfQ3dAwUostApE=;
        b=eIh9T53w3Kg/RqaF44mQAMvEg5rz/cm/Vnw8C7w0EukAxXUvoehoKDp9dyeJT581c5
         SKn+MpELWNd/MwWv45CokjgU7nJSeLwGoIwn0box5Vm02rYfHgMZ0JoUdS81P7K6d0GF
         LlT5MZaHkhOjrWx+S4fwrlSjf6eBwecxbkBEkZnnmv7LoFDkibPFixgrkgHZzmjiSq9F
         3mmiHXG4AV0ze3i5NNDUWZRBuq87UMBGliDgVTp8X5TmaA7hQcbzqoda519cwS4/osQW
         YGELZkCgkzVk23bxnprpVUaUafnuorzofCVLulmd+KMznh3LG3pafUtrxMClC1LaSIcB
         XxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=3+yh/LCE+gFQAaCYosmmo2U52vbDcAfQ3dAwUostApE=;
        b=hXtQdaEBIN5EgdPq2Ln0t3G+LEpinYRlUs2P5MNIEn1sF0FwqNwnFa+3GPnCPTqVFW
         LgpxRZPDwXkpUynHx8MdvctzLPZ0FcNBjKR6c2dWVAjdEfeNTEOj9IcpB7hN9+v6YcpB
         7DqqcK8qrTedoDdSGRc/RTtz/O0HjapZG/afBAleJRVkuvp69Wi/dtCSOKrYwoKkjGu+
         1OAEJ2WOpVKD6BHlxOLJPr8M2+/s9gQSlgbAOa03g6XXX/u5MblGjtqZPKUVUAj/bKS6
         2vP9q6FX9r1N9A3Bg4HHKJg7NsBDFj/L03Bhs5ToLSiCzfIYGSSsJx2lYM1A6nCD5Ss+
         vpsg==
X-Gm-Message-State: AOUpUlH3hAdZB4iNGA99SzLusBQnpUhHNcaduYDFJ+7AlOPBbJj7jTf7
        trpfTw4wP+Tqpq2YsJ8L7CSfPtt4zkOTvX2x0Uw4koy0
X-Google-Smtp-Source: AA+uWPxQ9ldQuXZbM3QrRkSgskYG2z8EkIhFmqJUdY4URZiNs1DhHbimXuIv0cc9urXcSEQQcvkbKuQEBSecMWAm6ts=
X-Received: by 2002:aca:4455:: with SMTP id r82-v6mr1412175oia.260.1533806313496;
 Thu, 09 Aug 2018 02:18:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:734:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 02:18:13 -0700 (PDT)
In-Reply-To: <2175835.YAv5WQJWxC@avalon>
References: <20180622120419.7675-1-matwey@sai.msu.ru> <20180622120419.7675-3-matwey@sai.msu.ru>
 <2175835.YAv5WQJWxC@avalon>
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
Date:   Thu, 9 Aug 2018 12:18:13 +0300
X-Google-Sender-Auth: JsndqUvGWe803MDGWHjSo4jZpaQ
Message-ID: <CAJs94EYX13oPHiD=Ck5E9cG=z3JMZ9Szs5kRaKHn9F90+uxQ8Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] media: usb: pwc: Don't use coherent DMA buffers
 for ISO transfer
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Mike Isely <isely@pobox.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Colin King <colin.king@canonical.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-09 1:46 GMT+03:00 Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
> Hi Matwey,
>
> Thank you for the patch.
>
> On Friday, 22 June 2018 15:04:19 EEST Matwey V. Kornilov wrote:
>> DMA cocherency slows the transfer down on systems without hardware
>> coherent DMA.
>>
>> Based on previous commit the following performance benchmarks have been
>> carried out. Average memcpy() data transfer rate (rate) and handler
>> completion time (time) have been measured when running video stream at
>> 640x480 resolution at 10fps.
>>
>> x86_64 based system (Intel Core i5-3470). This platform has hardware
>> coherent DMA support and proposed change doesn't make big difference here.
>>
>>  * kmalloc:            rate = (4.4 +- 1.0) GBps
>>                        time = (2.4 +- 1.2) usec
>>  * usb_alloc_coherent: rate = (4.1 +- 0.9) GBps
>>                        time = (2.5 +- 1.0) usec
>>
>> We see that the measurements agree well within error ranges in this case.
>> So no performance downgrade is introduced.
>>
>> armv7l based system (TI AM335x BeagleBone Black). This platform has no
>> hardware coherent DMA support. DMA coherence is implemented via disabled
>> page caching that slows down memcpy() due to memory controller behaviour.
>>
>>  * kmalloc:            rate =  (190 +-  30) MBps
>>                        time =   (50 +-  10) usec
>>  * usb_alloc_coherent: rate =   (33 +-   4) MBps
>>                        time = (3000 +- 400) usec
>>
>> Note, that quantative difference leads (this commit leads to 5 times
>> acceleration) to qualitative behavior change in this case. As it was
>> stated before, the video stream can not be successfully received at AM335x
>> platforms with MUSB based USB host controller due to performance issues
>> [1].
>>
>> [1] https://www.spinics.net/lists/linux-usb/msg165735.html
>>
>> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
>> ---
>>  drivers/media/usb/pwc/pwc-if.c | 12 +++---------
>>  1 file changed, 3 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/media/usb/pwc/pwc-if.c b/drivers/media/usb/pwc/pwc-if.c
>> index 72d2897a4b9f..339a285600d1 100644
>> --- a/drivers/media/usb/pwc/pwc-if.c
>> +++ b/drivers/media/usb/pwc/pwc-if.c
>> @@ -427,11 +427,8 @@ static int pwc_isoc_init(struct pwc_device *pdev)
>>               urb->interval = 1; // devik
>>               urb->dev = udev;
>>               urb->pipe = usb_rcvisocpipe(udev, pdev->vendpoint);
>> -             urb->transfer_flags = URB_ISO_ASAP | URB_NO_TRANSFER_DMA_MAP;
>> -             urb->transfer_buffer = usb_alloc_coherent(udev,
>> -                                                       ISO_BUFFER_SIZE,
>> -                                                       GFP_KERNEL,
>> -                                                       &urb->transfer_dma);
>> +             urb->transfer_flags = URB_ISO_ASAP;
>> +             urb->transfer_buffer = kmalloc(ISO_BUFFER_SIZE, GFP_KERNEL);
>
> ISO_BUFFER_SIZE is 970 bytes, well below a page size, so this should be fine.
> However, for other USB camera drivers, we might require larger buffers
> spanning multiple pages, and kmalloc() wouldn't be a very good choice there. I
> thus believe we should implement a helper function, possibly in the for of
> usb_alloc_noncoherent(), to allow picking the right allocation mechanism based
> on the buffer size (and possibly other parameters). Ideally the helper and the
> USB core should cooperate to avoid any overhead from DMA operations when DMA
> is coherent on the platform (on x86 and some ARM platforms).

pwc/pwc.h:

#define ISO_FRAMES_PER_DESC     10
#define ISO_MAX_FRAME_SIZE      960
#define ISO_BUFFER_SIZE         (ISO_FRAMES_PER_DESC * ISO_MAX_FRAME_SIZE)

The buffer size is 9600 bytes, where did 970 come from?

>
> That being said, I don't see a reason why this patch should be blocked until
> we get such a helper function, we can also implement it when needed for
> another USB webcam driver (likely uvcvideo given the recent discussions) and
> then use it in the pwc driver.
>
> We have also determined that performances can be further improved by keeping
> mappings around and using the dma_sync_* operations at runtime. That's again
> not a reason to block this patch, as the performance improvement is already
> impressive, so

I've incorporated this changes in v3, I'll send it shortly.

>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> But I would still like to see the above two issues addressed. If you'd like to
> give them a go, with or without getting v2 of this series merged first, please
> do so, and I'll happily review patches.
>
>>               if (urb->transfer_buffer == NULL) {
>>                       PWC_ERROR("Failed to allocate urb buffer %d\n", i);
>>                       pwc_isoc_cleanup(pdev);
>> @@ -491,10 +488,7 @@ static void pwc_iso_free(struct pwc_device *pdev)
>>               if (pdev->urbs[i]) {
>>                       PWC_DEBUG_MEMORY("Freeing URB\n");
>>                       if (pdev->urbs[i]->transfer_buffer) {
>> -                             usb_free_coherent(pdev->udev,
>> -                                     pdev->urbs[i]->transfer_buffer_length,
>> -                                     pdev->urbs[i]->transfer_buffer,
>> -                                     pdev->urbs[i]->transfer_dma);
>> +                             kfree(pdev->urbs[i]->transfer_buffer);
>>                       }
>>                       usb_free_urb(pdev->urbs[i]);
>>                       pdev->urbs[i] = NULL;
>
> --
> Regards,
>
> Laurent Pinchart
>
>
>



-- 
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Russia
119234, Moscow, Universitetsky pr-k 13, +7 (495) 9392382
