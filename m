Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E792C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2217F219F5
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="PsmMvPrf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2217F219F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbeHHQJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 12:09:24 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:59272 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeHHQJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 12:09:23 -0400
Received: from [192.168.0.67] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C074C57;
        Wed,  8 Aug 2018 15:49:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1533736175;
        bh=MkIZzjvCsp4pRt0NmJ9D5nN6+jnA+HlImudrZXFDlrU=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PsmMvPrfmshXh9zJtQqfVzWTNlVeJLSoYI/OkMpbpADoS2hobiv1WtYNf3/0ngFC/
         rV4su7jWSOXMcfDmBwTj5R9M4GDme+A4IH3n4GwoH/DAwbw5O2FsPDkivnYRIKy6Cs
         Jy4TP83g9bKoFC60ex0xs2heied5dYTKmFWriRHY=
Reply-To: kieran.bingham@ideasonboard.com
Subject: Re: [PATCH v4 6/6] media: uvcvideo: Move decode processing to process
 context
To:     Tomasz Figa <tfiga@google.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        g.liakhovetski@gmx.de, olivier.braun@stereolabs.com,
        troy.kisky@boundarydevices.com,
        Randy Dunlap <rdunlap@infradead.org>, philipp.zabel@gmail.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.3cb9065dabdf5d455da508fb4109201e626d5ee7.1522168131.git-series.kieran.bingham@ideasonboard.com>
 <cae511f90085701e7093ce39dc8dabf8fc16b844.1522168131.git-series.kieran.bingham@ideasonboard.com>
 <CAAFQd5CQEhmuLbs0dmGfu66x1Xq1V_kOT0bV_DoPitkkOX5Q4A@mail.gmail.com>
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kieran.bingham@ideasonboard.com; keydata=
 xsFNBFYE/WYBEACs1PwjMD9rgCu1hlIiUA1AXR4rv2v+BCLUq//vrX5S5bjzxKAryRf0uHat
 V/zwz6hiDrZuHUACDB7X8OaQcwhLaVlq6byfoBr25+hbZG7G3+5EUl9cQ7dQEdvNj6V6y/SC
 rRanWfelwQThCHckbobWiQJfK9n7rYNcPMq9B8e9F020LFH7Kj6YmO95ewJGgLm+idg1Kb3C
 potzWkXc1xmPzcQ1fvQMOfMwdS+4SNw4rY9f07Xb2K99rjMwZVDgESKIzhsDB5GY465sCsiQ
 cSAZRxqE49RTBq2+EQsbrQpIc8XiffAB8qexh5/QPzCmR4kJgCGeHIXBtgRj+nIkCJPZvZtf
 Kr2EAbc6tgg6DkAEHJb+1okosV09+0+TXywYvtEop/WUOWQ+zo+Y/OBd+8Ptgt1pDRyOBzL8
 RXa8ZqRf0Mwg75D+dKntZeJHzPRJyrlfQokngAAs4PaFt6UfS+ypMAF37T6CeDArQC41V3ko
 lPn1yMsVD0p+6i3DPvA/GPIksDC4owjnzVX9kM8Zc5Cx+XoAN0w5Eqo4t6qEVbuettxx55gq
 8K8FieAjgjMSxngo/HST8TpFeqI5nVeq0/lqtBRQKumuIqDg+Bkr4L1V/PSB6XgQcOdhtd36
 Oe9X9dXB8YSNt7VjOcO7BTmFn/Z8r92mSAfHXpb07YJWJosQOQARAQABzTBLaWVyYW4gQmlu
 Z2hhbSA8a2llcmFuLmJpbmdoYW1AaWRlYXNvbmJvYXJkLmNvbT7CwYAEEwEKACoCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4ACGQEFAlnDk/gFCQeA/YsACgkQoR5GchCkYf3X5w/9EaZ7
 cnUcT6dxjxrcmmMnfFPoQA1iQXr/MXQJBjFWfxRUWYzjvUJb2D/FpA8FY7y+vksoJP7pWDL7
 QTbksdwzagUEk7CU45iLWL/CZ/knYhj1I/+5LSLFmvZ/5Gf5xn2ZCsmg7C0MdW/GbJ8IjWA8
 /LKJSEYH8tefoiG6+9xSNp1p0Gesu3vhje/GdGX4wDsfAxx1rIYDYVoX4bDM+uBUQh7sQox/
 R1bS0AaVJzPNcjeC14MS226mQRUaUPc9250aj44WmDfcg44/kMsoLFEmQo2II9aOlxUDJ+x1
 xohGbh9mgBoVawMO3RMBihcEjo/8ytW6v7xSF+xP4Oc+HOn7qebAkxhSWcRxQVaQYw3S9iZz
 2iA09AXAkbvPKuMSXi4uau5daXStfBnmOfalG0j+9Y6hOFjz5j0XzaoF6Pln0jisDtWltYhP
 X9LjFVhhLkTzPZB/xOeWGmsG4gv2V2ExbU3uAmb7t1VSD9+IO3Km4FtnYOKBWlxwEd8qOFpS
 jEqMXURKOiJvnw3OXe9MqG19XdeENA1KyhK5rqjpwdvPGfSn2V+SlsdJA0DFsobUScD9qXQw
 OvhapHe3XboK2+Rd7L+g/9Ud7ZKLQHAsMBXOVJbufA1AT+IaOt0ugMcFkAR5UbBg5+dZUYJj
 1QbPQcGmM3wfvuaWV5+SlJ+WeKIb8tbOwU0EVgT9ZgEQAM4o5G/kmruIQJ3K9SYzmPishRHV
 DcUcvoakyXSX2mIoccmo9BHtD9MxIt+QmxOpYFNFM7YofX4lG0ld8H7FqoNVLd/+a0yru5Cx
 adeZBe3qr1eLns10Q90LuMo7/6zJhCW2w+HE7xgmCHejAwuNe3+7yt4QmwlSGUqdxl8cgtS1
 PlEK93xXDsgsJj/bw1EfSVdAUqhx8UQ3aVFxNug5OpoX9FdWJLKROUrfNeBE16RLrNrq2ROc
 iSFETpVjyC/oZtzRFnwD9Or7EFMi76/xrWzk+/b15RJ9WrpXGMrttHUUcYZEOoiC2lEXMSAF
 SSSj4vHbKDJ0vKQdEFtdgB1roqzxdIOg4rlHz5qwOTynueiBpaZI3PHDudZSMR5Fk6QjFooE
 XTw3sSl/km/lvUFiv9CYyHOLdygWohvDuMkV/Jpdkfq8XwFSjOle+vT/4VqERnYFDIGBxaRx
 koBLfNDiiuR3lD8tnJ4A1F88K6ojOUs+jndKsOaQpDZV6iNFv8IaNIklTPvPkZsmNDhJMRHH
 Iu60S7BpzNeQeT4yyY4dX9lC2JL/LOEpw8DGf5BNOP1KgjCvyp1/KcFxDAo89IeqljaRsCdP
 7WCIECWYem6pLwaw6IAL7oX+tEqIMPph/G/jwZcdS6Hkyt/esHPuHNwX4guqTbVEuRqbDzDI
 2DJO5FbxABEBAAHCwWUEGAEKAA8CGwwFAlnDlGsFCQeA/gIACgkQoR5GchCkYf1yYRAAq+Yo
 nbf9DGdK1kTAm2RTFg+w9oOp2Xjqfhds2PAhFFvrHQg1XfQR/UF/SjeUmaOmLSczM0s6XMeO
 VcE77UFtJ/+hLo4PRFKm5X1Pcar6g5m4xGqa+Xfzi9tRkwC29KMCoQOag1BhHChgqYaUH3yo
 UzaPwT/fY75iVI+yD0ih/e6j8qYvP8pvGwMQfrmN9YB0zB39YzCSdaUaNrWGD3iCBxg6lwSO
 LKeRhxxfiXCIYEf3vwOsP3YMx2JkD5doseXmWBGW1U0T/oJF+DVfKB6mv5UfsTzpVhJRgee7
 4jkjqFq4qsUGxcvF2xtRkfHFpZDbRgRlVmiWkqDkT4qMA+4q1y/dWwshSKi/uwVZNycuLsz+
 +OD8xPNCsMTqeUkAKfbD8xW4LCay3r/dD2ckoxRxtMD9eOAyu5wYzo/ydIPTh1QEj9SYyvp8
 O0g6CpxEwyHUQtF5oh15O018z3ZLztFJKR3RD42VKVsrnNDKnoY0f4U0z7eJv2NeF8xHMuiU
 RCIzqxX1GVYaNkKTnb/Qja8hnYnkUzY1Lc+OtwiGmXTwYsPZjjAaDX35J/RSKAoy5wGo/YFA
 JxB1gWThL4kOTbsqqXj9GLcyOImkW0lJGGR3o/fV91Zh63S5TKnf2YGGGzxki+ADdxVQAm+Q
 sbsRB8KNNvVXBOVNwko86rQqF9drZuw=
