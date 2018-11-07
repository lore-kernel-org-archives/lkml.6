Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF61C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6107820827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kgw3jYni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6107820827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389031AbeKGKcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 05:32:20 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36894 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387697AbeKGKcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 05:32:19 -0500
Received: by mail-pf1-f193.google.com with SMTP id u13-v6so6940954pfm.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 17:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IBgaqhFzeF1TpKh7XpgYVYLbY8p4f3B3hZXickKUZUg=;
        b=kgw3jYnioIm9CljR2FvmQhiREM4Bkk0e1ODD4XmY6reyfDOK2Kh+cjQX38xgUJyQYg
         0O8MwzsWJ+zXc3Yj7C8pStYq6L9y+MsoiSFKFn2y46ZBRXAf/OYbLdODjhkRMN5m32AV
         d2eoyeh09XMfWfrBoZ8MqXIarjFiEnvUu/HgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IBgaqhFzeF1TpKh7XpgYVYLbY8p4f3B3hZXickKUZUg=;
        b=DcWWkp2OSA+KcSpkXAkQSVd4hvPYRddTcfhwjgsFmpZar81PVLUsPbH8Xu8KP0CWFT
         RJmLlFaBQNU+h04BFIzFgufKahiBtO4c5XtTP0utVbm7t6LUKTsxKflhbcCUn/4iHtSo
         ZVm/4MoyxOZKgJVL9/3Yb0HIEOoI49kzvrnRzXRU7h8WV71ArwcFiKjnzowlCqGQQI8A
         sZYub9t/Y67Fis6ZUK402tAa9OTzBxQVOnHYszlfWKDZc9+hPPitBjineJHozChl3s9T
         d92kGdNfWzJ1sluHJIm55HgMowEGeCx+i7H1OTYAUPn6pM7ZxfQk+2woTdA6Ji8mtIwX
         dySQ==
X-Gm-Message-State: AGRZ1gLdTBODtWFs4Iq/OSruCiFw9dlffVbLIr0keqPnuRSuGphZWbRy
        RQECl5nbFgFVXUXrWvIAk4oUuF57GRA=
X-Google-Smtp-Source: AJdET5c3y3jJPeDvOM2g185ltZt+ZGQIj/wmh+Vvh4kt5SZ1AzJry4u0mjsgi4HRKlSxdmumNrA6Kg==
X-Received: by 2002:a63:fd53:: with SMTP id m19mr6879798pgj.340.1541552657619;
        Tue, 06 Nov 2018 17:04:17 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id v37sm30134695pgn.5.2018.11.06.17.04.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 17:04:17 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Douglas Anderson <dianders@chromium.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] kdb: Don't back trace on a cpu that didn't round up
Date:   Tue,  6 Nov 2018 17:00:28 -0800
Message-Id: <20181107010028.184543-5-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181107010028.184543-1-dianders@chromium.org>
References: <20181107010028.184543-1-dianders@chromium.org>
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

Changes in v3:
- New for v3.

Changes in v2: None

 kernel/debug/debug_core.c |  1 +
 kernel/debug/kdb/kdb_bt.c | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 324cba8917f1..08851077c20a 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -587,6 +587,7 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
 			kgdb_info[cpu].exception_state &=
 				~(DCPU_WANT_MASTER | DCPU_IS_SLAVE);
 			kgdb_info[cpu].enter_kgdb--;
+			kgdb_info[cpu].task = NULL;
 			smp_mb__before_atomic();
 			atomic_dec(&slaves_in_kgdb);
 			dbg_touch_watchdogs();
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
-- 
2.19.1.930.g4563a0d9d0-goog

