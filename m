Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8893BC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D87F20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="mf7bIN9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D87F20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbeG0Ayg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 20:54:36 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35318 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731286AbeG0Ayg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 20:54:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6-v6so2086094pgv.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 16:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BgepLu4qFRkCVji/S7m9MNFLH4XVu2eLeWzZgogQWnU=;
        b=mf7bIN9d2XJwnNkrxG1pUE9Nx/zOLxMSzS2TsXRPshs2IJ4uJLMbYHXQYdh4z6Fb0M
         oJgdMv7QkgimseyYWWEMyxUHUzOoz65qiiwGZxtJuclus/XERvnNLSlOnOXXT3zoygJH
         15iBGAoDWaj5UxrHTYLWKCJfUwKVok+o/iK8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BgepLu4qFRkCVji/S7m9MNFLH4XVu2eLeWzZgogQWnU=;
        b=fw/DxFlVh+cc2tOUBSJDrksjQ/xYQVpqGngQ+pMtc7IBV4UL/clhaowRxJabzMDCFa
         6oysOS8126dvuh9/jiM3zfn3x0bjePvaypqO91YyfgAOdiBWAyqG6xMqKQohYxo48apu
         ZXPQQCPqYI3r9WzRhJJRXEdNUB2ZjZD/1gKb/p5mEz8gbbNC9S6zzj2vR0KRMC56K8am
         MlpYxPOg4na+ephuIAgCf4TsdT1j8N4M6qkdpzATveIxAmt435t3uP+RSFdPNz2cRy0k
         XbFQ3iWDefpgXOM0X9MYhqUa9LEawdfZpWDyBnAO2oohQ5jdyF6+3mCPJyB6pvvU3KcZ
         tFPA==
X-Gm-Message-State: AOUpUlHkSsNf2SW8/5TwZLcn5O5HsMQ0TrW/8giijGzCp49+KZyvpf2/
        UdcD06LjMoTBOjMgFA7fdnWLcw==
X-Google-Smtp-Source: AAOMgpdj+T72ZMcQUIGoJdNAGIiYiAHLbnVsAHRZkGlR3lXj6FsjcAHKmWgmozarq9vpTbie5Gr2Eg==
X-Received: by 2002:a62:e813:: with SMTP id c19-v6mr4074673pfi.124.1532648132416;
        Thu, 26 Jul 2018 16:35:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id g28-v6sm9205238pfe.41.2018.07.26.16.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 16:35:31 -0700 (PDT)
Date:   Thu, 26 Jul 2018 16:35:31 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v10 2/3] tracepoint: Make rcuidle tracepoint callers use
 SRCU
Message-ID: <20180726233531.GB211260@joelaf.mtv.corp.google.com>
References: <20180713215547.255620-1-joel@joelfernandes.org>
 <20180713215547.255620-3-joel@joelfernandes.org>
 <20180717182528.GK2494@hirez.programming.kicks-ass.net>
 <20180718001625.GA154046@joelaf.mtv.corp.google.com>
 <20180726191800.154a178d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726191800.154a178d@gandalf.local.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 07:18:00PM -0400, Steven Rostedt wrote:
> On Tue, 17 Jul 2018 17:16:25 -0700
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > Is it Ok with you to take the below patch ontop of this series? I avoided
> > resending the 3-patch series since this is the only change, but let me know
> > what you prefer or makes it easy for you.
> 
> Can you send a v11, even though this is the only change. My INBOX is
> currently a mess, and I want to make sure I pull in the right patches.

Sure, I'll squash the extra patch and send it out as v11 now. Thanks!

- Joel

