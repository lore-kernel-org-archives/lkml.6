Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109DDC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF83C20693
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TTxzRqWG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF83C20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388277AbeGKOEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:04:55 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:33822 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387708AbeGKOEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:04:55 -0400
Received: by mail-yb0-f196.google.com with SMTP id e9-v6so10032003ybq.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 07:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZIkGn0ARJOQFbzhCZx+fjMQaYYqYf0RpeeAa7BeT8vY=;
        b=TTxzRqWGC7uAwBU2IObhc8qi9BawysVF8znwi6J/lPB+iO9eTB3WnX6bG8agTvfxyp
         UWUB3WkC+jgMTKCeYU3EeDLyM6ORIE55HcOj05A9ubcKHdKMqYVY7o8KD5qVhgzk2Ego
         5Al39hR+oALmmhx3XC7OdVfCaU25cE3W3UX5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZIkGn0ARJOQFbzhCZx+fjMQaYYqYf0RpeeAa7BeT8vY=;
        b=kVm9aWDMyfJLk7jki7BD50VxW06D+u2ujC4fdXOMKWh8lkQW+FoEQJdtxJ13CCnOcx
         SzhgwO8KvmPsS6uJFcLlLdDCxhnBjH+pOHQaOfPqs13eO2Xdbcet2IVpHPcRx0dCOZ1z
         EqL+QXQ2B6IpizboUMCZCBs3GMn0xiC1R5w8m3f7cWmKIsQVtsr/lXxTniEaZ3WCowBt
         sDa560CtwQMtJMz+LkWg4tK5NMMvBTbdqxRvcqKR/b5PBSPL9MvXSpjMoCoFB6JVb0yB
         FEWHaj7XMjcBG1GH3O34jVANwEmxmdTLJXjFCmJorwjWYdBsRKiPVw7guviONQDo649q
         wjCA==
X-Gm-Message-State: APt69E37tOVJcrB6q3Ksobe8+FzkdQvCLkx8CRRYmz/AOIX0r2Kxs6td
        coSodSgv1rFW73eSYOOEdKwGiw==
X-Google-Smtp-Source: AAOMgpdu0H5T7O1t+2MYJy//mjEHZSXHRgS8BJPmoWkkLulrRUD9D1/5wxtrbyD4QNa2fWIxhVPKAw==
X-Received: by 2002:a25:4e05:: with SMTP id c5-v6mr14867564ybb.266.1531317626126;
        Wed, 11 Jul 2018 07:00:26 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id y2-v6sm5767834ywf.89.2018.07.11.07.00.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 07:00:25 -0700 (PDT)
Date:   Wed, 11 Jul 2018 10:00:24 -0400
From:   Sean Paul <seanpaul@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sean Paul <seanpaul@chromium.org>, Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/msm: avoid using 'timespec'
Message-ID: <20180711140024.GV20303@art_vandelay>
References: <20180618153959.2169325-1-arnd@arndb.de>
 <20180710204736.GU20303@art_vandelay>
 <CAK8P3a0j7O8MdpxiGNKfrRB5Sdx0UJzH_=4diRw6a-0TKoUAdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0j7O8MdpxiGNKfrRB5Sdx0UJzH_=4diRw6a-0TKoUAdw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 11:27:00PM +0200, Arnd Bergmann wrote:
> On Tue, Jul 10, 2018 at 10:47 PM, Sean Paul <seanpaul@chromium.org> wrote:
> > On Mon, Jun 18, 2018 at 05:39:42PM +0200, Arnd Bergmann wrote:
> >> The timespec structure and associated interfaces are deprecated and will
> >> be removed in the future because of the y2038 overflow.
> >>
> >> The use of ktime_to_timespec() in timeout_to_jiffies() does not
> >> suffer from that overflow, but is easy to avoid by just converting
> >> the ktime_t into jiffies directly.
> >>
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >>  drivers/gpu/drm/msm/msm_drv.h | 3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> >> index b2da1fbf81e0..cc8977476a41 100644
> >> --- a/drivers/gpu/drm/msm/msm_drv.h
> >> +++ b/drivers/gpu/drm/msm/msm_drv.h
> >> @@ -353,8 +353,7 @@ static inline unsigned long timeout_to_jiffies(const ktime_t *timeout)
> >>               remaining_jiffies = 0;
> >>       } else {
> >>               ktime_t rem = ktime_sub(*timeout, now);
> >> -             struct timespec ts = ktime_to_timespec(rem);
> >> -             remaining_jiffies = timespec_to_jiffies(&ts);
> >> +             remaining_jiffies = ktime_divns(rem, NSEC_PER_SEC / HZ);
> >
> > Do you need to wrap rem in ktime_to_ns() just to be safe?
> 
> The ktime_t interfaces are still defined to use an opaque type,
> as previously it was a union that could be a seconds/nanoseconds
> pair depending on the architecture. These days, ktime_t is just
> a 64-bit integer, so div_u64() would work just as well as ktime_divns(),
> but this is the documented way to do it.

Hey Arnd,
Ahh, ok, I think I realize my confusion now. If ktime_t was not ns, 
ktime_divns() would do the conversion for us. Since it is ns, the conversion
is a no-op (which is why I didn't see ktime_to_ns() in ktime_divns()).

Thanks for breaking that down for me,

Reviewed-by: Sean Paul <seanpaul@chromium.org>


> 
>       Arnd

-- 
Sean Paul, Software Engineer, Google / Chromium OS
