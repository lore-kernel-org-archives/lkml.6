Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D46DC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2592064E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:53:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2592064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbeJIBGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:06:35 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:49259 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726291AbeJIBGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:06:35 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud8.xs4all.net with ESMTPA
        id 9Zisgnxsk0ZZE9Zivg8EIq; Mon, 08 Oct 2018 19:53:42 +0200
Subject: Re: [PATCH] media: vivid: Support 480p for webcam capture
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Keiichi Watanabe <keiichiw@chromium.org>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, tfiga@chromium.org,
        jcliang@chromium.org, shik@chromium.org
References: <20181003070656.193854-1-keiichiw@chromium.org>
 <b2dc51d7-fc92-2e7b-3a07-55a076b95d8b@ideasonboard.com>
 <20181008140302.2239633f@coco.lan>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <00b0a8af-b7a5-cb49-0684-0fd0efefa196@xs4all.nl>
Date:   Mon, 8 Oct 2018 19:53:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181008140302.2239633f@coco.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAVRnZeufrN9NlqaKtWsHVobHqgseGij+kS7+NmKCuiCnp0l2xvYKk4+ccWSGOAFux0mNFxNu+6F+RCoNstbB9jd7jkd46DFhSl6k/pQgvhUa6QggwrV
 vWlQi3QaY/tEn0XGpsyGyikPJC2+XQpJs3LdodAForFVmHKmWLnBxuTs1R/6ENTrZ3e8Lq14jPce00Blg4E9sEX9xBAjsp3+z72tGPhr4tGIxpVRCdg5Dzmx
 8O4wgT0p4r8Rf8C09txfUoB/C0lW7AWoUNLUg29HYZ0R7LNCpJqhIw0B9552rtJbixeZh5m/r+vqEgFPGA/3e57tfqGgLp09Lw3TZ6UrYm5wtHZRIzm4bRxR
 ZuirzISclLZqNkkiRzk8VTff8Ic90y1QuAzPL/+Bj+WiFPhnHyTVXRK0iOS1KHej1FPAUIjAKinYEhovP1kHPAPC7Lm5gPY/sGJoK75LBhtlvHVivpw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2018 07:03 PM, Mauro Carvalho Chehab wrote:
> Em Wed, 3 Oct 2018 12:14:22 +0100
> Kieran Bingham <kieran.bingham@ideasonboard.com> escreveu:
> 
>>> @@ -75,6 +76,8 @@ static const struct v4l2_fract webcam_intervals[VIVID_WEBCAM_IVALS] = {
>>>  	{  1, 5 },
>>>  	{  1, 10 },
>>>  	{  1, 15 },
>>> +	{  1, 15 },
>>> +	{  1, 25 },  
> 
> As the code requires that VIVID_WEBCAM_IVALS would be twice the number
> of resolutions, I understand why you're doing that.
> 
>> But won't this add duplicates of 25 and 15 FPS to all the frame sizes
>> smaller than 1280,720 ? Or are they filtered out?
> 
> However, I agree with Kieran: looking at the code, it sounds to me that
> it will indeed duplicate 1/15 and 1/25 intervals.

Oops, I missed this comment. Yes, you'll get duplicates which should be
avoided.

> 
> I suggest add two other intervals there, like:
> 	12.5 fps and 29.995 fps, e. g.:

29.995 is never used by webcams.

> 
> static const struct v4l2_fract webcam_intervals[VIVID_WEBCAM_IVALS] = {
>         {  1, 1 },
>         {  1, 2 },
>         {  1, 4 },
>         {  1, 5 },
>         {  1, 10 },
>         {  1, 15 },
> 	{  2, 50 },
>         {  1, 25 },
>         {  1, 30 },
>         {  1, 40 },
>         {  1, 50 },
> 	{  1001, 30000 },
>         {  1, 60 },
> };
> 
> Provided, of course, that vivid would support producing images
> at fractional rate. I didn't check. If not, then simply add
> 1/20 and 1/40.

vivid can do fractional rates (it does support this for the TV input),
but 29.995 makes no sense for a webcam. So 1/20 and 1/40 seems the
right approach.

> 
>> Now the difficulty is adding smaller frame rates (like 1,1, 1,2) would
>> effect/reduce the output rates of the larger frame sizes, so how about
>> adding some high rate support (any two from 1/{60,75,90,100,120}) instead?
> 
> Last week, I got a crash with vivid running at 30 fps, while running an 
> event's race code, on a i7core (there, the code was switching all video
> controls while subscribing/unsubscribing events). The same code worked
> with lower fps.

If you have a stack trace, then let me know.

> While I didn't have time to debug it yet, I suspect that it has to do
> with the time spent to produce a frame on vivid. So, while it would be
> nice to have high rate support, I'm not sure if this is doable. It may,
> but perhaps we need to disable some possible video output formats, as some
> types may consume more time to build frames.

In the end that depends on the CPU and what else is running. You'll know quickly
enough if the CPU isn't fast enough to support a format. Although it shouldn't
crash, of course.

Regards,

	Hans
