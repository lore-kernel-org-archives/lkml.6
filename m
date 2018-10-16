Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB89C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2591E2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="UhczbUsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2591E2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbeJQDzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 23:55:14 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41658 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbeJQDzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 23:55:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id m77-v6so11981612pfi.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 13:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3jUXMcF88Mt7C9Ai5w2U0e/r+8lwAfhWvkwWRTqxQxo=;
        b=UhczbUsQYYrKa0DjIdtKCzjIhe5d1/kg1a+NxufR5TZw+Y79iYRD28eK+qvlitNT/r
         ORyF6pgQqgNdu3xEAMkPj1RvaWzG1rdM7q7bkL3uMVzL4L4GckBc8fYEL94hgnZHBEtw
         B21FmusaFgtrqV9ELBw2sHNsIF7c7iDeIATDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3jUXMcF88Mt7C9Ai5w2U0e/r+8lwAfhWvkwWRTqxQxo=;
        b=DHc0nB/qhp2mZsmYE0lhwSfXbPQvT2fdMPAfwaosQGcnUdujn16R0dNseKustGfS/V
         BHjdTW3EKDCM0dc637STalK1Sl/cxshf0z9SLXoAwetp4Day0sgRzF7b3qujIl7Jzhr5
         yrXR1R4gx/JnKaUBwV1TfJBNUsoXQZi2qU9reMnx4CLlYxQfkDQ2pNZ6pJk8t+ilQ9Eb
         BJ9j63qetlzcjCVtksYHpaTIvrwBnirX1dKpH2Qndb2jMHatzfept/Ebog65KL9tYjt7
         I8P6q74Q8sq8FrM08Yoq70IPMnw5pMDZNOsixMl25pRG9QVRVy2XxrXTlndTbpBqfDQl
         swvQ==
X-Gm-Message-State: ABuFfogz/wOSNTIF0lV8jFDjV/KgWjp6gPksYu8rLh1Dov9IeE5Rb1Dw
        91Rnr4LvAD1zi9S5IWmpXXi0UrsOfaA=
X-Google-Smtp-Source: ACcGV63dq0HLiNOyf5Eani2Vwfe5FZCFWE7o7sDYU6l2zkFb+xH9QkCAa1vz8Ap4mwKd5k56ciAZ6A==
X-Received: by 2002:a63:e40e:: with SMTP id a14-v6mr21671583pgi.28.1539720190974;
        Tue, 16 Oct 2018 13:03:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id v63-v6sm18377613pgd.69.2018.10.16.13.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 13:03:09 -0700 (PDT)
Date:   Tue, 16 Oct 2018 13:03:08 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Use trace_clock_local() for looping in
 preemptirq_delay_test.c
Message-ID: <20181016200308.GA259794@joelaf.mtv.corp.google.com>
References: <20181016094005.654275a9@gandalf.local.home>
 <20181016094204.363b8dd4@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016094204.363b8dd4@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 09:42:04AM -0400, Steven Rostedt wrote:
> 
> Joel,
> 
> Can you Ack this patch. I want to push it upstream as without it, your
> preemptirq latency test fails on one of my boxes. Causing my automated
> tests to fail (I get by with removing the test from the automation).
> 
> -- Steve
> 
> 
> On Tue, 16 Oct 2018 09:40:05 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > The preemptirq_delay_test module is used for the ftrace selftest code that
> > tests the latency tracers. The problem is that it uses ktime for the delay
> > loop, and then checks the tracer to see if the delay loop is caught, but the
> > tracer uses trace_clock_local() which uses various different other clocks to
> > measure the latency. As ktime uses the clock cycles, and the code then
> > converts that to nanoseconds, it causes rounding errors, and the preemptirq
> > latency tests are failing due to being off by 1 (it expects to see a delay
> > of 500000 us, but the delay is only 499999 us). This is happening due to a
> > rounding error in the ktime (which is totally legit). The purpose of the
> > test is to see if it can catch the delay, not to test the accuracy between
> > trace_clock_local() and ktime_get(). Best to use apples to apples, and have
> > the delay loop use the same clock as the latency tracer does.
> > 
> > Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Cc: stable@vger.kernel.org
> > Fixes: f96e8577da102 ("lib: Add module for testing preemptoff/irqsoff latency tracers")
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Looks good to me!

Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

