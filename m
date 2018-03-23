Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvpd2NU1VUH58EeCGF3LamctiWJg+EdvGGdhfZH2BMutSk5fXLjmNioO5mxT1xhHJeUblIU
ARC-Seal: i=1; a=rsa-sha256; t=1521800333; cv=none;
        d=google.com; s=arc-20160816;
        b=IWQUZjvyubRmoR0dU14DuL0A8RoZCRpu2t2Gwu1L5tAtrUeww6phEthnwi/XNZ0oo3
         SP8a8Bhi1CuDXUVZ9jHkTmk4yMc/Uo2AFnJOaHH2KVwBfkqGgb/mPV1FXj509HKeIWNJ
         10z7TRvJCv+8KIVknU0dhYNT7kTWBh/+mJTN9VQ3X/pKDvDOsfSYMrFmLLUO96yOQrfR
         GQ8CMGA1ocWnwUhD95Q1OK+eEK2Y4j/u2fXLKHqNTsFcJfKpXq5Lfi4aX5jWY4tLEqQO
         naWE5PTZoMseaypHiJtbgta4872nAs+z/pK8vNLWbzcP/tHjC/mGpAk9N5PrXqI6DNny
         LW2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=l88goj88WdIXGLB8irFceQJKUoTuntUOjEJIVqI6fVc=;
        b=pO9gHjkuWt28o1FcH4fpX8Xs7+Bt5KZrmAdX+NAvaq8CXM/WzVDtH3/OSpzaCNsG+Q
         7xczN12kyD4Nfy8WhHtSeXWJC4VVTJlDu2W1vwM0Hgrug4hP2H2WvIYk0rRXxSiUXWRR
         v9cwAoCBLAAiBJIC0OziyKfxSqNvuHPulShwkHRM/iLhCloh2YHrLgTbDypGAswmAw1X
         9knb5JhbQTLz5fnbK7Mi8yM1j1OJ9xInQeFa9MsTFURUpIZHmRktoSsD6f0FzW0FMQt+
         AT3Ff8GxH8GquRbyU6HzEm1p5RCUuHqi9TbWBUmOTrJ2YS8aUnvm3sYU0jTzvo3jpBhK
         FKTg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Anthony Brandon <anthony@amarulasolutions.com>,
	Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 31/47] power: supply: pda_power: move from timer to delayed_work
Date: Fri, 23 Mar 2018 10:55:22 +0100
Message-Id: <20180323094249.454862841@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722747735081780?=
X-GMAIL-MSGID: =?utf-8?q?1595723306574903026?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Trimarchi <michael@amarulasolutions.com>


[ Upstream commit 633e8799ddc09431be2744c4a1efdbda13af2b0b ]

This changed is needed to avoid locking problem during
boot as shown:

