Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752882AbeCOUsF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 16:48:05 -0400
Received: from mail.efficios.com ([167.114.142.138]:42564 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752372AbeCOUsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 16:48:02 -0400
Date: Thu, 15 Mar 2018 16:48:01 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Oleg Nesterov <oleg@redhat.com>, Erica Bugden <ebugden@efficios.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <670124481.11073.1521146881571.JavaMail.zimbra@efficios.com>
Subject: uprobes misses breakpoint insertion into VM_WRITE mappings
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.6_GA_1906 (ZimbraWebClient - FF52 (Linux)/8.8.6_GA_1906)
Thread-Index: xnJUOONLk7g838+VaI6/G9W0lZoLCA==
Thread-Topic: uprobes misses breakpoint insertion into VM_WRITE mappings
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Erica has been working on extending test-cases for uprobes, and found
something unexpected:

Since commit e40cfce626a5 "uprobes: Restrict valid_vma(false) to skip VM_SHARED vmas"
uprobes does not insert breakpoints into mappings mprotect'd as writeable.

This issue can be reproduced by compiling a library without PIC (not using GOT),
and then concurrently:

A) Load the library (dynamic loader mprotect the code as writeable to do
   the relocations, and then mprotect as executable),

B) Enable a uprobe through perf.

(it is a race window between the two mprotect syscalls)

It appears that the following restriction in valid_vma() is responsible
for this behavior:

        if (is_register)
                flags |= VM_WRITE;

I don't figure a clear explanation for this flag based on the function
comment nor the commit changelog. Any idea on whether this is really
needed ?

Note that on uprobes unregister, it allows removing a breakpoint event
on a writeable mapping, so there is clearly a discrepancy between the
level of paranoia associated with registration and unregistration.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
