Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03101C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFBD2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TwOJRir+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c2sKNd8m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CFBD2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbeJXWGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 18:06:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44708 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbeJXWGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 18:06:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6310C602BD; Wed, 24 Oct 2018 13:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540388270;
        bh=yTpk2OxJaVAFeQCkNTNdiCnHScOdA6Uz4iB1oxdFFwI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TwOJRir+JS8cfs5Jw3nJeM7nThRmdegYKT9WPr5MSN4/Rm4WY1CgXs5XfXEs6qewn
         Aep6n0b+0ynRGx6meE/tdBtZK+IH5gKdVwh10531rHbB3N1FLjo+ZUc1EB7gQokuhd
         Ir6oHOZvIVYz/fwXUu9EIS509ztfMmhmhXiBoy9s=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id E5395602BD;
        Wed, 24 Oct 2018 13:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540388266;
        bh=yTpk2OxJaVAFeQCkNTNdiCnHScOdA6Uz4iB1oxdFFwI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c2sKNd8m6Iww0BVYmGY8wiLStERoRK0rD21LARl/T0S+JfBCpnAjXFSY2/pUfmk0v
         c+Xj65QxfICX3EMXvdYPwSu6ReYf7TYRpsohM39SYJuF+9cuG3HcXv6MeRPHWSZNOA
         xco77+h/A8CRV6z7iQgd0hj1tzGc7GfrCV7wrmwg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 24 Oct 2018 19:07:45 +0530
From:   mgottam@codeaurora.org
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        vgarodia@codeaurora.org
Subject: Re: [PATCH] media: venus: add support for key frame
In-Reply-To: <CAAFQd5BfNxBwEPaZvxbYpmvZw1WvynWV6NrUocm5vmXQNQf8uQ@mail.gmail.com>
References: <1539071634-1644-1-git-send-email-mgottam@codeaurora.org>
 <CAPBb6MUt_V4zEKGcRYXRXNRVdjF2uspOvEj0T-dH6dBZ9ya9CA@mail.gmail.com>
 <f1bb2ead-fe8e-af6a-1b96-9460a7b01f29@linaro.org>
 <CAPBb6MXxaGMCY43fXwWYZmYmiVwDA6kdJRwWZGqUHhWOGXSz7Q@mail.gmail.com>
 <40d15ea4-48e2-b2c7-1d70-68dcc1b08990@linaro.org>
 <CAPBb6MU9mV9_iq6cf-BzzhTFsed5vtjTui669jxq2uF8KenhQQ@mail.gmail.com>
 <CAAFQd5BfNxBwEPaZvxbYpmvZw1WvynWV6NrUocm5vmXQNQf8uQ@mail.gmail.com>
Message-ID: <ca27333e60d35b83b1842975a90488a9@codeaurora.org>
X-Sender: mgottam@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-23 08:37, Tomasz Figa wrote:
> On Mon, Oct 22, 2018 at 3:15 PM Alexandre Courbot 
> <acourbot@chromium.org> wrote:
>> 
>> On Fri, Oct 12, 2018 at 5:10 PM Stanimir Varbanov
>> <stanimir.varbanov@linaro.org> wrote:
>> >
>> >
>> >
>> > On 10/12/2018 11:06 AM, Alexandre Courbot wrote:
>> > > On Fri, Oct 12, 2018 at 4:37 PM Stanimir Varbanov
>> > > <stanimir.varbanov@linaro.org> wrote:
>> > >>
>> > >> Hi Alex,
>> > >>
>> > >> On 10/12/2018 08:26 AM, Alexandre Courbot wrote:
>> > >>> On Tue, Oct 9, 2018 at 4:54 PM Malathi Gottam <mgottam@codeaurora.org> wrote:
>> > >>>>
>> > >>>> When client requests for a keyframe, set the property
>> > >>>> to hardware to generate the sync frame.
>> > >>>>
>> > >>>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
>> > >>>> ---
>> > >>>>  drivers/media/platform/qcom/venus/venc_ctrls.c | 13 +++++++++++++
>> > >>>>  1 file changed, 13 insertions(+)
>> > >>>>
>> > >>>> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
>> > >>>> index 45910172..f332c8e 100644
>> > >>>> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
>> > >>>> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
>> > >>>> @@ -81,6 +81,8 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>> > >>>>         struct venc_controls *ctr = &inst->controls.enc;
>> > >>>>         u32 bframes;
>> > >>>>         int ret;
>> > >>>> +       void *ptr;
>> > >>>> +       u32 ptype;
>> > >>>>
>> > >>>>         switch (ctrl->id) {
>> > >>>>         case V4L2_CID_MPEG_VIDEO_BITRATE_MODE:
>> > >>>> @@ -173,6 +175,14 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>> > >>>>
>> > >>>>                 ctr->num_b_frames = bframes;
>> > >>>>                 break;
>> > >>>> +       case V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME:
>> > >>>> +               ptype = HFI_PROPERTY_CONFIG_VENC_REQUEST_SYNC_FRAME;
>> > >>>> +               ret = hfi_session_set_property(inst, ptype, ptr);
>> > >>>
>> > >>> The test bot already said it, but ptr is passed to
>> > >>> hfi_session_set_property() uninitialized. And as can be expected the
>> > >>> call returns -EINVAL on my board.
>> > >>>
>> > >>> Looking at other uses of HFI_PROPERTY_CONFIG_VENC_REQUEST_SYNC_FRAME I
>> > >>> see that the packet sent to the firmware does not have room for an
>> > >>> argument, so I tried to pass NULL but got the same result.
>> > >>
>> > >> yes, because pdata cannot be NULL. I'd suggest to make a pointer to
>> > >> struct hfi_enable and pass it to the set_property function.
>> > >
>> > > FWIW I also tried doing this and got the same error, strange...
>> > >
>> >
>> > OK, when you calling the v4l control? It makes sense when you calling
>> > it, because set_property checks does the session is on START state (i.e.
>> > streamon on both queues).
>> 
>> Do you mean that the property won't be actually applied unless both
>> queues are streaming? In that case maybe it would make sense for the
>> driver to save controls set before that and apply them when the
>> conditions allow them to be effective?
> 
> Right. The driver cannot just drop a control setting on the floor if
> it's not ready to apply it.
> 
> However, the V4L2 control framework already provides a tool to handle 
> this:
>  - the driver can ignore any .s_ctrl() calls when it can't apply the 
> controls,
>  - the driver must call v4l2_ctrl_handler_setup() when it initialized
> the hardware, so that all the control values are applied in one go.
> 
> Best regards,
> Tomasz
Yes V4L2 control framework validates the ctrls before being set.

But these controls are initialized before session initialization. So 
s_ctrl tries to set property 
"HFI_PROPERTY_CONFIG_VENC_REQUEST_SYNC_FRAME" as a part of initializing 
all controls(session still in UNINIT state). But this is not any client 
request.

So we can keep a check to
1. ensure that its client requesting sync frame and
2. session in START state (both planes are streaming)

I will update the patch with these changes.


