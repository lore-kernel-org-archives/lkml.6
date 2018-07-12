Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B73ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B4F208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="VuXLWJQr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B4F208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732997AbeGLVfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 17:35:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42517 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732547AbeGLVfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 17:35:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id e7-v6so3517357wrs.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 14:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=30sN7QPCl2f5+TxQYRNcc470C8xbnsS4dJL//uod7Fs=;
        b=VuXLWJQrFUPzrcMZDrVZb88vjxrpgFEBo5Ss4yS8eumfNaELOiK5ErLAWiiaDv3Df8
         gNP3Dp78LyQSx3Wy4SyulWpsFfsij6sQ4t/lGOLQPsfDXMr+z/yTX8aVvBFmXAhafrPS
         ULK1xI8w+g12J8yGQ1IhJwwjiQgtCosDDLcTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=30sN7QPCl2f5+TxQYRNcc470C8xbnsS4dJL//uod7Fs=;
        b=MeoOo8D1JU+MK8m22okApQ06G2EM51vThdJWdnC8Npici5sKLPvm+LxMJ53jC72QWd
         aq8VFXU0bfL8BI5XFwbOPuDaOcmAjpJCp+Nmmc/gzJmRbVyIcZHxWtCX7FhqGhK63P7Z
         7V0zQ1+LV8a/D0hr6aURib6MahY8JARmGC84pQ5+Zcica0xbu13Ts1EjpDQYzjoKlKBX
         UjNz/ZggVkIUTSGfzyyOKk3vJwrKHL8sBagHELgBPzspHypjMXWbrZMilQCt225vT59L
         RvNoFDHft8j80S82pCl6KBV2mDE+KyXm2evo60mOFfzIlKFKVIiXMwINZP8I7ti0eAlw
         x02g==
X-Gm-Message-State: AOUpUlErzR/gHKDhdYjywiq4mvtJo1VxXspWidIQcW3PcEi4s34B2nr1
        3G/kBSmKEvcxeT9yA64mreETdg==
X-Google-Smtp-Source: AAOMgpc5pOA26o4SLA73aOJC9umhiETlGDEYHwhdgxvidrpMnBeXhU+oWRW/3tF+BC65zLez8vhN/g==
X-Received: by 2002:a5d:438d:: with SMTP id i13-v6mr3082627wrq.156.1531430639059;
        Thu, 12 Jul 2018 14:23:59 -0700 (PDT)
Received: from andrea ([94.230.152.15])
        by smtp.gmail.com with ESMTPSA id z5-v6sm25889775wrv.2.2018.07.12.14.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 14:23:58 -0700 (PDT)
Date:   Thu, 12 Jul 2018 23:23:51 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Message-ID: <20180712212351.GA5480@andrea>
References: <20180712175228.GB3533@andrea>
 <Pine.LNX.4.44L0.1807121637050.1306-100000@iolanthe.rowland.org>
 <20180712211348.GA5308@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712211348.GA5308@andrea>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 11:13:48PM +0200, Andrea Parri wrote:
> On Thu, Jul 12, 2018 at 04:43:46PM -0400, Alan Stern wrote:
> > On Thu, 12 Jul 2018, Andrea Parri wrote:
> > 
> > > > It seems reasonable to ask people to learn that locks have stronger
> > > > ordering guarantees than RMW atomics do.  Maybe not the greatest
> > > > situation in the world, but one I think we could live with.
> > > 
> > > Yeah, this was one of my main objections.
> > 
> > Does this mean you don't think you could live with it?
> 
> Well, I *could* leave with it and with RCtso locks, ;-) but I'd rather not.
> 
> Assuming that I will not be able to resist this RCtso trend, ;-) would the
> below (completely untested) work?
> 
>   let rmw = rmw | lk-rmw   (* from lock.cat *)
>   let po-unlock-rf-lock-po = po ; [Release] ; rf ; [domain(rmw)] ; po

domain(rmw) & Acquire, maybe...

  Andrea


>   [the rest of your patch + the updates to the doc. I suggested in v2 ;-)]
> 
>    Andrea
