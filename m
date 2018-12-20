Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE94C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5370221852
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297984;
	bh=g//RrL8METWwPMhlhnsTKj3bu4XG2nG50aMnPYDAwo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TT+IlgEw4+5jZ0cz+jSsadvVjhnPCKz0TSePogHIDE99Z6l28hpMQJ9KrXXml2tzf
	 EtJpPs2v7JOBKMc55qIt1Imom9mjdjvTx5ycKusGeNVbD+uX0/VqA639MVrdUpqQQj
	 7kCfpZe3rgFCHl9+tFm+5DygcNDt4eP1cVF6JuAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732090AbeLTJ0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:26:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:53306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730839AbeLTJ0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:26:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6DC5217D9;
        Thu, 20 Dec 2018 09:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297977;
        bh=g//RrL8METWwPMhlhnsTKj3bu4XG2nG50aMnPYDAwo0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hEx6s6R5UzJdcirStO7wgKEIKUuiobdEBzHKo5/W44nHTHk4r5zLp8M+zJpSbBO+S
         h5AFGZ9EBb8hOsIHrdxGbnVQailxympddQqERa5RHAkWHzjVv04kOeKNar1rT41P7a
         2pUCSdN8Mllfry6UQTJ5XkXEv9fEY9brr2eSbXhw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Waiman Long <longman@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, boqun.feng@gmail.com,
        linux-arm-kernel@lists.infradead.org, paulmck@linux.vnet.ibm.com,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 25/72] locking/qspinlock: Remove duplicate clear_pending() function from PV code
Date:   Thu, 20 Dec 2018 10:18:24 +0100
Message-Id: <20181220085923.323410216@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085922.332225035@linuxfoundation.org>
References: <20181220085922.332225035@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 3bea9adc96842b8a7345c7fb202c16ae9c8d5b25 upstream.

The native clear_pending() function is identical to the PV version, so the
latter can simply be removed.

This fixes the build for systems with >= 16K CPUs using the PV lock implementation.

Reported-by: Waiman Long <longman@redhat.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: boqun.feng@gmail.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: paulmck@linux.vnet.ibm.com
Link: http://lkml.kernel.org/r/20180427101619.GB21705@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/locking/qspinlock_paravirt.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 854443f7b60b..1e882dfc8b79 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -106,11 +106,6 @@ static __always_inline void set_pending(struct qspinlock *lock)
 	atomic_or(_Q_PENDING_VAL, &lock->val);
 }
 
-static __always_inline void clear_pending(struct qspinlock *lock)
-{
-	atomic_andnot(_Q_PENDING_VAL, &lock->val);
-}
-
 static __always_inline int trylock_clear_pending(struct qspinlock *lock)
 {
 	int val = atomic_read(&lock->val);
-- 
2.19.1



