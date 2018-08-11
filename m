Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7546CC46464
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 02:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8FE22430
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 02:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9sM9xws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8FE22430
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbeHKFIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 01:08:09 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42505 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbeHKFIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 01:08:09 -0400
Received: by mail-pl0-f65.google.com with SMTP id g6-v6so4739114plq.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 19:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jttnbhd4Er7Bk31HDxo7R23H6lhSzWKwj8rB7AhvxiU=;
        b=e9sM9xwsinY/v05qig8Jm3pReghkRU4vY5RDNqV7Kp41uHNaKmKJHHa/bYTq4fd91f
         4F3y3BxBzX6623c846JiiIw8476oahTP9b5HaolWiDFvR244UhblnFhkDn2GKJEbya6W
         aJbAHuKofXq8DbZrh+L9e4aR1FTfX/9QqeqjLj7NMwKS1Co2QxGs++6kNbqdpW4413lL
         ejb1DJ0aYN51tSiC/Rlf4Rh8UOeeZlhJcvKvayLcy5e2SR7H6FpU8wMo3NE4y9shJt4o
         BurMG0aTCML5CfTh0XBt8+aymjAFsdUwuj28HQ/JQRG9qqBNi6j8ozo4QnhY4Sj3ETwa
         R+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jttnbhd4Er7Bk31HDxo7R23H6lhSzWKwj8rB7AhvxiU=;
        b=m53LloNXB9s867abeDKco6dcBwcBLWhTpuvtK56cMseFZ9VRFfKuGL4nhCZJcr7HKV
         GKEShRrtr+wrj9GYJIcaNhnnBYTYEtVVCd6VqTAL/keEr0MkNh+wUogMFyo2CyB+MfDM
         zFxTvpj2XZSAF4Eu6fjHK7voO+3TwUTZ6Br615nQLRdwljIhmIq5pG/iOXkNREfWV/1v
         Dg3Vo9g79sOI+I5smXO45sH0pvItz2CjjXIQLcw+Rzbo4dqQsRgeauiNDmGwWXKS0lvr
         UQafNbxRnOAh/LKAZgOvEMcCaWI1AfTYtMVqfHDdNHDbl3VNMpehQ+mJM28DAUH87rMJ
         RNrw==
X-Gm-Message-State: AOUpUlG0GJJBrMoGCWc8KL5R6N/wFkcy7KN8+XKTAML7GzNHptkbmB8k
        aMtyNJoLuOx9KweCkz1KllA=
X-Google-Smtp-Source: AA+uWPyAtq+JersKV7E0dGgXAVv5NrJscOPglVLO5VMcFtZXaHNM/w3ATQoslH3Jo6VpqykaXvaZzg==
X-Received: by 2002:a17:902:33c2:: with SMTP id b60-v6mr8338176plc.11.1533954939829;
        Fri, 10 Aug 2018 19:35:39 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:a5a3:1607:66e7:4841])
        by smtp.gmail.com with ESMTPSA id t12-v6sm20233537pgg.72.2018.08.10.19.35.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 19:35:39 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com
Cc:     linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] kernel: locking: rtmutex: Fix a possible sleep-in-atomic-context bug in rt_mutex_handle_deadlock()
Date:   Sat, 11 Aug 2018 10:35:24 +0800
Message-Id: <20180811023524.13845-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep with holding a spinlock.

The function call paths (from bottom to top) in Linux-4.16 are:

[FUNC] schedule
kernel/locking/rtmutex.c, 1223: 
	schedule in rt_mutex_handle_deadlock
kernel/locking/rtmutex.c, 1273: 
	rt_mutex_handle_deadlock in rt_mutex_slowlock
kernel/locking/rtmutex.c, 1249: 
	_raw_spin_lock_irqsave in rt_mutex_slowlock

To fix the bug, the spinlock is released before schedule() and then acquired again.
This is found by my static analysis tool (DSAC).

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 kernel/locking/rtmutex.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 2823d4163a37..af03e162f812 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1205,7 +1205,7 @@ __rt_mutex_slowlock(struct rt_mutex *lock, int state,
 }
 
 static void rt_mutex_handle_deadlock(int res, int detect_deadlock,
-				     struct rt_mutex_waiter *w)
+				     struct rt_mutex_waiter *w, struct rt_mutex *lock)
 {
 	/*
 	 * If the result is not -EDEADLOCK or the caller requested
@@ -1219,8 +1219,10 @@ static void rt_mutex_handle_deadlock(int res, int detect_deadlock,
 	 */
 	rt_mutex_print_deadlock(w);
 	while (1) {
+		raw_spin_unlock_irq(&lock->wait_lock);
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule();
+		raw_spin_lock_irq(&lock->wait_lock);
 	}
 }
 
@@ -1269,7 +1271,7 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
 	if (unlikely(ret)) {
 		__set_current_state(TASK_RUNNING);
 		remove_waiter(lock, &waiter);
-		rt_mutex_handle_deadlock(ret, chwalk, &waiter);
+		rt_mutex_handle_deadlock(ret, chwalk, &waiter, lock);
 	}
 
 	/*
-- 
2.17.0

