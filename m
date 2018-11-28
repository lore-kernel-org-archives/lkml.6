Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF165C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE2C2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZmEQD/4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE2C2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbeK1VDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:03:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39180 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbeK1VDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:03:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HhFbss0cBrLYDal0/TJDftFaGnEs8oSYCdo10pN8tAQ=; b=ZmEQD/4XtMR/yglGaw7GmfxE5
        p1LQ+g7G0vqkzP1X0VvSH7sKfRvrWITq4YjX6fr5eNtlzSUSBV1CjQjkQ+bZIhtPJB/YXRcoHRJpX
        5ZV6Cq5MW4/oiXvQTAiF6ovkk553L3UiDsf9u3YRgQOBJcJ15scLNZRGO82MdoCgjFuyseO10lKyD
        wrKW5j0/IvSZRpMTaCG1emo+NjqIPyzKh/4AhO6Fn54V9rP/iABzn15feq4ZLpGK2uATESuIRYL21
        WhEchL+wj2ytoWnd9narrIRby6ln0dZR16EmaHFhDQo0Kjiy9Id+C+ghVFpd0lPzY+htXx0QxU0aS
        C6O0tHp2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRwg8-0003fR-IP; Wed, 28 Nov 2018 10:02:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EADB42029FD58; Wed, 28 Nov 2018 11:02:41 +0100 (CET)
Date:   Wed, 28 Nov 2018 11:02:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        pkondeti@codeaurora.org, Quentin Perret <quentin.perret@arm.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v7 2/2] sched/fair: update scale invariance of PELT
Message-ID: <20181128100241.GA2131@hirez.programming.kicks-ass.net>
References: <1542711308-25256-1-git-send-email-vincent.guittot@linaro.org>
 <1542711308-25256-3-git-send-email-vincent.guittot@linaro.org>
 <CAKfTPtD=sV3zJiZMfCFi92_f6j-jTO9D5RsEBAXHVa6VN3Urwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtD=sV3zJiZMfCFi92_f6j-jTO9D5RsEBAXHVa6VN3Urwg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 10:54:13AM +0100, Vincent Guittot wrote:

> Is there anything else that I should do for these patches ?

IIRC, Morten mention they break util_est; Patrick was going to explain.

But yes, I like them.
