Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE57C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076C120652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IcDprEXH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IcDprEXH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 076C120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbeJVUWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 16:22:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37020 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbeJVUWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 16:22:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B380C6050D; Mon, 22 Oct 2018 12:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540209865;
        bh=jPA4y+GnEDaAxA5o0/d55VuHVENgGGSvdO4aifNciaE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IcDprEXHb1BVUMs8Dh0fBFWkva+VQyLafjbRDOYXIBQq84kq4AR8vRq4HUtuYCYxb
         21dWJ23TByIXCw8TnZyEpjevymf3Kl2mjWj5j3IiIEcfp26N9LntGqHSiSbsMwqKZj
         Bc/azRuVodHjji9aZuTEL+C31IQdta+QPjkcElso=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 41057601CF;
        Mon, 22 Oct 2018 12:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540209865;
        bh=jPA4y+GnEDaAxA5o0/d55VuHVENgGGSvdO4aifNciaE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IcDprEXHb1BVUMs8Dh0fBFWkva+VQyLafjbRDOYXIBQq84kq4AR8vRq4HUtuYCYxb
         21dWJ23TByIXCw8TnZyEpjevymf3Kl2mjWj5j3IiIEcfp26N9LntGqHSiSbsMwqKZj
         Bc/azRuVodHjji9aZuTEL+C31IQdta+QPjkcElso=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 22 Oct 2018 17:34:25 +0530
From:   mgottam@codeaurora.org
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org
Subject: Re: [PATCH] media: venus: handle peak bitrate set property
In-Reply-To: <274a112a-604c-82b4-130a-c3718abcf141@linaro.org>
References: <1539071483-1371-1-git-send-email-mgottam@codeaurora.org>
 <274a112a-604c-82b4-130a-c3718abcf141@linaro.org>
Message-ID: <1c2db4af132609460b1cf6cf0c25a024@codeaurora.org>
X-Sender: mgottam@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-09 20:29, Stanimir Varbanov wrote:
> Hi Malathi,
> 
> Thanks for the patch!
> 
> On 10/09/2018 10:51 AM, Malathi Gottam wrote:
>> Max bitrate property is not supported for venus version 4xx.
>> Add a version check for the same.
> 
> I'd like to avoid version checks in this layer of the driver. Could 
> just
> black-list this property in pkt_session_set_property_4xx? Hint, see
> HFI_PROPERTY_CONFIG_VENC_MAX_BITRATE in the same function.
> 
>> 
>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
>> ---
>>  drivers/media/platform/qcom/venus/venc.c | 22 ++++++++++++----------
>>  1 file changed, 12 insertions(+), 10 deletions(-)
>> 
>> diff --git a/drivers/media/platform/qcom/venus/venc.c 
>> b/drivers/media/platform/qcom/venus/venc.c
>> index ef11495..3f50cd0 100644
>> --- a/drivers/media/platform/qcom/venus/venc.c
>> +++ b/drivers/media/platform/qcom/venus/venc.c
>> @@ -757,18 +757,20 @@ static int venc_set_properties(struct venus_inst 
>> *inst)
>>  	if (ret)
>>  		return ret;
>> 
>> -	if (!ctr->bitrate_peak)
>> -		bitrate *= 2;
>> -	else
>> -		bitrate = ctr->bitrate_peak;
>> +	if (!IS_V4(inst->core)) {
>> +		if (!ctr->bitrate_peak)
>> +			bitrate *= 2;
>> +		else
>> +			bitrate = ctr->bitrate_peak;
>> 
>> -	ptype = HFI_PROPERTY_CONFIG_VENC_MAX_BITRATE;
>> -	brate.bitrate = bitrate;
>> -	brate.layer_id = 0;
>> +		ptype = HFI_PROPERTY_CONFIG_VENC_MAX_BITRATE;
>> +		brate.bitrate = bitrate;
>> +		brate.layer_id = 0;
>> 
>> -	ret = hfi_session_set_property(inst, ptype, &brate);
>> -	if (ret)
>> -		return ret;
>> +		ret = hfi_session_set_property(inst, ptype, &brate);
>> +		if (ret)
>> +			return ret;
>> +	}
>> 
>>  	if (inst->fmt_cap->pixfmt == V4L2_PIX_FMT_H264) {
>>  		profile = venc_v4l2_to_hfi(V4L2_CID_MPEG_VIDEO_H264_PROFILE,
>> 
Hi Stan,

Though this property is bypassed in the function 
"pkt_session_set_property_4xx", it is set to firmware in hfi_venus 
layer.

So we can return -ENOTSUPP from packet layer. If hfi_venus layer 
receives error as ENOTSUPP, treat it as normal and return 0 to venc 
layer.

I will post the updated patch, with this implementation.
