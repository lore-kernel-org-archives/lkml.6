Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DDAC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804E523C9A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 804E523C9A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932884AbeGCPtT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:49:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932254AbeGCPtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:49:18 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F4FF223B6;
        Tue,  3 Jul 2018 15:49:17 +0000 (UTC)
Date:   Tue, 3 Jul 2018 11:49:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [BUG] Caused by: sched/deadline: Move CPU frequency selection
 triggering points
Message-ID: <20180703114915.510f959c@gandalf.local.home>
In-Reply-To: <20180703113120.55288b03@gandalf.local.home>
References: <20180703105449.2a211fb2@gandalf.local.home>
        <20180703150711.GA23426@localhost.localdomain>
        <20180703113120.55288b03@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2018 11:31:20 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 3 Jul 2018 17:07:11 +0200
> Juri Lelli <juri.lelli@redhat.com> wrote:
> 
> > This got into tip quite recently
> > 
> > ecda2b66e263 ("sched/deadline: Fix missing clock update")
> > 
> > could you please double check that you have that in your stack?
> >   
> 
> Unfortunately, I just tested it out, and it still locks up with this
> patch.
> 

It appears that the below patch fixes the issue for me.

Is this a correct usage?

-- Steve

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index fbfc3f1d368a..90b6e9df79b2 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2085,6 +2085,8 @@ static int push_dl_task(struct rq *rq)
 		goto retry;
 	}
 
+	update_rq_clock(later_rq);
+
 	deactivate_task(rq, next_task, 0);
 	sub_running_bw(&next_task->dl, &rq->dl);
 	sub_rq_bw(&next_task->dl, &rq->dl);
