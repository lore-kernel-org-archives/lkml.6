Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C67C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6A920851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6A920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbeLLXjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:39:06 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41746 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbeLLXjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 18:39:05 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A0A50F1E;
        Wed, 12 Dec 2018 23:39:03 +0000 (UTC)
Date:   Wed, 12 Dec 2018 15:39:01 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH] debugobjects: Move printk out of db lock critical
 sections
Message-Id: <20181212153901.4e9c142cf2d6a75373d28368@linux-foundation.org>
In-Reply-To: <1544653694-27873-1-git-send-email-longman@redhat.com>
References: <1544653694-27873-1-git-send-email-longman@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018 17:28:14 -0500 Waiman Long <longman@redhat.com> wrote:

> The db->lock is a raw spinlock and so the lock hold time is supposed
> to be short. This will not be the case when printk() is being involved
> in some of the critical sections. In order to avoid the long hold time,
> in case some messages need to be printed, the debug_object_is_on_stack()
> and debug_print_object() calls are now moved out of those critical
> sections.
> 
> Holding the db->lock while calling printk() may lead to deadlock if
> printk() somehow requires the allocation/freeing of debug object that
> happens to be in the same hash bucket or a circular lock dependency
> warning from lockdep as reported in https://lkml.org/lkml/2018/12/11/143.
> 
> [   87.209665] WARNING: possible circular locking dependency detected
> [   87.210547] 4.20.0-rc4-00057-gc96cf92 #1 Tainted: G        W
> [   87.211449] ------------------------------------------------------
> [   87.212405] getty/519 is trying to acquire lock:
> [   87.213074] (____ptrval____) (&obj_hash[i].lock){-.-.}, at: debug_check_no_obj_freed+0xb4/0x302
> [   87.214343]
> [   87.214343] but task is already holding lock:
> [   87.215174] (____ptrval____) (&port_lock_key){-.-.}, at: uart_shutdown+0x3a3/0x4e2
> [   87.216260]
> [   87.216260] which lock already depends on the new lock.
> 
> This patch was also found to be able to fix a boot hanging problem
> when the initramfs image was switched on after a debugobjects splat
> from the EFI code.

Patch looks sensible, but I have a nit about the variable names.

> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -375,6 +375,8 @@ static void debug_object_is_on_stack(void *addr, int onstack)
>  	struct debug_bucket *db;
>  	struct debug_obj *obj;
>  	unsigned long flags;
> +	bool debug_printobj = false;

"debug_printobject" would be better, but this code already intermingles
"obj" and "object".

> +	bool debug_chkstack = false;

Not so good.  Is it debug_chkstack or debug_checkstk or ...

This file uses "check" consistently so let's not depart from that? 
Linux style is to avoid these tricky little abbreviations and to use
full words.  

ie, debug_checkstack, please.  Better would be debug_check_stack.  Or
simply check_stack: the "debug" doesn't add anything useful.


