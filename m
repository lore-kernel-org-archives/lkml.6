Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2AAC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0942080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0942080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbeLNKVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:21:40 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35025 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbeLNKVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:21:39 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so4884875wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 02:21:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VFxhhFyi8AFP4P7k3CPrB812jbKfK0Bk2SFShJ2xv1w=;
        b=PLBXeKC/USjVgyNMaS8VZTclq98Ay+JrmpsB4xjwku7mkEQD3+/5ZPgbQVWKbWX+iJ
         ScTRQEnYtbBVzu8GXdr8BZofi30LB8pO+tZDYLEh2EIZXcpPraL2Hpd6/sfsZdxzThhc
         jjk0MeBQ7c0RHseEGj6PYUfdjOGIs9ivrpfG7vV5jpp7yPiU9bOwKgA8aC8dB0y/Rb1J
         lAh9+HeKZ7/tXQhtRcRbWaZbtGvFRjT+Xr77B/XWvPNOCqa8dRX7zwpQM1oZylr6BrOA
         1RIDhrSOyXG1hsotosMXGIKQBt3Q5D+p+YlW5qTzgVPVtm/Ew8IL8yRdwOGJne9NSGTL
         X6Cg==
X-Gm-Message-State: AA+aEWYmDl2Kwt80tcolPf5+zY+BqD5qycyr4qZt50MqxeJmqvnOGfIu
        /FU1ypimevIOCl6drYf+k+VukA==
X-Google-Smtp-Source: AFSGD/XZnx3HnTt9VIeZtkE+IzR5VqPvD6JVOIvBLNMPevPKmmHUh2CMW4TPR6b65xhnAbgnaQCnKg==
X-Received: by 2002:adf:f9cb:: with SMTP id w11mr2034175wrr.201.1544782897911;
        Fri, 14 Dec 2018 02:21:37 -0800 (PST)
Received: from t460s.bristot.redhat.com ([193.205.81.200])
        by smtp.gmail.com with ESMTPSA id x12sm3298822wmc.37.2018.12.14.02.21.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 02:21:37 -0800 (PST)
Subject: Re: BUG: ftrace/perf dropping events at the begin of interrupt
 handlers
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Marko Pusch <marko.pusch@siemens.com>,
        Tommaso Cucinotta <tommaso.cucinotta@sssup.it>,
        =?UTF-8?Q?R=c3=b4mulo_Silva_de_Oliveira?= 
        <romulo.deoliveira@ufsc.br>, Ingo Molnar <mingo@redhat.com>
References: <a5e8182e-de6c-caaf-3106-a43b54198b97@redhat.com>
 <20181204141644.6852d450@vmware.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <e9375c7c-745d-fac3-6e16-539712ceaaea@redhat.com>
Date:   Fri, 14 Dec 2018 11:21:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181204141644.6852d450@vmware.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/18 8:16 PM, Steven Rostedt wrote:
> Yes, it's a simple fix. The problem is that the recursion detection of
> the function tracer requires that when its called from interrupt, the
> "in_interrupt" needs to be true, otherwise it thinks that the function
> tracer is recursing on itself (which is common).
> 
> Looking an the dropped events, and the code in __irq_enter() we have
> this:
> 
> #define __irq_enter()					\
> 	do {						\
> 		account_irq_enter_time(current);	\
> 		preempt_count_add(HARDIRQ_OFFSET);	\ <<-- in_interrupt() returns true here
> 		trace_hardirq_enter();			\
> 	} while (0)
> 
> Interesting enough, the dropped events happen to be in
> account_irq_enter_time()!
> 
> Thus what I believe is happening is that an interrupt came in while one
> event was being recorded. When account_irq_enter_time was called, the
> function tracer noticed that its recursion bit for the current context
> was already set, and just dropped the event because it thought it was
> just tracing itself. After we add HARDIRQ_OFFSET to preempt_count, the
> "in_interrupt()" will be set and the function tracer will know its in a
> new context where its safe to continue tracing.
> 
> Can you try this patch to see if it fixes it for you?

Hi Steve,

I finally took some time to play the patch, sorry for the delay. I got the idea
of the patch, but it is not working as expected :-(.

When I enable it, the system [a VM with 1 CPU] mostly freezes when I run that:

# while [ 1 ]; do echo > /dev/null; done &

I still need to investigate why.

The other point is that I got that the patch would start showing
account_irq_enter_time(). But, as far as I understood, it would not trace the
do_IRQ(). Right?

Wouldn't be the case of using a per-cpu variable to set the flag right in the
begin of the handler (in the entry*.s)?

Thoughts?

-- Daniel
