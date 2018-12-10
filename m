Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE65C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8907A2084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8907A2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbeLJVx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:53:28 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:46109 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeLJVx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:53:27 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MkEdF-1hCNxZ236v-00kgK7; Mon, 10 Dec 2018 22:53:20 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andreas Koensgen <ajk@comnets.uni-bremen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Mackerras <paulus@samba.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Colin Ian King <colin.king@canonical.com>,
        linux-hams@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org
Subject: [PATCH] hamradio, ppp: change semaphore to completion
Date:   Mon, 10 Dec 2018 22:52:56 +0100
Message-Id: <20181210215318.1982562-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:d3v9JfKe1nH/BTMqoL4T45oaXvu8btJPVtquML8pEwYf1/kiony
 8nd6/qm7IRQE5hmDAslkqZ6G8yP9cTO1Ke3HyBUx7VpYyTWhX8i4UN5zxfyXNWEl0N4Tx+v
 ZF7DwHdo+5SbNbHsnoOQ/hGTceRZ4hWctODjRQG2arh7IM70idaW+MRR0WgFo7atWBcoDo6
 82NSNGsH7Stygrp6O9zDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RNGezJgd3R4=:jYfsVW5pJF6PsTrOpTTQXQ
 lt/wB6Ob/dbmD5+38YgVhlhLasOehILOIaZLrxLVUlNNkMUZracr1kJUnN3jx1nH69G3U9tnk
 WRGT152ZkZSxlhoyJ/HiISHlFvi7GaShY2tP141dJ7foKsiv4NsJpoRr2Xg10zBUxUu/+aDss
 n51SwceQRDLc8ZsIA2av/SeeKaFJLkstz/gJgDhEHaCQipglBOFQKvKCFAQFpTQV9LV2h1QFV
 aNhjcpXBCBAwF5QqfiNvcu6kDa8N6VkDAjYUsIAJDT9OuYZIfVK8iMWDs1idt4RqgBuEyaT74
 3cEnraTtRfZfqNDcYBSvvsvijza/y4YP/KttXd8iALQ17sVO1biG40lMLFdbAZe2et9gONONV
 qD2kwAQIoCeRQ2vkFkbyEhJHS4PetOnUw8WBbR417mrXUCzwRLm1IZ1TzKpeKA/8ylxLeqeGH
 timQYN/ml37PWf39d9EL5SvkHcPtsPFny4reaM9SEafBLrqG407fZ2/y3B1aA0V6BCW5IDGYF
 n0Vtp/e63+WRnH40QDRzdzMBd45Z1GOd08fvBjICPKZtAoZgKYkiAb2AKnS1A1uI/uvSbdAUy
 9z9lyN8KgIKeB1YxzGINzAOV9RXM5gv8DBkyBAVi0Jc8efZcPHhRt381oyWWNr9R/4uYEzxBX
 cMVF9er2a3zCvz44vGIJ3wpXfzdM5miBlVnWWcO6M/w0qmZBxCyOlZb4D5A3Y/RkrB58XK5V6
 28YYac4h8dhXpILVMdSabn7PqzRrjIriR2z6zg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ppp and hamradio have copies of the same code that uses a semaphore
in place of a completion for historic reasons. Make it use the
proper interface instead in all copies.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/hamradio/6pack.c | 10 +++++-----
 drivers/net/hamradio/mkiss.c |  8 ++++----
 drivers/net/ppp/ppp_async.c  |  8 ++++----
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/hamradio/6pack.c b/drivers/net/hamradio/6pack.c
index 17e6dcd2eb42..28c749980359 100644
--- a/drivers/net/hamradio/6pack.c
+++ b/drivers/net/hamradio/6pack.c
@@ -120,7 +120,7 @@ struct sixpack {
 	struct timer_list	tx_t;
 	struct timer_list	resync_t;
 	refcount_t		refcnt;
-	struct semaphore	dead_sem;
+	struct completion	dead;
 	spinlock_t		lock;
 };
 
