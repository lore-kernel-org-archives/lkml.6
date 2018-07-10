Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36EAC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7673220870
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="aGS4rqPd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7673220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389171AbeGJSp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:45:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43783 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732237AbeGJSpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:45:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id v13-v6so2232533pgr.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 11:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Y2bIJtBP3OgG7qKzFC83bGjRZ6M9zD795pKCvqrP400=;
        b=aGS4rqPd8D+f/YUwPBZyrf+wdfNezAQ5fO9W4mBgwWiEcxXQ0AFfupNGYwYbbQXsw/
         cCSkihR4moUaHi+HHeZRvW2wWFqG4oXLfLPq4GAtXiLAkSRGejmS1PBwfqG7UifzDp7t
         4d8fNLQ5g+ehAEzDvs0fyFdhgd6yNli8lgdqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y2bIJtBP3OgG7qKzFC83bGjRZ6M9zD795pKCvqrP400=;
        b=qjvOp3BNh0JdOBtQrz8LOTZilM7AZ8zjV6S3l46RHquE03y9IRgYd2wbYB3aaf52JT
         7UgsMbg47d5uoj7L+zKbNMfbdO6R6UA8ULj/cpwKXnwmOMQKeLu4UED8po6D3XVgvliZ
         afo8UZENWcNx61U5ZmBuU55o7r8OneJyvAfx5/QgtYpcoFmH+48iJRzPYyr2EOaSODqu
         +++gc1TpBZMdA93p3EgdgXqmOu69C9GNfZvMPyiUXue/nXP734bl881+Yu2S+pmEYWzR
         nterb5DvqPHithYpdfjJ4B0BSmMqqa2yOeKnQQNVxEDhbp21XQFSzQmXt0qw+kDLKbQh
         Ucow==
X-Gm-Message-State: APt69E25eMQcZY/GzT6EVHcd3ZPYLBNH2qyaD+iMn18O8umhJjM27a4J
        XcvCgTDyw5K427anoYX0kpfU/VhAIHM=
X-Google-Smtp-Source: AAOMgpfTb9LjDNL7Qt8ssdYOoNlwuO3TRpKPf2Oe2SySKsgR+Ovvwx6QV5ZbG/XZ9CuDTxBP3OH8YA==
X-Received: by 2002:a65:5a49:: with SMTP id z9-v6mr23718441pgs.244.1531244700736;
        Tue, 10 Jul 2018 10:45:00 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id r77-v6sm32459182pfr.117.2018.07.10.10.44.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 10:45:00 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH] trace: Add SPDX-License-Identifier to trace_preemptirq.c
Date:   Tue, 10 Jul 2018 10:44:49 -0700
Message-Id: <20180710174449.110865-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

This patch adds a SPDX-License-Identifier to trace_preemptirq.c.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
This patch is based on top of the v9 posting of "Centralize and unify
usage of preempt/irq tracepoints": https://lkml.org/lkml/2018/6/28/643

 kernel/trace/trace_preemptirq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index dc01c7f4d326..13e2c6e99465 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * preemptoff and irqoff tracepoints
  *
-- 
2.18.0.203.gfac676dfb9-goog

