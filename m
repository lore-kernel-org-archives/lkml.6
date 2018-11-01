Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCA6C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F532205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ktrjL4jw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FyDe5ybf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F532205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbeKAX0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:26:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55964 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbeKAX0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:26:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8B9BB60214; Thu,  1 Nov 2018 14:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541082209;
        bh=OvlDM/QSxP/Nzwn9QMzni2KfgMM8f9ZIGJZ01i35fb4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ktrjL4jwBgDp+prMPFX1pmiDUrptfA6mcX3OJAkCBJ9909jPWxoTxtmMAG5RGUmaS
         Rdj2ZMnSemy70fBXHSEMN55DB1SF0OmjTdOO9qVfTDSYFgDZwAl3GDHNOb7TVKXsX4
         arRLjF3n80e/EstfizsQ67DvZXo0Rn9Ptk8XPDRo=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id D7E6360590;
        Thu,  1 Nov 2018 14:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541082208;
        bh=OvlDM/QSxP/Nzwn9QMzni2KfgMM8f9ZIGJZ01i35fb4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FyDe5ybfGmgAX1OIxvKW5tzgPKUk5i99wjJ0EmWAfOYTud7K8WF2yI1NgU525hH+O
         hQ8Cod4tqE1wcvsH2KBPETRgkvQeFlJ4CBV6fXDh2r/D7LJSuRkahe1CCqW4W83QwG
         bALMSbZLzbMmQYE350EBL3rlkOLbw7vaZQozu82s=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 01 Nov 2018 19:53:27 +0530
From:   Vikash Garodia <vgarodia@codeaurora.org>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     mgottam@codeaurora.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        linux-media-owner@vger.kernel.org
Subject: Re: [PATCH] media: venus: dynamic handling of bitrate
In-Reply-To: <CAAFQd5A+9GWmn4aD4D2JMf1e1m-6Dtc3xUdMZsf8fPtgi34QVQ@mail.gmail.com>
References: <1540971728-26789-1-git-send-email-mgottam@codeaurora.org>
 <3ff2c3dd-434d-960b-6806-f4bb8ec0d954@linaro.org>
 <3364115421e89c7710725c06b820f8c6@codeaurora.org>
 <CAAFQd5A+9GWmn4aD4D2JMf1e1m-6Dtc3xUdMZsf8fPtgi34QVQ@mail.gmail.com>
Message-ID: <ba1453b6868e97b96e0345129153b819@codeaurora.org>
X-Sender: vgarodia@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-01 19:23, Tomasz Figa wrote:
> On Thu, Nov 1, 2018 at 10:01 PM <mgottam@codeaurora.org> wrote:
>> 
>> On 2018-11-01 17:48, Stanimir Varbanov wrote:
>> > Hi Malathi,
>> >
>> > Thanks for the patch!
>> >
>> > On 10/31/18 9:42 AM, Malathi Gottam wrote:
>> >> Any request for a change in bitrate after both planes
>> >> are streamed on is handled by setting the target bitrate
>> >> property to hardware.
>> >>
>> >> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
>> >> ---
>> >>  drivers/media/platform/qcom/venus/venc_ctrls.c | 11 +++++++++++
>> >>  1 file changed, 11 insertions(+)
>> >>
>> >> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c
>> >> b/drivers/media/platform/qcom/venus/venc_ctrls.c
>> >> index 45910172..54f310c 100644
>> >> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
>> >> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
>> >> @@ -79,7 +79,9 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>> >>  {
>> >>      struct venus_inst *inst = ctrl_to_inst(ctrl);
>> >>      struct venc_controls *ctr = &inst->controls.enc;
>> >> +    struct hfi_bitrate brate;
>> >>      u32 bframes;
>> >> +    u32 ptype;
>> >>      int ret;
>> >>
>> >>      switch (ctrl->id) {
>> >> @@ -88,6 +90,15 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>> >>              break;
>> >>      case V4L2_CID_MPEG_VIDEO_BITRATE:
>> >>              ctr->bitrate = ctrl->val;
>> >> +            if (inst->streamon_out && inst->streamon_cap) {
>> >
>> > Hmm, hfi_session_set_property already checks the instance state so I
>> > don't think those checks are needed. Another thing is that we need to
>> > take the instance mutex to check the instance state.
>> 
>> Yes Stan, "hfi_session_set_property" this property check the instance
>> state,
>> but returns EINVAL if this is set at UNINIT instance state.
>> 
>> Controls initialization happens much earlier than session init and
>> instance init.
>> So the instance is still in UNINIT state which causes failure while
>> setting.
>> 
>> Through this patch we try to meet the client request of changing 
>> bitrate
>> only
>> when both planes are streamed on.
> 
> Where does this requirement come from? It should be possible to set
> the control at any time and it should apply to any encoding happening
> after the control is set.
> 
With the patch, now video driver will set the control whenever client 
sets
and will apply to encoder.

Thanks,
Vikash
