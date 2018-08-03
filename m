Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F3BC43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A432216F3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sOyulyaS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A432216F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbeHCEyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 00:54:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33705 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725736AbeHCEyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 00:54:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id d4-v6so2448639pfn.0;
        Thu, 02 Aug 2018 20:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rKHsBYfHlmB6tFfRCia5ua7tAELo6j78QIJmVAPqLWo=;
        b=sOyulyaS/9HAL9bVu+fEiYsIF2aEcqYh03/RSt4yGkuUx6qt6beM1vZE/OLbud0MN2
         9zcobetRdHqY+6rZZbNTWxBXJnQqqIj/nywoF3r8e6qCqA8BUkkX/hLEZfGa2cArpCX3
         vki89D0ZtdDF7YWFX3CAwzESMN/o4y2CHcdX6Faxb2+PKoFQyUDPna35lTvkx6t6kd57
         s2fiZht7zkDG5X6c3h9T+kl0ZwFKMmHbbmW0kM6xSdXcjWnHEJaYfjZvjLKDuH/ywpfD
         IB0PYjWYXZnpvrYZHoobb4OgeZDoixJY0UeRf6fIGqGfOtJbkz7QaU8dUJtOeDeqHc9j
         8dUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rKHsBYfHlmB6tFfRCia5ua7tAELo6j78QIJmVAPqLWo=;
        b=IOgurAwuQtp8N7JHpq6kaF2Vv6Y0M3+8bvKCHwqm2bqSCwDH6TcUZ/KhQ7+sItDlPX
         Y3rzicy789xXcvdomf5Ohra16VQ3pAo/XPNEsXxXf5ySKXyEKDfhvzw02QeKomAx3lGI
         bvpF5fnTpMeE8VJJ/aDM6EBPdzTb9wKgTrmbNJJyEBRrIvliMyEdKjBBO07NA3Fx6P4E
         bTAT/LEanyon7LMorpNHAHDuuFIWFnaEunMlGRib9mhiTmHanUDx3TZvSn2EG79QP97y
         fUrj2QtFN3sku517tcPKfnNJ7qp9m9B7gTjV430dkKRUMWC/MowLBu19HeQHPOMb0yzG
         fCag==
X-Gm-Message-State: AOUpUlFKh1NtE7icYpBkjr5aEDyebvrU7vRArsHKGWK78AigGXBDEU/o
        UQm94HpzNxyWkkB0Qw/IFzg=
X-Google-Smtp-Source: AAOMgpemOuk/tK/cABZZkYNWpX4KRcIpdh+ZGq66wlmrZVeoWpB2tGe5/y+fuyv0dDCh0Iy9c8BnEw==
X-Received: by 2002:a62:2459:: with SMTP id r86-v6mr2275825pfj.31.1533265225305;
        Thu, 02 Aug 2018 20:00:25 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2401:fa00:d:10:9465:817a:e0d1:934d])
        by smtp.gmail.com with ESMTPSA id x87-v6sm6627299pfa.143.2018.08.02.20.00.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 20:00:23 -0700 (PDT)
Date:   Fri, 3 Aug 2018 12:00:19 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tino Lehnig <tino.lehnig@contabo.de>, stable@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] zram: remove BD_CAP_SYNCHRONOUS_IO with writeback
 feature
Message-ID: <20180803030019.GB86818@rodete-desktop-imager.corp.google.com>
References: <20180802051112.86174-1-minchan@kernel.org>
 <20180802141304.d0589ddc5f8213429ab3b565@linux-foundation.org>
 <20180803023929.GA7500@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803023929.GA7500@jagdpanzerIV>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

On Fri, Aug 03, 2018 at 11:39:29AM +0900, Sergey Senozhatsky wrote:
> On (08/02/18 14:13), Andrew Morton wrote:
> [..]
> > That changelog is rather hard to follow.  Please review my edits:
> > 
> > : If zram supports writeback feature, it's no longer a BD_CAP_SYNCHRONOUS_IO
> 							^BDI_CAP_SYNCHRONOUS_IO
> 
> [..]
> 
> > A reader looking at this would wonder "why the heck are we doing that".
> > Adding a code comment would help them.
> 
> The interesting thing here is that include/linux/backing-dev.h
> BDI_CAP_SYNCHRONOUS_IO comment says
> 
> 	"Device is so fast that asynchronous IO would be inefficient."
> 
> Which is not the reason why BDI_CAP_SYNCHRONOUS_IO is used by ZRAM.
> Probably, the comment needs to be updated as well.

I couldn't catch your point. Could you clarify a little bit more?
What do you want to correct for the comment?

> 
> Both SWP_SYNCHRONOUS_IO and BDI_CAP_SYNCHRONOUS_IO tend to pivot
> "efficiency" [looking at the comments], but in ZRAM's case the whole
> reason to use SYNC IO is a race condition and user-after-free that
> follows.

Actually, it's not whole reason. As I wrote down, without it, swap_readpage
waits the IO completion for a long time by blk_poll so it causes system
sluggish problem when device is slow(e.g., zram with backing device).

Thanks.
