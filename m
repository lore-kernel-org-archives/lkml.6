Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F017FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA8820823
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Tctc8enw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfBUPLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:11:02 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37616 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfBUPLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:11:01 -0500
Received: by mail-qt1-f196.google.com with SMTP id a48so31847552qtb.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 07:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OfiyWt0nyZYpi1WZA8fh11x04uRedVVor5lXLAWzvDU=;
        b=Tctc8enw4VBqqUguz44H8pGhWtxEhSCBRy5We/JpX53ACCek7VX4X87rZMixWQkixL
         D91S1dvDeYq1MZ/3FTCnUPMXJ/j5P32Bml5j0bTFXjKgWcIBAQGQtO7pj1fGe56gOWSm
         xxecRexVJ6AMCu86e5yHfifSYeNdi2dVAzY1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OfiyWt0nyZYpi1WZA8fh11x04uRedVVor5lXLAWzvDU=;
        b=EyulPAhs74BTi81c5nBCbX/lDheXJ4xxXjYIJ3D8gMOKfGX+Ownh2q/xELFgDemCcm
         dhy0CYYvJn14XWtvH4F7qX522PPRkFW7Ln2q/4Xq5UV62PadQsMDnpYbGArdSm+dQEO9
         rcVZ/haQ/BYhPv19JtNpuDeUDCNRA9uFCwUg+jZNp1a+nQ995UXeqIj6DoO0Yrxjy7Dt
         YEylppFCfxSe0ecFy+KD/2QrX4bwWIRaFgGzpV9KPQQkEu+LpjbvWa3bE1poLOKvTwwJ
         hUXwV3E5GjwI4tEaQDh224VOp84hhqxYcS8AP17OR1FWiksttxfusuGScY6roUiss570
         STDA==
X-Gm-Message-State: AHQUAub8u8JjcrDfg0rg9x4Kw/MBClrzttYAWspahrN560FEI4uTQ0Ph
        pwr0eBHt3rbtep2yWDCuDZbcUg==
X-Google-Smtp-Source: AHgI3IZ75rH+4g9uggv+XkAvNL2+ZyCxpx+BttoJpwCekhf9VOxkt53FPt9Hyd9gMkLxha5HPuB/Mw==
X-Received: by 2002:ac8:2b28:: with SMTP id 37mr10931322qtu.223.1550761860153;
        Thu, 21 Feb 2019 07:11:00 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id s128sm11596624qkh.59.2019.02.21.07.10.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 07:10:58 -0800 (PST)
Date:   Thu, 21 Feb 2019 10:10:57 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        Ingo Molnar <mingo@redhat.com>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        netdev@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>,
        rcu@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        xdp-newbies@vger.kernel.org, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH RFC 4/5] sched/topology: Annonate RCU pointers properly
Message-ID: <20190221151057.GA19213@google.com>
References: <20190221054942.132388-1-joel@joelfernandes.org>
 <20190221054942.132388-5-joel@joelfernandes.org>
 <20190221091944.GY32477@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221091944.GY32477@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thanks for taking a look.

On Thu, Feb 21, 2019 at 10:19:44AM +0100, Peter Zijlstra wrote:
> On Thu, Feb 21, 2019 at 12:49:41AM -0500, Joel Fernandes (Google) wrote:
> 
> > Also replace rcu_assign_pointer call on rq->sd with WRITE_ONCE. This
> > should be sufficient for the rq->sd initialization.
> 
> > @@ -668,7 +668,7 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
> >  
> >  	rq_attach_root(rq, rd);
> >  	tmp = rq->sd;
> > -	rcu_assign_pointer(rq->sd, sd);
> > +	WRITE_ONCE(rq->sd, sd);
> >  	dirty_sched_domain_sysctl(cpu);
> >  	destroy_sched_domains(tmp);
> 
> Where did the RELEASE barrier go?
> 
> That was a publish operation, now it is not.

Funny thing is, initially I had written this patch with smp_store_release()
instead of WRITE_ONCE, but checkpatch complaints with that since it needs a
comment on top of it, and I wasn't sure if RELEASE barrier was the intent of
using rcu_assign_pointer (all the more reason to replace it with something
more explicit).

I will replace it with the following and resubmit it then:

/* Release barrier */
smp_store_release(&rq->sd, sd);

Or do we want to just drop the "Release barrier" comment and live with the
checkpatch warning?

(my same response applies to patch 5/5).

thanks,

 - Joel

