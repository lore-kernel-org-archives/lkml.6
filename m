Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoYVEIX3G6oYXqCLxELAzG1cQOqU9rp3gZTcyp1mVzhnAXy8xymf73ztldsEKmGmKeYjSR4
ARC-Seal: i=1; a=rsa-sha256; t=1524838122; cv=none;
        d=google.com; s=arc-20160816;
        b=I9dp8qyv49w3SehVz6MOyBfbKeoRphQOWFcbea2vbG4+mBnog9B/04EzrO6DZkHfKD
         fANZx/C09Exciov0dI+PCC78ax86uzID1O6e2mb6u+ikZOGEUTSWQ/PrWlZyFcNbWkVz
         ulGrqe3RsqWyfQHnqQXPf0nvKZtUi4XRjfLIBdsSWaRzSirdilyE+9AkPL9vbAFIfaLV
         /z1jAjjE0sWsMhAgCDjSOsB4QGDjq8MPj3UYtghPs/72qCKKLNHhHaJhwYsrzB1J/Ybl
         2CtWYuSmKj2ObgAL1+c6fI3tI07Xa3xDymfZVq0q5we+u5V3UTMX1arwQjUwVJ79gDhn
         u0jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=f07VLLs2pazTIJmYwOPBmCVIkYt0cSv1OZltV7ZF2fc=;
        b=TVm0xax8qjVabHBkNJXkrEs2z/QHWA6+Jrv2dgT6QBqRM+MqbesBqGSC3gVwqUgt+A
         //mvGF2HMmjiZLfTQQ5kRQXRexEaGnP+G13NIgGTvTgnMu95D7jpbjG1qb5ltkoVbwXM
         4eHSpG7PX0Wmc8RbcMmqiiPfH8FTuDgeD747igFxRkZM4RlqS9HLQtj/DRdyIW9N88d+
         7O0ophjF/j16CH9En5dntUrwRf7A/cpLRVux9UaMZnGTy61hhBxuyK67axQxxYc20z6V
         wPimzsqhp9heetqehR5cDPdQPnGobMdo/HD57gJjpw9olbNNkfNRHH3ayTUEiaDrXexx
         jTrA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5580221864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Laurent Vivier <lvivier@redhat.com>,
	Stan Johnson <userm57@yahoo.com>,
	Finn Thain <fthain@telegraphics.com.au>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 68/80] m68k/mac: Dont remap SWIM MMIO region
Date: Fri, 27 Apr 2018 15:59:01 +0200
Message-Id: <20180427135736.409564645@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908658841542656?=
X-GMAIL-MSGID: =?utf-8?q?1598908658841542656?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Finn Thain <fthain@telegraphics.com.au>

commit b64576cbf36afa5fabf3b31f62a1994c429ef855 upstream.

For reasons I don't understand, calling ioremap() then iounmap() on
the SWIM MMIO region causes a hang on 68030 (but not on 68040).

~# modprobe swim_mod
SWIM floppy driver Version 0.2 (2008-10-30)
SWIM device not found !
watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [modprobe:285]
Modules linked in: swim_mod(+)
Format 00  Vector: 0064  PC: 000075aa  Status: 2000    Not tainted
ORIG_D0: ffffffff  D0: d00c0000  A2: 007c2370  A1: 003f810c
A0: 00040000  D5: d0096800  D4: d0097e00
D3: 00000001  D2: 00000003  D1: 00000000
Non-Maskable Interrupt
Modules linked in: swim_mod(+)
PC: [<000075ba>] __iounmap+0x24/0x10e
SR: 2000  SP: 007abc48  a2: 007c2370
d0: d00c0000    d1: 000001a0    d2: 00000019    d3: 00000001
d4: d0097e00    d5: d0096800    a0: 00040000    a1: 003f810c
Process modprobe (pid: 285, task=007c2370)
Frame format=0
Stack from 007abc7c:
        ffffffed 00000000 006a4060 004712e0 007abca0 000076ea d0080000 00080000
        010bb4b8 007abcd8 010ba542 d0096000 00000000 00000000 00000001 010bb59c
        00000000 007abf30 010bb4b8 0047760a 0047763c 00477612 00616540 007abcec
        0020a91a 00477600 0047760a 010bb4cc 007abd18 002092f2 0047760a 00333b06
        007abd5c 00000000 0047760a 010bb4cc 00404f90 004776b8 00000001 007abd38
        00209446 010bb4cc 0047760a 010bb4cc 0020938e 0031f8be 00616540 007abd64
