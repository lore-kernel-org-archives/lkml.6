Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706AEC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5202083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wA9x4/XW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E5202083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937691AbeFSLeW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:34:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40256 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937499AbeFSLeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=h3Gykf+qtTM8qu0Xtr153I8SF9mw2/V5WbY2DPw0Q8o=; b=wA9x4/XWrVa//KkdKSdKUw8lo
        AtW3qEafADn9IEWRRVCdY5FZ2aMNL/ZmWwyQk6/U/bVruEaS9+MzmvVifFAMFc+0lHyAGjcU/+G19
        rCmmpbs5aM26A3isFDUtAYs1kKBnnBSTXMmQB4T6DnzMB/v7ZGY3LwOPq0NwTrzKbZP3+sDA16FGa
        5r5UVlTxORrjbdTk9Mghi0xS+Cvzb8iWEl8lZlHQrZmoTXppOSmBacDWS4KU7ccUDf+DeK5CdOcME
        C97qiF7p1yGxIlGvq92DHCRDkNpL/q1VxKrLfoNqxQShvpN7By8H/8+8Iutf5l1kOrGBiuiC+q5fU
        S/uH3vQiA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVEtl-0008Lx-U0; Tue, 19 Jun 2018 11:34:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9805B2011CEBE; Tue, 19 Jun 2018 13:34:08 +0200 (CEST)
Date:   Tue, 19 Jun 2018 13:34:08 +0200
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
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
Message-ID: <20180619113408.GQ2458@hirez.programming.kicks-ass.net>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521142505.6522-4-quentin.perret@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 03:24:58PM +0100, Quentin Perret wrote:
> +struct em_freq_domain *em_cpu_get(int cpu)
> +{
> +	struct em_freq_domain *fd;
> +	unsigned long flags;
> +
> +	read_lock_irqsave(&em_data_lock, flags);
> +	fd = per_cpu(em_data, cpu);
> +	read_unlock_irqrestore(&em_data_lock, flags);

Why can't this use RCU? This is the exact thing read_locks are terrible
at and RCU excells at.

> +
> +	return fd;
> +}
> +EXPORT_SYMBOL_GPL(em_cpu_get);
