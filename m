Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F513C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3930F20868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQ/5Sucz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3930F20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbeJLSYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:24:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46740 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeJLSYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:24:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id n11-v6so12845374wru.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 03:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=stEK0hPyCvUxQfCtmaOuzIg/Ce472ccHN2oxU3ZUPqE=;
        b=PQ/5Sucz3MUBlPcPsQs7RsQ5T+EqQ9WqCY7fZ7oBnOKCc4h+QpEX3MWeTmAZXU35Ur
         s0M4uNWW1HmizvYw1MDg+MoYifUApzMGFC+5v5HrePriITW2LO2qw4T2+9eREOGIbTFH
         fhcWyIef1CPHv4jOizJ+ByL9MvgzNHpsZwsDPtRubC8Z7SbsR9Bup0K5q9pKyJag3uQ5
         BDgbi/sSvuNE8v2hnPUghCGdSOPeKx+fETQzF2RYNlktFQ2XkYOgXKTFqnovr98+PWYy
         TC3bWTKYw/8uk217SYCOiPgaK9A2j2sgf0deXgA5SxHcJOFkpMzz6alzIQTqikzC6nsW
         qxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=stEK0hPyCvUxQfCtmaOuzIg/Ce472ccHN2oxU3ZUPqE=;
        b=CiFeaSCTb9eyw78ESZpI4s6Urtj1sOScMJTwtrYBmpD2IOc0xrWz2LpNFMjLfYre21
         OuAnThc3+4/XbR3LxaM7glpJAUVxZ9nP/uOL1Aj+KS807OkswFFWJYzb8tO+6KILjsPt
         iQerG5pJ0H14u2OPvbi4wSK8PC8nn5r6Q6HMJOrISG1Q7cF2wroOJJi92rt7M5CFXy7i
         tesSkgEnAJlXA94IgQ12Frlm6jEPO8qlFAGCsVURaTqyzAwJP9HJoRgthTq0bpNdh+tb
         l0SlbP7mH9dovzlaAY76nWWXuf7SEmDa1ZZM+uvpvbaEtC7o+SjZR3x4zUgeZbW0BqVB
         oUQg==
X-Gm-Message-State: ABuFfogVX9aGAwbgm4GPYShfe2VTEBrYoyoss1H/U82D+7mWgXIKdLSm
        518Q8ZKQyzO354vASG9ebH4=
X-Google-Smtp-Source: ACcGV61bloZoS074EZS6PoTv3kH5qv3LFwLLig/FZ4XPmzsO4uAiKfHAuDjkhaXoq2fRkpP+9BbnIA==
X-Received: by 2002:adf:c00e:: with SMTP id z14-v6mr4830962wre.268.1539341577483;
        Fri, 12 Oct 2018 03:52:57 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id t24-v6sm565380wra.5.2018.10.12.03.52.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 03:52:56 -0700 (PDT)
Date:   Fri, 12 Oct 2018 12:52:54 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Thomas Gleixner <tglx@linutronix.de>, sfr@canb.auug.org.au,
        kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org
Subject: Re: -next20181010,1011 regression: thinkpad x60 (32 bit) dies during
 boot.
Message-ID: <20181012105254.GA114888@gmail.com>
References: <20181010195920.GA13860@amd>
 <20181010200331.GA13975@amd>
 <20181011180328.GA6740@amd>
 <alpine.DEB.2.21.1810112208200.1457@nanos.tec.linutronix.de>
 <20181012102459.GA4469@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012102459.GA4469@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> > > > > I updated to todays next... and boot crashes with
> > > > > 
> > > > > ..
> > > > > Call Trace:
> > > > > kick_ilb
> > > > > trigger_load_balance
> > > > > ? active_load..
> > > > > scheduler_tick
> > > > > update_process_times
> > > > > tick_nohz_handler
> > > > > 
> > > > > -next20181005 worked ok.
> > > 
> > > Problem is still there in today's next.
> > 
> > So what came in between -next20181005 and the first bad one? kernel/sched/*
> > being the first place to look at.
> 
> kernel/sched does not seem to contain anything too scary.
> 
> I know that -next20181005 works ok, and I know -next20181010 is
> bad. Is there easy way to bisect using that information? I can do
> bisect between -next and mainline, but that's a lot of patches and
> thus not much fun :-(.
> 
> In the meantime, I reproduced the failure with T40p. Is there someone
> with working x86-32 in -next?

Does latest -tip fail too? If yes then I suspect bisection would be needed.

Thanks,

	Ingo
