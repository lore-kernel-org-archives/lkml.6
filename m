Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AE1C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821D12456B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 821D12456B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754318AbeFVQBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:01:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754129AbeFVQBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:01:52 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F3FC24555;
        Fri, 22 Jun 2018 16:01:51 +0000 (UTC)
Date:   Fri, 22 Jun 2018 12:01:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Byungchul Park <max.byungchul.park@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        jiangshanlai@gmail.com, josh@joshtriplett.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, kernel-team@lge.com, luto@kernel.org
Subject: Re: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct
 rcu_dynticks
Message-ID: <20180622120149.7d5396d5@gandalf.local.home>
In-Reply-To: <20180622132843.GN3593@linux.vnet.ibm.com>
References: <1529484440-20634-1-git-send-email-byungchul.park@lge.com>
        <1529484440-20634-2-git-send-email-byungchul.park@lge.com>
        <20180620145814.GQ3593@linux.vnet.ibm.com>
        <CANrsvRMYc5u3L53nnnGC6p-QcjBTfLPjkJGZyubGWAPauc-W8w@mail.gmail.com>
        <20180620164902.GW3593@linux.vnet.ibm.com>
        <20180622055659.GA255098@joelaf.mtv.corp.google.com>
        <20180622132843.GN3593@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018 06:28:43 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> It has been some years since I traced the code flow, but what happened
> back then is that it switches itself from an interrupt handler to not
> without actually returning from the interrupt.  This can only happen when
> interrupting a non-idle process, thankfully, and RCU's dyntick-idle code
> relies on this restriction.  If I remember correctly, the code ends up
> executing in the context of the interrupted process, but it has been some
> years, so please apply appropriate skepticism.

If irq_enter() is not paired with irq_exit() then major things will
break. Especially since that's how in_interrupt() and friends rely on to
work.

Now, perhaps rcu_irq_enter() is called elsewhere (as a git grep appears
it may be), and that rcu_irq_enter() may not be paired with
rcu_irq_exit(). But that's not anything to do with the irq_enter() and
irq_exit() routines being paired or not.

-- Steve
