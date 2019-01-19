Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A302C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 16:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED2F2084F
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 16:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="QaGNlyED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbfASQO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 11:14:59 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33534 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbfASQO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 11:14:59 -0500
Received: by mail-qt1-f194.google.com with SMTP id l11so18709712qtp.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 08:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e6yMb6PRHmeFDBnmK1UMXlNWyico8bLjeKf61ZSNHSU=;
        b=QaGNlyEDLCO3RK5ybtRJ/2ez07NsZyJIa1NB7+Cz/fZZzHXhfQeaVoMUmfb3o3fchu
         NTcqgK0tn03mvjCMauWGhE+rk1ENFenVDCFm0j6Z92NXQDXy9AJACWxXnuPYPXgABEKL
         tt1FR0PG7Rj9ilaeVtFG/IAlvy216UhS4LPYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e6yMb6PRHmeFDBnmK1UMXlNWyico8bLjeKf61ZSNHSU=;
        b=YIcsna4Vs46fCIXMk/yPGhARGYpir5eo4abY/qHLyN2OYt+VkgloqadG8m+zXIJaui
         SggUk8SLqEx2BWvrm3JkYJXOlGi9HF1GsRIMxOLJ56nGw6Y4VCS3gmBhw60VFkgKNUBf
         1Us2au9x3KnLdbYKQxIkz89qNlcy/QzUCIYv50kdpMCOfqQm01GgK6Z1oj8egxk7g4NY
         8qFlVUgI3SRla+bhti/1aoCwox50iaapyK6Lo1C3Bjq2Bek18J2Nn7ECLzjhYrdiUfgD
         1maRCinY7/dx50hBJMZfu3iZtWy1PyvtOLq0vpoTTD6NPdpac0kKe+HXee7YuMJG+Mf6
         ApHQ==
X-Gm-Message-State: AJcUukdibeqoHhrqSDSV8+PrGnUrlb+wHaC61ztd2sXmJQY0W5cx0v2r
        wQmsfH+sBCoXIiOMTtaAasjRwiMbEcU=
X-Google-Smtp-Source: ALg8bN6nQ5FM9dQz8wUXybMHVJVUNhOjpINhbbo+LoDbIzCBDm80cFSQhQK9OaZEUl/YbdonwnMBFw==
X-Received: by 2002:ac8:7353:: with SMTP id q19mr20125197qtp.265.1547914497548;
        Sat, 19 Jan 2019 08:14:57 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id u50sm70960256qta.23.2019.01.19.08.14.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 08:14:56 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC] rcu: Avoid unnecessary softirq when system is idle
Date:   Sat, 19 Jan 2019 11:14:18 -0500
Message-Id: <20190119161418.231042-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there are no callbacks pending on an idle system, I noticed that
RCU softirq is continuously firing. During this the cpu_no_qs is set to
false, and core_needs_qs is set to true indefinitely. This causes
rcu_process_callbacks to be repeatedly called, even though the node
corresponding to the CPU has that CPU's mask bit cleared and the system
is idle. I believe the race is when such mask clearing is done during
idle CPU scan of the quiescent state forcing stage in the kthread
instead of the softirq. Since the rnp mask is cleared, but the flags on
the CPU's rdp are not cleared, the CPU thinks it still needs to report
to core RCU.

Cure this by clearing the core_needs_qs flag when the CPU detects that
its node is already updated which will avoid the unwanted softirq raises
to the benefit of real-time systems.

Test: Ran rcutorture for various tree RCU configs.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9180158756d2..96ad80c76b15 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2273,6 +2273,7 @@ rcu_report_qs_rdp(int cpu, struct rcu_data *rdp)
 	}
 	mask = rdp->grpmask;
 	if ((rnp->qsmask & mask) == 0) {
+		rdp->core_needs_qs = false;
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	} else {
 		rdp->core_needs_qs = false;
-- 
2.20.1.321.g9e740568ce-goog

