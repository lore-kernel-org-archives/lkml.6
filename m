Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965690AbeEITjB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 15:39:01 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34580 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965631AbeEITiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 15:38:51 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-mm@kvack.org,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 8/8] md: raid5: Do not disable irq on release_inactive_stripe_list() call
Date: Wed,  9 May 2018 21:36:45 +0200
Message-Id: <20180509193645.830-9-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180509193645.830-1-bigeasy@linutronix.de>
References: <20180509193645.830-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anna-Maria Gleixner <anna-maria@linutronix.de>

There is no need to invoke release_inactive_stripe_list() with interrupts
disabled. All call sites, except raid5_release_stripe(), unlock
->device_lock and enable interrupts before invoking the function.

Make it consistent.

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
[bigeasy: s@atomic_dec_and_lock@refcount_dec_and_lock@g ]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/md/raid5.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 28453264c3eb..9433b2619006 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -414,9 +414,8 @@ void raid5_release_stripe(struct stripe_head *sh)
 		INIT_LIST_HEAD(&list);
 		hash =3D sh->hash_lock_index;
 		do_release_stripe(conf, sh, &list);
-		spin_unlock(&conf->device_lock);
+		spin_unlock_irqrestore(&conf->device_lock, flags);
 		release_inactive_stripe_list(conf, &list, hash);
-		local_irq_restore(flags);
 	}
 }
=20
--=20
2.17.0
