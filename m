Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5686C46462
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A421F208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A421F208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732313AbeGaRD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:03:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36341 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726789AbeGaRD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:03:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 84DBC8197006;
        Tue, 31 Jul 2018 15:23:09 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 732932026D68;
        Tue, 31 Jul 2018 15:23:09 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w6VFN9Gi024289;
        Tue, 31 Jul 2018 11:23:09 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w6VFN7HI024285;
        Tue, 31 Jul 2018 11:23:08 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 31 Jul 2018 11:23:07 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
cc:     Dave Airlie <airlied@redhat.com>,
        Bernie Thompson <bernie@plugable.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: Sleeping from invalid context in udlfb
In-Reply-To: <alpine.LRH.2.02.1807300552140.2919@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.LRH.2.02.1807311111520.22145@file01.intranet.prod.int.rdu2.redhat.com>
References: <CGME20180603154636epcas2p4812a1f19c6ae236336ae580658edb167@epcas2p4.samsung.com> <6008699.T6Yd1fn3Dk@amdc3058> <alpine.LRH.2.02.1807092148080.30863@file01.intranet.prod.int.rdu2.redhat.com> <1975707.vO8kdHz3oS@amdc3058>
 <alpine.LRH.2.02.1807300552140.2919@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 31 Jul 2018 15:23:09 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 31 Jul 2018 15:23:09 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BTW when using the udlfb driver as a console, I've got this warning. 
vt_console_print takes a spinlock and then calls the framebuffer driver 
that sleeps.

The question is - whose fault is this? Could the console code somehow be 
told to print characters without holding a spinlock? Or does it mean that 
framebuffer drivers can't sleep?

udlfb communicates through USB, so the sleeping is inevitable.

Mikulas


BUG: sleeping function called from invalid context at mm/slab.h:421
in_atomic(): 1, irqs_disabled(): 0, pid: 430, name: kworker/2:3
6 locks held by kworker/2:3/430:
 #0: 000000001301127e ( (wq_completion)"events"){....} , at: process_one_work+0x17c/0x3a8
 #1: 00000000beacc951 ( (work_completion)(&(&dlfb->init_framebuffer_work)->work)){....} , at: process_one_work+0x17c/0x3a8
 #2: 00000000a402f826 ( registration_lock){....} , at: register_framebuffer+0x28/0x2c0 [fb]
 #3: 0000000021cbe902 ( console_lock){....} , at: register_framebuffer+0x258/0x2c0 [fb]
 #4: 0000000096d51735 ( console_owner){....} , at: console_unlock+0x174/0x500
 #5: 00000000faa7f206 ( printing_lock){....} , at: vt_console_print+0x60/0x3a0
Preemption disabled at: [<ffffff8008403130>] vt_console_print+0x60/0x3a0
CPU: 2 PID: 430 Comm: kworker/2:3 Not tainted 4.17.10-debug #3
Hardware name: Marvell Armada 8040 MacchiatoBin/Armada 8040 MacchiatoBin, BIOS EDK II Jul 30 2018
Workqueue: events dlfb_init_framebuffer_work [udlfb]
Call trace:
 dump_backtrace+0x0/0x150
 show_stack+0x14/0x20
 dump_stack+0x8c/0xac
 ___might_sleep+0x140/0x170
 __might_sleep+0x50/0x88
 __kmalloc+0x1b0/0x270
 xhci_urb_enqueue+0xa8/0x460 [xhci_hcd]
 usb_hcd_submit_urb+0xc0/0x998 [usbcore]
 usb_submit_urb+0x1e0/0x518 [usbcore]
 dlfb_submit_urb+0x38/0x98 [udlfb]
 dlfb_handle_damage.isra.4+0x1e0/0x210 [udlfb]
 dlfb_ops_imageblit+0x28/0x38 [udlfb]
 soft_cursor+0x15c/0x1d8 [fb]
 bit_cursor+0x324/0x510 [fb]
 fbcon_cursor+0x144/0x1a0 [fb]
 hide_cursor+0x38/0xa0
 vt_console_print+0x334/0x3a0
 console_unlock+0x274/0x500
 register_framebuffer+0x22c/0x2c0 [fb]
 dlfb_init_framebuffer_work+0x1ec/0x2fc [udlfb]
 process_one_work+0x1e8/0x3a8
 worker_thread+0x44/0x418
 kthread+0x11c/0x120
 ret_from_fork+0x10/0x18

