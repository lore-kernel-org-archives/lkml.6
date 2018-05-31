Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754198AbeEaJJR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 05:09:17 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45883 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754026AbeEaJJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 05:09:12 -0400
X-Google-Smtp-Source: ADUXVKJUK2+z6AhnzH2k1GSsSTWLwqQnNV+GDuM7wwPLr4W5fWkZJM8ZdnEX7BTC8N2MF4NgsxfYJw==
To: bhelgaas@google.com, pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, Al Viro <viro@zeniv.linux.org.uk>,
        Greg KH <gregkh@linuxfoundation.org>, corbet@lwn.net,
        Linus Torvalds <torvalds@linux-foundation.org>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: Can printk() sleep at runtime?
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <ba98332d-7013-f5cb-7d49-645ee6f49156@gmail.com>
Date: Thu, 31 May 2018 17:08:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I write a static analysis tool (DSAC), and it finds that printk can sleep.
According to this finding, there is an example bug in drivers/pci/pci.c 
in Linux-4.16.7.

Here is the call path for this bug.
Please look at it *from the bottom up*.

========== BUG ==========
[FUNC] __might_sleep
kernel/locking/mutex.c: 747: __might_sleep in __mutex_lock_common
kernel/locking/mutex.c: 893: __mutex_lock_common in __mutex_lock
kernel/locking/mutex.c: 908: __mutex_lock in mutex_lock_nested
drivers/clk/clk.c, 123: mutex_lock_nested in clk_prepare_lock
drivers/clk/clk.c, 1369: clk_prepare_lock in clk_core_get_rate
drivers/clk/clk.c, 1393: clk_core_get_rate in clk_get_rate
lib/vsprintf.c, 1450: clk_get_rate in clock
lib/vsprintf.c, 1944: clock in pointer
lib/vsprintf.c, 2286: pointer in vsnprintf
lib/vsprintf.c, 2385: vsnprintf in vscnprintf
kernel/printk/printk.c, 1853: vscnprintf in vprintk_emit
kernel/printk/printk.c, 1947: vprintk_emit in vprintk_default
kernel/printk/printk_safe.c, 379: vprintk_default in vprintk_func
kernel/printk/printk.c, 1980: vprintk_func in printk
drivers/pci/pci.c, 5364: printk in pci_specified_resource_alignment
drivers/pci/pci.c, 5313: spin_lock in pci_specified_resource_alignment

In fact, I suspect that my report is false, because I always have an 
impression that printk() cannot sleep.
But according to the call path, I cannot find where I make the mistake...

So could someone please help me to point the mistake?


Best wishes,
Jia-Ju Bai
