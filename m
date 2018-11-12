Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856EAC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7572245E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GOsVvVTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F7572245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbeKMEVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 23:21:52 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46266 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730320AbeKMEVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 23:21:46 -0500
Received: by mail-pl1-f194.google.com with SMTP id t13so1754899ply.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 10:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m3Zzyja+eN7PZjh1JxBMeDW55sSSmajSLUw8jt2WPJk=;
        b=GOsVvVTF4mu5YBvNxsP3yvG6ZjWpY3v0VdwJ0vkPcUzuoaCRV35hJr4lvjWKWBz+cS
         eVNd74Y/S/+daC+Vy2t/z9d+IyxFdTCSWgjsFZXQdvimy+NNHu5dqO/xIxP4ujrzQJVQ
         JyZ0gdmP89zL7yFQKTBnrGDfT33IIfjsdagLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m3Zzyja+eN7PZjh1JxBMeDW55sSSmajSLUw8jt2WPJk=;
        b=m6zhg4uJoF7VtQJIzIJndl4qX3HOgMvTNkQje9VPhnY5eAR3iOCPGYsVFD2c5mq6GZ
         pFOPPjOk+YmnxY5QcKmDBAFmFqy0aqo0Stetv7EpkRSjc+RJGROp8odncJa3BKN5FC52
         NnREaSAkrZVFhMaQyUVVe6RtR9cj3r3IuA2ZV04ZvnEgm6wWyw/1CVo9xBNxeJkLesc/
         +0s/piVM6bTcnZ6+sn/IuJaXwumS8zq3h3BtywcNHe1XuNVrfFb84kIHTmOzJ0XSgqt1
         CPL6JsJXf2215kY1dTZb10Hhv5toDL86ZacPvS2MxAaqCeHN61LSTVq9VJZOkGl5xdqp
         cgTQ==
X-Gm-Message-State: AGRZ1gKRyR/jDoiYkyPYLzmPDQRWXP+IvoYvgEeKbg1svuTDhOhptipE
        Ivly7WuFQ3HnjmaqlEv11ZyusQ==
X-Google-Smtp-Source: AJdET5cTocWvdjYI9+beoXCPVkTVBLFqOvKET5ID5TweUm+Pu+C9pdzm6J+v41S8/ST4T/7phSnWVg==
X-Received: by 2002:a17:902:4303:: with SMTP id i3-v6mr1909794pld.204.1542047241926;
        Mon, 12 Nov 2018 10:27:21 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id o86-v6sm18813100pfk.8.2018.11.12.10.27.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 10:27:21 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Douglas Anderson <dianders@chromium.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] kdb: Don't back trace on a cpu that didn't round up
Date:   Mon, 12 Nov 2018 10:26:58 -0800
Message-Id: <20181112182659.245726-5-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181112182659.245726-1-dianders@chromium.org>
References: <20181112182659.245726-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you have a CPU that fails to round up and then run 'btc' you'll end
up crashing in kdb becaue we dereferenced NULL.  Let's add a check.
It's wise to also set the task to NULL when leaving the debugger so
that if we fail to round up on a later entry into the debugger we
won't backtrace a stale task.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4:
- Also clear out .debuggerinfo.
- Also clear out .debuggerinfo and .task for the master.
- Remove clearing out in kdb_stub for offline CPUs; it's now redundant.

Changes in v3:
- Don't back trace on a cpu that didn't round up new for v3.

Changes in v2: None

 kernel/debug/debug_core.c       |  4 ++++
 kernel/debug/kdb/kdb_bt.c       | 11 ++++++++++-
 kernel/debug/kdb/kdb_debugger.c |  7 -------
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 7e2f312fb41f..4907ac7a6250 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -583,6 +583,8 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
 				arch_kgdb_ops.correct_hw_break();
 			if (trace_on)
 				tracing_on();
+			kgdb_info[cpu].debuggerinfo = NULL;
+			kgdb_info[cpu].task = NULL;
 			kgdb_info[cpu].exception_state &=
 				~(DCPU_WANT_MASTER | DCPU_IS_SLAVE);
 			kgdb_info[cpu].enter_kgdb--;
@@ -715,6 +717,8 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
 	if (trace_on)
 		tracing_on();
 
+	kgdb_info[cpu].debuggerinfo = NULL;
+	kgdb_info[cpu].task = NULL;
 	kgdb_info[cpu].exception_state &=
 		~(DCPU_WANT_MASTER | DCPU_IS_SLAVE);
 	kgdb_info[cpu].enter_kgdb--;
diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
index 7921ae4fca8d..7e2379aa0a1e 100644
--- a/kernel/debug/kdb/kdb_bt.c
+++ b/kernel/debug/kdb/kdb_bt.c
@@ -186,7 +186,16 @@ kdb_bt(int argc, const char **argv)
 		kdb_printf("btc: cpu status: ");
 		kdb_parse("cpu\n");
 		for_each_online_cpu(cpu) {
-			sprintf(buf, "btt 0x%px\n", KDB_TSK(cpu));
+			void *kdb_tsk = KDB_TSK(cpu);
+
+			/* If a CPU failed to round up we could be here */
+			if (!kdb_tsk) {
+				kdb_printf("WARNING: no task for cpu %ld\n",
+					   cpu);
+				continue;
+			}
+
+			sprintf(buf, "btt 0x%px\n", kdb_tsk);
 			kdb_parse(buf);
 			touch_nmi_watchdog();
 		}
diff --git a/kernel/debug/kdb/kdb_debugger.c b/kernel/debug/kdb/kdb_debugger.c
index 15e1a7af5dd0..53a0df6e4d92 100644
--- a/kernel/debug/kdb/kdb_debugger.c
+++ b/kernel/debug/kdb/kdb_debugger.c
@@ -118,13 +118,6 @@ int kdb_stub(struct kgdb_state *ks)
 	kdb_bp_remove();
 	KDB_STATE_CLEAR(DOING_SS);
 	KDB_STATE_SET(PAGER);
-	/* zero out any offline cpu data */
-	for_each_present_cpu(i) {
-		if (!cpu_online(i)) {
-			kgdb_info[i].debuggerinfo = NULL;
-			kgdb_info[i].task = NULL;
-		}
-	}
 	if (ks->err_code == DIE_OOPS || reason == KDB_REASON_OOPS) {
 		ks->pass_exception = 1;
 		KDB_FLAG_SET(CATASTROPHIC);
-- 
2.19.1.930.g4563a0d9d0-goog

