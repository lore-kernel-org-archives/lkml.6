Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC5AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD7D21479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD7D21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=santannapisa.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbeJJS4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 14:56:12 -0400
Received: from mail.santannapisa.it ([193.205.80.99]:33731 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeJJS4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 14:56:11 -0400
Received: from [10.30.3.207] (account l.abeni@santannapisa.it HELO luca64)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 133568996; Wed, 10 Oct 2018 12:34:24 +0200
Date:   Wed, 10 Oct 2018 12:34:17 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFD/RFC PATCH 0/8] Towards implementing proxy execution
Message-ID: <20181010123417.26c682ef@luca64>
In-Reply-To: <20181009092434.26221-1-juri.lelli@redhat.com>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
Organization: Scuola Superiore S. Anna
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Tue,  9 Oct 2018 11:24:26 +0200
Juri Lelli <juri.lelli@redhat.com> wrote:

> Hi all,
> 
> Proxy Execution (also goes under several other names) isn't a new
> concept, it has been mentioned already in the past to this community
> (both in email discussions and at conferences [1, 2]), but no actual
> implementation that applies to a fairly recent kernel exists as of
> today (of which I'm aware of at least - happy to be proven wrong).
> 
> Very broadly speaking, more info below, proxy execution enables a task
> to run using the context of some other task that is "willing" to
> participate in the mechanism, as this helps both tasks to improve
> performance (w.r.t. the latter task not participating to proxy
> execution).

First of all, thanks to Juri for working on this!

I am looking at the patchset, and I have some questions / comments
(maybe some of my questions are really stupid, I do not know... :)


To begin, I have a very high-level comment about proxy execution: I
believe proxy execution is a very powerful concept, that can be used in
many cases, not only to do inheritance on mutual exclusion (think, for
example, about pipelines of tasks: a task implementing a stage of the
pipeline can act as a proxy for the task implementing the previous
stage).

So, I would propose to make the proxy() function of patch more generic,
and not strictly bound to mutexes. Maybe a task structure can contain a
list of tasks for which the task can act as a proxy, and we can have a
function like "I want to act as a proxy for task T" to be invoked when
a task blocks?



			Luca
