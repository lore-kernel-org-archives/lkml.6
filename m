Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CE1C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E0021A63
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="bbMPQGA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E0021A63
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732579AbeHFVxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 17:53:43 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43716 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731143AbeHFVxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 17:53:43 -0400
Received: by mail-ed1-f67.google.com with SMTP id j21-v6so3332750edp.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 12:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AAH2DZZlRxXs+lGxhonaJAm3wnkPvGBVewhynb6ZLW4=;
        b=bbMPQGA6bbOQPWkFt+taTZxAHZYngZ81KxE13dxwrorxZlAQ10dWZGcM1x8NwrDxJy
         fFbGK7CGY/y/a6W9oOJ9i5a6p9Ov2q4OZmk+pop2au/nIuh3fu7x2n9b8xyxs4zAsjD/
         WiPKy1Nw/KcvOeswKKmXl4vIyEO50NksH5v5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=AAH2DZZlRxXs+lGxhonaJAm3wnkPvGBVewhynb6ZLW4=;
        b=fwI8kbfVUzMYCJwMWZ6GZvUIwE2j5DPm5SsViDY9+tsr5UYAGa3/EDDt5bbInbsUNA
         N3cKZHWXc744Rg8HIt6Hm+RlirkbBg4ngj5C2DwwbtzSLvmvtS8peSfiIXPCXRnA+Tnl
         I0Rl6es4nuWxfVQW4Xnl2cY5YKA93c3WtarDSTyM6s5V8ZYGk4dpI2Nd0yT3e0VhEv6/
         cP3l31lXr2a1u0FJrgtEYWnXxe1te5b76nNZXvMVvdu8+wBoNldh8XeWVXqg19Gy0Gt9
         bKqHVnZ+SasThxpFr4f2klP1XdQ2XNPEwZNmW5hfG192REQ9sYbtdOKC4aytOrbC/TKy
         COIQ==
X-Gm-Message-State: AOUpUlFouu5HENixMIVavR6sTvtTCiUrui1MQ39FJdqLgBdvwEq0voBA
        cmwAB7pXZ5nsOR61EikUVTT+KbOKCi4=
X-Google-Smtp-Source: AAOMgpfx+8i7DeCcLhhpPV+dyNQNLPCAzCEC6nx2iuZVpoOjRK/D8Hw5h0ArOwbBmEOnL1ubRG/Dvg==
X-Received: by 2002:a50:8818:: with SMTP id b24-v6mr20211788edb.274.1533584586135;
        Mon, 06 Aug 2018 12:43:06 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:56fc:0:d707:d7d8:b180:96e5])
        by smtp.gmail.com with ESMTPSA id p20-v6sm4963619edr.12.2018.08.06.12.43.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 12:43:05 -0700 (PDT)
Date:   Mon, 6 Aug 2018 21:43:03 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Lyude Paul <lyude@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
        Karol Herbst <karolherbst@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 3/8] drm/fb_helper: Introduce hotplug_suspend/resume()
Message-ID: <20180806194303.GT3008@phenom.ffwll.local>
Mail-Followup-To: Lukas Wunner <lukas@wunner.de>,
        Lyude Paul <lyude@redhat.com>, David Airlie <airlied@linux.ie>,
        nouveau@lists.freedesktop.org, Karol Herbst <karolherbst@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20180731003954.19962-1-lyude@redhat.com>
 <20180731003954.19962-4-lyude@redhat.com>
 <20180806084322.GK3008@phenom.ffwll.local>
 <4e72a10062166d646ebd3eb28b6c186d4c00a63f.camel@redhat.com>
 <20180806193457.GA7028@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806193457.GA7028@wunner.de>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 09:34:57PM +0200, Lukas Wunner wrote:
> On Mon, Aug 06, 2018 at 03:15:31PM -0400, Lyude Paul wrote:
> > You did mention in the review of one of my other patches that we should avoid
> > disabling polling during runtime suspend, and you're definitely right. I feel
> > a bit silly for not remembering that since I was the one who made it so that
> > i915 does polling in runtime suspend for chips without RPM HPD detection in
> > the first place because it was causing people's displays not to come up on
> > vlv...
> > Anyway: I think if we just leave output polling enabled during runtime suspend
> > that might actually fix all of the fb_helper locking issues since we won't
> > need to wait on any of the output poll workers to finish, at least I think it
> > should: I'll confirm this when I get into the office
> 
> Quoth Imre Deak:
> 
>    "In i915 polling is on during runtime suspend only if there are outputs
>     without hotplug interrupt support. A special case is when an output has
>     working HPD interrupts when in D0, but no interrupts when runtime
>     suspended. For these we start polling (from a scheduled work) in the
>     runtime suspend hook and stop it in the runtime resume hook (again from
>     a scheduled work)."
>     https://lkml.org/lkml/2018/2/12/330
> 
> nouveau only uses runtime PM on discrete GPUs in dual GPU laptops.
> Resuming the GPU from D3cold to D0 every few seconds to poll the
> outputs would waste too much power on such machines.
> 
> The question is, why is polling running at all, since all modern
> laptops have HPD-capable ports such as DP?

Note we don't fully sync with the poll worker here, we just update the
polling flags and let the poll worker lazily notice the change (and stop
itsefl). That avoids the deadlock. It also means that the poll worker must
call pm_runtime_get() in all the right places though.

On resume we need to kick it again, but that doesn't have a deadlock
potential.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
