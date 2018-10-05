Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA633C65BD0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 23:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1573206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 23:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="XjhtMzt5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1573206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbeJFGT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 02:19:27 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41780 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729070AbeJFGT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 02:19:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id m77-v6so5730927pfi.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 16:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YA9WH3pfYU6schmD91/Hmd5hK9+CpUcqh3SP6wwSGRA=;
        b=XjhtMzt5Xd6fiPGeYST7XCyh8L60eEuk07+Hm95TeHuDpkYIsD45rr9NBSEd1Vi3It
         MhUw3JiOoIlGryCXOsgG6KK1GMC82uGIEOXSioQPmpQ5DCvZekWkQXGCY/sshKPyc1Fy
         Jnz4p3xlqd6fxMP4BwhyEdI7g7e/zeGcdvTz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YA9WH3pfYU6schmD91/Hmd5hK9+CpUcqh3SP6wwSGRA=;
        b=Mb9EIt65uIIB/Seec7G1RW5GY+9VQEKaMK/pfxR2H+UF5XxIVmFo2zs7ZsBgviZIDQ
         fWbs/rDfsI8JcKQCcqqPKhf/EJYcy1M6Q1dbeFiK0ES+4UHUwTywvCj8yHtq+HQwiiNJ
         s0uj5IINpAyuq3Z+xacUAMIlxYBSB3vacgyoQ9wHSG4jt0OqPMfCDxZcfELTbqkB3Rrs
         rjlTYtTDfNTboxrf1iv4XzFLJoHWeG/RHxDE7m8fMzcndAO03RT0KE8jrDzHupTJfZwO
         EZ87Jfh9ii53NKB8h4dt0R98ZVkbhphPnfJZ9czbhJKdOY2vxHOaDKTxba6BGUDP/A+r
         kN2g==
X-Gm-Message-State: ABuFfoii73vxchVK2uQEwXk2l06U6rT8P8KQVSkw5TeAdFqOpTua38rc
        cqndTaU7mHFVPyPC2iA+4iJNcjdirmA=
X-Google-Smtp-Source: ACcGV621aXYCsucSyU0/Rh3IRnWXf4FMAI2g+LOkygUhhZsXWSi62pyIDHV8XrImCLt/6bsfYRC8hQ==
X-Received: by 2002:a63:608c:: with SMTP id u134-v6mr11850262pgb.266.1538781511252;
        Fri, 05 Oct 2018 16:18:31 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id q76-v6sm16641028pfa.18.2018.10.05.16.18.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 16:18:29 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>, pantin@google.com
Subject: [PATCH RFC 2/5] doc: rcu: Add more rationale for using rcu_read_lock_sched in checklist
Date:   Fri,  5 Oct 2018 16:18:11 -0700
Message-Id: <20181005231815.170433-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181005231815.170433-1-joel@joelfernandes.org>
References: <20181005231815.170433-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It could be clarified better why rcu_read_lock_sched is better than
using preempt_disable, add the same.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 Documentation/RCU/checklist.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/checklist.txt b/Documentation/RCU/checklist.txt
index 49747717d905..8860ab2a897a 100644
--- a/Documentation/RCU/checklist.txt
+++ b/Documentation/RCU/checklist.txt
@@ -63,7 +63,7 @@ over a rather long period of time, but improvements are always welcome!
 	pointer must be covered by rcu_read_lock(), rcu_read_lock_bh(),
 	rcu_read_lock_sched(), or by the appropriate update-side lock.
 	Disabling of preemption can serve as rcu_read_lock_sched(), but
-	is less readable.
+	is less readable and prevents lockdep from detecting locking issues.
 
 	Letting RCU-protected pointers "leak" out of an RCU read-side
 	critical section is every bid as bad as letting them leak out
-- 
2.19.0.605.g01d371f741-goog

