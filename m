Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C780FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 01:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89FEC22360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 01:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bz4dsa4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89FEC22360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbeKNLCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 06:02:53 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37127 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeKNLCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 06:02:52 -0500
Received: by mail-pf1-f193.google.com with SMTP id u3-v6so4293027pfm.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 17:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yP7iG4Xc0EnORD2Lw8VTewjF3jn8iOuZJFfBlpMrWaU=;
        b=bz4dsa4e+NDJLH+IhlqZFyFkd5k3Xg+HATsE/7DTnJhofPzlRxpd5nadZeY1Pb6wqH
         nwexFcNKcnwqCfYKTe1nHNoW1LSac8U366nzlDZzj/HjvH6OeOrSqsSLDm/pXKIpKrxZ
         AAF1exFkru0ptl7JHNigdLNrQrnm/1fw1A3QU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=yP7iG4Xc0EnORD2Lw8VTewjF3jn8iOuZJFfBlpMrWaU=;
        b=inU82ecgkKvKW+//HixMmHHCFKIZJtieydJM+NQt7nIMtf2XTEWZRH6TuRG8lxU9OQ
         c3NByMBCGFFAgXbcNvnjb+CwMSzHqP1qU5Bc48DPSNp0UxkPs0UzvWrjwyCFzhHlB0Ii
         ekihzA1QkRN1VTO13Mvosrs9CH+LoiJ/jKZP99Ybg/J1LBS5KUGth0aV7KQ1Y2VF1RmV
         IdJAP4PviOVj2cowQZmBh7i7sWuCCqHoqkmIVzW/jo8RJq4RpP66q7+RNJO/Vff5h4oT
         h5lB++qi20W4lwtcE3zQS/eQ034EyqBvKaMHo7Ahr8QxstolU8VGj9iKxttSDMPFhjfS
         kicw==
X-Gm-Message-State: AGRZ1gIUjUoI3jg1FfKv0qukZhVxZqFqRGYStn/ZNWpPLEzZN1FFoUjF
        iIH2f61s5nYW+Vf63Zuyb8vzdg==
X-Google-Smtp-Source: AJdET5dw3oHLgAW0KDdOjizDhkhbWsQigObmda20G3WQaCYcMY1f/+QHeuvUQ643vLCCPb44kMIpTQ==
X-Received: by 2002:a63:4a0a:: with SMTP id x10mr6843463pga.237.1542157320907;
        Tue, 13 Nov 2018 17:02:00 -0800 (PST)
Received: from pure.paranoia.local ([172.83.40.72])
        by smtp.gmail.com with ESMTPSA id c14-v6sm24541785pfc.92.2018.11.13.17.01.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 17:02:00 -0800 (PST)
Date:   Tue, 13 Nov 2018 20:01:58 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     pr-tracker-bot@kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [GIT PULL] namespace fixes for v4.20-rc2
Message-ID: <20181114010157.GA24763@pure.paranoia.local>
Mail-Followup-To: pr-tracker-bot@kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        Jann Horn <jannh@google.com>
References: <87pnvcls3n.fsf@xmission.com>
 <20181114005545.8329.47629.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181114005545.8329.47629.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 12:55:45AM +0000, pr-tracker-bot@kernel.org wrote:
> The pull request you sent on Sat, 10 Nov 2018 12:12:12 -0600:
> 
> > git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-linus
> 
> has been merged into torvalds/linux.git:
> https://git.kernel.org/torvalds/c/1de4f2ef216dade3b5bd5f5247c4c750a953f51c

Sorry for the duplicates! It's entirely the fault of my fat fingers that
is unable to set the --nomail flag with test data properly.

-K
