Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E6EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD842083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="bEmsM7k3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbfBURRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:17:22 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36381 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfBURRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 12:17:21 -0500
Received: by mail-qt1-f196.google.com with SMTP id p25so32098336qtb.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 09:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LMtwVzQceYw4mMb6VeeosfIorSojv+5HEgIRi7ypF9o=;
        b=bEmsM7k3fGmaWWW1lDUyV/5DBJsi+NVcNQHShL3XnQe6XMYr79VQXoo33Tg7BZ2o1v
         stvXyyucz3TzOwAO5ySRzvAAT/m69jT4wee5ughAKrTeuYqOJdtZNSSFZ4E3Ayso3Loq
         MPC/rg7pR+Yt5+WK2bHZSqUYSCEL3HThKnHmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LMtwVzQceYw4mMb6VeeosfIorSojv+5HEgIRi7ypF9o=;
        b=qUG3JQUs3qy73XpyX+lHuxGC0d51IUo9MB3LM6yoV8nXwG7BTS5/ArttO/GdgKNut+
         IRDC8VVVb/KjX6OeVlR3m3f+2d5skho9RiMR3pRF9kSAa3Zo3Y7Djx93v0M2fK2wqRiv
         K0gl+o6yhZxCublfSNQOsfeG+MCbKIvC2djDu5MtKiFuTC2/ryVyG4Uf26aX7oy3tmIS
         /mqgNSIyFhe5x2FSOXFZxfyRr4+SsCmJB0JlLZYiLCYTyu3aVnCDVQ3g48JwK7fiV2DE
         6PDrUYgVZL+tH/RPJKR+dpw5ki2MYAkQ8aSjJ3qwQQMdrDPK3VE1zvGru6xJeGNen/PJ
         5hpA==
X-Gm-Message-State: AHQUAuar491U/sCQry5pWYUHP0sL81DnF7Wio+DUVn2doEMCnJEH6k7w
        bpCnHVKHipOy/jDtcwYuWRMfPw==
X-Google-Smtp-Source: AHgI3IZ8jNueEem6h0q4j7jKBYzrQds1HarANr3wp+tBgbqkligx+A49DQTYAqOXroQCoRnmfRz6vw==
X-Received: by 2002:ac8:3932:: with SMTP id s47mr10533144qtb.337.1550769440687;
        Thu, 21 Feb 2019 09:17:20 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id p18sm14879179qkl.48.2019.02.21.09.17.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 09:17:19 -0800 (PST)
Date:   Thu, 21 Feb 2019 12:17:19 -0500
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
Message-ID: <20190221171719.GB118415@google.com>
References: <20190221054942.132388-1-joel@joelfernandes.org>
 <20190221054942.132388-5-joel@joelfernandes.org>
 <20190221091944.GY32477@hirez.programming.kicks-ass.net>
 <20190221151057.GA19213@google.com>
 <20190221152944.GS32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221152944.GS32494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 04:29:44PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 21, 2019 at 10:10:57AM -0500, Joel Fernandes wrote:
> > Hi Peter,
> > 
> > Thanks for taking a look.
> > 
> > On Thu, Feb 21, 2019 at 10:19:44AM +0100, Peter Zijlstra wrote:
> > > On Thu, Feb 21, 2019 at 12:49:41AM -0500, Joel Fernandes (Google) wrote:
> > > 
> > > > Also replace rcu_assign_pointer call on rq->sd with WRITE_ONCE. This
> > > > should be sufficient for the rq->sd initialization.
> > > 
> > > > @@ -668,7 +668,7 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
> > > >  
> > > >  	rq_attach_root(rq, rd);
> > > >  	tmp = rq->sd;
> > > > -	rcu_assign_pointer(rq->sd, sd);
> > > > +	WRITE_ONCE(rq->sd, sd);
> > > >  	dirty_sched_domain_sysctl(cpu);
> > > >  	destroy_sched_domains(tmp);
> > > 
> > > Where did the RELEASE barrier go?
> > > 
> > > That was a publish operation, now it is not.
> > 
> > Funny thing is, initially I had written this patch with smp_store_release()
> > instead of WRITE_ONCE, but checkpatch complaints with that since it needs a
> > comment on top of it, and I wasn't sure if RELEASE barrier was the intent of
> > using rcu_assign_pointer (all the more reason to replace it with something
> > more explicit).
> > 
> > I will replace it with the following and resubmit it then:
> > 
> > /* Release barrier */
> > smp_store_release(&rq->sd, sd);
> > 
> > Or do we want to just drop the "Release barrier" comment and live with the
> > checkpatch warning?
> 
> How about we keep using rcu_assign_pointer(), the whole sched domain
> tree is under rcu; peruse that destroy_sched_domains() function for
> instance.
> 
> Also check how for_each_domain() uses rcu_dereference().

May be then, all those pointers should be made __rcu as well. Then we can use
rcu_assign_pointer() here. I will look more into it and study these functions
as you are suggesting.

thanks,

- Joel

