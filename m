Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F48C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139EC2083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="eL5a6aTi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbfBEJCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:02:52 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46669 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbfBEJCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 04:02:51 -0500
Received: by mail-ed1-f65.google.com with SMTP id o10so2147550edt.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 01:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7fk8V1TihraTHKCkkhXhixPSKwKwuDovNLxVglaKNAM=;
        b=eL5a6aTiC71IJXJqB5j/Ywpf4j0SvSkblWAAHFVG6TQO5X7Gs6mr5RO7tqQM8Z8RBB
         W2HCVVVJ30gg/oobA2fe24ZBelpW0wa8jqCD95/Zzg/bX7bJEFhBYaAYp1N1IsPWkZHg
         8UgZ43kXmf/kuOtPuLxVJ9KcldBIi3rpNWsx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=7fk8V1TihraTHKCkkhXhixPSKwKwuDovNLxVglaKNAM=;
        b=qKRo5dxwzYNLiMES5sMlkItt2KGe2a7ny9U051wePOwzauQk+jSQF2UlXmOUzTBwOp
         DH5txtMJFtCCSFEiQxugUM9e1DOMtlNebB/CyivD4jAOO3VCAOY4VMW2PlF9jm9ckKCU
         D8eGyrQQgy1xKTPBEkvEqby3yQkKVYK6K0GyfuO79hMz6S+V+4gld1hWsuFaZHKqvvko
         LVY+VbVW4H2Rf34TaaGE7TOS01Z6a7NHmN5I0Yruz+SUdpUzfXU5hjBAI/MXXrE8VxaW
         rQoEifg/zB7Rn7nEqrTM75ABVl694jed8iNNu3fnhD8Ebl+YFh7Pos7BUca8IhbCDF9x
         juQw==
X-Gm-Message-State: AHQUAubS4qpR38BapRBB6fsOMGUKr2Z1iLTq6lxVAq/FLKp7qaXvoRoX
        SYhoeMKUCD/48zn5xq0a1+s9EA==
X-Google-Smtp-Source: AHgI3IYBoiuLxK9Jf5klA3L+D4rJPoyIFIrhjlBdVObUSjiq5Q8sjtoA/6bPHDAFjdQEC5ymqsAoMw==
X-Received: by 2002:a17:906:1350:: with SMTP id x16mr2750156ejb.85.1549357369740;
        Tue, 05 Feb 2019 01:02:49 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id k12sm2898634ejz.4.2019.02.05.01.02.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 01:02:48 -0800 (PST)
Date:   Tue, 5 Feb 2019 10:02:46 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Tom Li <tomli@tomli.me>
Cc:     Daniel Vetter <daniel@ffwll.ch>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>
Subject: Re: [PATCH 0/8] fbdev: sm712fb: implement 2D acceleration w/
 cleanups.
Message-ID: <20190205090246.GB3271@phenom.ffwll.local>
Mail-Followup-To: Tom Li <tomli@tomli.me>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>
References: <20190202061648.30374-1-tomli@tomli.me>
 <20190204092618.GM3271@phenom.ffwll.local>
 <20190204220650.GA24673@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204220650.GA24673@localhost.localdomain>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 06:06:50AM +0800, Tom Li wrote:
> > Since you care about this driver, considered converting it to a drm
> > display driver? You can still have all the acceleration and stuff, the
> > fbdev compat mode in drm is rather flexible.
> > -Daniel
> 
> Yes, I know fbdev is now in maintenance-only mode, reimplementing it
> on top of DRM is on my roadmap, including rewriting a saner version
> of the modesetting code. The current version is beyond repair. I'll
> start working on it once I managed to purchase the hardware for testing.
> 
> But currently my objectively is to have something usable during the
> transitional period. The major user of the chipset was Yeeloong 8089D
> laptop - a choice for many non-x86 and MIPS hobbyists for experimentation.
> Getting the current version of the patch merged would solve the immediate
> usability issues, and then trying to get some platform drivers merged.
> And after completing the preliminary upstreaming process, since then,
> can start working on a DRM version of the driver, and possibly eventually
> remove the fbdev version of sm712fb entirely. 
> 
> The 2D acceleration implementation is strictly no more than 200 lines,
> the vast majority of the code insertions are comments and documentation
> changes ranting about the known issues of the driver/hardware, nothing
> non-trivial is added and I think the changeset is manageable and would
> not be a burden for the fbdev maintainers, and I can grarantee that I will
> not add any other new features to this driver.

Awesome, and I think as a gradual plan this makes tons of sense.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