Organization: Ideas on Board
Message-ID: <2b71a365-ce3b-8eaa-67d7-7577bac2d5b0@ideasonboard.com>
Date:   Wed, 8 Aug 2018 14:49:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAAFQd5CQEhmuLbs0dmGfu66x1Xq1V_kOT0bV_DoPitkkOX5Q4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

On 07/08/18 10:54, Tomasz Figa wrote:
> Hi Kieran,
> 
> On Wed, Mar 28, 2018 at 1:47 AM Kieran Bingham
> <kieran.bingham@ideasonboard.com> wrote:
> [snip]
>> @@ -1544,25 +1594,29 @@ static int uvc_alloc_urb_buffers(struct uvc_streaming *stream,
>>   */
>>  static void uvc_uninit_video(struct uvc_streaming *stream, int free_buffers)
>>  {
>> -       struct urb *urb;
>> -       unsigned int i;
>> +       struct uvc_urb *uvc_urb;
>>
>>         uvc_video_stats_stop(stream);
>>
>> -       for (i = 0; i < UVC_URBS; ++i) {
>> -               struct uvc_urb *uvc_urb = &stream->uvc_urb[i];
>> +       /*
>> +        * We must poison the URBs rather than kill them to ensure that even
>> +        * after the completion handler returns, any asynchronous workqueues
>> +        * will be prevented from resubmitting the URBs
>> +        */
>> +       for_each_uvc_urb(uvc_urb, stream)
>> +               usb_poison_urb(uvc_urb->urb);
>>
>> -               urb = uvc_urb->urb;
>> -               if (urb == NULL)
>> -                       continue;
>> +       flush_workqueue(stream->async_wq);
>>
>> -               usb_kill_urb(urb);
>> -               usb_free_urb(urb);
>> +       for_each_uvc_urb(uvc_urb, stream) {
>> +               usb_free_urb(uvc_urb->urb);
>>                 uvc_urb->urb = NULL;
>>         }
>>
>>         if (free_buffers)
>>                 uvc_free_urb_buffers(stream);
>> +
>> +       destroy_workqueue(stream->async_wq);
> 
> In our testing, this function ends up being called twice, if before
> suspend the camera is streaming and if the camera disconnects between
> suspend and resume. This is because uvc_video_suspend() calls this
> function (with free_buffers = 0), but uvc_video_resume() wouldn't call
> uvc_init_video() due to an earlier failure and uvc_v4l2_release()
> would end up calling this function again, while the workqueue is
> already destroyed.
> 
> The following diff seems to take care of it:

Thank you for the investigation and patch report ;D

I think moving the workqueue allocation might be a reasonable option as
suggested by Laurent in his review.

I'll look further into this when I get to another spin of the series.


> 
> 8<~~~
> diff --git a/drivers/media/usb/uvc/uvc_video.c
> b/drivers/media/usb/uvc/uvc_video.c
> index c5e0ab564b1a..6fb890c8ba67 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -1493,10 +1493,11 @@ static void uvc_uninit_video(struct
> uvc_streaming *stream, int free_buffers)
>                uvc_urb->urb = NULL;
>        }
> 
> -       if (free_buffers)
> +       if (free_buffers) {
>                uvc_free_urb_buffers(stream);
> -
> -       destroy_workqueue(stream->async_wq);
> +               destroy_workqueue(stream->async_wq);
> +               stream->async_wq = NULL;
> +       }
> }
> 
> /*
> @@ -1648,10 +1649,12 @@ static int uvc_init_video(struct uvc_streaming
> *stream, gfp_t gfp_flags)
> 
>        uvc_video_stats_start(stream);
> 
> -       stream->async_wq = alloc_workqueue("uvcvideo", WQ_UNBOUND | WQ_HIGHPRI,
> -                       0);
> -       if (!stream->async_wq)
> -               return -ENOMEM;
> +       if (!stream->async_wq) {
> +               stream->async_wq = alloc_workqueue("uvcvideo",
> +                                                  WQ_UNBOUND | WQ_HIGHPRI, 0);
> +               if (!stream->async_wq)
> +                       return -ENOMEM;
> +       }
> 
>        if (intf->num_altsetting > 1) {
>                struct usb_host_endpoint *best_ep = NULL;
> ~~~>8
> 
> Best regards,
> Tomasz
> 

-- 
Regards
--
Kieran
