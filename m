Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8BFC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E559320A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tt+x9ldM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E559320A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbeGJVTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 17:19:42 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:38944 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732187AbeGJVTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 17:19:42 -0400
Received: by mail-yb0-f196.google.com with SMTP id k127-v6so9201108ybk.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 14:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D4V2He12W5IThoG2lp37esf8UqUdAuwXkWaIgIeVuu4=;
        b=Tt+x9ldMF6TqXe7r96ec1npfJ+OcvnUpXNSUTOJ1ZOq53nCRnvlzDtpe0Kd1Q7S0vu
         KoczRrmqhFru//MStzG9wyqgOSgxkEcmtGqtXlKDneHdjcacFsC13d0jUqg2eCIowQzY
         T1oYQU66Nts5lJFwBSQy/o9eFlvDWmxbwbh9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D4V2He12W5IThoG2lp37esf8UqUdAuwXkWaIgIeVuu4=;
        b=MU+zGcoqAt62+Szk/xeaqjdW7+NlOcFciruUSa1iOPnDWD0FRzX+sevw0xOSoWkg9M
         1FrVxALa++QhxczlzA7UHt6YK0ZFwhPyyDUksNYG5J1zjqE2z+bbOEDFnqCvruM28zKM
         BVQRwyQdkYdmQ1k9dbv0rEqg9KZ+TT+A/rmNxLYGKVhuVTcOzqZRYhK1fo0Gt5KCjGOE
         wFCAidEe4cbh/6aCZzJhX2VJs8PeKxvBhNCAJY91x2sf9SmP3BTSoAtpxiHvr/vcXVh1
         EKdi2gjpFBzTW4dQD0NShXz3g5NTG/IISLnLq2LuH+mC69Iz+ryU2NzEFU7nF3U/u0Lk
         Ofug==
X-Gm-Message-State: APt69E2DfBj0rjUFzYSUm5ORx/2AOzwbuukByQOugBD5302diiqa8m9m
        PfAToWCYgRO3wJKQ9aoaZOTFeQ==
X-Google-Smtp-Source: AAOMgpfeLn4S+9Xd74m9GZwBsunknjYkESjhX5EfSSAN/+lvGg3wSeVbbT0bGC9w9fCbXX50kOgGKw==
X-Received: by 2002:a25:ac44:: with SMTP id r4-v6mr13826891ybd.497.1531255657892;
        Tue, 10 Jul 2018 13:47:37 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id m128-v6sm4808378ywf.10.2018.07.10.13.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 13:47:36 -0700 (PDT)
Date:   Tue, 10 Jul 2018 16:47:36 -0400
From:   Sean Paul <seanpaul@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        y2038@lists.linaro.org, Jordan Crouse <jcrouse@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm: avoid using 'timespec'
Message-ID: <20180710204736.GU20303@art_vandelay>
References: <20180618153959.2169325-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618153959.2169325-1-arnd@arndb.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 05:39:42PM +0200, Arnd Bergmann wrote:
> The timespec structure and associated interfaces are deprecated and will
> be removed in the future because of the y2038 overflow.
> 
> The use of ktime_to_timespec() in timeout_to_jiffies() does not
> suffer from that overflow, but is easy to avoid by just converting
> the ktime_t into jiffies directly.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/msm/msm_drv.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index b2da1fbf81e0..cc8977476a41 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -353,8 +353,7 @@ static inline unsigned long timeout_to_jiffies(const ktime_t *timeout)
>  		remaining_jiffies = 0;
>  	} else {
>  		ktime_t rem = ktime_sub(*timeout, now);
> -		struct timespec ts = ktime_to_timespec(rem);
> -		remaining_jiffies = timespec_to_jiffies(&ts);
> +		remaining_jiffies = ktime_divns(rem, NSEC_PER_SEC / HZ);

Do you need to wrap rem in ktime_to_ns() just to be safe?

Sean

>  	}
>  
>  	return remaining_jiffies;
> -- 
> 2.9.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
