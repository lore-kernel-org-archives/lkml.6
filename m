Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934515AbeCEL0y (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 06:26:54 -0500
Received: from mail-ot0-f181.google.com ([74.125.82.181]:34607 "EHLO
        mail-ot0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932797AbeCEL0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 06:26:52 -0500
X-Google-Smtp-Source: AG47ELvNDUKNbNQ7V1reb+N/T9RIJehj4Dcf2y8YBXvviWUL0yXqlxKyQcVzFc6wMFRHsZHNlC0IrPCmSKENUMwg46o=
MIME-Version: 1.0
In-Reply-To: <20180305104446.GN25201@hirez.programming.kicks-ass.net>
References: <1657351.s4RTvEoqBQ@aspire.rjw.lan> <46071692.o1R0bjyNQV@aspire.rjw.lan>
 <20180305104446.GN25201@hirez.programming.kicks-ass.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 5 Mar 2018 12:26:50 +0100
X-Google-Sender-Auth: 9u4YWH2UXwBzgGNSHEWxbvXZD7g
Message-ID: <CAJZ5v0hMgdvoZdBwyCXSf--Cy1-20qXDscNKGmfsyeVi8HVevw@mail.gmail.com>
Subject: Re: [RFC/RFT][PATCH 1/7] time: tick-sched: Reorganize idle tick
 management code
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 5, 2018 at 11:44 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Sun, Mar 04, 2018 at 11:24:00PM +0100, Rafael J. Wysocki wrote:
>> +/**
>> + * tick_nohz_idle_prepare - prepare for entering idle on the current CPU.
>> + *
>> + * Called when we start the idle loop.
>> + */
>> +void tick_nohz_idle_prepare(void)
>> +{
>> +     __tick_nohz_idle_prepare();
>> +
>> +     local_irq_enable();
>> +}
>
> I really dislike the asymmetry in IRQ state you introduced here.
> __tick_nohz_idle_prepare() disables IRQs. Must we do that?

Not really, but at the cost of a tiny bit of duplicated code.
