Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54961C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A2C2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="PLwuHrEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfAXU2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:28:42 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45876 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbfAXU2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:28:42 -0500
Received: by mail-yw1-f67.google.com with SMTP id d190so2964018ywd.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 12:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ufqPic79j9muAkEXn+008Ps95N1UNi5tG2Gsrk66KWw=;
        b=PLwuHrEFXjXJdrsrnybqu+ZuXzJxS/Rz7jtwSr8xvFonsLExITIF2PBmUU7tJXYLQd
         HNkqIDSzPn+wm0qgItYi968U7hvnaPTKc/jBxYkL6zf9SFpFYq+LVzeE2o0izKrEdFHa
         BWAjRMkkQ5DK0rxtBwkZ3SIPXU8nBxzbfw69HHEyHlE2OetBfZbh/5O2bv7gHT+Qi9ky
         MCPqjBxoDu1XJLQ9y4AMdVEXgO1F3TvcLwE4ElZfig89kFYU9VCv9MfoqBwbbDJ33ZJI
         dJAvr/im7sMt1EBlF67RAwQV/CmaPY2Az0Dbx4T0bO0W78eXoPkXq60KG3DfgtXkScFh
         OO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ufqPic79j9muAkEXn+008Ps95N1UNi5tG2Gsrk66KWw=;
        b=PkosN1B8NWgNVNJWqvQPwltN6RQGmt8ZZtGCNCFklvb4KspSoN8mTYwA54fiqobD7K
         SYuqorerD+L3U9shw3rEiGhV49gN7po4eRcTOy8bbToe83jNMoKCV3Y12wHIai2gIOly
         xA0xGzI90DhBnrRNMZLd/gllVYfw9azcjJfZOTkMMtPd7ov1V5wP5M3t7xmYWxXq+Nqd
         mPOKGAXFjoTtpWc7w8pyc9YRJLeuyC0ir7vwQ7Z2RYlorgVlVgOdjltzdcfGa5BCncZ8
         VZkio/Ev0gaQiQt5O3NctnYARFsLMvGgfod0S6qNIwXRqsm0TedgOJNc5+W5sLjkuiS9
         fvIA==
X-Gm-Message-State: AJcUukfME+sMjD3xx454cNF4IAENv6IzA3wj3fjb28wx0TVFM5AZfdKq
        5jHYwAWenmLO9IicNFTVkMxcGw==
X-Google-Smtp-Source: ALg8bN5tUKbWIRaC7Q3W36Yh9bdaDfhmgVGXPycOoZenXu2QCCcRzzJFHyL3S6PfesFm1n9P3gVtrA==
X-Received: by 2002:a81:2cc4:: with SMTP id s187mr8174896yws.67.1548361721101;
        Thu, 24 Jan 2019 12:28:41 -0800 (PST)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id d3sm13551171ywh.58.2019.01.24.12.28.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 12:28:40 -0800 (PST)
Date:   Thu, 24 Jan 2019 15:28:40 -0500
From:   Sean Paul <sean@poorly.run>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Sean Paul <sean@poorly.run>, Hans de Goede <hdegoede@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/6] drm: remove drmP.h from drm_modeset_helper.h
Message-ID: <20190124202840.GR114153@art_vandelay>
References: <20190119084014.5355-1-sam@ravnborg.org>
 <20190119084014.5355-7-sam@ravnborg.org>
 <20190124140320.GY3271@phenom.ffwll.local>
 <20190124200747.GQ114153@art_vandelay>
 <20190124201749.GA9246@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124201749.GA9246@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 09:17:49PM +0100, Sam Ravnborg wrote:
> Hi Sean.
> 
> > > 
> > > Merge the previous 5 patches from this series, but this now goes boom on
> > > vbox in staging. Needs another prep patch I think.
> > 
> > Soo, can we drop vboxvideo yet?
> 
> Hans de Goede sent out patches in September to convert it to a proper
> atomic driver.
> I recall that the feedback was mostly positive and that there was only
> minor things to left to do. Hans?

Ah, even better if we can move it from staging into drm. Would be nice to know
what it's hung up on so we can avoid these refactor breakages.

Sean

> 
> 	Sam

-- 
Sean Paul, Software Engineer, Google / Chromium OS
