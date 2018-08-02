Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D93C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECECC214FB
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cy0tV2Fb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECECC214FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731997AbeHBLjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:39:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56340 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbeHBLjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OY9bAezH3+xlruTxmagsjPO9lowgAkQHrIyeRVbPLNU=; b=Cy0tV2FbV8BoVIH7RaxPdD8dJt
        J5OkUDF3d6/qxSi2iQq2Rd/5YHp+YB9PVcZOssg+xzbRo2cCqkjExiinTiIaQ5AOIrJ1RRZwv64o+
        LMNa1cDWKUwkbl5Lzo+sssjrlyE26BLEzkicfnAhD7tnJ24K3DgvjJsqxomtLs1B25rdrrdvAR+1Q
        txWRrWFo6UMLy47sCixiMj29k6pyLgup6e2JFmrjvf4S3QRSHkebxLWfupXcCABUuGsWDgoKBY3x/
        P0Oj2jBtv/52DVSQX1dRpNl7x15SMVpr3o4w8qiP1aCa96Y2wuielUHQE0Yuw4jzrHtnpGC1e5bsj
        m9Y/LmHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flAEK-0004KS-JF; Thu, 02 Aug 2018 09:49:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 94C0820267E4D; Thu,  2 Aug 2018 11:49:08 +0200 (CEST)
Date:   Thu, 2 Aug 2018 11:49:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sodagudi Prasad <psodagud@codeaurora.org>
Cc:     mingo@kernel.org, gregkh@linuxfoundation.org,
        bigeasy@linutronix.de, tglx@linutronix.de, isaacm@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: cpu stopper threads and setaffinity leads to deadlock
Message-ID: <20180802094908.GK2494@hirez.programming.kicks-ass.net>
References: <24eebe1d874cb8e3b9a18087554544fa@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24eebe1d874cb8e3b9a18087554544fa@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 06:34:40PM -0700, Sodagudi Prasad wrote:
> Due to cross migration of tasks between cpu7 and cpu3, migration/7 has
> started executing and waits for the migration/3 task, so that they can
> proceed within the multi cpu stop state machine together.
> Unfortunately stress-ng-affin is affine to cpu7, and since migration 7 has
> started running, and has monopolized cpu7’s execution, stress-ng will never
> run on cpu7, and cpu3’s migration task is never woken up.

> diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
> index e190d1e..f932e1e 100644
> --- a/kernel/stop_machine.c
> +++ b/kernel/stop_machine.c
> @@ -87,9 +87,9 @@ static bool cpu_stop_queue_work(unsigned int cpu, struct
> cpu_stop_work *work)
>                 __cpu_stop_queue_work(stopper, work, &wakeq);
>         else if (work->done)
>                 cpu_stop_signal_done(work->done);
> -       raw_spin_unlock_irqrestore(&stopper->lock, flags);
> 
>         wake_up_q(&wakeq);
> +       raw_spin_unlock_irqrestore(&stopper->lock, flags);
> 

So why didn't you do the 'obvious' parallel to what you did for
cpu_stop_queue_two_works(), namely:

--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -81,6 +81,7 @@ static bool cpu_stop_queue_work(unsigned
 	unsigned long flags;
 	bool enabled;
 
+	preempt_disable();
 	raw_spin_lock_irqsave(&stopper->lock, flags);
 	enabled = stopper->enabled;
 	if (enabled)
@@ -90,6 +91,7 @@ static bool cpu_stop_queue_work(unsigned
 	raw_spin_unlock_irqrestore(&stopper->lock, flags);
 
 	wake_up_q(&wakeq);
+	preempt_enable();
 
 	return enabled;
 }
