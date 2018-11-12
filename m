Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF82FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F6B223DD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="a+ql0PFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F6B223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbeKMABS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 19:01:18 -0500
Received: from mail.efficios.com ([167.114.142.138]:47998 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbeKMABS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 19:01:18 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 827CB238972;
        Mon, 12 Nov 2018 09:07:51 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id BpKjrrEUl27O; Mon, 12 Nov 2018 09:07:50 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 8C526238969;
        Mon, 12 Nov 2018 09:07:50 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 8C526238969
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1542031670;
        bh=X7AGNmctA5QMRd+GNzVJIazoxttgMWPkCHXlyaGPfFY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=a+ql0PFF1nYBBF6avk0paPYNZ2ZWSmePUHARoyKkdbHZtFF66Su6DFgpF7R1QhwNf
         k7KtlzypICUoM7DpT/FVpNXFPBu7EI19u9b57VIgItLrDxofUaHl7pj+3ldkt46DZy
         K6sgJoKZSzXrCLVejOu33p2auQzElLsCpffdSmagCL/FyVz8gizVZVCDTKJ68xWdm0
         jzhnlVYrmmPI0vcQ5ZyKILVRLm8WYBH5OYOq6grbX0lVh2gDIrn0Syzn6naqTyYkSn
         Xe9C3iyzD4Wav9HTTW0oLTQKif3WozI/yrBhZAvU75yqNwy6IXjr6SKOxebooBYmXL
         Kb1dfWt4U3ysQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id LRjxCb_-ZzGM; Mon, 12 Nov 2018 09:07:50 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 6D730238962;
        Mon, 12 Nov 2018 09:07:50 -0500 (EST)
Date:   Mon, 12 Nov 2018 09:07:50 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     paulmck <paulmck@linux.ibm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        dipankar <dipankar@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        fweisbec <fweisbec@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        kernel-team <kernel-team@android.com>
Message-ID: <2113574714.3779.1542031670315.JavaMail.zimbra@efficios.com>
In-Reply-To: <20181111194104.GA4787@linux.ibm.com>
References: <20181111194104.GA4787@linux.ibm.com>
Subject: Re: [PATCH tip/core/rcu 0/41] More RCU flavor consolidation cleanup
 for v4.21/v5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3047 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3041)
Thread-Topic: More RCU flavor consolidation cleanup for v4.21/v5.0
Thread-Index: wSthxDOTXtMSC6VgWohpPZMvbxkGKQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Nov 11, 2018, at 2:41 PM, paulmck paulmck@linux.ibm.com wrote:

> Hello!
> 
> This series does additional cleanup for the RCU flavor consolidation,
> focusing primarily on uses of old API members, for example, so that
> call_rcu_bh() becomes call_rcu().  There are also a few straggling
> internal-to-RCU cleanups.
> 
> 1.	Remove unused rcu_state externs, courtesy of Joel Fernandes.
> 
> 2.	Fix rcu_{node,data} comments about gp_seq_needed, courtesy of
>	Joel Fernandes.
> 
> 3.	Eliminate synchronize_rcu_mult() and its sole caller.
> 
> 4.	Consolidate the RCU update functions invoked by sync.c.
> 
> 5-41.	Replace old flavorful RCU API calls with the corresponding
>	vanilla calls.

Hi Paul,

Just a heads up: we might want to spell out warnings in very big letters
for anyone trying to backport code using RCU from post-4.21 kernels
back to older kernels. I fear that newer code will build just fine
on older kernels, but will spectacularly fail in hard-to-debug ways at
runtime.

Renaming synchronize_rcu() and call_rcu() to something that did not
exist in prior kernels would prevent that. It may not be as pretty
though.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
