Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E6CC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8F1255DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB8F1255DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754423AbeFYI2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:28:34 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:57531 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753154AbeFYI2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:28:32 -0400
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.51 with ESMTP; 25 Jun 2018 17:28:31 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.121 with ESMTP; 25 Jun 2018 17:28:30 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Mon, 25 Jun 2018 17:28:24 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Byungchul Park <max.byungchul.park@gmail.com>,
        jiangshanlai@gmail.com, josh@joshtriplett.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, kernel-team@lge.com, luto@kernel.org
Subject: Re: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct
 rcu_dynticks
Message-ID: <20180625082824.GB21377@X58A-UD3R>
References: <1529484440-20634-1-git-send-email-byungchul.park@lge.com>
 <1529484440-20634-2-git-send-email-byungchul.park@lge.com>
 <20180620145814.GQ3593@linux.vnet.ibm.com>
 <CANrsvRMYc5u3L53nnnGC6p-QcjBTfLPjkJGZyubGWAPauc-W8w@mail.gmail.com>
 <20180620164902.GW3593@linux.vnet.ibm.com>
 <20180622055659.GA255098@joelaf.mtv.corp.google.com>
 <20180622132843.GN3593@linux.vnet.ibm.com>
 <20180622181916.GA13628@joelaf.mtv.corp.google.com>
 <20180622143247.781028b1@gandalf.local.home>
 <20180622200548.GA114655@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622200548.GA114655@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 01:05:48PM -0700, Joel Fernandes wrote:
> On Fri, Jun 22, 2018 at 02:32:47PM -0400, Steven Rostedt wrote:
> > On Fri, 22 Jun 2018 11:19:16 -0700
> > Joel Fernandes <joel@joelfernandes.org> wrote:
> > 
> > > Sure. So in a later thread you mentioned "usermode helpers". I took a closer
> > > look at that subsystem, and it seems you can execute usermode helpers from
> > > atomic sections with help of UMH_NO_WAIT flag.
> > > 
> > > Then I checked where this flag is used and it turns out its from the
> > > mce_work_trigger function in x86/kernel/cpu/mcheck/dev-mcelog.c which can be
> > > called infact from an interrupt context (mce_notify_irq).
> > > 
> > > Is this the usecase you remember causing this weird transitions to userspace?
> > 
> > But this case still looks like it uses work queues, it just doesn't
> > wait for the result.
> > 
> > I'll have to look at the code from what it looked like back in 2011, to
> > see if there was an actual issue here back then.
> 
> Good point Steve. So I guess in the current kernel sources, there's no code
> that uses UMH in IRQ context AFAICT. I'll go through the google group thread
> Paul pointed as well to study the history of the problem a bit more.

Me too. Good discussion we had thanks to you, Joel.

> thanks,
> 
> - Joel
