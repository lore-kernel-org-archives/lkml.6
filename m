Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753756AbeBVLqQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 06:46:16 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:35343 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753669AbeBVLqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 06:46:14 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Gleixner <tglx@linutronix.de>,
        Yang Shi <yang.shi@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] debugobjects: fix debug_objects_freed accounting
Date: Thu, 22 Feb 2018 12:45:41 +0100
Message-Id: <20180222114558.1307380-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:cv9ijHo7ZeRAQpPkzyp2qVSZq1VUAHliVNOUbFKk6nn6SOU8t8E
 lvocAVJ0/NDTFhg8EYz4SQcV24Kr4WxFGpS/xO/WqjdDLZemRueHv6W78zDgAnY9W5VDNPJ
 O/zRpM4z+fgaob8GaOVtEfclwX/ttCRWEZPKTVgeFmfUTmYG7QXo1jpMz6yITvV01x6sVrX
 CPEQ6BhnYkcfpnjharD9Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6EL7XNZxzr8=:seSiOaR+vBfzbPdglocrP3
 bEPjm3TaTbiDTH2IRNLjNb8UirmObSj/Qt1GDzdRv6QqtORuQsT9XqKwjwqKhkoFXWnLUlHut
 8vlywkcEKPNIy/Y36eCw8gz4LskogXFS2v0FmCctJA/9iWDHV4xifSmntMtJFDqlzZux6ByGN
 7KpcbgJfcPhDcQs5GW3VyDPci5mhAS+4k4nL1VWMIcHTqXS8DDreAjEbrxjdXZwvVhNBTu7qE
 owVmY0MAim2X2HoTEDzN1Bso+ssj8Gc0nbM3QQ4UL90lZ8whpaib9v+3fp5Hr8JszeLxbkriM
 +qBUDNTU7FfHTNepBaL/vrGlCGqN/d6idCXbWlG8bjQ05ZLkS2n/MtO4PwyzSZiRteX8xDgyZ
 +0Dtap1BGWXIRqfILn5TMQvAW7gaPAQGZB/6+o7Hg+Qg9wNR3tTmdAJJ1t0UllDl5eAWL46/R
 VAGm50jY+SGV+MmzZGy7pOy1u5LXr8aBwKp6EJe9YTz+gqyNigXcODr0yVFPsH5eJBey78xGP
 vXO4LoQ81RWumiV2jATInOGRDaqwgATtricm7K7vPb9D6Zl8A+6uYoGHQxwQaQvI/2XTxdHkP
 vpi9QM8hsbtKs9ftIN5zgnP+4Epn3dTcXIiQxpGDwhcffdhKhlJyYzDyv3TOuUOIWRPwzduX3
 GfF//sqbWhylQI/n0bstEkoKILkfmmvdyfMWp2g7CCyfY3vL9XEnQigeMqxiDFBv0nI4KEQEe
 hl5Uaiu0oge3qwHsYMxoP0MUTMZoSM55XoAWNg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The removal of the batched object freeing has caused the debug_objects_freed
to become read-only, and the reading is inside an ifdef, so gcc warns that it
is completely unused without CONFIG_DEBUG_FS:

lib/debugobjects.c:71:14: error: 'debug_objects_freed' defined but not used [-Werror=unused-variable]

Assuming we are still interested in this number, this adds back code to
count every instance we are about to free while we still hold the spinlock.

Fixes: 636e1970fd7d ("debugobjects: Use global free list in free_object()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/debugobjects.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index faab2c4ea024..748288dba512 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -235,6 +235,9 @@ static void free_obj_work(struct work_struct *work)
 		hlist_move_list(&obj_to_free, &tofree);
 		obj_nr_tofree = 0;
 	}
+	hlist_for_each_entry(obj, &tofree, node)
+		debug_objects_freed++;
+
 	raw_spin_unlock_irqrestore(&pool_lock, flags);
 
 	hlist_for_each_entry_safe(obj, tmp, &tofree, node) {
-- 
2.9.0
