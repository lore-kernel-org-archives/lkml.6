Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3789AC64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F070620684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLQpGnXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F070620684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbeJCOmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 10:42:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53753 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbeJCOmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 10:42:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id b19-v6so4693717wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 00:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YAypkEgm5GQsmJ+5zgrtsoROOcpTePzTilkMddpKUg8=;
        b=hLQpGnXoTiazdriq1EP7rQsFd9/YLq1is43R+gMTGZYGGgiT5PKsNvFfQjL58y48gq
         i3uTZFhlHMU2MTNyXrvUYQUzKsJ/EhQ69KI0wPvmL/0nwGmWtaUkUubKPREag+XcbYz3
         CtNDCvw21WfW3mMunrd4XkBdMTQTd1Sn+i44rXMmk0bnwEq2vCUck97iRiS+L7IeH/dV
         VGg+3/nOjXAhQ47sf++HM7ceO6cmaxbUnWLSEO3giO0xjjygdga0JC7cgdzlD+K8VR8C
         3cHDeBH2fTLoGuQjkLAMwFR369wzj2qFqUn304/5RjzHbZAAvLtCMCMwK+qzDwb8qimi
         v6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YAypkEgm5GQsmJ+5zgrtsoROOcpTePzTilkMddpKUg8=;
        b=ln9Xv2F7u5f2BLSNendc0UV298EjBIktfv6bwCs117X9biHEiDXmQKYO5vZLWurxJC
         AuwpwN2fmc7HpKcCTGts7b01oaU1FsWsILh7tGEY0wTabFhLrPyuYqld+9UwIaa2skw2
         gw7RCaYySOYkaIPFpqLpV329HOlcvK7th3xdBD15o8f9RMa4+6qQu9L22InrgH2XsBH2
         ged5fOxALPW1662fKk9aSYvoFcl2tfummJEdX1QAANmk0JWeMOuDFyb8vgS7/aAujt62
         e67d1QUtooCmAv8wEB0z1Tz5MxybUyIHMK00BPgq8XAlQnaSoK+316oj30fLlO5xlWJb
         lGYw==
X-Gm-Message-State: ABuFfoiUICLJisV6ZgmQdIceNEWwhDzLp4xAJq7uX8ogSSR6z4S7HSND
        q1g14Cuez/+Np0/Y0zyIi0E=
X-Google-Smtp-Source: ACcGV6159NKfHjfg4hhzJ0ugu5WJhApRBJ6hGUENNlTJDJAw+wdKDWYaYdlqiw+aPzEFyCsGrPqT7A==
X-Received: by 2002:a1c:f312:: with SMTP id q18-v6mr566000wmq.14.1538553289350;
        Wed, 03 Oct 2018 00:54:49 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b83-v6sm619207wmh.16.2018.10.03.00.54.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 00:54:48 -0700 (PDT)
Date:   Wed, 3 Oct 2018 09:54:46 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] locking/lockdep: Make class->ops a percpu counter
Message-ID: <20181003075446.GA3183@gmail.com>
References: <1538511560-10090-1-git-send-email-longman@redhat.com>
 <1538511560-10090-5-git-send-email-longman@redhat.com>
 <20181003074809.GJ26858@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003074809.GJ26858@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Oct 02, 2018 at 04:19:19PM -0400, Waiman Long wrote:
> > +DEFINE_PER_CPU(unsigned long [MAX_LOCKDEP_KEYS], lock_class_ops);
> 
> > @@ -179,9 +181,30 @@ DECLARE_PER_CPU(struct lockdep_stats, lockdep_stats);
> >  	}								\
> >  	__total;							\
> >  })
> > +
> > +static inline void debug_class_ops_inc(struct lock_class *class)
> > +{
> > +	int idx;
> > +
> > +	idx = class - lock_classes;
> > +	__this_cpu_inc(lock_class_ops[idx]);
> > +}
> > +
> > +static inline unsigned long debug_class_ops_read(struct lock_class *class)
> > +{
> > +	int idx, cpu;
> > +	unsigned long ops = 0;
> > +
> > +	idx = class - lock_classes;
> > +	for_each_possible_cpu(cpu)
> > +		ops += per_cpu(lock_class_ops[idx], cpu);
> > +	return ops;
> > +}
> 
> Would it make sense to stick that in struct lockdep_stats ?
> 
> A little something like:
> 
> struct lockdep_stats {
> 	/* ... */
> 	int	lock_class_ops[MAX_LOCKDEP_KEYS];
> };

Did you shrink the 'long' to 'int' intentionally?

Thanks,

	Ingo
