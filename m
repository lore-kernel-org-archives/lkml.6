Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbeEDOZ1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:25:27 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40847 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbeEDOZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 10:25:15 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        "David S. Miller" <davem@davemloft.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4/4] ide: don't enable/disable interrupts in force threaded-IRQ mode
Date: Fri,  4 May 2018 16:24:46 +0200
Message-Id: <20180504142446.30525-5-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180504142446.30525-1-bigeasy@linutronix.de>
References: <20180504142446.30525-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupts are enabled/disabled so the interrupt handler can run
with enabled interrupts while serving the interrupt and not lose other
interrupts especially the timer tick.
If the system runs with force-threaded interrupts then there is no need
to enable the interrupts.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/ide/ide-iops.c     | 13 +++++++++----
 drivers/ide/ide-taskfile.c |  2 +-
 kernel/irq/manage.c        |  1 +
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
index 210a0887dd29..d55e9ebd5628 100644
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -108,6 +108,7 @@ int __ide_wait_stat(ide_drive_t *drive, u8 good, u8 bad,
 	ide_hwif_t *hwif =3D drive->hwif;
 	const struct ide_tp_ops *tp_ops =3D hwif->tp_ops;
 	unsigned long flags;
+	bool irqs_threaded =3D force_irqthreads;
 	int i;
 	u8 stat;
=20
@@ -115,8 +116,10 @@ int __ide_wait_stat(ide_drive_t *drive, u8 good, u8 ba=
d,
 	stat =3D tp_ops->read_status(hwif);
=20
 	if (stat & ATA_BUSY) {
-		local_save_flags(flags);
-		local_irq_enable_in_hardirq();
+		if (!irqs_threaded) {
+			local_save_flags(flags);
+			local_irq_enable_in_hardirq();
+		}
 		timeout +=3D jiffies;
 		while ((stat =3D tp_ops->read_status(hwif)) & ATA_BUSY) {
 			if (time_after(jiffies, timeout)) {
@@ -129,12 +132,14 @@ int __ide_wait_stat(ide_drive_t *drive, u8 good, u8 b=
ad,
 				if ((stat & ATA_BUSY) =3D=3D 0)
 					break;
=20
-				local_irq_restore(flags);
+				if (!irqs_threaded)
+					local_irq_restore(flags);
 				*rstat =3D stat;
 				return -EBUSY;
 			}
 		}
-		local_irq_restore(flags);
+		if (!irqs_threaded)
+			local_irq_restore(flags);
 	}
 	/*
 	 * Allow status to settle, then read it again.
diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
index 49f9b4739779..d42feeaebd36 100644
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -405,7 +405,7 @@ static ide_startstop_t pre_task_out_intr(ide_drive_t *d=
rive,
 		return startstop;
 	}
=20
-	if ((drive->dev_flags & IDE_DFLAG_UNMASK) =3D=3D 0)
+	if (!force_irqthreads && (drive->dev_flags & IDE_DFLAG_UNMASK) =3D=3D 0)
 		local_irq_disable();
=20
 	ide_set_handler(drive, &task_pio_intr, WAIT_WORSTCASE);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index e3336d904f64..4c2ef8084e32 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -24,6 +24,7 @@
=20
 #ifdef CONFIG_IRQ_FORCED_THREADING
 __read_mostly bool force_irqthreads;
+EXPORT_SYMBOL_GPL(force_irqthreads);
=20
 static int __init setup_forced_irqthreads(char *arg)
 {
--=20
2.17.0
