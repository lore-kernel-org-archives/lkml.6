Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751572AbeEDQUY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 12:20:24 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:45278 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751419AbeEDQUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 12:20:23 -0400
X-Google-Smtp-Source: AB8JxZomyD1OlACNsYflzpzGbOss2eMFGVLMa57qGE5vN0nvP3ypQ7D2OAooldDxjVlI0kHycGwyfitf/RU7VC95N90=
MIME-Version: 1.0
From: Joel Fernandes <joelaf@google.com>
Date: Fri, 04 May 2018 16:20:11 +0000
Message-ID: <CAJWu+oqCun1Ae6GqPxnS+eCDi3jadGPp+MO8TjOWgs+AiAh79A@mail.gmail.com>
Subject: rcu-bh design
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul, everyone,

I had some question(s) about rcu-bh design.
I am trying to understand the reasoning or need of it. I see that rcu-bh
will disable softirqs across read-side sections. But I am wondering why
this is needed. __do_softirq already disables softirq when a softirq
handler is running. The only reason I can see is, rcu-bh helps in
situations where - a softirq interrupts a preemptible RCU read-section and
prevents that read section from completing. But this problem would happen
if anyone where to use rcu-preempt - then does rcu-preempt even make sense
to use and shouldn't everyone be using rcu-bh?

The other usecase for rcu-bh seems to be if context-switch is used as a
quiescent state, then softirq flood can prevent that from happening and
cause rcu grace periods from completing. But preemptible RCU *does not* use
context-switch as a quiescent state. So in that case rcu-bh would make
sense only in a configuration where we're not using preemptible-rcu at all
and are getting flooded by softirqs. Is that the reason rcu-bh needs to
exist?

thanks!

- Joel
