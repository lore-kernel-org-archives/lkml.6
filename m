Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F49BC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9E520936
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="CrGVha/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9E520936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733117AbeGJS1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:27:47 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37977 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732610AbeGJS1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:27:46 -0400
Received: by mail-pl0-f66.google.com with SMTP id b1-v6so7987457pls.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 11:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=amrNnaZhe4X4AzMg7tJ95AaHhzytXQJ6jphe+s7QY0U=;
        b=CrGVha/zJk3hhKdmHNZPWeby2LKowWWqIHaBDgIR5KmYDPTjGibvWI4MFqvn5hR0kD
         oA15tp+N2m7kvrVC7IDGVluyA7/lns/AKaQkeL7j8gWrwc6yyLiysO3MX9d1JSUeNRMl
         8tTY8A2i7AsEokzGDtjxvmgsU7aPv83GrOgjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=amrNnaZhe4X4AzMg7tJ95AaHhzytXQJ6jphe+s7QY0U=;
        b=W9RPR2rMlm3JMdsefVJbqZFkVRpFMeFx+QxeIuY4XI1+EOtDc5qWW5doMTjcyCXLFT
         4APtNEH0GX940QRA6lrwRoTOGggjBG4yyap3mWMuFsIQClNDUKILikre71mehL4shCPz
         xDdBiC0HYRn23MApYcJvIqXhLhk51rd9i66ySvKgxMbDpg2TbPWzBaHaezkXs7C5yQvK
         yu8OBpVtcYOCS9OC0FqGIurMI1ro4F0nnEued7k7dhMv+KD/pdZDJvaecQ/WODInuGf+
         zlV9e5UsGb8aePW+DQmC1jEF3TY2IA3VMnWw7F/cW9bpuozfqhw5EVvToMGSb5mUByLF
         vvYg==
X-Gm-Message-State: APt69E0ozhzZEz/qe3zXpTFqDjnDRfUGysp4YuLc5s99QQKNlSkx8evf
        i/PnbV9AMjhFa+q+tcEAcXOqSw==
X-Google-Smtp-Source: AAOMgpfDCLovj5IkF4+zr/M6SgYrXcF6lCfgFnrkVXgt3CBejotQT8IneS70fV+wL11wepavgE0i9g==
X-Received: by 2002:a17:902:9695:: with SMTP id n21-v6mr25738935plp.6.1531244026848;
        Tue, 10 Jul 2018 10:33:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id t3-v6sm32744212pfk.161.2018.07.10.10.33.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 10:33:45 -0700 (PDT)
Date:   Tue, 10 Jul 2018 10:33:45 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v9 5/7] tracing: Centralize preemptirq tracepoints and
 unify their usage
Message-ID: <20180710173345.GB103636@joelaf.mtv.corp.google.com>
References: <20180628182149.226164-1-joel@joelfernandes.org>
 <20180628182149.226164-6-joel@joelfernandes.org>
 <20180710102050.78ae0ea8@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710102050.78ae0ea8@gandalf.local.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 10:20:50AM -0400, Steven Rostedt wrote:
> On Thu, 28 Jun 2018 11:21:47 -0700
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
> > new file mode 100644
> > index 000000000000..dc01c7f4d326
> > --- /dev/null
> > +++ b/kernel/trace/trace_preemptirq.c
> > @@ -0,0 +1,71 @@
> 
> Can you send a patch on top of this, that adds a SPDX header here. Just
> add another patch, no need to resend this one.
> 
> I need to go through all the files in kernel/trace/* and add SPDX
> headers. I don't want to add more files that don't have them.

Sure, I'll send a patch ontop of this.

> I'm still playing around with this patch, and testing it.

Ok, thanks.

-Joel

