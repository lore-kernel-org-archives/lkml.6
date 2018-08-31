Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46F9C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B96D20841
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KM/g7Nv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B96D20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbeIADOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:14:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46740 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbeIADOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:14:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id u24-v6so6130620pfn.13;
        Fri, 31 Aug 2018 16:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mTxI2cMyb0DZL6tFA4aDgckTs2eXVqvVeVNbuADggPg=;
        b=KM/g7Nv4zU7+yNBwYcg1a6cVxScr+kBecO+gj/pM59O1sCrBdIxya90ApCd1WlkSBx
         zo5FIR2FpvTWbbIKr262uUovA5Lal4EYIkR7y7zkhC0qhnSH2kJi7HEnbGBmXtqF+Srb
         CR165COamE0I8d/usGGeCED1bcp7ex7MEfT2b7cUTKaHuwQe9SyMvQeYdySM1ZDB3W9K
         Jqg+o/bcyZkSjuvGwJG3ufZwDsUes+sGVAIwgfyzDLoAgBKxJCZ/sUHtcx4gx9F445CN
         Oo7sVd2RwEnK3dETjNhIbymQLhkmnIMO/i4eqjrRzcOxaetEGehx99cQAuD+culjt+lV
         rk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mTxI2cMyb0DZL6tFA4aDgckTs2eXVqvVeVNbuADggPg=;
        b=alUzSI6c/6WvEP+nVqMOvG7Wm5En+9GHzmB2NxLQodTjvEmiCf1F9xFY8R7XaLKOSM
         v6pGGagI7WeauGNjKOrMfN442slVlxeKaILB/Q9wSOyXjCSDAvVv8W3bPLKdzD+PhrLl
         HYPo1LsXJbM4i6XI8Y2CwTBPGxTDCggL+sa2LyxYEMWI125oygyzB4mG3OgkElXzE3Iz
         jDb1JTZLLoCIw4tfp5saPvSI7rudU7Ck+uu+8nVCQDGFmWG+9LQuC5/KzUtNT5GHwztu
         9yHyDbvIJB2erEo6CfvvnPYOAHX1sW0D3J++Zd+vUK6G/4BN61XDG/4gGo7YORRnR+Au
         e8fA==
X-Gm-Message-State: APzg51BCSSmbZzVE+iLhwoNPQtDzxffkD3Vp3Sbc5/TNjyH6ctqYFBVl
        FajNWHZ285TkVxwx2YA3+8k=
X-Google-Smtp-Source: ANB0VdZmJXhIXhnWYfJDKTuWv2ieJb0NfqKPhI+b/2ojAYUGbEUsYrrK6p4y6tBt3gmKX0asao2WHg==
X-Received: by 2002:a63:cf52:: with SMTP id b18-v6mr3343734pgj.194.1535756669148;
        Fri, 31 Aug 2018 16:04:29 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::1:a245])
        by smtp.gmail.com with ESMTPSA id t1-v6sm13820412pgp.32.2018.08.31.16.04.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 16:04:23 -0700 (PDT)
Date:   Fri, 31 Aug 2018 16:04:20 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Dennis Zhou <dennisszhou@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/15] blkcg: fix ref count issue with bio_blkcg using
 task_css
Message-ID: <20180831230420.GB1488037@devbig004.ftw2.facebook.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-5-dennisszhou@gmail.com>
 <20180831153538.brzgcm3rgmwfy3rg@destiny>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831153538.brzgcm3rgmwfy3rg@destiny>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Aug 31, 2018 at 11:35:39AM -0400, Josef Bacik wrote:
> > +static inline struct cgroup_subsys_state *blkcg_get_css(void)
> > +{
> > +	struct cgroup_subsys_state *css;
> > +
> > +	rcu_read_lock();
> > +
> > +	css = kthread_blkcg();
> > +	if (css) {
> > +		css_get(css);
> > +	} else {
> > +		while (true) {
> > +			css = task_css(current, io_cgrp_id);
> > +			if (likely(css_tryget(css)))
> > +				break;
> > +			cpu_relax();
> 
> Does this work?  I'm ignorant of what cpu_relax() does, but it seems if we're
> rcu_read_lock()'ed here we aren't going to queisce so if we fail to get the css
> here we just simply aren't going to get it unless we go to sleep right?  An
> honest question, because this is all magic to me, I'd like to understand how
> this isn't going to infinite loop on us if css_tryget(css) fails.

The only time css_tryget() on task_css(current, xxx) can fail is if it
races against the current thread migrating away from that cgroup and
that cgroup is now getting destroyed.  IOW,

1. For css_tryget() to fail, the cgroup must be dying.
2. The cgroup must be empty for it to be dying.
3. current must have already been migrated away to a different cgroup.

So, the above happens only when racing against css_set_move_task() -
it's seeing the old css pointer.  As the membership pointer switching
must already have happened, all it's waiting for is the new css
membership pointer to be propagated on the polling cpu, making
cpu_relax() busy loop the right thing to do.

This pattern is also used in task_get_css() and cgroup_sk_alloc().
Given that it's a bit tricky, it probably would be worthwhile to
factor out and document it.

Once Josef's other concerns are addressed, please feel free to add

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
