Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751207AbeCIKt3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 05:49:29 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43751 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbeCIKt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 05:49:28 -0500
Date: Fri, 9 Mar 2018 02:49:19 -0800
From: tip-bot for Bartosz Golaszewski <tipbot@zytor.com>
Message-ID: <tip-28b6afa7d4456e759031bf83706b4be3689fba94@git.kernel.org>
Cc: tglx@linutronix.de, marc.zyngier@arm.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, hpa@zytor.com, brgl@bgdev.pl
Reply-To: brgl@bgdev.pl, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com, tglx@linutronix.de
In-Reply-To: <20180304121018.640-3-brgl@bgdev.pl>
References: <20180304121018.640-3-brgl@bgdev.pl>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/irq_sim: Check the return value of
 irq_sim_init() for error codes
Git-Commit-ID: 28b6afa7d4456e759031bf83706b4be3689fba94
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  28b6afa7d4456e759031bf83706b4be3689fba94
Gitweb:     https://git.kernel.org/tip/28b6afa7d4456e759031bf83706b4be3689fba94
Author:     Bartosz Golaszewski <brgl@bgdev.pl>
AuthorDate: Sun, 4 Mar 2018 13:10:17 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 9 Mar 2018 11:44:03 +0100

genirq/irq_sim: Check the return value of irq_sim_init() for error codes

As discussed with Marc Zyngier: irq_sim_init() and its devres variant
should return the base of the allocated interrupt range on success rather
than 0.

Make devm_irq_sim_init() check for an error code. This is a preparatory
change for modifying irq_sim_init() itself.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Link: https://lkml.kernel.org/r/20180304121018.640-3-brgl@bgdev.pl

---
 kernel/irq/irq_sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index bd7dc1db6a80..05f0d7c1698a 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -124,7 +124,7 @@ int devm_irq_sim_init(struct device *dev, struct irq_sim *sim,
 		return -ENOMEM;
 
 	rv = irq_sim_init(sim, num_irqs);
-	if (rv) {
+	if (rv < 0) {
 		devres_free(dr);
 		return rv;
 	}
