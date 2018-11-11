Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D97DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5423920862
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMi078bs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5423920862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390310AbeKLIWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:22:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:51232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390276AbeKLIWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:08 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC9352241E;
        Sun, 11 Nov 2018 22:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975530;
        bh=bZjBCr2byS1GUHy2AvAwRp32O49qr+E3PuaJQch557g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CMi078bsAR79QOKbbUqXkqZgHNXxhIOVdWvl8wOubt7f/GqxMt/1BaNC93UTnO3NQ
         OyL+uUjEam/GSreQlpjO+hsl+dew3Ok43KuORjV0MKUYo2RhAzhncUOh5c0WU7rcoj
         NY2C7THAffm90h6aDsB8mmtfLuO8R+xHaHARBYS8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 039/222] locking/lockdep: Fix debug_locks off performance problem
Date:   Sun, 11 Nov 2018 14:22:16 -0800
Message-Id: <20181111221651.679122759@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Waiman Long <longman@redhat.com>

[ Upstream commit 9506a7425b094d2f1d9c877ed5a78f416669269b ]

It was found that when debug_locks was turned off because of a problem
found by the lockdep code, the system performance could drop quite
significantly when the lock_stat code was also configured into the
kernel. For instance, parallel kernel build time on a 4-socket x86-64
server nearly doubled.

Further analysis into the cause of the slowdown traced back to the
frequent call to debug_locks_off() from the __lock_acquired() function
probably due to some inconsistent lockdep states with debug_locks
off. The debug_locks_off() function did an unconditional atomic xchg
to write a 0 value into debug_locks which had already been set to 0.
This led to severe cacheline contention in the cacheline that held
debug_locks.  As debug_locks is being referenced in quite a few different
places in the kernel, this greatly slow down the system performance.

To prevent that trashing of debug_locks cacheline, lock_acquired()
and lock_contended() now checks the state of debug_locks before
proceeding. The debug_locks_off() function is also modified to check
debug_locks before calling __debug_locks_off().

Signed-off-by: Waiman Long <longman@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Link: http://lkml.kernel.org/r/1539913518-15598-1-git-send-email-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/locking/lockdep.c |    4 ++--
 lib/debug_locks.c        |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4215,7 +4215,7 @@ void lock_contended(struct lockdep_map *
 {
 	unsigned long flags;
 
-	if (unlikely(!lock_stat))
+	if (unlikely(!lock_stat || !debug_locks))
 		return;
 
 	if (unlikely(current->lockdep_recursion))
@@ -4235,7 +4235,7 @@ void lock_acquired(struct lockdep_map *l
 {
 	unsigned long flags;
 
-	if (unlikely(!lock_stat))
+	if (unlikely(!lock_stat || !debug_locks))
 		return;
 
 	if (unlikely(current->lockdep_recursion))
--- a/lib/debug_locks.c
+++ b/lib/debug_locks.c
@@ -37,7 +37,7 @@ EXPORT_SYMBOL_GPL(debug_locks_silent);
  */
 int debug_locks_off(void)
 {
-	if (__debug_locks_off()) {
+	if (debug_locks && __debug_locks_off()) {
 		if (!debug_locks_silent) {
 			console_verbose();
 			return 1;


