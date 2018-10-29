Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088BCC46475
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E0A2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E0A2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gliwa.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbeJ2Qy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 12:54:57 -0400
Received: from s30320.gliwa.com ([148.251.52.238]:40904 "EHLO mail.gliwa.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbeJ2Qy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 12:54:57 -0400
X-Greylist: delayed 513 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Oct 2018 12:54:56 EDT
Received: by mail.gliwa.com (Postfix, from userid 992)
        id AE028344D0A; Mon, 29 Oct 2018 08:58:51 +0100 (CET)
X-Virus-Checker-Version: ClamAV 0.100.2/25073/Mon Oct 29 06:05:58 2018
X-Virus-Status: OK
Received: from [192.168.1.3] (x5f721fb9.dyn.telefonica.de [95.114.31.185])
        by mail.gliwa.com (Postfix) with ESMTPSA id 7993C3449DC;
        Mon, 29 Oct 2018 08:58:51 +0100 (CET)
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
From:   Claudio <claudio.fontana@gliwa.com>
Subject: new arch-independent tracepoints on hardware entry/exit from
 interrupt ?
Message-ID: <a2e9ee60-e206-3775-62db-c05dc046b15e@gliwa.com>
Date:   Mon, 29 Oct 2018 08:58:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I am currently facing the requirements to trace OS events close to hardware entry and exit from
interrupt.

There are currently arch-independent events defined for entry/exit from irq handlers as
registered in Linux (irq_handler_entry, irq_handler_exit),

However that is of course a different view compared with the entry and exit to/from the kernel from a hardware perspective.

While playing around with the idea, I experimented with the idea of having two new events:

name: hw_irq_entry
ID: 93
format:
	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
	field:unsigned char common_preempt_count;	offset:3;	size:1;signed:0;
	field:int common_pid;	offset:4;	size:4;	signed:1;

	field:irq_hw_number_t hw_irq;	offset:8;	size:8;	signed:0;

print fmt: "hw_irq=%lu", REC->hw_irq

name: hw_irq_exit
ID: 92
format:
	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
	field:unsigned char common_preempt_count;	offset:3;	size:1;signed:0;
	field:int common_pid;	offset:4;	size:4;	signed:1;

	field:irq_hw_number_t hw_irq;	offset:8;	size:8;	signed:0;

print fmt: "hw_irq=%lu", REC->hw_irq

With the intention to report on any architecture the specific number meaningful for that architecture.

I noticed that on x86 we have a specific separate events for irq_vectors,
apparently introduced by commit cf910e83ae23 ("x86, trace: Add irq vector tracepoints")

but I wonder if a more general solution could be implemented to cover meaningfully all architectures,
without having the tools having to special case all possible architectures and also special case all possible events generated as a consequence of irq entry.

The use case here is about timing analysis for the automotive domain, the current architectures we are looking at are x86 and arm64.

Thank you for your thoughts on this,

Claudio