@@ -389,7 +389,7 @@ static struct sixpack *sp_get(struct tty_struct *tty)
 static void sp_put(struct sixpack *sp)
 {
 	if (refcount_dec_and_test(&sp->refcnt))
-		up(&sp->dead_sem);
+		complete(&sp->dead);
 }
 
 /*
@@ -576,7 +576,7 @@ static int sixpack_open(struct tty_struct *tty)
 
 	spin_lock_init(&sp->lock);
 	refcount_set(&sp->refcnt, 1);
-	sema_init(&sp->dead_sem, 0);
+	init_completion(&sp->dead);
 
 	/* !!! length of the buffers. MTU is IP MTU, not PACLEN!  */
 
@@ -670,10 +670,10 @@ static void sixpack_close(struct tty_struct *tty)
 	 * we have to wait for all existing users to finish.
 	 */
 	if (!refcount_dec_and_test(&sp->refcnt))
-		down(&sp->dead_sem);
+		wait_for_completion(&sp->dead);
 
 	/* We must stop the queue to avoid potentially scribbling
-	 * on the free buffers. The sp->dead_sem is not sufficient
+	 * on the free buffers. The sp->dead completion is not sufficient
 	 * to protect us from sp->xbuff access.
 	 */
 	netif_stop_queue(sp->dev);
diff --git a/drivers/net/hamradio/mkiss.c b/drivers/net/hamradio/mkiss.c
index 802233d41b25..4938cf4c184c 100644
--- a/drivers/net/hamradio/mkiss.c
+++ b/drivers/net/hamradio/mkiss.c
@@ -81,7 +81,7 @@ struct mkiss {
 #define CRC_MODE_SMACK_TEST	4
 
 	atomic_t		refcnt;
-	struct semaphore	dead_sem;
+	struct completion	dead;
 };
 
 /*---------------------------------------------------------------------------*/
@@ -687,7 +687,7 @@ static struct mkiss *mkiss_get(struct tty_struct *tty)
 static void mkiss_put(struct mkiss *ax)
 {
 	if (atomic_dec_and_test(&ax->refcnt))
-		up(&ax->dead_sem);
+		complete(&ax->dead);
 }
 
 static int crc_force = 0;	/* Can be overridden with insmod */
@@ -715,7 +715,7 @@ static int mkiss_open(struct tty_struct *tty)
 
 	spin_lock_init(&ax->buflock);
 	atomic_set(&ax->refcnt, 1);
-	sema_init(&ax->dead_sem, 0);
+	init_completion(&ax->dead);
 
 	ax->tty = tty;
 	tty->disc_data = ax;
@@ -795,7 +795,7 @@ static void mkiss_close(struct tty_struct *tty)
 	 * we have to wait for all existing users to finish.
 	 */
 	if (!atomic_dec_and_test(&ax->refcnt))
-		down(&ax->dead_sem);
+		wait_for_completion(&ax->dead);
 	/*
 	 * Halt the transmit queue so that a new transmit cannot scribble
 	 * on our buffers
diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index bdc4d23627c5..288cf099876b 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -70,7 +70,7 @@ struct asyncppp {
 	struct tasklet_struct tsk;
 
 	refcount_t	refcnt;
-	struct semaphore dead_sem;
+	struct completion dead;
 	struct ppp_channel chan;	/* interface to generic ppp layer */
 	unsigned char	obuf[OBUFSIZE];
 };
@@ -148,7 +148,7 @@ static struct asyncppp *ap_get(struct tty_struct *tty)
 static void ap_put(struct asyncppp *ap)
 {
 	if (refcount_dec_and_test(&ap->refcnt))
-		up(&ap->dead_sem);
+		complete(&ap->dead);
 }
 
 /*
@@ -186,7 +186,7 @@ ppp_asynctty_open(struct tty_struct *tty)
 	tasklet_init(&ap->tsk, ppp_async_process, (unsigned long) ap);
 
 	refcount_set(&ap->refcnt, 1);
-	sema_init(&ap->dead_sem, 0);
+	init_completion(&ap->dead);
 
 	ap->chan.private = ap;
 	ap->chan.ops = &async_ops;
@@ -235,7 +235,7 @@ ppp_asynctty_close(struct tty_struct *tty)
 	 * by the time it returns.
 	 */
 	if (!refcount_dec_and_test(&ap->refcnt))
-		down(&ap->dead_sem);
+		wait_for_completion(&ap->dead);
 	tasklet_kill(&ap->tsk);
 
 	ppp_unregister_channel(&ap->chan);
-- 
2.20.0

