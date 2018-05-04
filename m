Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751960AbeEDPs7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 11:48:59 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41277 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbeEDPp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 11:45:57 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-mm@kvack.org,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/5] kernel/user: Use irqsave variant of atomic_dec_and_lock()
Date: Fri,  4 May 2018 17:45:31 +0200
Message-Id: <20180504154533.8833-4-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180504154533.8833-1-bigeasy@linutronix.de>
References: <20180504154533.8833-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anna-Maria Gleixner <anna-maria@linutronix.de>

The irqsave variant of atomic_dec_and_lock handles irqsave/restore when
taking/releasing the spin lock. With this variant the call of
local_irq_save/restore is no longer required.

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/user.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/user.c b/kernel/user.c
index 36288d840675..8959ad11d766 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -169,11 +169,8 @@ void free_uid(struct user_struct *up)
 	if (!up)
 		return;
=20
-	local_irq_save(flags);
-	if (atomic_dec_and_lock(&up->__count, &uidhash_lock))
+	if (atomic_dec_and_lock_irqsave(&up->__count, &uidhash_lock, flags))
 		free_user(up, flags);
-	else
-		local_irq_restore(flags);
 }
=20
 struct user_struct *alloc_uid(kuid_t uid)
--=20
2.17.0
