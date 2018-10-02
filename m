Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24ACBC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB732064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="xEgISZ6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB732064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbeJBIBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 04:01:00 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41660 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeJBIBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 04:01:00 -0400
Received: by mail-io1-f67.google.com with SMTP id q4-v6so327975iob.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 18:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RT5UWl+3t+I9fx3wXsQ/PEvXB1KHsktMrM8m6ADJM5g=;
        b=xEgISZ6vTskWeFLvKHaHFR4TcY++6iVfcERzmrlUlWp4co33MBmdGtC6f9SFhaBCov
         h76/c3zHvGQHPSXvIdI/H0C0n3lBO5OzRTHTQ3/gU/5Sxki0yKgVX20alzsGMZN0aGbw
         hXyL6hMBKZ89HVx5OGp4s502ytZTooP4usOaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RT5UWl+3t+I9fx3wXsQ/PEvXB1KHsktMrM8m6ADJM5g=;
        b=a2YXJbXdRCFqWe2cfoL8T/vg7WcLs2pOSkAOVkVGtofgd3h3xc6g5hIKJsrTex0HPx
         CM3JSXyU8nns+Rs68PTqaxPsr+Dxv2cO6Zsy4mkdV6OubFs8hakkzCvXksPpE1z9fNHw
         RtMqeE2D4O0D87k/+v95bbtACvWyvVzMuD80LbfZQlSG7MI++kYKpmAjo0lNT/PEDD8h
         Q1LeTNAGiWe9Mc4r9kghH5f3cD2gQXuVXYyV5Ai8NYBFNzMIqn1vVywURRftjFwRrBGo
         Xve+iDepQ0ztkYstT5OOiAjTgrKMT6HM1K8ceOGYrKxiwHLMpi3RmHH30Y0Nl0L2o/01
         G0fw==
X-Gm-Message-State: ABuFfohgN8joU9mFj0s5JbQNuqBFC1BNo8HlEvhgX29OBcH//t8hjyYG
        tJyeNAhy6aLWLpzUxi8alk++dVaR2F8=
X-Google-Smtp-Source: ACcGV61LfWsPNjcVI46Qbd0zELv83CYRGzW3pDmziPV/rXjHHULEyfJaazYuGRnmsghprcP+xWLI/g==
X-Received: by 2002:a17:902:7043:: with SMTP id h3-v6mr14448954plt.103.1538443223449;
        Mon, 01 Oct 2018 18:20:23 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id h7-v6sm7409003pfd.35.2018.10.01.18.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 18:20:22 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RFC 1/2] sched/core: Convert synchronize_rcu_mult to synchronize_rcu
Date:   Mon,  1 Oct 2018 18:20:11 -0700
Message-Id: <20181002012012.13133-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

synchronize_rcu_mult is now obsolete since all the different RCU flavors
have been consolidated and the API is now common on the updater side.
sched/core.c is the only user of it. All call_rcu_<flavor> calls boil
down to the same call_rcu. So there's no point in calling
synchronize_rcu_mult infact it could potentially be slower due to
waiting for the call_rcu callback twice. Just call synchronize_rcu here
which should do the job.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 625bc9897f62..d8311f3cf58c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5791,7 +5791,7 @@ int sched_cpu_deactivate(unsigned int cpu)
 	 *
 	 * Do sync before park smpboot threads to take care the rcu boost case.
 	 */
-	synchronize_rcu_mult(call_rcu, call_rcu_sched);
+	synchronize_rcu();
 
 	if (!sched_smp_initialized)
 		return 0;
-- 
2.19.0.605.g01d371f741-goog

