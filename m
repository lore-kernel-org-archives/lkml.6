Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716F0C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C2F20652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="tHltnuBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C2F20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbeJCEFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:05:41 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43736 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeJCEFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:05:41 -0400
Received: by mail-pl1-f194.google.com with SMTP id 30-v6so2350190plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 14:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j3b9ugThL80ggkphyupozrvPcysha1YTgIlDd2Tsjps=;
        b=tHltnuBmp1GnZ+ep7+gdaYqjymyppeudVwstgCu5AVgtAVRtdJx/LVJCcdMSzyn1bo
         9VRa18pbd5ZqOA3WoR4CVPMuslDGmVdjfiYItM/DcBjoZnrZVq7OCjYXHQnlWt6WJnPd
         QUInrGPDqRn0qvisR3Eo3SMUETbGUDEqZt2ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j3b9ugThL80ggkphyupozrvPcysha1YTgIlDd2Tsjps=;
        b=BD8++KYfXryatfviR8WNBi6UtpDDWZDLCj6SYrXVImKhXe88zJcw2/hRXJ0PxuT/EL
         FuzCSHQHfqlDX08IuR+PtiXMAfnv+HR+qj/MGvWCulJx2pT3cdqpOWLooSc4EFmQpiEY
         dAq1RD5xbbboS0NOe+975NvfCRvp+dL7fLpmySbRlaWf4YM7dDjyBeWa4V8mIximcJl0
         IZluqRsdCw4+Po4vPtPxSNZD3lqe0yMu9Uyj4PdSRJ0u4CrOPEpKpOyH10Gx7U0AF1vw
         MUrTLxbLYyHoV6IuWK92sO3JXZfYG1v/dddiQy6Fk38GxW0nwey6dF70KiTh6cev4Xs9
         tjkQ==
X-Gm-Message-State: ABuFfojUMHtNgfJALmhU80Q1+PoYVprYEN3iE6F98Vym+gB1Lmw+/D5q
        jd/Pf+E4G1okgX4jVXUn9OCNQg==
X-Google-Smtp-Source: ACcGV635RaIrllCGh2qB9dhhgSgzmJi4E8DX3bNsmwo6o5qwjo/CvVIc1f9/b19lmTFLMpMJ3erPTQ==
X-Received: by 2002:a17:902:6b09:: with SMTP id o9-v6mr18556236plk.316.1538515221585;
        Tue, 02 Oct 2018 14:20:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id m15-v6sm29034284pgt.28.2018.10.02.14.20.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 14:20:20 -0700 (PDT)
Date:   Tue, 2 Oct 2018 14:20:19 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC 1/2] sched/core: Convert synchronize_rcu_mult to
 synchronize_rcu
Message-ID: <20181002212019.GC89166@joelaf.mtv.corp.google.com>
References: <20181002012012.13133-1-joel@joelfernandes.org>
 <20181002033801.GP4222@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002033801.GP4222@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 08:38:01PM -0700, Paul E. McKenney wrote:
> On Mon, Oct 01, 2018 at 06:20:11PM -0700, Joel Fernandes wrote:
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > 
> > synchronize_rcu_mult is now obsolete since all the different RCU flavors
> > have been consolidated and the API is now common on the updater side.
> > sched/core.c is the only user of it. All call_rcu_<flavor> calls boil
> > down to the same call_rcu. So there's no point in calling
> > synchronize_rcu_mult infact it could potentially be slower due to
> > waiting for the call_rcu callback twice. Just call synchronize_rcu here
> > which should do the job.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Well, the theory was that I was going to keep this series hidden until
> the consolidation hit mainline just to avoid confusion, but please see
> 5fc9d4e000b1 ("rcu: Eliminate synchronize_rcu_mult()"), which I just
> now pushed to -rcu.  To your credit, you did get most of it.  ;-)

Glad you already took care of that ;-) I should have taken a peek at rcu/test
branch :D

> Here is the full list:
> 
> pick 1f3e6eaed8fa Apply coccinelle script to consolidate calls to RCU-bh and RCU-sched
> pick 5fc9d4e000b1 rcu: Eliminate synchronize_rcu_mult()
> pick a8475496801e rcu: Consolidate the RCU update functions invoked by sync.c
> pick d8ffb03461ad sched/membarrier: Replace synchronize_sched() with synchronize_rcu()
> 
> Of course, I will need to rerun the coccinelle script and split the
> result across subsystems, but I am waiting until the current pull
> request hits mainline.  Let's face it, none of us need to do debugging
> on someone consolidating their RCU updates before at least this commit
> and its predecessors hit mainline:
> 
> 709fdce7545c ("rcu: Express Tiny RCU updates in terms of RCU rather than RCU-sched")
> 
> I sent the pull request to Ingo a few days ago, so with some luck this
> will all get to mainline during the next merge window, and then it is
> open season on outside-of-RCU cleanups.  ;-)

Cool, thanks,

 - Joel

