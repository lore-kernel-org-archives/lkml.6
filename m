Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553D1C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6DE204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mm-sol.com header.i=@mm-sol.com header.b="aXZeYyvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB6DE204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=mm-sol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbeICT7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:59:06 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:52379 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbeICT7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:59:06 -0400
Received: from [192.168.27.197] (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id F207BCD90;
        Mon,  3 Sep 2018 18:38:22 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1535989102; bh=g/WpekE+4KaCt/LTuHD4Xy/hZGXXZisIHzlgQ/g6wDM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aXZeYyvNkPJikPn1qriVwdc9jSuDe9dnMc0tgPBFPQj+Lx8YlF+LeBztxVVuuDFNd
         W4E2MxVjeYfaOdnxXxVu52lcVxPGR0ntOUcSXnUJMWPjbZagv06kaJtpdaeUgoqAa8
         gu8ce7PPcrdYYfvDrUg5LSjsrc/LQv7M62ySeqIC4j6bSI1h03UTObTAf+ra8cuco8
         4LeB7zqIw62UTGPxVQJbnY6VKnFKegEH+uBrnIPHmdzqNiJ5UOSb2KczGVWHlE/cPT
         CE84OVJxG6SVi0bOHQHbpd5/Cn7URJh+2ZjNyjcOgrEgO5UIy5XVeN9S7r5ne3fYvd
         HRL5x3PaeUSRQ==
Subject: Re: [PATCH v3 16/23] camss: vfe: Support for frame padding
To:     Sakari Ailus <sakari.ailus@iki.fi>, hans.verkuil@cisco.com,
        linux-media@vger.kernel.org
Cc:     Todor Tomov <todor.tomov@linaro.org>, mchehab@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <1500287629-23703-1-git-send-email-todor.tomov@linaro.org>
 <1500287629-23703-17-git-send-email-todor.tomov@linaro.org>
 <20170720151732.h4wmqr56j4tuhk7r@valkosipuli.retiisi.org.uk>
From:   Todor Tomov <ttomov@mm-sol.com>
Message-ID: <90fecd27-3255-fbec-a73f-598cc66a3b31@mm-sol.com>
Date:   Mon, 3 Sep 2018 18:38:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20170720151732.h4wmqr56j4tuhk7r@valkosipuli.retiisi.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari and all,

I'm sorry to up this thread from an year ago but I'm currently thinking
about a problem which is related to this so I decided to ask here.

On 20.07.2017 18:17, Sakari Ailus wrote:
> Hi Todor,
> 
> On Mon, Jul 17, 2017 at 01:33:42PM +0300, Todor Tomov wrote:
>> Add support for horizontal and vertical frame padding.
>>
>> Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
>> ---
>>  drivers/media/platform/qcom/camss-8x16/camss-vfe.c | 86 +++++++++++++++++-----
>>  .../media/platform/qcom/camss-8x16/camss-video.c   | 69 ++++++++++++-----
>>  .../media/platform/qcom/camss-8x16/camss-video.h   |  2 +
>>  3 files changed, 121 insertions(+), 36 deletions(-)
>>

...

>> diff --git a/drivers/media/platform/qcom/camss-8x16/camss-video.c b/drivers/media/platform/qcom/camss-8x16/camss-video.c
>> index c5ebf5c..5a2bf18 100644
>> --- a/drivers/media/platform/qcom/camss-8x16/camss-video.c
>> +++ b/drivers/media/platform/qcom/camss-8x16/camss-video.c

...

>> @@ -542,28 +537,68 @@ static int video_g_fmt(struct file *file, void *fh, struct v4l2_format *f)
>>  	return 0;
>>  }
>>  
>> -static int video_s_fmt(struct file *file, void *fh, struct v4l2_format *f)
>> +static int video_try_fmt(struct file *file, void *fh, struct v4l2_format *f)
>>  {
>>  	struct camss_video *video = video_drvdata(file);
>> +	struct v4l2_plane_pix_format *p;
>> +	u32 bytesperline[3] = { 0 };
>> +	u32 sizeimage[3] = { 0 };
>> +	u32 lines;
>>  	int ret;
>> +	int i;
>>  
>> -	if (vb2_is_busy(&video->vb2_q))
>> -		return -EBUSY;
>> +	if (video->line_based)
>> +		for (i = 0; i < f->fmt.pix_mp.num_planes && i < 3; i++) {
>> +			p = &f->fmt.pix_mp.plane_fmt[i];
>> +			bytesperline[i] = clamp_t(u32, p->bytesperline,
>> +						  1, 65528);
>> +			sizeimage[i] = clamp_t(u32, p->sizeimage,
>> +					       bytesperline[i],
>> +					       bytesperline[i] * 4096);
>> +		}
>>  
>>  	ret = video_get_subdev_format(video, f);
>>  	if (ret < 0)
>>  		return ret;
> 
> If you take the width and height from the sub-device format, then for the
> user to figure out how big a buffer is needed for a particular format it
> takes to change the sub-device format.
> 
> I wouldn't do this but keep the image dimensions on the video node
> independent of what's configured on the sub-device.

So the question is whether the video device node should:
a) keep its format and framesize always in sync with what is set on the
   subdev node with active link to it. This means all s_fmt and enum_fmt
   will return only the value which is in sink with the subdev node;
b) allow to set all possible allowed formats and framesizes. This however
   allows the userspace to try to start the streaming with format and
   framesizes not in sync (on video and subdev node) in which case the
   start streaming will fail.

Currently the driver is implemented as in b) and I hit this problem (in b))
when I try to use it from opencv. I wonder how this can be overcome, the
userspace cannot be blamed that it tried to start streaming for format
and framesize which were allowed to be set.

Are there any new insights on this lately - what can be done to avoid
the problems in a) and b)?

Thank you.

> 
> This patch doesn't really change the behaviour, but a patch before this
> one. That's where the fix should be (as well).
> 
>>  
>> -	video->active_fmt = *f;
>> +	if (video->line_based)
>> +		for (i = 0; i < f->fmt.pix_mp.num_planes; i++) {
>> +			p = &f->fmt.pix_mp.plane_fmt[i];
>> +			p->bytesperline = clamp_t(u32, p->bytesperline,
>> +						  1, 65528);
>> +			p->sizeimage = clamp_t(u32, p->sizeimage,
>> +					       p->bytesperline,
>> +					       p->bytesperline * 4096);
>> +			lines = p->sizeimage / p->bytesperline;
>> +
>> +			if (p->bytesperline < bytesperline[i])
>> +				p->bytesperline = ALIGN(bytesperline[i], 8);
>> +
>> +			if (p->sizeimage < p->bytesperline * lines)
>> +				p->sizeimage = p->bytesperline * lines;
>> +
>> +			if (p->sizeimage < sizeimage[i])
>> +				p->sizeimage = sizeimage[i];
>> +		}
>>  
>>  	return 0;
>>  }
>>  
>> -static int video_try_fmt(struct file *file, void *fh, struct v4l2_format *f)
>> +static int video_s_fmt(struct file *file, void *fh, struct v4l2_format *f)
>>  {
>>  	struct camss_video *video = video_drvdata(file);
>> +	int ret;
>> +
>> +	if (vb2_is_busy(&video->vb2_q))
>> +		return -EBUSY;
>>  
>> -	return video_get_subdev_format(video, f);
>> +	ret = video_try_fmt(file, fh, f);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	video->active_fmt = *f;
>> +
>> +	return 0;
>>  }
>>  
>>  static int video_enum_input(struct file *file, void *fh,


-- 
Best regards,
Todor Tomov
