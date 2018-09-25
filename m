Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF70EC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27FF2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27FF2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbeIYTP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 15:15:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34151 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbeIYTP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 15:15:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id t15so15391811wrx.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 06:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d8g83b6i35ADrsNO4s+zte5J1jBMbiWbcYoOLQl0Yzs=;
        b=CxnBJozK9NoIDfq3SFskRrWSZjnL2U0WW5Z1FxgUXfjXRhfZUKNiQNMQbTFnUgLWl9
         6HneXFN+m7+DjHbHBk8vNHDZUpaGqK/aAWmxzbfl52S11dzy5w6A2uTdP9sxXlGWP1Ng
         LhlobA6EuZVP0bVJuYDwvHe9fb4il7tSzuGxJ9rw8uq5sWg02Zk7BZ1CtgmehzJfwb1j
         cRBHOAhtHsh39fbaIRI9JthuvDHRT0mU+Ssv9PDyxGsBvMFfcpRQyhz3UA7Wz1OvAbn1
         /LRfZcMkkar5k4A7qJTiQYtw97XP+mfsWOsd09nLi5IMZ4Yil/hj1/Jx3kHumm03FMyu
         l/kA==
X-Gm-Message-State: ABuFfoiqn2+UF8nBzdjeSNwbiaBPSzTlyJIEXUX4rtY2ME37Pp9UP+63
        R6cWs+I1ji6e8/qYiJjf0mcW2g==
X-Google-Smtp-Source: ACcGV61q9emSM5JuosAlBVRRizVFwRgYBOxTy+xFmy4cQ+nTHSpvYqKk2UP9UKaDkRI3uDiLcRFPyg==
X-Received: by 2002:a5d:4292:: with SMTP id k18-v6mr942125wrq.225.1537880909497;
        Tue, 25 Sep 2018 06:08:29 -0700 (PDT)
Received: from localhost.localdomain ([151.82.116.90])
        by smtp.gmail.com with ESMTPSA id j35-v6sm3536318wre.52.2018.09.25.06.08.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 06:08:28 -0700 (PDT)
Date:   Tue, 25 Sep 2018 15:08:24 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v5 5/5] cpuset: Rebuild root domain deadline accounting
 information
Message-ID: <20180925130824.GB25664@localhost.localdomain>
References: <20180903142801.20046-1-juri.lelli@redhat.com>
 <20180903142801.20046-6-juri.lelli@redhat.com>
 <20180925125359.GB29985@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925125359.GB29985@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/18 14:53, Peter Zijlstra wrote:
> On Mon, Sep 03, 2018 at 04:28:01PM +0200, Juri Lelli wrote:
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index fb7ae691cb82..08128bdf3944 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -1883,8 +1883,19 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
> >  	for (i = 0; i < ndoms_cur; i++) {
> >  		for (j = 0; j < n && !new_topology; j++) {
> >  			if (cpumask_equal(doms_cur[i], doms_new[j])
> > -			    && dattrs_equal(dattr_cur, i, dattr_new, j))
> > +			    && dattrs_equal(dattr_cur, i, dattr_new, j)) {
> 
> While there, please also fix that wrongly placed operator.

Sure.

Thanks,

- Juri
