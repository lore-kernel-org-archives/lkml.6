Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45B1C4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 03:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4598022438
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 03:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOM+Wpv1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4598022438
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbeHKFdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 01:33:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36400 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbeHKFdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 01:33:23 -0400
Received: by mail-pg1-f195.google.com with SMTP id h12-v6so5196030pgs.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 20:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=B9vO4OXrh3KNw+pSpZxYm5noIXOJzlSyxuge9i+Dg5I=;
        b=fOM+Wpv1CunMnB2WcO9V7/JxlQHveEeGI5Y8gpWXW/QQi/IxOr2CLG0j3+n8OxGRRK
         xW68GhknzVdzcNegO+IIzsmcj67/QaDNiPpNA2xLiUyeH5nLDaed7fNuzLo6T49s/TtE
         ukuQqTT5m9b1mqJIqVxYGEMQ8WF0W1TRTkxYsrGcXo3P8wiH8nQ+0iv/bJXesqTKJTNH
         zYsA/l69JBGpD6ATIMnDCpeSl2No8YtsffRLhD7TDRvqGVBc9Yx79cRSxVJ5Hi5LybFm
         JQPvZlLfc2daU/h2UXnryeNiZehSURG8zwJ0nRKlCNA7O2JUYDKWi1kAH2FlgXEBrWhx
         G6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B9vO4OXrh3KNw+pSpZxYm5noIXOJzlSyxuge9i+Dg5I=;
        b=HAcpN7paBt9zwIZnjl647QIpjE48r1XdeyefI6v5lie5QWa/tBrjc9xmoZsXhw8pOi
         tHZ0CpAe4iExaPbnx/Mre+Oq+M/nZuiaQfSD3EriSVYouT7FCKx49JLycD2nvWnuFvXk
         6jJ8/KN3BY/yy5BlQ3F71Sog+t7fRdUu9CUKsKi6AN5RYIA9lID5DpO9emXeIy0WhRbG
         JpCA57gZwNVvLrfWwiROyTcXUexmZ9Z+HeOBY0La+ay5VvYrQY0Ds95qYOFfn3G6sqnw
         c40sqoXyUka0YcMdLWpyUkcVSLIAr+2vLT3bes3zSKeNBBUhYTMnKC5RF02aPILOs963
         vhwg==
X-Gm-Message-State: AOUpUlGDj9AQHo0kAg4Hi1jjzKF0WLrH3nYNsbgz/peq3vWrC6JA1mnw
        7AuZ5WE5pBJ5+DkXzCUoIGw=
X-Google-Smtp-Source: AA+uWPzWXJTpVLN6KHJoP/nHT+xs/gThxplPYaedorlc2cfJhbdiF6vYCJhE27G1A7p68NsuyCoKhw==
X-Received: by 2002:a62:5302:: with SMTP id h2-v6mr9620552pfb.183.1533956449324;
        Fri, 10 Aug 2018 20:00:49 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:a5a3:1607:66e7:4841])
        by smtp.gmail.com with ESMTPSA id q85-v6sm18846365pfa.151.2018.08.10.20.00.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 20:00:48 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com
Cc:     linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH V2] kernel: locking: rtmutex: Fix a possible sleep-in-atomic-context bug in rt_mutex_handle_deadlock()
Date:   Sat, 11 Aug 2018 11:00:37 +0800
Message-Id: <20180811030037.14885-1-baijiaju1990@gmail.com>
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

To fix the bug, the spinlock is released before the loop of schedule()
This is found by my static analysis tool (DSAC).

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
v2:
* Release the spinlock before the loop, instead of v1 that releases the
  spinlock before schedule() and then acquires the spinlock again.
  Thank Steven for good advice.
---
 kernel/locking/rtmutex.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 2823d4163a37..8f25a289abe8 100644
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
@@ -1218,6 +1218,8 @@ static void rt_mutex_handle_deadlock(int res, int detect_deadlock,
 	 * Yell lowdly and stop the task right here.
 	 */
 	rt_mutex_print_deadlock(w);
+	/* We're not going anywhere, release the wait_lock */
+	raw_spin_unlock_irq(&lock->wait_lock);
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule();
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

