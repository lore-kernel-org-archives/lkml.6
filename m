Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77686C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 21:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F9A020665
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 21:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8WbfN0g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbeL1V3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 16:29:11 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39401 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeL1V3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 16:29:11 -0500
Received: by mail-pf1-f195.google.com with SMTP id r136so10916929pfc.6;
        Fri, 28 Dec 2018 13:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9A9TPdUjmy+tRWZsLInzQrzQ9VjRCGfuPngosxQuXQs=;
        b=j8WbfN0gtKFkmjkx/omHA7fNK177eKVMEvPTD11QYxEH4csPbOCD4hFiG52PwE3X8P
         YVuLD6/viK6zs+U3x6MyRISOiSTPvqeehS88Zi4kGwyoNc8ElZQiV796jpvjEauQcuTj
         tbWemnG2BmzBIHHnb/2Fh6mchKjqTf1Ng+sb2bfsoP8UAyWoEmRX674eUJYvzgqSy/4E
         UCNfBrFH5dJ8IGuJgd9ApvJ54Wg8wTtFAxr5zb9XshAOfaHszYVYrsqYpYKtrj/FsQKg
         kWNrMzH5Yr589DkQepfsMuLrnC5lrZslmAOCK/NzA7LgJRZJHllQUFlntK+bWmaBo1aC
         es6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9A9TPdUjmy+tRWZsLInzQrzQ9VjRCGfuPngosxQuXQs=;
        b=ChMvTNv2FcGCPmkIE6jNp8OckLcCFXYkHNfxqvxRQyyXPnOI1b2dCsVVYD+aNRRwUc
         pH5wrr1XFqHeJL8Yl4jss9pBVZEmhoq+asDWaI7sDB5jxEYv1YgmOLqPymBFrdnZC3b7
         9co/9/czDl92F2r1YGePihFVaVF9GztPO0GHiquddO8Gp0HhexHDrJS6EYzX2sDD3AoW
         ieyV+A0i1+MArhkx3yVCtuwwUZdvc+M37C3/UtUlqqmYl+FRSWwkr+swbSf42fOi6ApA
         Xg+fgrwcIF1fvXsz2GFjjpK3eZ5gQjx57CZixNFfl7dpsqkY9B2TimWFK4y3/I4hM6Bb
         u/Ow==
X-Gm-Message-State: AJcUukc3RJKeSj5PPZv9xPdL1oV6ZpxQF3Q/dQF+5KcCVHKkO7hXplWf
        WZ5N22IiEkqsUmv9ur71wSU=
X-Google-Smtp-Source: ALg8bN78F+Pc3EzRhoAj8QZvQ6oN+XrISweszPOLpWtFn6kmITkPYZ1BUuFWvGAF7xoHXyCl+kfrrw==
X-Received: by 2002:a63:5e43:: with SMTP id s64mr27875488pgb.101.1546032550488;
        Fri, 28 Dec 2018 13:29:10 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e23sm61849601pfh.68.2018.12.28.13.29.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 13:29:09 -0800 (PST)
Date:   Fri, 28 Dec 2018 13:29:09 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/46] 4.19.13-stable review
Message-ID: <20181228212909.GC32706@roeck-us.net>
References: <20181228113124.971620049@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228113124.971620049@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 12:51:54PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.13 release.
> There are 46 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Dec 30 11:30:49 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 332 pass: 332 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
