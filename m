Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154F4C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D032089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dPcoKxNu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D032089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933737AbeGIPm7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:42:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54016 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933384AbeGIPmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K0uV2r+TWSuI7qB3rzFv+2Gyz/a2y7PR6GOmqh7nsB4=; b=dPcoKxNuseNGKraatO1FxeSY3
        Gk3RvfLaRa4Qm6pz3Vs3v5EsX2FkRsDLhCHr+da26mNXoogvlejYro2xuZYaknoNnhmt13iYY11qd
        uftCJzzmLO/Fu/wPtd5RKKGqqu16/JrvhvHU5mcCeeOmhocFtZtvPe2c1b9s/PHubBwAxR+G+T2ou
        YFsdJpKfYVA8Z+zWh/4TT5m1RY585tEAvgMgEvgE60YnR0WNzW+pvyKW6SPF7799CtuBSi4EBDPR2
        I7kicf+5Dja3ySry/kaCvVDo1ZtdA1xXyLrn5JC6iu/hGgAmrFhnJjY9M1YtXpGpJwGsDv91iSkfD
        yi4xC0M0g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcYJ1-00017R-T7; Mon, 09 Jul 2018 15:42:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 58F0620289331; Mon,  9 Jul 2018 17:42:26 +0200 (CEST)
Date:   Mon, 9 Jul 2018 17:42:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v4 09/12] sched/fair: Introduce an energy estimation
 helper function
Message-ID: <20180709154226.GZ2476@hirez.programming.kicks-ass.net>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-10-quentin.perret@arm.com>
 <20180706131243.GV2458@hirez.programming.kicks-ass.net>
 <20180706151212.GD17577@e108498-lin.cambridge.arm.com>
 <20180706154949.GO2494@hirez.programming.kicks-ass.net>
 <20180706170443.GE17577@e108498-lin.cambridge.arm.com>
 <20180709120138.GQ2494@hirez.programming.kicks-ass.net>
 <20180709152825.GA17598@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709152825.GA17598@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 04:28:26PM +0100, Quentin Perret wrote:
> What about moving schedutil_freq_util() to sched.h and give it a more
> generic name (total_cpu_util() ?) with no dependencies on
> CONFIG_CPU_FREQ_GOV_SCHEDUTIL ? Also, 'energy_util' would have to be
> renamed I guess (busy_time_util ?).

Bit big for an inline, and I don't think there's much point using all
this without schedutil. You already rely on it anyhow.
