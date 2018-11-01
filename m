Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08BDC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5280720657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iL2fpXWH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NvLlUdPw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5280720657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbeKAWEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:04:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36078 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbeKAWEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:04:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7A742607E2; Thu,  1 Nov 2018 13:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541077309;
        bh=loOFQ5+Rv8J/8Th+I4HGto0cMxZP2smDduUMYaxJPlk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iL2fpXWHivJYq+z9ihHS5BmlUe+Yma/Sk5tScH6pNMEKpCQuRBTVXG1XsU0eGLjHa
         YNpdQmnC0GZxWK2BBDrL3Ka4mtHXpGXp3otFtqUhD8Py8hpZyY/DFlhnHBUHUMgF88
         8BI0FzZSskcJsyGSZ7+PMxqEHLYBOSSmv2PI6v+Q=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id B0AEB607E2;
        Thu,  1 Nov 2018 13:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541077308;
        bh=loOFQ5+Rv8J/8Th+I4HGto0cMxZP2smDduUMYaxJPlk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NvLlUdPw56FUH1d4PrVAXuKQSWCeAr0rGUTS4dDxAUQpCwcg6MTZadyrAquE2vdvs
         NlOqfdvEemirHXjFpgj7QWTvLzCfiDYM0TWWv6U+oNlt28mEhxEG11gq7b+d1I4Sn5
         xX2xX9LQb95fRg2pomDgJ8Wkb1lxGU4gWI00XGvQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 01 Nov 2018 18:31:48 +0530
From:   mgottam@codeaurora.org
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org
Subject: Re: [PATCH] media: venus: dynamic handling of bitrate
In-Reply-To: <3ff2c3dd-434d-960b-6806-f4bb8ec0d954@linaro.org>
References: <1540971728-26789-1-git-send-email-mgottam@codeaurora.org>
 <3ff2c3dd-434d-960b-6806-f4bb8ec0d954@linaro.org>
Message-ID: <3364115421e89c7710725c06b820f8c6@codeaurora.org>
X-Sender: mgottam@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-01 17:48, Stanimir Varbanov wrote:
> Hi Malathi,
> 
> Thanks for the patch!
> 
> On 10/31/18 9:42 AM, Malathi Gottam wrote:
>> Any request for a change in bitrate after both planes
>> are streamed on is handled by setting the target bitrate
>> property to hardware.
>> 
>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
>> ---
>>  drivers/media/platform/qcom/venus/venc_ctrls.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>> 
>> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c 
>> b/drivers/media/platform/qcom/venus/venc_ctrls.c
>> index 45910172..54f310c 100644
>> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
>> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
>> @@ -79,7 +79,9 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>>  {
>>  	struct venus_inst *inst = ctrl_to_inst(ctrl);
>>  	struct venc_controls *ctr = &inst->controls.enc;
>> +	struct hfi_bitrate brate;
>>  	u32 bframes;
>> +	u32 ptype;
>>  	int ret;
>> 
>>  	switch (ctrl->id) {
>> @@ -88,6 +90,15 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>>  		break;
>>  	case V4L2_CID_MPEG_VIDEO_BITRATE:
>>  		ctr->bitrate = ctrl->val;
>> +		if (inst->streamon_out && inst->streamon_cap) {
> 
> Hmm, hfi_session_set_property already checks the instance state so I
> don't think those checks are needed. Another thing is that we need to
> take the instance mutex to check the instance state.

Yes Stan, "hfi_session_set_property" this property check the instance 
state,
but returns EINVAL if this is set at UNINIT instance state.

Controls initialization happens much earlier than session init and 
instance init.
So the instance is still in UNINIT state which causes failure while 
setting.

Through this patch we try to meet the client request of changing bitrate 
only
when both planes are streamed on.

We have two ways to handle it
1. The way in this patch checks the planes state which will definitely 
ensure
    instance is in START state.
2. Have a check to ensure that instance is atleast Initialized.

I hope the first proposal is good enough for meeting requirement.

> 
>> +			ptype = HFI_PROPERTY_CONFIG_VENC_TARGET_BITRATE;
>> +			brate.bitrate = ctr->bitrate;
>> +			brate.layer_id = 0;
>> +
>> +			ret = hfi_session_set_property(inst, ptype, &brate);
>> +			if (ret)
>> +				return ret;
>> +		}
>>  		break;
>>  	case V4L2_CID_MPEG_VIDEO_BITRATE_PEAK:
>>  		ctr->bitrate_peak = ctrl->val;
>> 
