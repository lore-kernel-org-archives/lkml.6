Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1FBC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F7A20881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="vkQ3934O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F7A20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732375AbeGJXKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 19:10:38 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45939 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732253AbeGJXKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 19:10:37 -0400
Received: by mail-pl0-f68.google.com with SMTP id a17-v6so2428302plm.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 16:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bCrVqF/4xU/NZolCM6FpF6mkmZ+l7CQSJ+ObQfuSAes=;
        b=vkQ3934OTtHCizpX8Ka9zlT0hsj3rXv7V5pQiGmZBPQGU34z9dqVdpm5sMqHYh5JMo
         FE5vbLInKXpS4zCgyDF9Xay4H/u+pyleVgiFQ935Kd4BjaWkNip//K7EYeM6TQAm/2xG
         9NNDtJykK/hbsOIy8XH1edtz4OMEaJszxYOiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bCrVqF/4xU/NZolCM6FpF6mkmZ+l7CQSJ+ObQfuSAes=;
        b=bCvs6VFZ0ihYZCHHgLnYTbPX1sDw4Yzbtem2lIBld+8iRbyU0FTyLjKYqcAZ1thA7w
         VTgqXU1MQnuu2BR47I3tewPC/H/8nlbELyl7L4QD9/74FdOCsXYzr+Tf+ZxxPq+pig81
         Bh/yyvonZiAOzxKD4QzLCJ9qXIf7rRPKSfZ9jA9ClLBEs7LfdZsC4bEk6t47qX/P/fiP
         AG6wAqdclvsT3uM2rvb/8fTssof/jebCEKQvAqqwEHWMZXJYTcj22cy/7GY53nq6Nigo
         AYGn0XT9SrC0Z7l/qcy/DFk2V8zOKdPLibIaLAl+Rk+i0fJ1LrgJFXe2lyD4vysHzilB
         bYrQ==
X-Gm-Message-State: APt69E3R0Z1EvlL+Bvq0+0Etzfyjwk4Bnc2CRhFHwN1w1A0/vZ1cxZ7K
        L2jFaKZ3dDb196jRbYgykjhB7A==
X-Google-Smtp-Source: AAOMgpeQiYfhGc+2Wed9mmm9CLwk5aOqL58kDCHv8cSceh4O94S2JWSFnTDHzioIVrJnBQSgY/Ykag==
X-Received: by 2002:a17:902:b586:: with SMTP id a6-v6mr26304962pls.174.1531264158169;
        Tue, 10 Jul 2018 16:09:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id p62-v6sm29406089pfb.58.2018.07.10.16.09.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 16:09:17 -0700 (PDT)
Date:   Tue, 10 Jul 2018 16:09:17 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        kernel-team@android.com, Joel Fernandes <joelaf@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Remove setting task's se->runnable_weight
 during PELT update
Message-ID: <20180710230917.GA187293@joelaf.mtv.corp.google.com>
References: <20180709164753.24699-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709164753.24699-1-dietmar.eggemann@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 05:47:53PM +0100, Dietmar Eggemann wrote:
> A CFS (SCHED_OTHER, SCHED_BATCH or SCHED_IDLE policy) task's
> se->runnable_weight must always be in sync with its se->load.weight.
> 
> se->runnable_weight is set to se->load.weight when the task is
> forked (init_entity_runnable_average()) or reniced (reweight_entity()).
> 
> There are two cases in set_load_weight() which since they currently only
> set se->load.weight could lead to a situation in which se->load.weight
> is different to se->runnable_weight for a CFS task:
> 
> (1) A task switches to SCHED_IDLE.
> 
> (2) A SCHED_FIFO, SCHED_RR or SCHED_DEADLINE task which has been reniced
>     (during which only its static priority gets set) switches to
>     SCHED_OTHER or SCHED_BATCH.
> 
> Set se->runnable_weight to se->load.weight in these two cases to prevent
> this. This eliminates the need to explicitly set it to se->load.weight
> during PELT updates in the CFS scheduler fastpath.

Looks good to me. By the way just asking, is there a chance where
se_weight(se) and se_runnable(se) can ever be different?  Seems not, then in
that case we pointlessly do this division in ___update_load_avg if the sa
belongs to the task:

	sa->load_avg = div_u64(load * sa->load_sum, divider);
	sa->runnable_load_avg =	div_u64(runnable * sa->runnable_load_sum, divider);

and we could probably just do this if se is a task?

	sa->load_avg = div_u64(load * sa->load_sum, divider);
	sa->runnable_load_avg =	sa->load_avg;

thanks,

-Joel

