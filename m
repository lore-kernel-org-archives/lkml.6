Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27327C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D993C21537
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D993C21537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732581AbeHOBve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 21:51:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55546 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729705AbeHOBve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 21:51:34 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D4D7FD00;
        Tue, 14 Aug 2018 23:02:09 +0000 (UTC)
Date:   Tue, 14 Aug 2018 16:02:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Build failures with gcc 4.5 and older
Message-Id: <20180814160208.4f4dd7ca142912f5894ddddd@linux-foundation.org>
In-Reply-To: <20180814221559.GA15888@roeck-us.net>
References: <20180814170904.GA12768@roeck-us.net>
        <20180814143655.3acd4bb211d44747f77e74f2@linux-foundation.org>
        <20180814221559.GA15888@roeck-us.net>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2018 15:15:59 -0700 Guenter Roeck <linux@roeck-us.net> wrote:

> > Confused.  Why does it think that the mm_struct is "otherwise empty"?
> > 
> 
> The problem isn't really that the structure is otherwise empty.
> Some digging reveals that the error message is wrong; gcc should
> instead complain about having no _named_ structure element before
> the flexible array member.
> 
> > This shuts it up:
> > 
> > --- a/include/linux/mm_types.h~a
> > +++ a/include/linux/mm_types.h
> > @@ -490,6 +490,7 @@ struct mm_struct {
> >  #endif
> >  	} __randomize_layout;
> >  
> > +	int wibble;
> >  	/*
> >  	 * The mm_cpumask needs to be at the end of mm_struct, because it
> >  	 * is dynamically sized based on nr_cpu_ids.
> > 
> 
> Unfortunately, that only triggers secondary errors.
> Seen with both gcc 4.4 and 4.5.
> 
> mm/init-mm.c:29: error: unknown field ‘mm_rb’ specified in initializer
> mm/init-mm.c:29: warning: missing braces around initializer
> mm/init-mm.c:29: warning: (near initialization for ‘init_mm.<anonymous>’)
> mm/init-mm.c:29: error: incompatible types when initializing type ‘struct
> vm_area_struct *’ using type ‘struct rb_root’
> mm/init-mm.c:30: error: unknown field ‘pgd’ specified in initializer
> 
> and many more similar errors.

This works, I think.

The m68k build still fails because 0cc3cd21657 ("cpu/hotplug: Boot HT
siblings at least once") was evidently never tested on CONFIG_SMP=n. 
How could that come about - the patch is six weeks old??

kernel/cpu.c: In function 'boot_cpu_hotplug_init':
kernel/cpu.c:2275:2: error: 'struct cpuhp_cpu_state' has no member named 'booted_once'


--- a/include/linux/mm_types.h~a
+++ a/include/linux/mm_types.h
@@ -490,6 +490,8 @@ struct mm_struct {
 #endif
 	} __randomize_layout;
 
+	int wibble;
+
 	/*
 	 * The mm_cpumask needs to be at the end of mm_struct, because it
 	 * is dynamically sized based on nr_cpu_ids.
--- a/mm/init-mm.c~a
+++ a/mm/init-mm.c
@@ -26,15 +26,17 @@
  * and size this cpu_bitmask to NR_CPUS.
  */
 struct mm_struct init_mm = {
-	.mm_rb		= RB_ROOT,
-	.pgd		= swapper_pg_dir,
-	.mm_users	= ATOMIC_INIT(2),
-	.mm_count	= ATOMIC_INIT(1),
-	.mmap_sem	= __RWSEM_INITIALIZER(init_mm.mmap_sem),
-	.page_table_lock =  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
-	.arg_lock	=  __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
-	.mmlist		= LIST_HEAD_INIT(init_mm.mmlist),
-	.user_ns	= &init_user_ns,
+	{
+		.mm_rb		= RB_ROOT,
+		.pgd		= swapper_pg_dir,
+		.mm_users	= ATOMIC_INIT(2),
+		.mm_count	= ATOMIC_INIT(1),
+		.mmap_sem	= __RWSEM_INITIALIZER(init_mm.mmap_sem),
+		.page_table_lock = __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
+		.arg_lock	= __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
+		.mmlist		= LIST_HEAD_INIT(init_mm.mmlist),
+		.user_ns	= &init_user_ns,
+	},
 	.cpu_bitmap	= { [BITS_TO_LONGS(NR_CPUS)] = 0},
 	INIT_MM_CONTEXT(init_mm)
 };
_

