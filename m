Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050A8C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E2A20870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CYU+kcJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8E2A20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbeJ2Wn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 18:43:26 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44529 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeJ2WnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 18:43:25 -0400
Received: by mail-ed1-f66.google.com with SMTP id z21-v6so7344214edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 06:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iPs4Gs3Y/n3f7pwNOhpWRAjaXS8uccko7yxxth6Lx2E=;
        b=CYU+kcJOlGafaF/e+lNnsWWVqWQqJIkBUC8HbyCOzZYXfihaJ3xvfYW26Tboomt0cZ
         SffenIjkg2AY0VK25hPVl2xqC/T+km0hywOQjYtLi65zeLylcbGpjsP6YNj5uTHht3L0
         RHe1pZ2N3BKTLvyGPg6xBREwceA0yO0lZhQ1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=iPs4Gs3Y/n3f7pwNOhpWRAjaXS8uccko7yxxth6Lx2E=;
        b=D4BxjKJGKcEPYprbpWslsTR3HoW1wLuQjh9VDCUHuBzcnF1yJgWlcXY7qZVktP3Mxm
         dP2uK0KzKXXwOXW1fBnMRf1lK/IgFFyNa8M6GG2HcDT+MQt3la8Hvt8iBZJ5WQhDQt/x
         3kg0N4BdqztcMXblAPuJBipUFsgpudpvNGXKZ0v/Hy4JYEOogAga5/SM4rlNsvx/bmTr
         LQtq8cju9DWKu4LXfb4JPL1EyWD8fHHDnjJnGt/vyvzW/7twnR9dd+hymwachHYmffhz
         E3wEwTNGF7U5xyQiDKuCTh6EiMOPWxZ3DhUdKu3qwvHpNoYbzFFfBHlbkugsJWnAvaPZ
         9mJA==
X-Gm-Message-State: AGRZ1gI/7XESPEcET7Yb/4hAVqIvQJ6HTqvDWPgGvesTKNOnM6eWfPGR
        Ir+hs94Y4VopWYhj/dv6UxT8rQ==
X-Google-Smtp-Source: AJdET5fpu57nXdsDZlK6f0BW4dSMiAnwNgPX9AJ/iYne9Hk4K6YwVHHFkMVk/roWH4O2FgaItyqybg==
X-Received: by 2002:a50:afa2:: with SMTP id h31-v6mr13990219edd.169.1540821277694;
        Mon, 29 Oct 2018 06:54:37 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id k13-v6sm471625edi.37.2018.10.29.06.54.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 06:54:36 -0700 (PDT)
Date:   Mon, 29 Oct 2018 14:54:34 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
Cc:     Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH 0/6] drm/qxl: Remove checkpatch issues
Message-ID: <20181029135434.GY21967@phenom.ffwll.local>
Mail-Followup-To: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>,
        Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
References: <cover.1540579956.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1540579956.git.shayenneluzmoura@gmail.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 04:20:30PM -0300, Shayenne da Luz Moura wrote:
> This series cleans the following checkpatch.pl issues:
> 
> ERROR: trailing whitespace
> WARNING: Missing a blank line after declarations
> CHECK: Please don't use multiple blank lines
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> ERROR: space required before the open parenthesis '('
> CHECK: Avoid using bool structure members because of possible alignment issues

I looked through the patches, all fine, great work. I've pinged
maintainers and will merge it all as soon as they've acked it.

Assuming you want to continue hacking on gpu drivers, we have a todo list
with more advanced tasks:

https://dri.freedesktop.org/docs/drm/gpu/todo.html

Best to discuss those on #dri-devel irc before getting started, to make
sure scope and all is clear.

Cheers, Daniel

> 
> Shayenne da Luz Moura (6):
>   drm/qxl: Remove trailing whitespace
>   drm/qxl: Add line after variable declarations
>   drm/qxl: Remove exceding whiteline
>   drm/qxl: Use 'unsigned int' instead of 'usigned'
>   drm/qxl: Add space before open parentheses
>   drm/qxl: Use 'unsigned int' instead of bool
> 
>  drivers/gpu/drm/qxl/qxl_cmd.c     |  7 +++++--
>  drivers/gpu/drm/qxl/qxl_debugfs.c |  5 ++---
>  drivers/gpu/drm/qxl/qxl_dev.h     |  1 -
>  drivers/gpu/drm/qxl/qxl_display.c | 19 ++++++++++---------
>  drivers/gpu/drm/qxl/qxl_draw.c    | 11 ++++++-----
>  drivers/gpu/drm/qxl/qxl_drv.h     | 31 ++++++++++++++-----------------
>  drivers/gpu/drm/qxl/qxl_dumb.c    |  3 ++-
>  drivers/gpu/drm/qxl/qxl_fb.c      |  4 ++--
>  drivers/gpu/drm/qxl/qxl_image.c   |  4 +++-
>  drivers/gpu/drm/qxl/qxl_ioctl.c   |  2 ++
>  drivers/gpu/drm/qxl/qxl_kms.c     |  2 +-
>  drivers/gpu/drm/qxl/qxl_object.c  |  5 ++---
>  drivers/gpu/drm/qxl/qxl_object.h  |  2 ++
>  drivers/gpu/drm/qxl/qxl_prime.c   |  1 -
>  drivers/gpu/drm/qxl/qxl_release.c |  1 -
>  drivers/gpu/drm/qxl/qxl_ttm.c     | 12 +++++-------
>  16 files changed, 56 insertions(+), 54 deletions(-)
> 
> -- 
> 2.19.1
> 
> -- 
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/cover.1540579956.git.shayenneluzmoura%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
