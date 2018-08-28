Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE81DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 681482087F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="EFRUS89+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 681482087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbeH1X17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 19:27:59 -0400
Received: from mail-yb0-f180.google.com ([209.85.213.180]:33838 "EHLO
        mail-yb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbeH1X17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 19:27:59 -0400
Received: by mail-yb0-f180.google.com with SMTP id t10-v6so1072244ybb.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 12:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PvfyDllO5XoQxb5hGuNC3vsabBwsvZiUC2wmtVYoP4E=;
        b=EFRUS89+C3XdrMP+Mzcl86bx6Un1KmzEVCgQ55Xwt3yLKDax6Uu/h1cOV+tcS17skR
         EdsWk+DQzrW4MkV5jk6lad3ylGBnZ6zXDFPfMHpFMjlfH4wLrh6QbIXZEKYAD54Kvvtt
         jFdEjJan5z3j+CJE7V1CmpL32fM1DjDK6T9dojw2xU5vW/6RtBsrfB2M9v5U3BMSyE/5
         gGgKbFN5W1K87dflbLQsE898zqyc+M6eqE6VChfXzdm+fxDQKhqMcjvBZwZ3373YyBts
         J6ccQvR/0Uxx2DYcXq/CM/T3hNDW8zZStuQLl+IbOSr/mZFTbUV/5sHSVRCJvLpVX1JU
         gvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PvfyDllO5XoQxb5hGuNC3vsabBwsvZiUC2wmtVYoP4E=;
        b=SpQ0DiAf13FoneC9x10Oe67gGxKrK3z1Dddvq4LdYDkXZm1482iKnA8V9/07LCty0F
         M8PFkqo0sbz0/mRal0fUFs8Fh36v/GfGkTW7Yr8dDyT11ADAVGRh50kqSmFHz0NculBo
         JRH+hd4KSuml4Z2aZTAarytel/IAWymrkGZ0HvrOzUqeBIARFNUh6bJfG5DX2pfStrPi
         e7Tz3Hp3z+mzGW8JpYxfM9pcpYDa/5tGrexi7Yd1tVBZ8IZyq2ieWdiAVPu4m4f+1ShH
         snmj5o6jNNirBhOKLmhAsyqHxZTfNwjkNe08XP264jJbp+gGQf4tVildlJBgoomJp4G3
         QqCQ==
X-Gm-Message-State: APzg51DuERO4WswyEJAujKV64yPk0M3nx9EjKwfrQ7svuiej6wrZoI77
        9CreQ2GbAeQJReuXrXjgNbyOJQ==
X-Google-Smtp-Source: ANB0VdZ+jANiZQTZ6vysJb78niLQoj55bKNikUH2FXII4QvYV9vZK5cRvFkJwRN3DmwGycR6WHshnw==
X-Received: by 2002:a25:4c88:: with SMTP id z130-v6mr1706189yba.444.1535484892497;
        Tue, 28 Aug 2018 12:34:52 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id c126-v6sm2066430ywa.104.2018.08.28.12.34.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 12:34:51 -0700 (PDT)
Date:   Tue, 28 Aug 2018 15:34:51 -0400
From:   Sean Paul <sean@poorly.run>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the
 drm-misc-fixes tree
Message-ID: <20180828193451.GI45089@art_vandelay>
References: <20180828072959.631b9dbc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828072959.631b9dbc@canb.auug.org.au>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 07:29:59AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   ccb748df0058 ("drm/vc4: Fix the "no scaling" case on multi-planar YUV formats")
> 
> is missing a Signed-off-by from its committer.
> 
> It was rebased.

Hi Stephen,
I've fixed the commit and fixed our tooling to avoid this in the future. Thanks
for the poke,

Sean

> 
> -- 
> Cheers,
> Stephen Rothwell



-- 
Sean Paul, Software Engineer, Google / Chromium OS
