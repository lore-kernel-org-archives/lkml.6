Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6426ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 810AD20C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ccdf6mPO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810AD20C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbeGQIqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:46:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42012 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbeGQIqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=J+gstwVCFqlFfgmxoxh72LkjINTd93YeXG+7psn/6k0=; b=Ccdf6mPOrV211mcPKW8Jld0CC
        AYIqIq7I1TaQUWgW3trJjkrz+xo6EX5w3oTIs3OwAvhDSXf5jaEknIP7kER2Qvy/AaEoDTwAezJRL
        DdkfKaugZmv8V2O6aL6npbGvJIvN9NYjAdEYtojD5uz1EaFgBMak9mYwFgHiiyJ0yw4adCO5MH2gv
        imEtdq9czUwZsb++gDPgXLHxugBXwiHTleINvTwQTDNcEZ1lzk5+Ud0cWrMwm84v2JruLbShT4OuY
        +lsh9zIZshM3pyLz/IX9CS0AHJ33uo6x7fq5M4Updlz3oNeF+GZ7Fonn02Tz0n1DSoOEhSgJL4i1O
        Iu+sUAfTg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffL8Y-0002tl-CV; Tue, 17 Jul 2018 08:15:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E9F8A20275F36; Tue, 17 Jul 2018 10:15:07 +0200 (CEST)
Date:   Tue, 17 Jul 2018 10:15:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andreas Herrmann <aherrmann@suse.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Commit 554c8aa8ecad causing severe performance degression with
 pcc-cpufreq
Message-ID: <20180717081507.GS2476@hirez.programming.kicks-ass.net>
References: <20180717065048.74mmgk4t5utjaa6a@suselix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717065048.74mmgk4t5utjaa6a@suselix>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 08:50:48AM +0200, Andreas Herrmann wrote:
> I've recently noticed that commit 554c8aa8ecad ("sched: idle: Select
> idle state before stopping the tick") causes severe performance drop
> for systems using pcc-cpufreq driver. Depending on the number of CPUs
> the system might be almost unusable. 

Have you looked at that driver? It features a global lock which is taken
for all cpufreq operations. Once you get past a handful of cpus that
will constrict your system exactly as you say.

What kind of machine are you running this on, and can you configure the
thing to use anything else? If so, do so and never look back.
