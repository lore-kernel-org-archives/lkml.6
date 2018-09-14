Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052D5ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1B62146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="eJf4U3pG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A1B62146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbeINQNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 12:13:08 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:34656 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbeINQNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 12:13:08 -0400
Received: from [192.168.0.23] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6F0D4CE;
        Fri, 14 Sep 2018 12:59:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536922748;
        bh=sDnNBZ5z0kr6y50Oh6gHismsPV5E4AEPyxrsk59xB1s=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eJf4U3pGjBSxjE3mPqCVIfEUgbKF1q45v1tWq4OhLcvUUq5bQK9RCtIJHWOHrqZfL
         siTB3KYDc0+QXr1R6xh2zL/Fb/CU5KOxZ0ARAjE6veYDlxwWH09NyDWrtTkQF583UO
         gZfZk2FQne4dDctrQ/iiIY+RNn5iJ+xoMlmY6QA4=
Reply-To: kieran.bingham+renesas@ideasonboard.com
Subject: Re: [PATCH 2/6] media: vsp1: Correct the pitch on multiplanar formats
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180831144044.31713-1-kieran.bingham+renesas@ideasonboard.com>
 <20180831144044.31713-3-kieran.bingham+renesas@ideasonboard.com>
 <4407219.HP1UPh24hA@avalon>
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Organization: Ideas on Board
Message-ID: <8e97bc7f-57b9-e9fd-e304-9e8158530ca4@ideasonboard.com>
Date:   Fri, 14 Sep 2018 11:59:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4407219.HP1UPh24hA@avalon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 14/09/18 11:25, Laurent Pinchart wrote:
> Hi Kieran,
> 
> Thank you for the patch.
> 
> On Friday, 31 August 2018 17:40:40 EEST Kieran Bingham wrote:
>> DRM pipelines now support tri-planar as well as packed formats with
>> YCbCr, however the pitch calculation was not updated to support this.
>>
>> Correct this by adjusting the bytesperline accordingly when 3 planes are
>> used.
>>
>> Fixes: 7863ac504bc5 ("drm: rcar-du: Add tri-planar memory formats support")
>> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> 
> I already have a similar patch from Matsuoka-san in my tree, please see 
> https://patchwork.kernel.org/patch/10425565/. I'll update it with the fixes 
> tag.
> 
>> ---
>>  drivers/media/platform/vsp1/vsp1_drm.c | 10 ++++++++++
>>  include/media/vsp1.h                   |  2 +-
>>  2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/vsp1/vsp1_drm.c
>> b/drivers/media/platform/vsp1/vsp1_drm.c index b9c0f695d002..b9afd98f6867
>> 100644
>> --- a/drivers/media/platform/vsp1/vsp1_drm.c
>> +++ b/drivers/media/platform/vsp1/vsp1_drm.c
>> @@ -814,6 +814,16 @@ int vsp1_du_atomic_update(struct device *dev, unsigned
>> int pipe_index, rpf->format.num_planes = fmtinfo->planes;
>>  	rpf->format.plane_fmt[0].bytesperline = cfg->pitch;
>>  	rpf->format.plane_fmt[1].bytesperline = cfg->pitch;
>> +
>> +	/*
>> +	 * Packed YUV formats are subsampled, but the packing of two components
>> +	 * into a single plane compensates for this leaving the bytesperline
>> +	 * to be the correct value. For multiplanar formats we must adjust the
>> +	 * pitch accordingly.
>> +	 */
>> +	if (fmtinfo->planes == 3)
>> +		rpf->format.plane_fmt[1].bytesperline /= fmtinfo->hsub;
>> +
>>  	rpf->alpha = cfg->alpha;
>>
>>  	rpf->mem.addr[0] = cfg->mem[0];
>> diff --git a/include/media/vsp1.h b/include/media/vsp1.h
>> index 3093b9cb9067..0ce19b595cc7 100644
>> --- a/include/media/vsp1.h
>> +++ b/include/media/vsp1.h
>> @@ -46,7 +46,7 @@ int vsp1_du_setup_lif(struct device *dev, unsigned int
>> pipe_index, /**
>>   * struct vsp1_du_atomic_config - VSP atomic configuration parameters
>>   * @pixelformat: plane pixel format (V4L2 4CC)
>> - * @pitch: line pitch in bytes, for all planes
>> + * @pitch: line pitch in bytes
> 
> Should I update the above-mentioned patch with this as well ? How about 
> phrasing it as "line pitch in bytes for the first plane" ?

Yes, your suggestion sounds fine.

The patch at [0] looks good to me as a fix for this issue.

for: "v4l: vsp1: Fix YCbCr planar formats pitch calculation" [0]
With the fixes tag, and documentation updated:

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

[0]  https://patchwork.kernel.org/patch/10425565

> 
>>   * @mem: DMA memory address for each plane of the frame buffer
>>   * @src: source rectangle in the frame buffer (integer coordinates)
>>   * @dst: destination rectangle on the display (integer coordinates)
> 

