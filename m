Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121B8C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAEE9204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bCGTAhDX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bCGTAhDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAEE9204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbeKAWNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:13:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39716 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbeKAWNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:13:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D9BDD6083C; Thu,  1 Nov 2018 13:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541077835;
        bh=Ozq+WnTVtO0/pL37GikBYdZtPiusfJi1TtQ7m01/Ggw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bCGTAhDXdF3p3Au5Qtako2l250233w0aWLJpPMPXUFwatbBNCILn1KxoDdP3KZvhW
         n1Egh3llLMUhz/fDMrJomSwcJA+QhrNBPVaNb9nXlj+k8QmTJn0gJXPOZ+m+K9GAsC
         g2BfBYnwbWYCwqJK/CDUcrkEQWeIF4u6ZfSZRySg=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 1BBA360795;
        Thu,  1 Nov 2018 13:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541077835;
        bh=Ozq+WnTVtO0/pL37GikBYdZtPiusfJi1TtQ7m01/Ggw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bCGTAhDXdF3p3Au5Qtako2l250233w0aWLJpPMPXUFwatbBNCILn1KxoDdP3KZvhW
         n1Egh3llLMUhz/fDMrJomSwcJA+QhrNBPVaNb9nXlj+k8QmTJn0gJXPOZ+m+K9GAsC
         g2BfBYnwbWYCwqJK/CDUcrkEQWeIF4u6ZfSZRySg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 01 Nov 2018 18:40:35 +0530
From:   mgottam@codeaurora.org
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org
Subject: Re: [PATCH] media: venus: add support for selection rectangles
In-Reply-To: <0e0f689e-f6e3-73a6-e145-deb2ef7cafc8@linaro.org>
References: <1539071603-1588-1-git-send-email-mgottam@codeaurora.org>
 <0e0f689e-f6e3-73a6-e145-deb2ef7cafc8@linaro.org>
Message-ID: <5037ca4b0dd0de80750e35ca889d4225@codeaurora.org>
X-Sender: mgottam@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-16 15:11, Stanimir Varbanov wrote:
> Hi Malathi,
> 
> On 10/09/2018 10:53 AM, Malathi Gottam wrote:
>> Handles target type crop by setting the new active rectangle
>> to hardware. The new rectangle should be within YUV size.
>> 
>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
>> ---
>>  drivers/media/platform/qcom/venus/venc.c | 19 +++++++++++++++++--
>>  1 file changed, 17 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/media/platform/qcom/venus/venc.c 
>> b/drivers/media/platform/qcom/venus/venc.c
>> index 3f50cd0..754c19a 100644
>> --- a/drivers/media/platform/qcom/venus/venc.c
>> +++ b/drivers/media/platform/qcom/venus/venc.c
>> @@ -478,16 +478,31 @@ static int venc_g_fmt(struct file *file, void 
>> *fh, struct v4l2_format *f)
>>  venc_s_selection(struct file *file, void *fh, struct v4l2_selection 
>> *s)
>>  {
>>  	struct venus_inst *inst = to_inst(file);
>> +	int ret;
>> +	u32 buftype;
>> 
>>  	if (s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
>>  		return -EINVAL;
>> 
>>  	switch (s->target) {
>>  	case V4L2_SEL_TGT_CROP:
>> -		if (s->r.width != inst->out_width ||
>> -		    s->r.height != inst->out_height ||
>> +		if (s->r.width > inst->out_width ||
>> +		    s->r.height > inst->out_height ||
>>  		    s->r.top != 0 || s->r.left != 0)
>>  			return -EINVAL;
>> +		if (s->r.width != inst->width ||
>> +		    s->r.height != inst->height) {
>> +			buftype = HFI_BUFFER_OUTPUT;
>> +			ret = venus_helper_set_output_resolution(inst,
>> +								 s->r.width,
>> +								 s->r.height,
>> +								 buftype);
> 
> I'm afraid that set_output_resolution cannot be called at any time. Do
> you think we can set it after start_session?

Yes Stan, we can set output_resolution after the session has been 
initialization.
As per the spec, this call s_selection is an optional step under 
Initialization
procedure of encoder even before we request buffers.

So I think setting output resolution in this api shouldn't cause any 
issue once
we are confident on the instance state.
