Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010FFC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 06:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A2821857
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 06:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="R8vXYker"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A2821857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbeHQJtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 05:49:51 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:38516 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeHQJtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 05:49:51 -0400
Received: by mail-it0-f54.google.com with SMTP id v71-v6so10542525itb.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 23:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=EPzzXmX+2etSRW8Ke2ANFBPT9Wh8WStz2pnojzz9qtY=;
        b=R8vXYkerQOLpj8Yfjpc2p42ZtkRcehTTK3IBnU/aPrLJ+C0ozNaqYmr5mz7vOIAu61
         3BtVnE8t5UV+tZ4hLl1gZF6dW2bNzi7W72n4nSBSjQjS6laEDVp6KlE+9mbCuQ/MLjYX
         YBqE4bqHAl0givKg6UrnAhSVuOfOGTxXSo3xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=EPzzXmX+2etSRW8Ke2ANFBPT9Wh8WStz2pnojzz9qtY=;
        b=eFSo53xuds9BsJvS9cyWYQwTAtiMcbdrVXf3TRhV94Fz3aClGAD16QqaobcLjxW3Wy
         DHxV9nL/HFC3qAvCzF0s3KC6ysny4raKyQ+7aP8lZnDWCGUhYlhgG9UVO34Lq8qb3idf
         iQ88pbkRDgoAx5EeJRdVP7NxRdfYi/8Y6dFrI6YkaS8lSHeEm8AO9c5rR2JgLZm7wFqn
         nxYE1WyzC96pbYBsNT/tnUUCd+FCht0ED1sbzB9WMH7AmKHp9WYrE0HZEbauk9Yj5tGE
         hFgbblt6oI6FJEETet2UiCqpHOHDQ+fl8em9O7ZYyX92ssWF7vbeg/cH6SAn542DFURj
         RE9w==
X-Gm-Message-State: AOUpUlE9UqwPY4IzWqMqspoFnVx5Mh05G+3q8iRSz6+i2ZeJc//4INQ4
        zWKlYapYTC/DKtvSeb7eLY0NgbZqyPQbQiNtucWWdA==
X-Google-Smtp-Source: AA+uWPy5jSIsoN6KyqJnTPpBp5OL9OUWgL+qJfw2ZN+Vqic20cY9gfOVNQ93cz7oCferioFuv7maMI7JT18sKj+KCsg=
X-Received: by 2002:a24:6c04:: with SMTP id w4-v6mr3274535itb.4.1534488460600;
 Thu, 16 Aug 2018 23:47:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:e502:0:0:0:0:0 with HTTP; Thu, 16 Aug 2018 23:47:40
 -0700 (PDT)
X-Originating-IP: [212.51.149.109]
In-Reply-To: <CALAqxLUf33tfMNOJMnpwGpjG7MnKBhTRmZCSGyLrXxsgs1zDqA@mail.gmail.com>
References: <CAPM=9txqtcX42eSYjkyJLL8mmzomXRRHi7iWmW=BYgk=CAagZg@mail.gmail.com>
 <CALAqxLXt3MOc=W_gnsR=D=Um5RPsK+6sTKDbSiqro_53ZbXfQQ@mail.gmail.com>
 <CAKMK7uFb0jXVm4gGr_TR07mhT924sTORGXZVNzx4rdTe3Pj94Q@mail.gmail.com>
 <CALAqxLWq-wgbc+aS0p45rvxmPj3KicsOV5ucCB-tcKWr74uqCQ@mail.gmail.com>
 <CAKMK7uEbfa24DaDbWjxgerzH69q-niHS5==z6NqJd3Yxi0q+7A@mail.gmail.com>
 <CALAqxLVrZXRT875-AxN=jt_kSD5=Nb9SuCW4PEsVL=pQkT_ugw@mail.gmail.com>
 <CAKMK7uHrCAQpUhd2D4PpiizascLwP1kYgMM6cZv3B8OGez66Sw@mail.gmail.com> <CALAqxLUf33tfMNOJMnpwGpjG7MnKBhTRmZCSGyLrXxsgs1zDqA@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 17 Aug 2018 08:47:40 +0200
X-Google-Sender-Auth: 51DJ6P0-JDEQ5Wt0qkuFLVmMB2E
Message-ID: <CAKMK7uF9-z0+oUCoBaOGY4xBbY7tDoKegHHEAf0VQ-c7wgEY3w@mail.gmail.com>
Subject: Re: [git pull] drm for 4.19-rc1
To:     John Stultz <john.stultz@linaro.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 12:22 AM, John Stultz <john.stultz@linaro.org> wrote:
> On Thu, Aug 16, 2018 at 3:16 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
>> On Thu, Aug 16, 2018 at 11:21 PM, John Stultz <john.stultz@linaro.org> wrote:
>>> On Thu, Aug 16, 2018 at 1:46 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
>>>> You happen to have set drm_fb_overalloc respectively
>>>> CONFIG_DRM_FBDEV_OVERALLOC? Was added so that mali blob can pageflip,
>>>> would explain what's going on at least.
>>>
>>> Yep. CONFIG_DRM_FBDEV_OVERALLOC is set to 200.
>>
>> So ->max_height is indeed the limit (or should be, minus driver bugs)
>> for framebuffers. That's enforced in drm_framebuffer_create_internal
>> for everything (both ioctl and should also for all internal callers),
>> except the cma helpers never made sure this is correct. So I'd call
>> this a bugfix.
>
> Sure.  I'm really not sure where the max_height=2048 comes from (and
> if its the real limitation or a vendor guessed value - the hikey960
> driver I have uses the same), but yea, the old code wasn't checking
> it.

So in a way the limit is not entirely correct, since it's enforced for
drm_framebuffer, not for the underlying memory object. Assuming you
keep alignment correct (which is not exposed to userspace) you can
overallocate that and scan the drm_framebuffer over it. But the fbdev
helpers don't do that.

We also don't have separate limits for fb sizes and max scanout.
Though the later is supposed to be filtered in the various mode_valid
callbacks, not through max_*.

>> Now the question is whether the fbdev page-flipping actually worked on
>> older kernels for you or not ...
>
> It sure seems to work ok with the changes reverted.   Any suggestion
> on how to check this?

No idea. I didn't type a testcase for it, wasn't my feature :-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
