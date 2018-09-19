Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1847EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6B1206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZDh8ij2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB6B1206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732118AbeITCfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:35:06 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:44987 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbeITCfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:35:06 -0400
Received: by mail-yb1-f194.google.com with SMTP id s8-v6so2985502ybo.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 13:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6LHoA8FhhC+6c7CSMYTPVmToxn9L+kcipGtG8g2T1oI=;
        b=mZDh8ij25oh4hWSb6lqqxwVCZoKMc49yjmMAH6ZQN+wS7fGJn8+TZcGN99feE9FKwX
         44IP2HSI0cDL9bhG+PxmPT4daBzLFVWQbw+EU1Z/VoUWOoOoT57Ck4wNES1UkSYXzm4K
         nWz9EFg9PJs5rrmk58RGTklF3zTHJqEamu9/DVlNvd26vomzIOlwJx7U/WEE8oOhyyIt
         Fpe8+wjdZy+1tNr3ZQV5MU2lAhoAimRwi30U53oiZw9lLjHigqgMn4snX0HH+wX8x0FN
         7IRvVM/X40HSWjktTh1CkFhuH9eRV0llJgJgiq7IxD3cu1bhtr9Tr/n/OY8jBtfW/sdS
         Guag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6LHoA8FhhC+6c7CSMYTPVmToxn9L+kcipGtG8g2T1oI=;
        b=tmIbvdYjL85i8KNKSNYpY9SldtjRTvgnQGdX/WQ8/wGClWPWUM2GxLcVCAQugd5Si6
         Awr0QHbhtinhsugPBNIbhDEBy1tVO+fsb4voW4rVZ07THYnVwbT1+pfByYdUiwqW3Zra
         pq7E47nN5echuGydSS3m3IMnTDZZ32rBzwRTtN6IolxnSJNsg9zskZ33kkn9VpvmHLjM
         bSw78VQPnD9PcpjaQJB1OPSofsWhPBtim4Slmjg9O+alY6uOJNkBaLGmfmcjplOojpm9
         MfA9pQL3RdC2PZ2Y+ZGyWuyTSIO8i8vzwf5oQl2hES2tyVqwLl1B5BZx/syb2HhLRewX
         Uuxw==
X-Gm-Message-State: APzg51BwdQobKQc6eqzrgMHBM+0/Za73I9g3vpAGO0FULnBdwLCHoVGj
        4zg4VCuts+sZrMH/Oyawgdo=
X-Google-Smtp-Source: ANB0VdZ6YjW4wzz2Qy8y329iOGpBt63Tc+JF5hS9xamoA+SJB0wRHTu2ibK2PGLT+1U3Pvz831aXEA==
X-Received: by 2002:a25:6412:: with SMTP id y18-v6mr16582123ybb.436.1537390524483;
        Wed, 19 Sep 2018 13:55:24 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:cfe3])
        by smtp.gmail.com with ESMTPSA id b16-v6sm8390472ywa.33.2018.09.19.13.55.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 13:55:23 -0700 (PDT)
Date:   Wed, 19 Sep 2018 13:55:21 -0700
From:   Tejun Heo <tj@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        tglx@linutronix.de, Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] rcu: Use cpus_read_lock() while looking at
 cpu_online_mask
Message-ID: <20180919205521.GE902964@devbig004.ftw2.facebook.com>
References: <20180910135615.tr3cvipwbhq6xug4@linutronix.de>
 <20180911160532.GJ4225@linux.vnet.ibm.com>
 <20180911162142.cc3vgook2gctus4c@linutronix.de>
 <20180911170222.GO4225@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911170222.GO4225@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Sep 11, 2018 at 10:02:22AM -0700, Paul E. McKenney wrote:
> > Doesn't work for me because it is still within the preempt-disable
> > section :/.
> > Would it work to use WORK_CPU_UNBOUND? As far as I understand it, the
> > CPU number does not matter, you just want to spread it across multiple
> > CPUs in the NUMA case.
> 
> Locality is a good thing, but yes, something like this?
> 
> 	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && /* or whatever it is called */
> 	    unlikely(cpu > rnp->grphi - rnp->grplo))
> 
> Another approach that might be better longer term would be to have a
> workqueue interface that treats the specified CPU as a suggestion,
> and silently switches to WORK_CPU_UNBOUND if there is any problem
> whatsoever with the specified CPU.  Tejun, Lai, thoughts?

Unbound workqueue is NUMA-affine by default, so using it by default
might not harm anything.  Also, per-cpu work items get unbound from
the cpu if the cpu goes down while the work item is running or queued,
so it might just work already.

Thanks.

-- 
tejun
