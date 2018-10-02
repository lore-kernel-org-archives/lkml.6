Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E5FC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06909204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cZR4N2MG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06909204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbeJBTTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:19:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32768 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbeJBTTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7CTzwyJs2ZazMibJHdLvZF4CG47W7dTYTxWMlahPVm4=; b=cZR4N2MGN882UrLRNws8YBrAZ
        IoJXxPl5NCCJ/C4TKCpkpqfPXGlolAOZHw20+rwt5ke7msE1XuUnxYQCpOVgum+2Ae7vH3NxvjOMJ
        jSEaZkRw0yLI5W4c6mdF26HwIl/Egrny0272DGSlz0QKLxP1ztQ/aK85a4oLF0QNxu+KZEasjsCsh
        eCFrkWJK44aldM5QVfAKrUh9GXw+3ksXavr7AISfq0QyveklqIkkpCwj/XiTV94wIakdQMDAuBKPL
        TjSYCyFAUGrmj9PDFD6dQ1FqH+opv2j5XuIQg6jhW5iOMPf0oGhst0PMvLqwUBHps7dNggP3D4LXi
        8HpNIQL+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7JuU-0008If-VL; Tue, 02 Oct 2018 12:36:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D0202025A349; Tue,  2 Oct 2018 14:36:17 +0200 (CEST)
Date:   Tue, 2 Oct 2018 14:36:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@codeaurora.org,
        skannan@codeaurora.org, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
Subject: Re: [PATCH v7 06/14] sched/topology: Reference the Energy Model of
 CPUs when available
Message-ID: <20181002123617.GB3439@hirez.programming.kicks-ass.net>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-7-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912091309.7551-7-quentin.perret@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 10:13:01AM +0100, Quentin Perret wrote:
> +struct perf_domain {
> +	struct em_perf_domain *obj;
> +	struct perf_domain *next;
> +	struct rcu_head rcu;
> +};

Maybe s/obj/em_pd/ or something like that? @obj is so very opaque.
