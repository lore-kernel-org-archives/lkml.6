Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89303C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3133420833
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="poT1x2Ka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3133420833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeIKQ6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 12:58:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60142 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbeIKQ6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 12:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fo7y2hfhD496olj7c22vN/Iq8vx+OSXh9VhyM/uSJW8=; b=poT1x2KaBdjCIiaFrNNRUETPp
        BC29vfMTfS0XUkvCpzEGsfCmEVfI2sdHz4VSZqEYG4fj2l3KWKOG7zCA+KXMzXaRnufQdxKA4G9AO
        tFMJttoVzF8evg8sqHrcJtgjN6sPklo5O61KWtKzhtZ2KOqVZ4k1XotDp/l2jDhM/C1LA/og5LUes
        SxVCm6Gvbz2FNni+l8MY8ZAICUGxSzVn49ItAEjQFo4WizK38YBjKZv26AxDzNBBFzQOBnjNHiy3H
        aVDzjK6aQwPjzCIW3maNqSM1g0VsV8xMW5in2rWuqoG55FLe5D3jhnUBGt7rihh1bCPRav452gOjP
        q/F5hABfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzhKP-0005kV-JL; Tue, 11 Sep 2018 11:59:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 446992057F834; Tue, 11 Sep 2018 13:59:32 +0200 (CEST)
Date:   Tue, 11 Sep 2018 13:59:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan March <nathan@gt.net>,
        Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        "Rong, Chen" <rong.a.chen@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCHv3 4/6] tty/lockdep: Add ldisc_sem asserts
Message-ID: <20180911115932.GA19234@hirez.programming.kicks-ass.net>
References: <20180911014821.26286-1-dima@arista.com>
 <20180911014821.26286-5-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911014821.26286-5-dima@arista.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: tty/ldsem: Convert to regular lockdep annotations

For some reason ldsem has its own lockdep wrappers, make them go away.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/tty/tty_ldsem.c | 51 ++++++++++++++-----------------------------------
 1 file changed, 14 insertions(+), 37 deletions(-)

diff --git a/drivers/tty/tty_ldsem.c b/drivers/tty/tty_ldsem.c
index 0c98d88f795a..60beada5be6c 100644
--- a/drivers/tty/tty_ldsem.c
+++ b/drivers/tty/tty_ldsem.c
@@ -34,29 +34,6 @@
 #include <linux/sched/task.h>
 
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-# define __acq(l, s, t, r, c, n, i)		\
-				lock_acquire(&(l)->dep_map, s, t, r, c, n, i)
-# define __rel(l, n, i)				\
-				lock_release(&(l)->dep_map, n, i)
-#define lockdep_acquire(l, s, t, i)		__acq(l, s, t, 0, 1, NULL, i)
-#define lockdep_acquire_nest(l, s, t, n, i)	__acq(l, s, t, 0, 1, n, i)
-#define lockdep_acquire_read(l, s, t, i)	__acq(l, s, t, 1, 1, NULL, i)
-#define lockdep_release(l, n, i)		__rel(l, n, i)
-#else
-# define lockdep_acquire(l, s, t, i)		do { } while (0)
-# define lockdep_acquire_nest(l, s, t, n, i)	do { } while (0)
-# define lockdep_acquire_read(l, s, t, i)	do { } while (0)
-# define lockdep_release(l, n, i)		do { } while (0)
-#endif
-
-#ifdef CONFIG_LOCK_STAT
-# define lock_stat(_lock, stat)		lock_##stat(&(_lock)->dep_map, _RET_IP_)
-#else
-# define lock_stat(_lock, stat)		do { } while (0)
-#endif
-
-
 #if BITS_PER_LONG == 64
 # define LDSEM_ACTIVE_MASK	0xffffffffL
 #else
@@ -310,17 +287,17 @@ static int __ldsem_down_read_nested(struct ld_semaphore *sem,
 {
 	long count;
 
-	lockdep_acquire_read(sem, subclass, 0, _RET_IP_);
+	rwsem_acquire_read(&sem->dep_map, subclass, 0, _RET_IP_);
 
 	count = atomic_long_add_return(LDSEM_READ_BIAS, &sem->count);
 	if (count <= 0) {
-		lock_stat(sem, contended);
+		lock_contended(&sem->dep_map, _RET_IP_);
 		if (!down_read_failed(sem, count, timeout)) {
-			lockdep_release(sem, 1, _RET_IP_);
+			rwsem_release(&sem->dep_map, 1, _RET_IP_);
 			return 0;
 		}
 	}
-	lock_stat(sem, acquired);
+	lock_acquired(&sem->dep_map, _RET_IP_);
 	return 1;
 }
 
@@ -329,17 +306,17 @@ static int __ldsem_down_write_nested(struct ld_semaphore *sem,
 {
 	long count;
 
-	lockdep_acquire(sem, subclass, 0, _RET_IP_);
+	rwsem_acquire(&sem->dep_map, subclass, 0, _RET_IP_);
 
 	count = atomic_long_add_return(LDSEM_WRITE_BIAS, &sem->count);
 	if ((count & LDSEM_ACTIVE_MASK) != LDSEM_ACTIVE_BIAS) {
-		lock_stat(sem, contended);
+		lock_contended(&sem->dep_map, _RET_IP_);
 		if (!down_write_failed(sem, count, timeout)) {
-			lockdep_release(sem, 1, _RET_IP_);
+			rwsem_release(&sem->dep_map, 1, _RET_IP_);
 			return 0;
 		}
 	}
-	lock_stat(sem, acquired);
+	lock_acquired(&sem->dep_map, _RET_IP_);
 	return 1;
 }
 
@@ -362,8 +339,8 @@ int ldsem_down_read_trylock(struct ld_semaphore *sem)
 
 	while (count >= 0) {
 		if (atomic_long_try_cmpxchg(&sem->count, &count, count + LDSEM_READ_BIAS)) {
-			lockdep_acquire_read(sem, 0, 1, _RET_IP_);
-			lock_stat(sem, acquired);
+			rwsem_acquire_read(&sem->dep_map, 0, 1, _RET_IP_);
+			lock_acquired(&sem->dep_map, _RET_IP_);
 			return 1;
 		}
 	}
@@ -388,8 +365,8 @@ int ldsem_down_write_trylock(struct ld_semaphore *sem)
 
 	while ((count & LDSEM_ACTIVE_MASK) == 0) {
 		if (atomic_long_try_cmpxchg(&sem->count, &count, count + LDSEM_WRITE_BIAS)) {
-			lockdep_acquire(sem, 0, 1, _RET_IP_);
-			lock_stat(sem, acquired);
+			rwsem_acquire(&sem->dep_map, 0, 1, _RET_IP_);
+			lock_acquired(&sem->dep_map, _RET_IP_);
 			return 1;
 		}
 	}
@@ -403,7 +380,7 @@ void ldsem_up_read(struct ld_semaphore *sem)
 {
 	long count;
 
-	lockdep_release(sem, 1, _RET_IP_);
+	rwsem_release(&sem->dep_map, 1, _RET_IP_);
 
 	count = atomic_long_add_return(-LDSEM_READ_BIAS, &sem->count);
 	if (count < 0 && (count & LDSEM_ACTIVE_MASK) == 0)
@@ -417,7 +394,7 @@ void ldsem_up_write(struct ld_semaphore *sem)
 {
 	long count;
 
-	lockdep_release(sem, 1, _RET_IP_);
+	rwsem_release(&sem->dep_map, 1, _RET_IP_);
 
 	count = atomic_long_add_return(-LDSEM_WRITE_BIAS, &sem->count);
 	if (count < 0)
