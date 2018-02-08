Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751834AbeBHKNT convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 05:13:19 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:51043 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750929AbeBHKNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 05:13:17 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Jia-Ju Bai" <baijiaju1990@gmail.com>
From: Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <1808276.ZJn2ZeULZY@aspire.rjw.lan>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1516875222-12293-1-git-send-email-baijiaju1990@gmail.com>
 <1808276.ZJn2ZeULZY@aspire.rjw.lan>
Message-ID: <151808479008.28809.166946118004484639@mail.alporthouse.com>
User-Agent: alot/0.3.6
Subject: Re: [PATCH] acpi: osl: Replace GFP_ATOMIC with GFP_KERNEL in acpi_os_execute
Date: Thu, 08 Feb 2018 10:13:10 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rafael J. Wysocki (2018-02-08 09:51:41)
> On Thursday, January 25, 2018 11:13:41 AM CET Jia-Ju Bai wrote:
> > After checking all possible call chains to acpi_os_execute here,
> > my tool finds that acpi_os_execute is never called in atomic context.
> > And acpi_os_execute calls acpi_debugger_create_thread 
> > which calls mutex_lock,
> > thus it proves again that acpi_os_execute can 
> > call functions which may sleep.
> > Thus GFP_ATOMIC is not necessary, and it can be replaced with GFP_KERNEL.
> > 
> > This is found by a static analysis tool named DCNS written by myself.
> > 
> > Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> > ---
> >  drivers/acpi/osl.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> > index 3bb46cb..8ee605e 100644
> > --- a/drivers/acpi/osl.c
> > +++ b/drivers/acpi/osl.c
> > @@ -1066,7 +1066,7 @@ acpi_status acpi_os_execute(acpi_execute_type type,
> >        * having a static work_struct.
> >        */
> >  
> > -     dpc = kzalloc(sizeof(struct acpi_os_dpc), GFP_ATOMIC);
> > +     dpc = kzalloc(sizeof(struct acpi_os_dpc), GFP_KERNEL);
> >       if (!dpc)
> >               return AE_NO_MEMORY;
> >  
> > 
> 
> Applied, thanks!

Hmm, not this patch per se, but 

https://intel-gfx-ci.01.org/tree/next/next-20180207/fi-bxt-dsi/dmesg0.log
[  111.378236] BUG: sleeping function called from invalid context at mm/slab.h:420
[  111.378259] in_atomic(): 1, irqs_disabled(): 1, pid: 1701, name: gem_exec_flush
[  111.378275] INFO: lockdep is turned off.
[  111.378277] irq event stamp: 0
[  111.378280] hardirqs last  enabled at (0): [<          (null)>]           (null)
[  111.378286] hardirqs last disabled at (0): [<00000000a01fa473>] copy_process.part.7+0x2f1/0x1db0
[  111.378290] softirqs last  enabled at (0): [<00000000a01fa473>] copy_process.part.7+0x2f1/0x1db0
[  111.378292] softirqs last disabled at (0): [<          (null)>]           (null)
[  111.378293] Preemption disabled at:
[  111.378298] [<ffffffffa18f14f6>] __mutex_lock+0x56/0x9b0
[  111.378311] CPU: 1 PID: 1701 Comm: gem_exec_flush Tainted: G     U  W        4.15.0-next-20180207-g5d1c98967100-next-20180207 #1
[  111.378313] Hardware name: Intel Corp. Broxton P/Apollolake RVP1A, BIOS APLKRVPA.X64.0150.B11.1608081044 08/08/2016
[  111.378314] Call Trace:
[  111.378318]  <IRQ>
[  111.378323]  dump_stack+0x5f/0x86
[  111.378328]  ___might_sleep+0x1d9/0x240
[  111.378334]  ? acpi_os_execute+0x2d/0x130
[  111.378338]  kmem_cache_alloc_trace+0x1ae/0x2b0
[  111.378344]  ? acpi_ev_asynch_enable_gpe+0x2d/0x2d
[  111.378347]  acpi_os_execute+0x2d/0x130
[  111.378351]  acpi_ev_gpe_dispatch+0xd7/0x120
[  111.378355]  acpi_ev_gpe_detect+0x156/0x195
[  111.378362]  acpi_ev_sci_xrupt_handler+0x16/0x28
[  111.378365]  acpi_irq+0xd/0x30
[  111.378369]  __handle_irq_event_percpu+0x3c/0x340
[  111.378374]  handle_irq_event_percpu+0x1b/0x50
[  111.378378]  handle_irq_event+0x2f/0x50
[  111.378381]  handle_fasteoi_irq+0x93/0x150
[  111.378386]  handle_irq+0x11/0x20
[  111.378390]  do_IRQ+0x5e/0x120
[  111.378395]  common_interrupt+0xbb/0xbb
[  111.378397]  </IRQ>

does tell us that acpi_os_execute() is called in irq context.
-Chris
