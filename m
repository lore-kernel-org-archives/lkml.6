Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753481AbeDSTzM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 15:55:12 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:40589 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752153AbeDSTzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 15:55:08 -0400
X-Google-Smtp-Source: AB8JxZq67xwFcyT9XpTx+bTd7+1HprRzUJYSUo/NIptbgs0P/4hSBTZHuW3UmJ/+7gkiTUYkvPJFTQ==
Date: Thu, 19 Apr 2018 22:55:04 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Waiman Long <longman@redhat.com>
Cc: linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] proc/stat: Separate out individual irq counts into
 /proc/stat_irqs
Message-ID: <20180419195504.GA4343@avx2>
References: <20180419190846.GE2066@avx2>
 <1c3b9cf3-3a36-568f-3da2-e560a721f4aa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1c3b9cf3-3a36-568f-3da2-e560a721f4aa@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3JJtIxT027095

On Thu, Apr 19, 2018 at 03:28:40PM -0400, Waiman Long wrote:
> On 04/19/2018 03:08 PM, Alexey Dobriyan wrote:
> >> Therefore, application performance can be impacted if the application
> >> reads /proc/stat rather frequently.
> > [nods]
> > Text interfaces can be designed in a very stupid way.
> >
> >> For example, reading /proc/stat in a certain 2-socket Skylake server
> >> took about 4.6ms because it had over 5k irqs.
> > Is this top(1)? What is this application doing?
> > If it needs percpu usage stats, then maybe /proc/stat should be
> > converted away from single_open() so that core seq_file code doesn't
> > generate everything at once.
> 
> The application is actually a database benchmarking tool used by a
> customer.

So it probably needs lines before "intr" line.

> The reading of /proc/stat is an artifact of the benchmarking
> tool that can actually be turned off. Without doing that, about 20% of
> CPU time were spent reading /proc/stat and the trashing of cachelines
> slowed the benchmark number quite significantly. However, I was also
> told that there are legitimate cases where reading /proc/stat was
> necessary in some of their applications.
> 
> >> -
> >> -	/* sum again ? it could be updated? */
> >> -	for_each_irq_nr(j)
> >> -		seq_put_decimal_ull(p, " ", kstat_irqs_usr(j));
> >> -
> > This is direct userspace breakage.
> 
> Yes, I am aware of that. That is the cost of improving the performance
> of applications that read /proc/stat, but don't need the individual irq
> counts.

Yeah, but all it takes is one script which cares.

I have an idea.

Maintain "maximum registered irq #", it should be much smaller than
"nr_irqs":

intr 4245359 151 0 0 0 0 0 0 0 38 0 0 0 0 0 0 0 0 0 64 0 0 0 0 0 0 0 0 0 0 44330 182364 57741 0 0 0 0 0 0 0 0 85 89124 0 0 0 0 0 323360 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

Or maintain array of registered irqs and iterate over them only.

I have another idea.

perf record shows mutex_lock/mutex_unlock at the top.
Most of them are irq mutex not seqfile mutex as there are many more
interrupts than reads. Take it once.
