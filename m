Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03FCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73A920880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfBUIrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 03:47:05 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37499 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfBUIrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 03:47:04 -0500
Received: by mail-wm1-f66.google.com with SMTP id x10so8985646wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 00:47:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uZk32ivhigBYYDvuhrhk2pnZaRGKzq0lqzJp27kyQzY=;
        b=uGxCv0XImx093CUMA4mD8Tln5V6AL3kODTedmhpemErWCsgXbYPB/qheFoJhi5PFg8
         dg8ph06p54WttzKxZPjSwb/jaElJ5KVfe8bNvPlLrY3HwewfKkc+VGSTeliED627rXr0
         jk4dxC1a064sX/TER9ftKNeCgoKsyeDSQ9nt/NA8pb9fSNoj/6ENgmbg3cXmZMcDp4Ka
         qZtkAvo0o9jq/nGZfoG7XHjjxQMIH8DWvSyY8leHpP8Szf8wALUJPMkdMDzITTY//nLi
         dLiClVhymJahjlVaxie5sQ1QUWAxDpLXG33n/zgdb7/oZNP/rVPPMvO8Vs8EvOsyLZsy
         RQ8g==
X-Gm-Message-State: AHQUAuZsJ3l1j9apZQn8EKmimGIr3JVbBpZFfCf76BW/9fc8W4lLJK3b
        e0ykmMHx5sdqXGF9HiMSHjw8kw==
X-Google-Smtp-Source: AHgI3IbaPkW/JdkD0kKKmTmvCCDTZQRHZ2g5i0t/hHrY0Lq8U0sCm9vJ5VSBj9FsfzH27vrSti0MAQ==
X-Received: by 2002:a1c:c208:: with SMTP id s8mr9877893wmf.75.1550738822831;
        Thu, 21 Feb 2019 00:47:02 -0800 (PST)
Received: from localhost.localdomain ([151.15.254.225])
        by smtp.gmail.com with ESMTPSA id a8sm12739331wmh.26.2019.02.21.00.47.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 00:47:02 -0800 (PST)
Date:   Thu, 21 Feb 2019 09:46:59 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     tglx@linutronix.de, linux-rt-users@vger.kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        bristot@redhat.com, williams@redhat.com
Subject: Re: [RFC PATCH RT 0/2] Add PINNED_HARD mode to hrtimers
Message-ID: <20190221084659.GK21785@localhost.localdomain>
References: <20190214133716.10187-1-juri.lelli@redhat.com>
 <20190219171905.qrpr5uurayfqbehp@linutronix.de>
 <20190220074751.GJ21785@localhost.localdomain>
 <20190220153055.dt7vm47c2auove3d@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220153055.dt7vm47c2auove3d@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/19 16:30, Sebastian Andrzej Siewior wrote:
> On 2019-02-20 08:47:51 [+0100], Juri Lelli wrote:
> > > In this case you prepare the wakeup and then wake the CPU anyway. There
> > > should be no downside to this unless the housekeeping CPU is busy and in
> > > irq-off regions which would increase the latency. Also in case of
> > > 	cyclictest -d0
> > > 
> > > the one CPU would have to process all timers. So the latency will be
> > > worse compared to every CPU does its own wakeup. And on RT you probably
> > > do not want to do deep idle anyway.
> > 
> > Mmm, right. But, still very much dependent on the workload, I understand
> > you are saying? So, no one size fits all solution.
> 
> Now that I slept over it, I think it makes sense from RT point of view
> to always pin the timer. I'm not sure if we want to swap the sysctl or
> make the PINNED change like you suggested.

My thinking was that it would be nice to be able to discern between
timers coming from RT and !RT tasks so that the latter can be migrated
to housekeeping CPUs, leaving potentially isolated CPUs to deal with the
former only.

Not sure we can achieve this "best of both worlds" policy any way we set
the sysctl default to be.

Thanks,

- Juri
