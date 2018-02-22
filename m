Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933046AbeBVPxy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:53:54 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:51233 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933000AbeBVPxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:53:53 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Gleixner <tglx@linutronix.de>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Waiman Long <longman@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] debugobjects: fix debug_objects_freed accounting
Date: Thu, 22 Feb 2018 16:52:58 +0100
Message-Id: <20180222155335.1647466-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:P+O6ZlvA5LYEhiXqK4cG8ZD7VaPEWheZVYbeHgy3hi9xyvgxX7k
 evBmRTYlEJ1TyenPO8RPH3rEKCv+P9zvsvOdyTThtUOTaTBosmlD4/ksgh519Tz58JxnO3B
 nE2KQzHeq+hYwnQ2O5Z7eIUkwKB8Enq7jgyFVkKL/pWjZDmdX3DNLuxhYquIABKoXu0aSAP
 FKJNlr9ke/eaAhyJOXZaA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8lKGIdJrr/I=:HUhNNFTBw+eYo+BKo8dbMy
 i9RmoJLMnkQjsfgYs0Zyoz8MweMnZDUwIe4cKy6kWLZ4IwMSSP4RSBVHmwdLh7pLGFl0F6nA2
 AAoFhmWkA7PQRiHh1QsuAlIP0tT30LH9uSjqbQgJHehA4OgcIWjiSBuQjlymAhpXpiCDJcWYM
 Djagox4WX+LGXf4GtMpnEUxuNtW3bDsInM753pu1/1QbtFeyvBvOJzf0pkzhfSObMN274l3Ta
 yDl+yeg5tYgW2szUFT063v0TxkD5CT4JIvb6gnNC5y2TSs/JJT90n4aKw5OeW35P7ZH5HXp2Z
 8TEb+oSF8gPqffRE3duY9viCA7vbIh+942EwbDYHA1ic0U6HBMSO550Q7DOI5Kmnuz04tU/gN
 nhZuYfaiCmjcY5TL+sxTaxacBzpIL3yKYP8T8vI3/1c3kRcTvTz1x4Hqc40O39mYWtQOqYM6K
 R9KzNZpriWnjcBLPYDftdvNUTDL58BAcqcUX76UIQv2bQ1nxP04Eai5U6nfIYY/nVtKElOCw7
 G2jyGRgbmvdOqKT2T6NifmC4tv+drqfYftjhFAAZipu0dvcrnp5J4Cn1lcwuywUNtuJ7pzVNQ
 hFfc6svyhYMJ69P1swuq0dmeDGd/snf/hmI6qfmIWKHYu/fXbouky16kjIOCpPBurUQHbvztH
 +er07F9OYJwiKq4vzoZRpvLwRV7ntGo+wF8d9SDFMD4F0Gmg7f7aoHilFUztZXjYgH7WXfzJn
 YTUjKnmEKTdNTEyjtoDdgszDAw8ecvKUoG+93g==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The removal of the batched object freeing has caused the debug_objects_freed
to become read-only, and the reading is inside an ifdef, so gcc warns that it
is completely unused without CONFIG_DEBUG_FS:

lib/debugobjects.c:71:14: error: 'debug_objects_freed' defined but not used [-Werror=unused-variable]

Assuming we are still interested in this number, this adds back code to
keep track of the freed objects.

Fixes: 636e1970fd7d ("debugobjects: Use global free list in free_object()")
Suggested-by: Waiman Long <longman@redhat.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
--
v2: simplify the counting as pointed out by Longman
---
 lib/debugobjects.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index faab2c4ea024..105ecfc47d8c 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -233,6 +233,7 @@ static void free_obj_work(struct work_struct *work)
 	 */
 	if (obj_nr_tofree) {
 		hlist_move_list(&obj_to_free, &tofree);
+		debug_objects_freed += obj_nr_tofree;
 		obj_nr_tofree = 0;
 	}
 	raw_spin_unlock_irqrestore(&pool_lock, flags);
-- 
2.9.0
