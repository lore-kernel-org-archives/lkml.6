Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278F8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0258E2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfBTHsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 02:48:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54155 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfBTHsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 02:48:01 -0500
Received: by mail-wm1-f68.google.com with SMTP id e74so4915226wmg.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 23:48:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mMMDihoOxx8auqqxwzKnxdWtX+ynPEcI5yhKxVPfzYo=;
        b=MUIf2/Wxqe94cosFbVC4DHF7mj9s6YJYrRqfWL2hE58lLUNvboYNoTtdVliQ30jhiD
         3wBps20ZVw341cuNrIPhDIEkFwcD4dN5A5a4QfPoSfhr5NRh/3dsi0FYIF0dJDWiH6v8
         3Ro6QzBR7BlnVoX4oL2ftw7ox/5w/nnKFehxO5jSvmfd6Wpjge7gJk6NkABG0UChkxa9
         kt2gk7opeXQXNX7PAEraZL/K9yOypYraJtaIpcac5lxa6OBysA4Ls0fTOo8y/zc21Maz
         ARhUsa41bXg+ZLM65xf+xE9FNfRlNAwqCpWyAPpDChrphHTKwsXHrQYF9u396IA5My9G
         l3Sg==
X-Gm-Message-State: AHQUAubCb0N1KOH6nayDGQqJq+BBZCoarL7bodw9N1I1GwwO3PiWTBo8
        RafOgjfd5JFtm0PMbtfKf9vuDg==
X-Google-Smtp-Source: AHgI3IZjZXb91A+ELotyzyyE9XSLRWoy0E+Av7CAPVM29BAQmPs+eSO7MA1lPKE4ukl6rd9oMEhdhw==
X-Received: by 2002:a1c:1c4:: with SMTP id 187mr5927055wmb.6.1550648879392;
        Tue, 19 Feb 2019 23:47:59 -0800 (PST)
Received: from localhost.localdomain ([151.15.254.225])
        by smtp.gmail.com with ESMTPSA id b3sm9962891wme.27.2019.02.19.23.47.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 23:47:58 -0800 (PST)
Date:   Wed, 20 Feb 2019 08:47:51 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     tglx@linutronix.de, linux-rt-users@vger.kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        bristot@redhat.com, williams@redhat.com
Subject: Re: [RFC PATCH RT 0/2] Add PINNED_HARD mode to hrtimers
Message-ID: <20190220074751.GJ21785@localhost.localdomain>
References: <20190214133716.10187-1-juri.lelli@redhat.com>
 <20190219171905.qrpr5uurayfqbehp@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219171905.qrpr5uurayfqbehp@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/19 18:19, Sebastian Andrzej Siewior wrote:
> On 2019-02-14 14:37:14 [+0100], Juri Lelli wrote:
> > Hi,
> Hi,
> 
> > Now, I'm sending this and an RFC, as I'm wondering if the first behavior
> > is actually what we want, and it is not odd at all for reasons that are
> > not evident to me at the moment. In this case this posting might also
> > function as a question: why we need things to work as they are today?
> 
> There is /proc/sys/kernel/timer_migration which should disable this but
> I think you know that already.
> 
> So this is a NO_HZ feature. Basically try to move all the timers to a
> designated CPU so all others can deep idle while one CPU does the work.
> Ideally you have no timer which is pending / will expire if you go idle.
> And then, once the timer fires the housekeeping CPU does the work so
> chances are that the CPU, that programmed the timer, may remain idle.

Right.

> In this case you prepare the wakeup and then wake the CPU anyway. There
> should be no downside to this unless the housekeeping CPU is busy and in
> irq-off regions which would increase the latency. Also in case of
> 	cyclictest -d0
> 
> the one CPU would have to process all timers. So the latency will be
> worse compared to every CPU does its own wakeup. And on RT you probably
> do not want to do deep idle anyway.

Mmm, right. But, still very much dependent on the workload, I understand
you are saying? So, no one size fits all solution.

Thanks,

- Juri
