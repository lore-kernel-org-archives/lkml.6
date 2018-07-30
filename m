Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45C3C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDFC20857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="LyPBFZxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FDFC20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731977AbeG3UzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 16:55:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34454 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731047AbeG3UzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 16:55:23 -0400
Received: by mail-pf1-f194.google.com with SMTP id k19-v6so4955566pfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 12:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cWy/CwXcPTX3LoPHHcBK9xe+CKTCvVEGtnMY/DDRHXQ=;
        b=LyPBFZxUmEHU0Rj8PlI1hvpVhLWgdmhqVnUJdCZjdb/k2UB9qfcPgMW7y9qcXDf+7a
         E23jHhvhMN+toNQExtghr3jXg0OPryFPT2OQmOs/CKogKf+C1fPue2kVmr1y5w7IOwH6
         YT90JkRFsK/j46ouEVpbpjCWzr6wufLwjoqso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cWy/CwXcPTX3LoPHHcBK9xe+CKTCvVEGtnMY/DDRHXQ=;
        b=YATVpeP7V3ct/yZ+trfuXaj8VEaPp62zWn0LlpC53h42DILOThhCrWedtgNEW6u0J+
         AUekG1wrZsjTJYzNMUKJQDp2ulPeHQgLOCYWgwm6FjNdk6BMLdURP7TsZ8G7VO68hW3S
         Np6h4f8G+ygetfDUUknoBuP7wYWNAkDycCWJzIlwOa2U+dfUj59a8MJDB8p7Sj7aM6Ld
         Fjy4mGZ3MnoTUPUus3KALXK1fogEB92cRBYVpFyOX8drandN1xKvEduYLut3cLin4tNm
         voG2LJ6E722Rz+REdBwidPODh/xooI95RtypPPse4eK9nATQCDN9dLPoolsaIK4lG+tZ
         6D9g==
X-Gm-Message-State: AOUpUlGAr5smQdbyt42qdBcsKZqAZY+MEcrYUxiStLil8wRteHNnUgd/
        AEF07KB16LrMQXI5wpO4QXDXHw==
X-Google-Smtp-Source: AAOMgpc1SbsQiFTabhe/IXnTkhSvvGA1FGBDtALvCXlM6hwY//sWKGg2JXOW8kiYCZQoJlvrgGMfDQ==
X-Received: by 2002:a62:b29c:: with SMTP id z28-v6mr19324792pfl.8.1532978336899;
        Mon, 30 Jul 2018 12:18:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id 14-v6sm20473161pft.93.2018.07.30.12.18.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 12:18:55 -0700 (PDT)
Date:   Mon, 30 Jul 2018 12:18:55 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v11 3/3] tracing: Centralize preemptirq tracepoints and
 unify their usage
Message-ID: <20180730191855.GA46892@joelaf.mtv.corp.google.com>
References: <20180726235044.10195-1-joel@joelfernandes.org>
 <20180726235044.10195-4-joel@joelfernandes.org>
 <20180730085813.GB2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730085813.GB2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 10:58:13AM +0200, Peter Zijlstra wrote:
> On Thu, Jul 26, 2018 at 04:50:44PM -0700, Joel Fernandes wrote:
> > One note, I have to check for lockdep recursion in the code that calls
> > the trace events API and bail out if we're in lockdep recursion
> > protection to prevent something like the following case: a spin_lock is
> > taken. Then lockdep_acquired is called.  That does a raw_local_irq_save
> > and then sets lockdep_recursion, and then calls __lockdep_acquired. In
> > this function, a call to get_lock_stats happens which calls
> > preempt_disable, which calls trace IRQS off somewhere which enters my
> > tracepoint code and sets the tracing_irq_cpu flag to prevent recursion.
> > This flag is then never cleared causing lockdep paths to never be
> > entered and thus causing splats and other bad things.
> 
> That is now fixed, right?

Yes, that's right it got fixed from v9->v10 but I forgot to update the
changelog, I'll make the change and resend. Thanks!

thanks,

- Joel

