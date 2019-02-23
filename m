Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC19AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89ECF2084F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="s/78w0YG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfBWGfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 01:35:01 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42888 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbfBWGe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 01:34:57 -0500
Received: by mail-qt1-f193.google.com with SMTP id b8so5097325qtr.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 22:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j9uaH19zzwr4OSX1n04BhljetL/RmyflP+g9OcvA0u0=;
        b=s/78w0YGTc2XtFwNSTGRH7EzLpdGadOr9CbcH16Ykl04d98Jj2wGbWSxhbnjOTpfrZ
         OIuG3RiwNiWryVdu02ArDq7KDyDswe9l8C+bgbkSuPtmL8rpmqfWW2ShIN1TGHSegkj6
         ErshRyL42Z8mIhldo1XK/Q7NCZuHNZKcERyNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j9uaH19zzwr4OSX1n04BhljetL/RmyflP+g9OcvA0u0=;
        b=ir2vfnqqTUIRpQ8IXMvfh5nJeTjnwTwVOmrUqkukH7dliuCjoFeipT0G92r4pbO0Yt
         bzKQUNyeakQyuYX5MKmIP1zwmpOSpuGQZe3xgzuKWO7Yj5GLJno+PaZWngrTdNwLjuNJ
         77aCObryuwB2Arw/9EG9v1VkaQQ7jVOxht5bd+S4pqu9uY1eeu6ANbKNh2Zu0GK5HOna
         ePXrxA+VEVi0o0kB5SmVHjiHeq0DuU87x0kSEjlpQLlfZtfGCpHdf2bdzi0MfuxmxZzL
         i0VucBiNH84dHTofysz/vJUjAmcc1KUMvG36T27+M7VAQ6n6u+rS/9E/W8IWKvL1IsMc
         ZLEA==
X-Gm-Message-State: AHQUAubQULD1cHtKTiTy7+c8qmHIPfhkJSXE3qqXOZlUWouYckrKE57E
        qciiy9oIrtS/WQaMaDSlDevB0U4Zz1g=
X-Google-Smtp-Source: AHgI3IbH9rbs5/xUnSBNzQ1jBth6cKcBV/4cG/qubG7uaPWUv4MRKW8heTjLFYj1yn326XSsWSWbXg==
X-Received: by 2002:ac8:29e8:: with SMTP id 37mr6232688qtt.153.1550903695498;
        Fri, 22 Feb 2019 22:34:55 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id d32sm2189408qtc.88.2019.02.22.22.34.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 22:34:54 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        netdev@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Perret <quentin.perret@arm.com>, rcu@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xdp-newbies@vger.kernel.org, Yonghong Song <yhs@fb.com>
Subject: [PATCH v2 3/6] sched/cpufreq: Annotate cpufreq_update_util_data pointer with __rcu
Date:   Sat, 23 Feb 2019 01:34:31 -0500
Message-Id: <20190223063434.6793-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190223063434.6793-1-joel@joelfernandes.org>
References: <20190223063434.6793-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently I added an RCU annotation check to rcu_assign_pointer(). All
pointers assigned to RCU protected data are to be annotated with __rcu
inorder to be able to use rcu_assign_pointer() similar to checks in
other RCU APIs.

This resulted in a sparse error: kernel//sched/cpufreq.c:41:9: sparse:
error: incompatible types in comparison expression (different address
spaces)

Fix this by annotating cpufreq_update_util_data pointer with __rcu. This
will also help sparse catch any future RCU misuage bugs.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/cpufreq.c | 2 +-
 kernel/sched/sched.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
index 22bd8980f32f..e316ee7bb2e5 100644
--- a/kernel/sched/cpufreq.c
+++ b/kernel/sched/cpufreq.c
@@ -7,7 +7,7 @@
  */
 #include "sched.h"
 
-DEFINE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
+DEFINE_PER_CPU(struct update_util_data __rcu *, cpufreq_update_util_data);
 
 /**
  * cpufreq_add_update_util_hook - Populate the CPU's update_util_data pointer.
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d04530bf251f..2ab545d40381 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2166,7 +2166,7 @@ static inline u64 irq_time_read(int cpu)
 #endif /* CONFIG_IRQ_TIME_ACCOUNTING */
 
 #ifdef CONFIG_CPU_FREQ
-DECLARE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
+DECLARE_PER_CPU(struct update_util_data __rcu *, cpufreq_update_util_data);
 
 /**
  * cpufreq_update_util - Take a note about CPU utilization changes.
-- 
2.21.0.rc0.258.g878e2cd30e-goog

