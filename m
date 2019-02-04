Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81B4C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE9320820
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Du6PMVwz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbfBDJ0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:26:24 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44963 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfBDJ0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 04:26:23 -0500
Received: by mail-ed1-f68.google.com with SMTP id y56so10585291edd.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 01:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HCk6Cker7EnaqG4lRZ4AvMxXN47boaQMquZ5+xe/jYk=;
        b=Du6PMVwzIgSQ53vnpOupZdNTSnriu0zadfMIjv3MuL04LxYHFeMqYjsvz/B2N+cORu
         D4TIsnFLi3bE7HWvltEg6m4O1zeSatuaO8k4YldvIEf/ZeFWczFT4OrIwAEG8/3f8+22
         YglGGOIpqDEa2XX78/VMX2OuYp/kJkLzfwchE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=HCk6Cker7EnaqG4lRZ4AvMxXN47boaQMquZ5+xe/jYk=;
        b=OxHnX8gwft8t1lWpMdl5v7Hc7p/x49loc3aNTJtFcwIJvphhDdJri9GXv7GPzqS6UD
         g4ZWwShQSvCWWlIucXLcyh8J9Egv3J7jQq17KRLSrLgl1d2I7F6enx/5+h5g+sKulJH1
         JotBg+ZESG7C6x61oLFPrG9M+ACoDxjDZwSnmCmTD0ZOdDeDjKnk2oxQr7Lr3kV8lgwu
         0jKyo+qi/M5IcPmOxT056om2/7vaMkJVHevXQpUAE+m87BSOMJSld3nKnfhFH1KvXshr
         p55f8tEi0RtO3b6Ps32G01zlbxhbDTInfcpLXytW+dUvnG+yYHZeE+hf3zcHR4kdZ4o1
         0YFA==
X-Gm-Message-State: AJcUukfEvA3wyf7BSqeIxqApmK9RFW9v5Dc/QSDys+pfBodhp/QfoXJ/
        sdfDkA1NI8CbuTEngoYrmO2HsQ==
X-Google-Smtp-Source: ALg8bN483B6g9VKR3p4w5y8w1P454HAFOh8ssUXVGJeO3vZdPQlxGFoltwUXq9ORpcNtgnIUKAyRFg==
X-Received: by 2002:a50:8b26:: with SMTP id l35mr48215172edl.146.1549272381471;
        Mon, 04 Feb 2019 01:26:21 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id g20sm3927496edr.47.2019.02.04.01.26.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 01:26:20 -0800 (PST)
Date:   Mon, 4 Feb 2019 10:26:18 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Yifeng Li <tomli@tomli.me>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>
Subject: Re: [PATCH 0/8] fbdev: sm712fb: implement 2D acceleration w/
 cleanups.
Message-ID: <20190204092618.GM3271@phenom.ffwll.local>
Mail-Followup-To: Yifeng Li <tomli@tomli.me>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>
References: <20190202061648.30374-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190202061648.30374-1-tomli@tomli.me>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2019 at 02:16:40PM +0800, Yifeng Li wrote:
> Previously, in staging/sm7xxfb (now fbdev/sm712fb), 2D acceleration
> was implemented, but after its submission, a critical bug that causes
> total system hang was discovered, as a stopgap measure, 2D ops was
> completele removed in commit 3af805735a25 ("staging: sm7xx: remove the
> buggy 2D acceleration support") and never implemented again.
> 
> It created a massive usability problem - on YeeLoong 8089, a notable
> MIPS platform which uses SM712 - even scrolling a single line of text
> on the console required an unaccelerated screen redraw, running "dmesg"
> typically takes 8-11 seconds, and absurdly, printf(), became a significant
> performance bottleneck that slows down GCC and "make", make the computer
> largely unusable.
> 
> So I decided to take a look. Most of the my actual development was done
> in 2014 in a personal out-of-tree driver, I did not mainline it because
> 2D acceleration was not working properly in 24-bit color. I discovered
> the solution in early 2019 and now it's ready to be mainlined.
> 
> This commit reimplements the 2D acceleration for sm712fb. Unlike the
> original implementation, which was messy and unnecessarily complicated
> by calling a 2D acceleration wrapper file with many unneeded functions,
> this is a minimum and (relatively) clean implementation. My tests have
> shown that running "dmesg" only takes 0.9 seconds, a performance boost
> of 950%. System hangs did not occur in my tests.
> 
> Currently, 2D acceleration is only supported on SM712 with little-endian
> CPUs, it's disabled on Big Endian systems and SM720 chips as a safety
> measure, since I code for myself without any monetary or hardware support
> from any company or OEMs, I don't have the hardware and it's completely
> untested. I should be also to purchase a Big Endian test platform and add
> proper support soon.  If you have a Big-Endian platform with SM7xx
> available for testing, please send an E-mail to me immediately! Thanks!
> 
> Also, thanks to Miodrag Vallat and other OpenBSD developers, this work
> would be impossible without their code, that served as a reference
> implementation for me.
> 
> Finally, during the development and testing of 2D acceleration, the
> modesetting code of this driver received a minor cleanup, and many
> issues about issues about the modesetting code and this driver in
> general have been documented.
> 
> Yifeng Li (8):
>   fbdev: sm712fb: update copyright headers.
>   fbdev: sm712fb: use type "u8" for 8-bit I/O.
>   fbdev: sm712fb: add 2D-related I/O headers and functions.
>   fbdev: sm712fb: support 2D acceleration on SM712 w/ Little-Endian CPU.
>   fbdev: sm712fb: add 32-bit color modes, drops some other modes.
>   Documentation: fb: sm712fb: add information mainly about 2D.
>   fbdev: sm712fb: Kconfig: add information about docs.
>   MAINTAINERS: sm712fb: list myself as one maintainer.

Since you care about this driver, considered converting it to a drm
display driver? You can still have all the acceleration and stuff, the
fbdev compat mode in drm is rather flexible.
-Daniel

> 
>  Documentation/fb/sm712fb.txt  | 123 +++++++-
>  MAINTAINERS                   |   1 +
>  drivers/video/fbdev/Kconfig   |   4 +
>  drivers/video/fbdev/sm712.h   | 129 +++++++-
>  drivers/video/fbdev/sm712fb.c | 574 ++++++++++++++++++++++++++--------
>  5 files changed, 679 insertions(+), 152 deletions(-)
> 
> -- 
> 2.20.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
