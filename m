Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23681C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61B32081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cHXQ0Kwf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="f3NCqwcx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D61B32081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeKBVko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 17:40:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46134 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeKBVko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 17:40:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B10FF60ADB; Fri,  2 Nov 2018 12:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541162020;
        bh=iCFPf9dRs83lCexc5gg84QECTERN7azysQjd8OvQahM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cHXQ0Kwfhafkszf0E14E9T0STxw1hDKwNjz2N45IwS3pM+TeqVtHbUJUac98lUlLl
         B1oDB+N1+TuGmIrptQa2vC/8PVJPHNdZEGUFpAddBQ/ROsAqEz0Q8u088PGHCg/F+s
         Z23woxHagSMqNy0FUOjGfANkkZJ7/g+VslkG5r54=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id CDA176083C;
        Fri,  2 Nov 2018 12:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541162019;
        bh=iCFPf9dRs83lCexc5gg84QECTERN7azysQjd8OvQahM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f3NCqwcxMdfGSJaOUHDsLxC4g9dCK7Ku+36uIPg4GCkwerZv8Z00p1KA3Ei9W7HV5
         GUaQYeqD+ZeGhxRj0dW9yNXEV2UOq8c7t2bBLAOhIyQG6Fb7q7gKiW7rWes63yQf1O
         VnVatETj3UtbUfwPCtVnwgVXk1Tb8KbHc5s7TvZ4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 02 Nov 2018 18:03:39 +0530
From:   mgottam@codeaurora.org
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Tomasz Figa <tfiga@chromium.org>, vgarodia@codeaurora.org,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        linux-media-owner@vger.kernel.org
Subject: Re: [PATCH] media: venus: dynamic handling of bitrate
In-Reply-To: <19a08bd3-4e4c-56d2-6df2-54c3d91af4f3@linaro.org>
References: <1540971728-26789-1-git-send-email-mgottam@codeaurora.org>
 <3ff2c3dd-434d-960b-6806-f4bb8ec0d954@linaro.org>
 <3364115421e89c7710725c06b820f8c6@codeaurora.org>
 <CAAFQd5A+9GWmn4aD4D2JMf1e1m-6Dtc3xUdMZsf8fPtgi34QVQ@mail.gmail.com>
 <ba1453b6868e97b96e0345129153b819@codeaurora.org>
 <CAAFQd5DuEqTiJbp5wR=_V0zVkVXTJPuMxDaJoTYFvVYfUA8U8g@mail.gmail.com>
 <19a08bd3-4e4c-56d2-6df2-54c3d91af4f3@linaro.org>
Message-ID: <40ae496b61880e747df9f19409ab26c0@codeaurora.org>
X-Sender: mgottam@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-01 20:33, Stanimir Varbanov wrote:
> On 11/1/18 4:31 PM, Tomasz Figa wrote:
>> On Thu, Nov 1, 2018 at 11:23 PM Vikash Garodia 
>> <vgarodia@codeaurora.org> wrote:
>>> 
>>> On 2018-11-01 19:23, Tomasz Figa wrote:
>>>> On Thu, Nov 1, 2018 at 10:01 PM <mgottam@codeaurora.org> wrote:
>>>>> 
>>>>> On 2018-11-01 17:48, Stanimir Varbanov wrote:
>>>>>> Hi Malathi,
>>>>>> 
>>>>>> Thanks for the patch!
>>>>>> 
>>>>>> On 10/31/18 9:42 AM, Malathi Gottam wrote:
>>>>>>> Any request for a change in bitrate after both planes
>>>>>>> are streamed on is handled by setting the target bitrate
>>>>>>> property to hardware.
>>>>>>> 
>>>>>>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
>>>>>>> ---
>>>>>>>  drivers/media/platform/qcom/venus/venc_ctrls.c | 11 +++++++++++
>>>>>>>  1 file changed, 11 insertions(+)
>>>>>>> 
>>>>>>> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c
>>>>>>> b/drivers/media/platform/qcom/venus/venc_ctrls.c
>>>>>>> index 45910172..54f310c 100644
>>>>>>> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
>>>>>>> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
>>>>>>> @@ -79,7 +79,9 @@ static int venc_op_s_ctrl(struct v4l2_ctrl 
>>>>>>> *ctrl)
>>>>>>>  {
>>>>>>>      struct venus_inst *inst = ctrl_to_inst(ctrl);
>>>>>>>      struct venc_controls *ctr = &inst->controls.enc;
>>>>>>> +    struct hfi_bitrate brate;
>>>>>>>      u32 bframes;
>>>>>>> +    u32 ptype;
>>>>>>>      int ret;
>>>>>>> 
>>>>>>>      switch (ctrl->id) {
>>>>>>> @@ -88,6 +90,15 @@ static int venc_op_s_ctrl(struct v4l2_ctrl 
>>>>>>> *ctrl)
>>>>>>>              break;
>>>>>>>      case V4L2_CID_MPEG_VIDEO_BITRATE:
>>>>>>>              ctr->bitrate = ctrl->val;
>>>>>>> +            if (inst->streamon_out && inst->streamon_cap) {
>>>>>> 
>>>>>> Hmm, hfi_session_set_property already checks the instance state so 
>>>>>> I
>>>>>> don't think those checks are needed. Another thing is that we need 
>>>>>> to
>>>>>> take the instance mutex to check the instance state.
>>>>> 
>>>>> Yes Stan, "hfi_session_set_property" this property check the 
>>>>> instance
>>>>> state,
>>>>> but returns EINVAL if this is set at UNINIT instance state.
>>>>> 
>>>>> Controls initialization happens much earlier than session init and
>>>>> instance init.
>>>>> So the instance is still in UNINIT state which causes failure while
>>>>> setting.
>>>>> 
>>>>> Through this patch we try to meet the client request of changing
>>>>> bitrate
>>>>> only
>>>>> when both planes are streamed on.
>>>> 
>>>> Where does this requirement come from? It should be possible to set
>>>> the control at any time and it should apply to any encoding 
>>>> happening
>>>> after the control is set.
>>>> 
>>> With the patch, now video driver will set the control whenever client
>>> sets
>>> and will apply to encoder.
>> 
>> That's good, thanks for clarifying. I guess I misunderstood Malathi's 
>> comment.
> 
> OK, just wonder about locking when we check streamon_out/cap flags?

Yes Stan, I agree that we should add an instance lock for these flags 
check.
Posting the updated patch. Please review.
