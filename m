Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbeEDLj5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 07:39:57 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39390 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeEDLj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 07:39:56 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, Ingo Molnar <mingo@elte.hu>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RFC] random: Reduce preempt disabled region
Date: Fri,  4 May 2018 13:39:47 +0200
Message-Id: <20180504113947.26254-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

No need to keep preemption disabled across the whole function.

Cc: "Theodore Ts'o" <tytso@mit.edu>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/char/random.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1122,8 +1122,6 @@ static void add_timer_randomness(struct
 	} sample;
 	long delta, delta2, delta3;
=20
-	preempt_disable();
-
 	sample.jiffies =3D jiffies;
 	sample.cycles =3D random_get_entropy();
 	sample.num =3D num;
@@ -1161,8 +1159,6 @@ static void add_timer_randomness(struct
 	 * and limit entropy entimate to 12 bits.
 	 */
 	credit_entropy_bits(r, min_t(int, fls(delta>>1), 11));
-
-	preempt_enable();
 }
=20
 void add_input_randomness(unsigned int type, unsigned int code,
