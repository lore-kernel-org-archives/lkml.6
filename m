Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE8AC282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC902070C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="MGq++3go"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbfBFANz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:13:55 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33342 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbfBFALT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:11:19 -0500
Received: by mail-ed1-f65.google.com with SMTP id p6so4517858eds.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 16:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G8ebtD0PUJZzL4V55Z6Zjj8nffme1FjZTkLJ2ixHSJ4=;
        b=MGq++3goR1a7kJbU4vTTpimixiyed7M0i0ACMPjuJYBknjvQH1297QuIzRXLwBbY70
         sX1Tcl6+dMBPfnTAyV8IrKgKud77KAIzVy5sCs4YenD3Cf6JVZmVPL2UqKH+QBV1/YHi
         9FMVeba/ep4x0CgxY+e9fabMUCcrHgYQruHVUYylDka8WVX1EDariVvXpgfKi+eUBXFB
         FNRNbpUSKeqfc+Liul01fku+tkupT9Ht9qJDLmtqHupfV5ePQBsiyRXUOjeO1JEeKnKr
         5xAQHgtZ3mnvGeYxw5w8CV2mdtwphPpwqKJC8dpwBBgBpdSIR2kdrCNbZ1LYJsgUwnYH
         m96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G8ebtD0PUJZzL4V55Z6Zjj8nffme1FjZTkLJ2ixHSJ4=;
        b=uWtbpzolU58yBT4LufQQKEeYeLQsZiFWq7A1gLjLrno6hFwDVSQcsZRrsPC5E8rakE
         YU9ZnYG76fHmDySLA9QhEvI7+XwtWGfTd6EFAF72jisKB//NudHZYZ42VasNz8egjLYg
         +HKeAIOgHS0EIbND1R7IBjrCIzqMHYUHZYriIEcEeNp5psRmgtMKhIM+aLoT93K3xc5+
         3OhRfcORXNcZTUgm5VO+T3T7qPg4V2Ae+CgE/ZZgSgYBF2J6vvHeOAs5F9yQvf6p5wse
         pTCh4gBJ+t1kYBK4OZftmreVnxSsd6MwAMwY+Jbw0RW2q7jFzcwKdbuHazE+VF0dzgdb
         NAJQ==
X-Gm-Message-State: AHQUAubr7CtuoT08QUi2rwsbfQFxM2QCiJvKNIc61DA0TOPru3a2MZw+
        woj7e1cXF1LwlWSr46zDJkE66Ondy+M=
X-Google-Smtp-Source: AHgI3IYt9ivLdqd64/Kd+jo1t5i2ADfwJoDkRG8OmY2t1mkzRcHoCjJyAoEQzWQCYkkhln1mlAK4vA==
X-Received: by 2002:a17:906:470a:: with SMTP id y10mr5311866ejq.236.1549411877498;
        Tue, 05 Feb 2019 16:11:17 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p30sm5489594eda.68.2019.02.05.16.11.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 05 Feb 2019 16:11:16 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Tucker <agtucker@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCH 06/32] posix-timers/timens: Take into account clock offsets
Date:   Wed,  6 Feb 2019 00:10:40 +0000
Message-Id: <20190206001107.16488-7-dima@arista.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206001107.16488-1-dima@arista.com>
References: <20190206001107.16488-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

Wire timer_settime() syscall into time namespace virtualization.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/time/posix-timers.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 782708054df2..d008dfd5b081 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -854,10 +854,6 @@ static int do_timer_settime(timer_t timer_id, int flags,
 	unsigned long flag;
 	int error = 0;
 
-	if (!timespec64_valid(&new_spec64->it_interval) ||
-	    !timespec64_valid(&new_spec64->it_value))
-		return -EINVAL;
-
 	if (old_spec64)
 		memset(old_spec64, 0, sizeof(*old_spec64));
 retry:
@@ -865,6 +861,15 @@ static int do_timer_settime(timer_t timer_id, int flags,
 	if (!timr)
 		return -EINVAL;
 
+	if (flags & TIMER_ABSTIME)
+		timens_clock_to_host(timr->it_clock, &new_spec64->it_value);
+
+	if (!timespec64_valid(&new_spec64->it_interval) ||
+	    !timespec64_valid(&new_spec64->it_value)) {
+		unlock_timer(timr, flag);
+		return -EINVAL;
+	}
+
 	kc = timr->kclock;
 	if (WARN_ON_ONCE(!kc || !kc->timer_set))
 		error = -EINVAL;
-- 
2.20.1

