Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A627EC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B2F120836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qWZ0vyrA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B2F120836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965953AbeFSM04 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 08:26:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41534 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964997AbeFSM0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 08:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2t6iHGlO4Kxxws9kBydDEMiZ99HbO5lrqA94nOVFCac=; b=qWZ0vyrAA+p8jhGc2Ht0uj6nl
        T4e0UpSlLzaUCrzK7qWkeJQBQ8DwX9B2gN2pUkStLIrIAOoQT8U9jYlZtJjMNgZrBGKmUHemRJN1y
        jWi5ha7nTAhLN2pXWNNJp7iuMHI4m4R7dECIq8Cmn4Og/fBJVXjYev7vU2fcoe8hCu6mX/sR8ERaP
        xp4bgpPHeD0TD4+j2CFcBYnhO/50e43WuTY7IhAE10a4nPJ7Opc6ARb2iVHGL1fvSInEcmeQXrQS0
        1ggmEaJasKfM+NTftXDbM7l6F4/BKxrBsC8tuB4CpqEFH1PVQ1V7uUXUJo0XU6t0V4p6nr89R0XoE
        5VfRBS6TQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVFiU-0000Zw-HK; Tue, 19 Jun 2018 12:26:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7BDD92029FA0E; Tue, 19 Jun 2018 14:26:32 +0200 (CEST)
Date:   Tue, 19 Jun 2018 14:26:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v3 05/10] sched/topology: Reference the Energy Model
 of CPUs when available
Message-ID: <20180619122632.GS2458@hirez.programming.kicks-ass.net>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-6-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521142505.6522-6-quentin.perret@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 03:25:00PM +0100, Quentin Perret wrote:
> In order to use EAS, the task scheduler has to know about the Energy
> Model (EM) of the platform. This commit extends the scheduler topology
> code to take references on the frequency domains objects of the EM
> framework for all online CPUs. Hence, the availability of the EM for
> those CPUs is guaranteed to the scheduler at runtime without further
> checks in latency sensitive code paths (i.e. task wake-up).

I'm confused by this patch,... what does it do? Why is em_cpu_get()
(after you fix it) not sufficient?
