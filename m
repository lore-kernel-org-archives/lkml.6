Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040F0C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 23:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B6A2150E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 23:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="fRsLbea0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B6A2150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbeIWFhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 01:37:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33965 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbeIWFhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 01:37:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id k19-v6so7521953pfi.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 16:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gcw9CPSV3u4YZIhv/1kFUlTXnlNjBUBOnEHeo2kzAG8=;
        b=fRsLbea0WqRNuUF/D8fiemmJvAOCLFkpp5qlftzGN5aLY+hZvkgUZ/7w6LeI7hwozy
         iTA9JYcxARVNloV04ELd8eqgaVO2JHPcmoZ+vKpcRzBx+hpLoCHlmYxEzQZbmiROeMph
         +TsZFHV1KZUuKbYXkWRsUGgC46fGD16VRzh6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gcw9CPSV3u4YZIhv/1kFUlTXnlNjBUBOnEHeo2kzAG8=;
        b=eZWWldkan3AEk8x1pGhxxcxXkR9GUi2PIB+x5kBAYZ4csUd3ocwvrDl9lCsx64qibe
         VCamWcRTcjb07HB8XeFwhv3TGngAWAcn8JfNeQIwSXlAxagQhlOKVpcm9QPuW78gCuGv
         zS0h2ujLPj8IzS1Nu91R3fzFrhvx9UX42QJ7uI0LfWlGz6NSFIxUivZR5QGKkHBjrzJI
         ZLBbfgQYvABnWjaCEFsc6wvgJtLpB2YlI4Qf5Q5blAhRtyBcVeBn7bUkNzQxYznP4mdj
         hSXtS/cOfx1bsPKvjbGA3o0TlHavDEXdiPZGOeeK2Le8UOcZ1zKAvSMSvgL8uKSBXHEu
         qJjA==
X-Gm-Message-State: ABuFfoj7hppiay7/aesdZ84UnCj1cgfD4J9rcBUeJQIQAiz6yTGOQPDl
        NKsQ6Okb693gNckiQcsv/wyzZuS5Krk=
X-Google-Smtp-Source: ACcGV61HqTSEmA6k1xeHjIqiB46mqmWw/Rc7H8WwHSLt/o7nNRkGfvUeoSl6rq0AnOYEgRP3uAEFHg==
X-Received: by 2002:a65:594b:: with SMTP id g11-v6mr3710808pgu.260.1537659702332;
        Sat, 22 Sep 2018 16:41:42 -0700 (PDT)
Received: from joelaf-glaptop0.roam.corp.google.com (c-98-210-118-128.hsd1.ca.comcast.net. [98.210.118.128])
        by smtp.gmail.com with ESMTPSA id h4-v6sm32377789pgp.13.2018.09.22.16.41.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 16:41:41 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RFC 3/3] Documentation: RCU: Fix rcu_preempt_state reference in stallwarn
Date:   Sat, 22 Sep 2018 19:41:27 -0400
Message-Id: <20180922234127.94970-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
In-Reply-To: <20180922234127.94970-1-joel@joelfernandes.org>
References: <20180922234127.94970-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rcu_preempt_state doesn't exist anymore. Update stallwarn documentation
accordingly.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 Documentation/RCU/stallwarn.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/stallwarn.txt b/Documentation/RCU/stallwarn.txt
index 491043fd976f..b6bc7a2a9961 100644
--- a/Documentation/RCU/stallwarn.txt
+++ b/Documentation/RCU/stallwarn.txt
@@ -176,9 +176,8 @@ causing stalls, and that the stall was affecting RCU-sched.  This message
 will normally be followed by stack dumps for each CPU.  Please note that
 PREEMPT_RCU builds can be stalled by tasks as well as by CPUs, and that
 the tasks will be indicated by PID, for example, "P3421".  It is even
-possible for a rcu_preempt_state stall to be caused by both CPUs -and-
-tasks, in which case the offending CPUs and tasks will all be called
-out in the list.
+possible for a rcu_state stall to be caused by both CPUs -and- tasks,
+in which case the offending CPUs and tasks will all be called out in the list.
 
 CPU 2's "(3 GPs behind)" indicates that this CPU has not interacted with
 the RCU core for the past three grace periods.  In contrast, CPU 16's "(0
-- 
2.19.0.444.g18242da7ef-goog