<5>[    8.824096] Registering SWP/SWPB emulation handler
<6>[    8.977294] clock: disabling unused clocks to save power
<3>[    9.108154] BUG: sleeping function called from invalid context at kernel_albert/kernel/mutex.c:269
<3>[    9.122894] in_atomic(): 1, irqs_disabled(): 0, pid: 1, name: swapper/0
<4>[    9.130249] 3 locks held by swapper/0/1:
<4>[    9.134613]  #0:  (&__lockdep_no_validate__){......}, at: [<c0342430>] __driver_attach+0x58/0xa8
<4>[    9.144500]  #1:  (&__lockdep_no_validate__){......}, at: [<c0342440>] __driver_attach+0x68/0xa8
<4>[    9.154357]  #2:  (&polling_timer){......}, at: [<c0053770>] run_timer_softirq+0x108/0x3ec
<4>[    9.163726] Backtrace:
<4>[    9.166473] [<c001269c>] (dump_backtrace+0x0/0x114) from [<c067e5f0>] (dump_stack+0x20/0x24)
<4>[    9.175811]  r6:00203230 r5:0000010d r4:d782e000 r3:60000113
<4>[    9.182250] [<c067e5d0>] (dump_stack+0x0/0x24) from [<c007441c>] (__might_sleep+0x10c/0x128)
<4>[    9.191650] [<c0074310>] (__might_sleep+0x0/0x128) from [<c0688f60>] (mutex_lock_nested+0x34/0x36c)
<4>[    9.201660]  r5:c02d5350 r4:d79a0c64
<4>[    9.205688] [<c0688f2c>] (mutex_lock_nested+0x0/0x36c) from [<c02d5350>] (regulator_set_current_limit+0x30/0x118)
<4>[    9.217071] [<c02d5320>] (regulator_set_current_limit+0x0/0x118) from [<c0435ce0>] (update_charger+0x84/0xc4)
<4>[    9.228027]  r7:d782fb20 r6:00000101 r5:c1767e94 r4:00000000
<4>[    9.234436] [<c0435c5c>] (update_charger+0x0/0xc4) from [<c0435d40>] (psy_changed+0x20/0x48)
<4>[    9.243804]  r5:d782e000 r4:c1767e94
<4>[    9.247802] [<c0435d20>] (psy_changed+0x0/0x48) from [<c0435dec>] (polling_timer_func+0x84/0xb8)
<4>[    9.257537]  r4:c1767e94 r3:00000002
<4>[    9.261566] [<c0435d68>] (polling_timer_func+0x0/0xb8) from [<c00537e4>] (run_timer_softirq+0x17c/0x3ec)
<4>[    9.272033]  r4:c1767eb0 r3:00000000
<4>[    9.276062] [<c0053668>] (run_timer_softirq+0x0/0x3ec) from [<c004b000>] (__do_softirq+0xf0/0x298)
<4>[    9.286010] [<c004af10>] (__do_softirq+0x0/0x298) from [<c004b650>] (irq_exit+0x98/0xa0)
<4>[    9.295013] [<c004b5b8>] (irq_exit+0x0/0xa0) from [<c000edbc>] (handle_IRQ+0x60/0xc0)
<4>[    9.303680]  r4:c1194e98 r3:c00bc778
<4>[    9.307708] [<c000ed5c>] (handle_IRQ+0x0/0xc0) from [<c0008504>] (gic_handle_irq+0x34/0x68)
<4>[    9.316955]  r8:000ac383 r7:d782fc3c r6:d782fc08 r5:c11936c4 r4:e0802100
<4>[    9.324310] r3:c026ba48
<4>[    9.327301] [<c00084d0>] (gic_handle_irq+0x0/0x68) from [<c068c2c0>] (__irq_svc+0x40/0x74)
<4>[    9.336456] Exception stack(0xd782fc08 to 0xd782fc50)
<4>[    9.342041] fc00:                   d6e30e6c ac383627 00000000 ac383417 ea19c000 ea200000
<4>[    9.351104] fc20: beffffff 00000667 000ac383 d6e30670 d6e3066c d782fc94 d782fbe8 d782fc50
<4>[    9.360168] fc40: c026ba48 c001d1f0 00000113 ffffffff

Fixes: b2998049cfae ("[BATTERY] pda_power platform driver")
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Anthony Brandon <anthony@amarulasolutions.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/pda_power.c |   49 +++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

--- a/drivers/power/pda_power.c
+++ b/drivers/power/pda_power.c
@@ -30,9 +30,9 @@ static inline unsigned int get_irq_flags
 static struct device *dev;
 static struct pda_power_pdata *pdata;
 static struct resource *ac_irq, *usb_irq;
-static struct timer_list charger_timer;
-static struct timer_list supply_timer;
-static struct timer_list polling_timer;
+static struct delayed_work charger_work;
+static struct delayed_work polling_work;
+static struct delayed_work supply_work;
 static int polling;
 
 #if IS_ENABLED(CONFIG_USB_PHY)
@@ -143,7 +143,7 @@ static void update_charger(void)
 	}
 }
 
