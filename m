Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BD4C282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 01:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534292183E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 01:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="OLa7wtqD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfBFBWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 20:22:39 -0500
Received: from tomli.me ([153.92.126.73]:49470 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbfBFBWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 20:22:39 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 20be58de;
        Wed, 6 Feb 2019 01:22:36 +0000 (UTC)
X-HELO: x220
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli; iprev=pass
Received: from tor27.quintex.com (HELO x220) (199.249.230.80)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Wed, 06 Feb 2019 01:22:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=1490979754; bh=JjZsmmcr6qWH0XRoq5LSjyhKAP6lnbsK6fZ5OoZdsNM=; b=OLa7wtqDiUIkAQ1bj2hQGygLyV3yfM3iwzScG0rVa9DIbanMlyNiOEF8KQPWrKUX/z035RJGIbMRObROUax3gUKVoaYnt+3+3TfmoOf+oGKD1lXOd8J7dwvfZHobcQXHSBe/x9mVCg99PjVVb7z+Nokm1EfO3ib96r3SSLVjzkr8zfWLPiI/6Sm2U78NObXSlz2MCTf5LFwT+aijNw+l+B70B/pVcsRmtw0/LnCvKENy6u+Bkzk7oeHft3gqS4rJZZ25+EgKcUV8Mrl6ra/BR845qRm0vQrj2+gj/kC2xLkoAxhxof0umpjX0ItW1vdXIZnVw/BsTWk5DN5PxvIjyA==
Date:   Wed, 6 Feb 2019 09:22:14 +0800
From:   tomli@tomli.me
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>
Cc:     ak@linux.intel.com, bp@alien8.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, linux-mips@vger.kernel.org
Subject: Re: [REGRESSION 4.20-rc1] 45975c7d21a1 ("rcu: Define RCU-sched API
 in terms of RCU for Tree RCU PREEMPT builds")
Message-ID: <20190206012214.GA25642@x220>
References: <20181113135453.GW9144@intel.com>
 <20181113151037.GG4170@linux.ibm.com>
 <20181114202013.GA27603@linux.ibm.com>
 <20181126220122.GA6345@linux.ibm.com>
 <20190205050700.GA31571@localhost.localdomain>
 <20190205095809.GA16356@darkstar.musicnaut.iki.fi>
 <20190205130559.GA12858@localhost.localdomain>
 <20190205185914.GB16356@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205185914.GB16356@darkstar.musicnaut.iki.fi>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, thanks. This looks slightly different from the Loongson problem:
> 
> - In Loongson, we don't get stuck in RCU, but in
>   cpufreq_dbs_governor_stop -> irq_work_sync(). 
> 
> - I run non-preemptible kernel, and my system still gets stuck.
> 
> What is common is that it's UP with i8259 PIC.
> 
> A.

Now it's an interesting case. Because on my machine, the problem I
encountered seems to be the identical one of the original thread,
disabling preempting can effectively solve the lockup. Also, my
issue is not only occuring on 4.20-rc1, but also on earlier kernels,
with a lower probability.

But on your machine, you have another non-identical, but closely-
related issue. It seems the timing-dependent lockup of i8259 PIC can
be triggered in different ways.

The conclusion is clear though, there's a real lockup condition in
i8259 PIC driver, and it's causing real issues.  Aaro, have you tried
submitting your i8259 patch to the mainline? Despite your concerns
about its underlying cause, I think a fix should be submitted. If there
are no objections from the maintainers, I suggest submitting it to the
mainline upstream, and send it to linux-stable, requesting it to be
applied on 3.16, 4.4, 4.9, 4.14, 4.19, 4.20 stable branches. If you
are busy, I can help submitting.

Tom Li