Call Trace: [<000076ea>] iounmap+0x46/0x5a
 [<00080000>] shrink_page_list+0x7f6/0xe06
 [<010ba542>] swim_probe+0xe4/0x496 [swim_mod]
 [<0020a91a>] platform_drv_probe+0x20/0x5e
 [<002092f2>] driver_probe_device+0x21c/0x2b8
 [<00333b06>] mutex_lock+0x0/0x2e
 [<00209446>] __driver_attach+0xb8/0xce
 [<0020938e>] __driver_attach+0x0/0xce
 [<0031f8be>] klist_next+0x0/0xa0
 [<00207562>] bus_for_each_dev+0x74/0xba
 [<000344c0>] blocking_notifier_call_chain+0x0/0x20
 [<00333b06>] mutex_lock+0x0/0x2e
 [<00208e44>] driver_attach+0x1a/0x1e
 [<0020938e>] __driver_attach+0x0/0xce
 [<00207e26>] bus_add_driver+0x188/0x234
 [<000344c0>] blocking_notifier_call_chain+0x0/0x20
 [<00209894>] driver_register+0x58/0x104
 [<000344c0>] blocking_notifier_call_chain+0x0/0x20
 [<010bd000>] swim_init+0x0/0x2c [swim_mod]
 [<0020a7be>] __platform_driver_register+0x38/0x3c
 [<010bd028>] swim_init+0x28/0x2c [swim_mod]
 [<000020dc>] do_one_initcall+0x38/0x196
 [<000344c0>] blocking_notifier_call_chain+0x0/0x20
 [<003331cc>] mutex_unlock+0x0/0x3e
 [<00333b06>] mutex_lock+0x0/0x2e
 [<003331cc>] mutex_unlock+0x0/0x3e
 [<00333b06>] mutex_lock+0x0/0x2e
 [<003331cc>] mutex_unlock+0x0/0x3e
 [<00333b06>] mutex_lock+0x0/0x2e
 [<003331cc>] mutex_unlock+0x0/0x3e
 [<00333b06>] mutex_lock+0x0/0x2e
 [<00075008>] __free_pages+0x0/0x38
 [<000045c0>] mangle_kernel_stack+0x30/0xda
 [<000344c0>] blocking_notifier_call_chain+0x0/0x20
 [<003331cc>] mutex_unlock+0x0/0x3e
 [<00333b06>] mutex_lock+0x0/0x2e
 [<0005ced4>] do_init_module+0x42/0x266
 [<010bd000>] swim_init+0x0/0x2c [swim_mod]
 [<000344c0>] blocking_notifier_call_chain+0x0/0x20
 [<0005eda0>] load_module+0x1a30/0x1e70
 [<0000465d>] mangle_kernel_stack+0xcd/0xda
 [<00331c64>] __generic_copy_from_user+0x0/0x46
 [<0033256e>] _cond_resched+0x0/0x32
 [<00331b9c>] memset+0x0/0x98
 [<0033256e>] _cond_resched+0x0/0x32
 [<0005f25c>] SyS_init_module+0x7c/0x112
 [<00002000>] _start+0x0/0x8
 [<00002000>] _start+0x0/0x8
 [<00331c82>] __generic_copy_from_user+0x1e/0x46
 [<0005f2b2>] SyS_init_module+0xd2/0x112
 [<0000465d>] mangle_kernel_stack+0xcd/0xda
 [<00002b40>] syscall+0x8/0xc
 [<0000465d>] mangle_kernel_stack+0xcd/0xda
 [<0008c00c>] pcpu_balance_workfn+0xb2/0x40e
Code: 2200 7419 e4a9 e589 2841 d9fc 0000 1000 <2414> 7203 c282 7602 b681 6600 0096 0242 fe00 0482 0000 0000 e9c0 11c3 ed89 2642

There's no need to call ioremap() for the SWIM address range, as it lies
within the usual IO device region at 0x5000 0000, which has already been
mapped by head.S.

Remove the redundant ioremap() and iounmap() calls to fix the hang.

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: stable@vger.kernel.org # v4.14+
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/swim.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -911,7 +911,7 @@ static int swim_probe(struct platform_de
 		goto out;
 	}
 
-	swim_base = ioremap(res->start, resource_size(res));
+	swim_base = (struct swim __iomem *)res->start;
 	if (!swim_base) {
 		ret = -ENOMEM;
 		goto out_release_io;
@@ -923,7 +923,7 @@ static int swim_probe(struct platform_de
 	if (!get_swim_mode(swim_base)) {
 		printk(KERN_INFO "SWIM device not found !\n");
 		ret = -ENODEV;
-		goto out_iounmap;
+		goto out_release_io;
 	}
 
 	/* set platform driver data */
@@ -931,7 +931,7 @@ static int swim_probe(struct platform_de
 	swd = kzalloc(sizeof(struct swim_priv), GFP_KERNEL);
 	if (!swd) {
 		ret = -ENOMEM;
-		goto out_iounmap;
+		goto out_release_io;
 	}
 	platform_set_drvdata(dev, swd);
 
@@ -945,8 +945,6 @@ static int swim_probe(struct platform_de
 
 out_kfree:
 	kfree(swd);
-out_iounmap:
-	iounmap(swim_base);
 out_release_io:
 	release_mem_region(res->start, resource_size(res));
 out:
@@ -974,8 +972,6 @@ static int swim_remove(struct platform_d
 	for (drive = 0; drive < swd->floppy_count; drive++)
 		floppy_eject(&swd->unit[drive]);
 
-	iounmap(swd->base);
-
 	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
 	if (res)
 		release_mem_region(res->start, resource_size(res));
