Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932299AbeCDMK1 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 07:10:27 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37109 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932199AbeCDMKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 07:10:24 -0500
X-Google-Smtp-Source: AG47ELsSosZLf+p72yt7N3rZLyNIAcA3rdsvzRYLytPfby8pFAZAG1js2jGXXEACFEKzWat1LWqmyw==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 2/3] irq/irq_sim: modify the return value check for irq_sim_init()
Date: Sun,  4 Mar 2018 13:10:17 +0100
Message-Id: <20180304121018.640-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180304121018.640-1-brgl@bgdev.pl>
References: <20180304121018.640-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed with Marc Zyngier: irq_sim_init() and its devres variant
should return the base of the allocated interrupt range on success
rather than 0. This will be modified later - first, change the way
devm_irq_sim_init() check the return value.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
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
-- 
2.16.1
