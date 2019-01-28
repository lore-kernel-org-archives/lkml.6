Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C53FC282CF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A452171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfA1Xqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:46:46 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40562 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfA1Xqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 18:46:40 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so8745928pfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 15:46:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ocVsLGoOVFNFLIAYDL3/HqCd3oHcBwGNRPNFaJxJjvo=;
        b=FidFFwvxooB1xnmNhpSTymW5MBJX1StlaOifsGKaJpIsFE522QBcUF15OYdcYW9JBp
         A5pBZuDvxqDxAXHklo0PHElZ3nsCoo7BSneKRM/JuNcgNEfVYnuWR/o/35uXpLlhCxfo
         /VqsjtvXyPNfNKh3TNvuLcwuHfEjwjSzsycPX0d+xjxVG3xImhwNGfzzV+euraWKX3BT
         OVKGAT5yOTq6uMhILZsNOyuFMdq3A37h8mgAwvL7K0vD2/5GdOFRHVbaumVJ7xmNDKBK
         CNWYpmTY1Is7cRuX+UJC7JUiUWmupFXBdCwvNxIwpiwP7adByAGexDfPZgXRT9l492sJ
         puXw==
X-Gm-Message-State: AJcUukfe0a2htIM3NXDBMeHwVIYph9THu9XFfC148ZK+1V573Di5wuop
        aTgP91Q05OkyZ+oBocNtyKSdQhoHxYqSNQ==
X-Google-Smtp-Source: ALg8bN713mGOBEnDruviuwbiYnWl/ojrmTjX8zfpki4/JeCJBd13EK8KeBgi1CKD8//Hh9oHp5w0Cg==
X-Received: by 2002:a62:190e:: with SMTP id 14mr23713686pfz.70.1548719199057;
        Mon, 28 Jan 2019 15:46:39 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id f67sm52473331pfc.141.2019.01.28.15.46.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 15:46:38 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 2/2] softirq: Don't skip softirq execution when softirq thread is parking
Date:   Mon, 28 Jan 2019 15:46:25 -0800
Message-Id: <20190128234625.78241-3-mka@chromium.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190128234625.78241-1-mka@chromium.org>
References: <20190128234625.78241-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a CPU is unplugged the kernel threads of this CPU are parked
(see smpboot_park_threads()). kthread_park() is used to mark each
thread as parked and wake it up, so it can complete the process of
parking itselfs (see smpboot_thread_fn()).

If local softirqs are pending on interrupt exit invoke_softirq() is
called to process the softirqs, however it skips processing when the
softirq kernel thread of the local CPU is scheduled to run. The
softirq kthread is one of the threads that is parked when a CPU is
unplugged. Parking the kthread wakes it up, however only to complete
the parking process, not to process the pending softirqs. Hence
processing of softirqs at the end of an interrupt is skipped, but
not done elsewhere, which can result in warnings about pending
softirqs when a CPU is unplugged:

/sys/devices/system/cpu # echo 0 > cpu4/online
[ ... ] NOHZ: local_softirq_pending 02
[ ... ] NOHZ: local_softirq_pending 202
[ ... ] CPU4: shutdown
[ ... ] psci: CPU4 killed.

Don't skip processing of softirqs at the end of an interrupt when
the softirq thread of the CPU is parking.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 kernel/softirq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index d28813306b2c2..10277429ed84f 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -89,7 +89,8 @@ static bool ksoftirqd_running(unsigned long pending)
 
 	if (pending & SOFTIRQ_NOW_MASK)
 		return false;
-	return tsk && (tsk->state == TASK_RUNNING);
+	return tsk && (tsk->state == TASK_RUNNING) &&
+		!__kthread_should_park(tsk);
 }
 
 /*
-- 
2.20.1.495.gaa96b0ce6b-goog

