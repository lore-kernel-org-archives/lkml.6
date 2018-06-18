Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F6AC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444992086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uIfY47Xn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444992086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754565AbeFRM5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:57:37 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35195 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754237AbeFRM5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 08:57:36 -0400
Received: by mail-pl0-f67.google.com with SMTP id k1-v6so9011049plt.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 05:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9Ov7TBW7BuSNN9tr01UsDeqw26CKjpVgi8DUNvd7IqQ=;
        b=uIfY47XnhnLaR8/nKlVxsi9AN+XvL/Jdbm6RFANSucSDIH/QFX48Y7TheRjEy+LfyX
         JKdXPIVYQHhI/nUVF9yr9eBQcQ9OP5K7cmjZERqzuEbHLu8hdK9ReynByIYblAon1T8R
         yyl84wbHU74+OL5z/7VT8kiicBG7VOjVlpWA6tN2Cg1LPrEx93mxl3xpAPctQIAqiwC4
         ISEYXsPjoxE8XZ6PtTI5KbKlEQWfomHRKF+9uwpaNxs8Xw6d5KeJCuXRJvlgtkSJ5i9d
         6F1lKhqdasJePzZTAvZ9V+rXHiusGRetQw+PN+fd0qkXii3OgfbT9dj6g4EOiVIXNOt0
         gQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9Ov7TBW7BuSNN9tr01UsDeqw26CKjpVgi8DUNvd7IqQ=;
        b=EDPcWkQ+Cz9XJmzxF12Qiq+Ya347xm9h+KIfPbsFnx5CPCLqKy4vYyohRwu8ogfyKw
         gbbiasXrKXsHz19WMxsye/VW2rmbGb5bJuwY/uJD0Dxb0pRFTSZbv3JLRhz67m8tY6G9
         Nyv/ix9qlr1FIq0PCYINO+bx44vF2D4PIn9GpgAeDeDCmqn6MMa3UGlWGTY9/fDhQW1V
         Qov1/PWvqhbiYgiZpw1T87EhjKpfqdU3OWZtxSH9x+zB9AauyyDu4enEDtkcvLcqpyNp
         MQadHyJ1vemodxA8ndwItms8rdu2432iE0S92O5ZN+DivkpUl7LT7vdiikXGqIGYHIHR
         zN+w==
X-Gm-Message-State: APt69E2rdv84DWegHJq177mdgSSOZhTjb3saJsD/5IjUv6NF0twffjGH
        m/sG/jvkm13E2U2JIgT3b2Ni1Q==
X-Google-Smtp-Source: ADUXVKKaMdvFEBYDuZvtlyM9O9VJutaVRMrzakbrYAmM1Ykv67wp67SQ9v03eJIYzCUgI+I5dpeBZw==
X-Received: by 2002:a17:902:ac89:: with SMTP id h9-v6mr14101442plr.311.1529326655417;
        Mon, 18 Jun 2018 05:57:35 -0700 (PDT)
Received: from localhost ([2620:15c:2c4:201:f5a:7eca:440a:3ead])
        by smtp.gmail.com with ESMTPSA id n25-v6sm22238716pff.119.2018.06.18.05.57.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 05:57:34 -0700 (PDT)
From:   Eric Dumazet <edumazet@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Willem de Bruijn <willemb@google.com>
Subject: [PATCH] genirq: use rcu in kstat_irqs_usr()
Date:   Mon, 18 Jun 2018 05:56:12 -0700
Message-Id: <20180618125612.155057-1-edumazet@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Dorfman identified mutex contention when multiple threads
parse /proc/stat concurrently.

Since Thomas Gleixner commit 425a5072dcd1 ("genirq: Free irq_desc
with rcu"), we can easily switch kstat_irqs_usr() to rcu locking
and remove this mutex contetion.

show_interrupts() case will be handled in a separate patch.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Jeremy Dorfman <jdorfman@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Willem de Bruijn <willemb@google.com>
---
 kernel/irq/irqdesc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index afc7f902d74a3eff5d1f8a5e407159c5d28625f7..a668b7ad8a5d5e3b191e3a1dc8f9f32293658d42 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -443,6 +443,7 @@ static void free_desc(unsigned int irq)
 	 * We free the descriptor, masks and stat fields via RCU. That
 	 * allows demultiplex interrupts to do rcu based management of
 	 * the child interrupts.
+	 * This also allows us to use rcu in kstat_irqs_usr().
 	 */
 	call_rcu(&desc->rcu, delayed_free_desc);
 }
@@ -928,17 +929,17 @@ unsigned int kstat_irqs(unsigned int irq)
  * kstat_irqs_usr - Get the statistics for an interrupt
  * @irq:	The interrupt number
  *
- * Returns the sum of interrupt counts on all cpus since boot for
- * @irq. Contrary to kstat_irqs() this can be called from any
- * preemptible context. It's protected against concurrent removal of
- * an interrupt descriptor when sparse irqs are enabled.
+ * Returns the sum of interrupt counts on all cpus since boot for @irq.
+ * Contrary to kstat_irqs() this can be called from any context.
+ * It uses rcu since a concurrent removal of an interrupt descriptor is
+ * observing an rcu grace period before delayed_free_desc()/irq_kobj_release().
  */
 unsigned int kstat_irqs_usr(unsigned int irq)
 {
 	unsigned int sum;
 
-	irq_lock_sparse();
+	rcu_read_lock();
 	sum = kstat_irqs(irq);
-	irq_unlock_sparse();
+	rcu_read_unlock();
 	return sum;
 }
-- 
2.18.0.rc1.244.gcf134e6275-goog

