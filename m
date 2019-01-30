Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8DBC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BBA6218A3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731039AbfA3NY1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:24:27 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:47165 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfA3NY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:24:27 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gopqm-0000vI-L6; Wed, 30 Jan 2019 14:24:20 +0100
Date:   Wed, 30 Jan 2019 14:24:20 +0100
From:   Sebastian Sewior <bigeasy@linutronix.de>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org,
        Stefan Liebler <stli@linux.ibm.com>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggered
Message-ID: <20190130132420.spwrq2d4oxeydk5s@linutronix.de>
References: <alpine.DEB.2.21.1901291012330.1669@nanos.tec.linutronix.de>
 <20190129102409.GB26906@osiris>
 <20190129103557.GF28485@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1901291402410.1513@nanos.tec.linutronix.de>
 <20190129132303.GE26906@osiris>
 <20190129151058.GG26906@osiris>
 <20190129171653.ycl64psq2liy5o5c@linutronix.de>
 <20190130094913.GC5299@osiris>
 <alpine.DEB.2.21.1901301303320.5537@nanos.tec.linutronix.de>
 <20190130125955.GD5299@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190130125955.GD5299@osiris>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-30 13:59:55 [+0100], Heiko Carstens wrote:
> Last lines of trace below (full log attached):

            <...>-56956 [005] ....   658.931364: handle_futex_death: uaddr: 3ff9e880c58 pi: 1
…
            <...>-56956 [005] ....   658.931369: handle_futex_death: uaddr: 3ff9e8808c0 success
            <...>-56956 [005] ....   658.931370: sched_process_exit: comm=ld64.so.1 pid=56956 prio=120

not including 3ff9e880140

            <...>-56956 [005] ....   658.931370: sched_process_exit: comm=ld64.so.1 pid=56956 prio=120

            <...>-56496 [001] ....   658.932404: sys_futex(uaddr: 3ff9e880140, op: 6, val: 1, utime: 0, uaddr2: 5, val3: 0)
            <...>-56496 [001] ....   658.932405: attach_to_pi_owner: Missing pid 56956
            <...>-56496 [001] ....   658.932406: handle_exit_race: uval2 vs uval 8000de7c vs 8000de7c (-1)
            <...>-56496 [001] ....   658.932501: sys_futex -> 0xfffffffffffffffd
…
            <...>-56496 [001] ....   659.020750: handle_futex_death: uaddr: 3ff9e880140 pi: 1
            <...>-56496 [001] ....   659.020750: handle_futex_death: uaddr: 3ff9e880140 uval: 8000de7c
            <...>-56496 [001] ....   659.020750: handle_futex_death: uaddr: 3ff9e880140 success

and here we have it.

Sebastian
