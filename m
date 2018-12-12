Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620A0C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D97208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YHlZvmtt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D97208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeLLJqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:46:21 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56498 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbeLLJqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:46:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=s/qc4uW6NBXupLnXJsYLmAJxT6wemoTcD/fG8c6HBDk=; b=YHlZvmttLn0SZ+bTZfk18C8Us
        nF/7C2fZhSrm+8PAjR1HnnY+qwCFohUlwSSiEhQY163EtRfRABTac2c+oIf710ObiC8SmDD1yyDIW
        DBaWmfZp0/G285HU560qki4wSbIYKBY6jwd7JiJJ9Z+Gdzq/CSFodKdRBTweGZe/NTEiLhtnbC08s
        Fz5jVYvldVCvw/vQCrQ4uzvS0s/K6wX0goFF3WfqBFkjYnVKMY2Tsd+f+Pu7TRBiZN13yLUcjZ1mg
        3kzpmxhZK4xiKTtsr7Cb7MNETvFJdx0DJd2xAHiUJ/OvfU8TiL04Iw7kB7WtcreZUc+Xg2roJXlFZ
        ygJSTABGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gX15n-0006mR-Lm; Wed, 12 Dec 2018 09:46:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 360082075BF39; Wed, 12 Dec 2018 10:46:10 +0100 (CET)
Date:   Wed, 12 Dec 2018 10:46:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2] cpuidle: Add 'above' and 'below' idle state metrics
Message-ID: <20181212094610.GW5289@hirez.programming.kicks-ass.net>
References: <3514439.dzOWKx1Cjx@aspire.rjw.lan>
 <20181210122104.GL5289@hirez.programming.kicks-ass.net>
 <CAJZ5v0j-a6cHayRtcsUPbUTBT0iBSUvmcUy6pfSSvUVcTMBxbw@mail.gmail.com>
 <20181210225134.GB24811@worktop.programming.kicks-ass.net>
 <CAJZ5v0jvbDCCgy=nUfb-yZCYGOxe4-XexbvnmeBm8ZPDPBaK4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jvbDCCgy=nUfb-yZCYGOxe4-XexbvnmeBm8ZPDPBaK4w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 10:51:48AM +0100, Rafael J. Wysocki wrote:
> On Mon, Dec 10, 2018 at 11:51 PM Peter Zijlstra <peterz@infradead.org> wrote:

> > Dunno; it could be cold cachelines, at which point it can be fairly
> > expensive. Also, being stuck with API is fairly horrible if you want to
> > 'fix' it.
> 
> All of the cache lines involved should've been touched earlier in this
> code path by the governor.  At least menu and the new one both touch
> them.
> 
> The API part I'm not too worried about.  I know it is useful and two
> other people have told that to me already. :-)

Like said on IRC; I mostly wanted to raise the issue of overhead due to
stats and ABI -- it's something I've been bitten by too many times :/

If you're confident you're hitting the same lines with the already
extant accouning (time and usage) and you cannot make the whole lot
conditional because of ABI (bah) then I'll not stand in the way here.

I agree the numbers are useful, I'm just weary of overhead.