-static void supply_timer_func(unsigned long unused)
+static void supply_work_func(struct work_struct *work)
 {
 	if (ac_status == PDA_PSY_TO_CHANGE) {
 		ac_status = new_ac_status;
@@ -164,11 +164,12 @@ static void psy_changed(void)
 	 * Okay, charger set. Now wait a bit before notifying supplicants,
 	 * charge power should stabilize.
 	 */
-	mod_timer(&supply_timer,
-		  jiffies + msecs_to_jiffies(pdata->wait_for_charger));
+	cancel_delayed_work(&supply_work);
+	schedule_delayed_work(&supply_work,
+			      msecs_to_jiffies(pdata->wait_for_charger));
 }
 
-static void charger_timer_func(unsigned long unused)
+static void charger_work_func(struct work_struct *work)
 {
 	update_status();
 	psy_changed();
@@ -187,13 +188,14 @@ static irqreturn_t power_changed_isr(int
 	 * Wait a bit before reading ac/usb line status and setting charger,
 	 * because ac/usb status readings may lag from irq.
 	 */
-	mod_timer(&charger_timer,
-		  jiffies + msecs_to_jiffies(pdata->wait_for_status));
+	cancel_delayed_work(&charger_work);
+	schedule_delayed_work(&charger_work,
+			      msecs_to_jiffies(pdata->wait_for_status));
 
 	return IRQ_HANDLED;
 }
 
-static void polling_timer_func(unsigned long unused)
+static void polling_work_func(struct work_struct *work)
 {
 	int changed = 0;
 
@@ -214,8 +216,9 @@ static void polling_timer_func(unsigned
 	if (changed)
 		psy_changed();
 
-	mod_timer(&polling_timer,
-		  jiffies + msecs_to_jiffies(pdata->polling_interval));
+	cancel_delayed_work(&polling_work);
+	schedule_delayed_work(&polling_work,
+			      msecs_to_jiffies(pdata->polling_interval));
 }
 
 #if IS_ENABLED(CONFIG_USB_PHY)
@@ -253,8 +256,9 @@ static int otg_handle_notification(struc
 	 * Wait a bit before reading ac/usb line status and setting charger,
 	 * because ac/usb status readings may lag from irq.
 	 */
-	mod_timer(&charger_timer,
-		  jiffies + msecs_to_jiffies(pdata->wait_for_status));
+	cancel_delayed_work(&charger_work);
+	schedule_delayed_work(&charger_work,
+			      msecs_to_jiffies(pdata->wait_for_status));
 
 	return NOTIFY_OK;
 }
@@ -302,8 +306,8 @@ static int pda_power_probe(struct platfo
 	if (!pdata->ac_max_uA)
 		pdata->ac_max_uA = 500000;
 
-	setup_timer(&charger_timer, charger_timer_func, 0);
-	setup_timer(&supply_timer, supply_timer_func, 0);
+	INIT_DELAYED_WORK(&charger_work, charger_work_func);
+	INIT_DELAYED_WORK(&supply_work, supply_work_func);
 
 	ac_irq = platform_get_resource_byname(pdev, IORESOURCE_IRQ, "ac");
 	usb_irq = platform_get_resource_byname(pdev, IORESOURCE_IRQ, "usb");
@@ -381,9 +385,10 @@ static int pda_power_probe(struct platfo
 
 	if (polling) {
 		dev_dbg(dev, "will poll for status\n");
-		setup_timer(&polling_timer, polling_timer_func, 0);
-		mod_timer(&polling_timer,
-			  jiffies + msecs_to_jiffies(pdata->polling_interval));
+		INIT_DELAYED_WORK(&polling_work, polling_work_func);
+		cancel_delayed_work(&polling_work);
+		schedule_delayed_work(&polling_work,
+				      msecs_to_jiffies(pdata->polling_interval));
 	}
 
 	if (ac_irq || usb_irq)
@@ -429,9 +434,9 @@ static int pda_power_remove(struct platf
 		free_irq(ac_irq->start, &pda_psy_ac);
 
 	if (polling)
-		del_timer_sync(&polling_timer);
-	del_timer_sync(&charger_timer);
-	del_timer_sync(&supply_timer);
+		cancel_delayed_work_sync(&polling_work);
+	cancel_delayed_work_sync(&charger_work);
+	cancel_delayed_work_sync(&supply_work);
 
 	if (pdata->is_usb_online)
 		power_supply_unregister(&pda_psy_usb);
