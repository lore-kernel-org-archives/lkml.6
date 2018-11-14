Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DFBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78D222419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PGmmqij0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78D222419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733310AbeKOBrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:47:02 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:34617 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbeKOBrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:47:01 -0500
Received: by mail-pf1-f181.google.com with SMTP id h3so1557818pfg.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 07:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+LrqeRLzCZh5UnH15yo3d1dbLZ1V/W8P2HnIyJcAXIc=;
        b=PGmmqij0Xwi6t5wQvRNeBk54GW6X2CBByyNh0kG6/GgDUr28Ere/nP6uCngqNPQ6wS
         8grQfgxD9gaGWjv0+s+ReGzZ5oSaaQZUO6/891gpG2Pev5I6bG9cVtArFaja0VM4/MCY
         JUr0VgQIg6X3r1xkrzAfMbBqLwzeaiA8Vx3J4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=+LrqeRLzCZh5UnH15yo3d1dbLZ1V/W8P2HnIyJcAXIc=;
        b=d9HOHB1/RK/oluIZwJqLqfxvCjk1wP1rMPM1nwYM36QTYXG3ib2P2BLLRyKprBAu13
         5/8VdymUhpt9J+KmiaMf7C0IRJ3ZjidEpVufV0n4eaogLhrGXP84gq1GA7yPQNCeomz/
         lZmYCea5+kWO2/MpuIxLF9sYljK75gz5HbWSmtBblyYkGE3AL6JXwgT3VzYOmbf+FmBe
         HEt1CxJTHuXV/toob7ztVynF9eCqwucGGFNaaFShe/SrRdU49DJet5mEdQrNu83QuBS1
         peUE7MUEpDbgZ1D2ELrv+E0E1KMehdAxAl5UyKSw4wrdtKf/N/RHcjRMn0waaLHsFN4J
         UaRw==
X-Gm-Message-State: AGRZ1gJOqlahxPhi49YASqgaTwE8y2cGFKAxTFunjqv9jlrseqgxaGJE
        UGZep9YBihYDnIfUUUi/q+1ahw==
X-Google-Smtp-Source: AJdET5d1BuIDiogEuZnaDnU0/PGtFg312fvIfWfeTPR6jZTLQxRYXfR/WyM7Z35ORvY+XK8vO/BICw==
X-Received: by 2002:a62:c104:: with SMTP id i4-v6mr2395824pfg.133.1542210195971;
        Wed, 14 Nov 2018 07:43:15 -0800 (PST)
Received: from pure.paranoia.local ([172.83.40.72])
        by smtp.gmail.com with ESMTPSA id l26-v6sm43468483pfg.161.2018.11.14.07.43.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 07:43:15 -0800 (PST)
Date:   Wed, 14 Nov 2018 10:43:12 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     pr-tracker-bot@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>
Subject: Re: [git pull] drm fixes for 4.20-rc2
Message-ID: <20181114154312.GA31033@pure.paranoia.local>
Mail-Followup-To: Jani Nikula <jani.nikula@linux.intel.com>,
        pr-tracker-bot@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>
References: <CAPM=9tzQBpaa7HcNvCHNxrPUDmF4o4orGy_kTJBA-8KBQO65Mw@mail.gmail.com>
 <20181114005545.8329.81866.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
 <87zhuchqps.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zhuchqps.fsf@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 12:57:03PM +0200, Jani Nikula wrote:
> Hey, this is pretty nice! Thanks!
> 
> For whatever reason, two copies were sent, though:
> 
> http://mid.mail-archive.com/20181110193502.26034.53729.pr-tracker-bot-20ef6d06ef9a31a33516637a80521b9fc7f1f849@pdx-korg-gitolite-1.ci.codeaurora.org
> http://mid.mail-archive.com/20181114005545.8329.81866.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org

Correct, this was my fault. I managed to run it against test data
without disabling mail sending capability. Hopefully, I'll remember next
time I have to do it. :)

-K
