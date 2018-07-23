Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F3EECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110BE20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNyLl/Vw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110BE20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbeGWVtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:49:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32837 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbeGWVtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:49:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id r5-v6so1211803pgv.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 13:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bTpCZJm0w8EJVk9lSXRq6DLWEvagSV3npe+zkaXb9ps=;
        b=iNyLl/Vw9fvO/xh4s/f+b2lRpOoWajhkmnKKTZTPqaYoR7Ar3gk2kjqDJ8gvzYpspd
         y6llveh4xQ6NwHDug4WPya+lGHDNFYy1fx7G6XsAyyIoaQAOgNFTF9xqiG0/tYeqM9LO
         YtK4tXmgKPwWRCdlCevddG4X+2tV1t34ByTlwwjMjz2QqdEtadapRbRbmzXwTjxyLo7m
         IuDEmSIwdOTd42yVU4/fo37QHTfbHEj/jahtKsP/T+0WWgMeHW4mHXHPl4VU+ufrSsQO
         DuOaubjhvcwuLJnCiJLD3DN/d+t+TyGouSOW6XjsTkjUvIYgLLsjrcvpAp7inNLRQsJa
         wmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bTpCZJm0w8EJVk9lSXRq6DLWEvagSV3npe+zkaXb9ps=;
        b=kgeXcOnSuN4CSEULrlWIw74odhrnYyX3HC/iYF2FnYBD0fknyeVKAmCxoeBD1GewL1
         DzwFe3cs6Z0bZaq5bYr9neMsnyOok2YRWO0e8ewqnjkZv1HoKPpHrAM0TTLtD0OcsINS
         Rfb9SNrJf3Xne//Ii17pXyXZmBphXxMcUGG+NGWg9dA9qj6jriwox7FdMBKNmWTxPScM
         3rx2Ii08tSyfiJcKHeEGKEpednWGgf8+FVsnkJiNWzuZiG5SqRwr6hGHXHe5KBTTMW+g
         wY/Krg0YGqrnHjyYzgkfNlKHj8IL1LULQglSUC+Vturj/HGplBIaUewWVHTJ4XIIkV0c
         ImNw==
X-Gm-Message-State: AOUpUlGI9lKT/pD6UtLSsSIpr0yPV+OhmBq1/dhMFRWjoLTw1QKaOQk7
        j6E0NA7nQiBdbWHFnQmLS5ZnKmdx
X-Google-Smtp-Source: AAOMgpcoZhai/q43Q4frn9w/RnPPcK/iQyJpa9A1b4pzCOiaSKif79nVfP0iCgm1AtNzbyufa0t7Sg==
X-Received: by 2002:a63:735d:: with SMTP id d29-v6mr13709312pgn.156.1532378780024;
        Mon, 23 Jul 2018 13:46:20 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id t21-v6sm17122246pfi.73.2018.07.23.13.46.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 13:46:18 -0700 (PDT)
Date:   Mon, 23 Jul 2018 13:46:17 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 4.18-rc6
Message-ID: <20180723204617.GA14487@roeck-us.net>
References: <CA+55aFzMheDA-2z=MdGgJrz-REcrknb+4OEvRKaJipm+x6xEhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzMheDA-2z=MdGgJrz-REcrknb+4OEvRKaJipm+x6xEhw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 22, 2018 at 02:23:39PM -0700, Linus Torvalds wrote:
> So this was the week when the other shoe dropped ...  The reason the
> two previous rc releases were so nice and small was that David hadn't
> sent me much networking fixes, and they came in this week.
> 

Build results:
	total: 134 pass: 133 fail: 1
Failed builds: 
	sparc32:allmodconfig 
Qemu test results:
	total: 172 pass: 172 fail: 0

The s390 gcc plugins related build error reported previously has not really
been fixed; after feedback from the s390 maintainers, suggesting that it
won't get fixed in 4.18, I disabled GCC_PLUGINS for s390 builds. This is
not my preferred solution, but it beats not testing s390:allmodconfig
builds at all.

The sparc32 build error is still:

In file included from
	...
	from drivers/staging/media/omap4iss/iss_video.c:15:
include/linux/highmem.h: In function 'clear_user_highpage':
include/linux/highmem.h:137:31: error:
	passing argument 1 of 'sparc_flush_page_to_ram' from incompatible pointer type

due to a missing declaration of 'struct page', as previously reported.

Guenter
