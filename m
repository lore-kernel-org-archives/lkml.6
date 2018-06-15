Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EFEC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136B3208DD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="HEU8jOZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136B3208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756384AbeFOSSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 14:18:10 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33261 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756331AbeFOSSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 14:18:08 -0400
Received: by mail-pl0-f68.google.com with SMTP id 6-v6so5210494plb.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 11:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dt3YyKahDoj24TpB4or88lOmNtPYtWcdPlC7U2wGV/A=;
        b=HEU8jOZNGvmbx9JLPpHv6KkDojBqfCdhFHsqKtjuA7TLcNBaUR/m5X+s3FomPpKoO7
         K1qUeyLZC3xIGHzr+ICdf/kq/qACtVkE/4Tyy4O78kk3b5SBHK20h4m+pKYf1Dc29Mpn
         6oSSWIu4xPHxJIOeVImfcut+kOtaD6AQwZ608=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dt3YyKahDoj24TpB4or88lOmNtPYtWcdPlC7U2wGV/A=;
        b=QBLYInP+R+ZBMYDd+F32Vn86kyVFAs8kUEEOiQXqLRiKU51dgTOy/p1qQxihTrGFk9
         U6N9Y9CFgPKWoTwRSDWzndLaEydPJRZFfnTMhyoG0ZLwzhEpAT6lg73uZ3BZVU2p6YPb
         kh13SKgOwmY8jygZx7R7U2Kj0ZOQ2dm5wLy3zG+uYkjr7/mO7w1GXIjiWvVDMoQTPS1v
         Nkt6dkNUBjBYtSQ73i4ucq7JuDlYZ4sun72QUAbm/dGg87+ApaY7C8dtH5+NYVx4SoX/
         vAkLtxRIk9H4N4XKUCqpuYWba1KMbbmPacfciQlnpTMuhs/0Tuz3ZIr4jsec6w9deE0G
         jfaQ==
X-Gm-Message-State: APt69E3bUFpN67YE0jdGc4uaK17zsc602ZvNCrJtU9pejHTcOVWXImHq
        ArcHVLw2V7Dtd/buUsOaPRMU/KqnhKg=
X-Google-Smtp-Source: ADUXVKJBDyE4oKl/2qXJvE9oeAYlFyA2jII1cUvECe0yJMjw/LZWnnXd1TskIRRWIYAwvi+k6Ox1ug==
X-Received: by 2002:a17:902:650a:: with SMTP id b10-v6mr3250034plk.45.1529086687830;
        Fri, 15 Jun 2018 11:18:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id g66-v6sm18511513pfk.99.2018.06.15.11.18.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 11:18:07 -0700 (PDT)
Date:   Fri, 15 Jun 2018 11:18:06 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joelaf@google.com>, kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de,
        mhiramat@kernel.org, namhyung@kernel.org,
        mathieu.desnoyers@efficios.com, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] tracing: Call triggers only if event passes filter
 checks
Message-ID: <20180615181806.GA60478@joelaf.mtv.corp.google.com>
References: <20180615010113.127718-1-joel@joelfernandes.org>
 <20180615121603.33007151@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615121603.33007151@gandalf.local.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 12:16:03PM -0400, Steven Rostedt wrote:
> On Thu, 14 Jun 2018 18:01:13 -0700
> Joel Fernandes <joelaf@google.com> wrote:
> 
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > 
> > Currently, trace event triggers are called regardless of if the event
> > filter checks pass or fail. Thus if one were to enable event triggers
> > and filters at the same time, then the triggers will always be called
> > even if the filter checks didn't pass.
> > 
> > This is a problem for a usecase I was experimenting with: measuring the
> > time preemption is disabled using synthetic events and dump the stack
> > using the stacktrace trigger if the total preempt off time was greater
> > than a threshold. Following are the commands for the same:
> > 
> > Create synthetic event:
> > 
> > echo 'preemptdisable u64 lat' >> \
> > 	      /sys/kernel/debug/tracing/synthetic_events
> > 
> > echo 'hist:keys=cpu:ts0=common_timestamp.usecs:scpu=cpu' >> \
> > 	      /sys/kernel/debug/tracing/events/preemptirq/preempt_disable/trigger
> > 
> > echo 'hist:keys=cpu:wakeup_lat=common_timestamp.usecs-$ts0:\
> > onmatch(preemptirq.preempt_disable).preemptdisable($wakeup_lat)' >> \
> > 	        /sys/kernel/debug/tracing/events/preemptirq/preempt_enable/trigger
> > 
> > Enable synthetic event:
> > 
> > echo stacktrace > /sys/kernel/debug/tracing/events/synthetic/preemptdisable/trigger
> > echo 'lat > 400' > /sys/kernel/debug/tracing/events/synthetic/preemptdisable/filter
> > echo 1 > /sys/kernel/debug/tracing/events/synthetic/preemptdisable/enable
> > 
> > With the patch, the stacktrace is triggered only if the filter checks
> > passed. It also seems sensible to call triggers only if filter checks
> > pass so lets do that.
> 
> No, it worked as expected. The filter is only to be used it the event
> should be recorded or not. What you wanted to do is:
> 
>  echo 'stacktrace if lat > 400' > events/synthetic/preemptdisable/trigger

Thanks, that worked!

I was thinking at some point we should add these synthetic event 'recipes' to
the kernel tree as scripts or documentation, or something like that. Do you
have any suggestions on where to add these? A recipe would be 'report
preemptoff times > threshold us' or 'wake up latency > threshold us'. I think
there will be quite a few such useful ones.

Another idea could be to make the 'recipes' a part of ftrace itself.
Something like a 'built in' synthetic event that will set itself up when its
enabled without needing to create the hist triggers and other triggers
explicitly. Thoughts?

thanks!

 - Joel

PS: Your reply also went a weird address (barclay something) on CC. Wondering
what happened. The headers in my original email seemed correct. I have
included back the CC list.

