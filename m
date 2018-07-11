Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0602CC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 06:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F0020C0A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 06:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="r2fP8Ni1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F0020C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbeGKGib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 02:38:31 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42866 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbeGKGib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 02:38:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id y4-v6so2580428pgp.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 23:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=YdNnef6liQv+cv8lkhDhEKwxtTrdsQCQQvqpHn1+dI0=;
        b=r2fP8Ni1tKcxhv4GwD3odgucc9wrdDkChr4Bblz4gc6gm/RsiEpySBYTflysrR5QrV
         U6epJo4io0qieJxRXZKNsJKQhdjbyEEofr40J3+pH9q6+lNXnrM6wQXjbMclw3Is5+83
         KngkFoJntt6/54d/aO5e+aq1zs/x9tY5sVdsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YdNnef6liQv+cv8lkhDhEKwxtTrdsQCQQvqpHn1+dI0=;
        b=lbH9eSGDgvrFTyqqIHsYmw1ym6V7xmt5IPX2tdyu/gDPrg6A8u8+GmetOROovGzQWu
         gliPuACZirNlUU/hJUNkh459hJMawvD7Ot3DT7LtcmNAz9TXMAo/gYEP/rleDdevwZ57
         6lsZXWOn3dVe8nbNk83HbFkdhJOLXvTuFqyRXT8cXJkkTscUtLCV915Wxn455f7wmVLx
         ri+p8x23pVqweM2vbrt+KLLHGABQbKlLGOrJkmxfxHH7O5QBgLxNOGlPemeDD6X3NvS+
         xqjqtm4GpVVo76SIu68Cb3izcUYnSNDADhRP+cuRvHoCDPsr4yV0NMuAahZmpgx5o1Pb
         NPWQ==
X-Gm-Message-State: APt69E2FJeFZDRDdwBNOTp8xf2Z985tn1Z+7mBVxgJjy28DW5uE6s9d3
        5SCTA6q9AvrOkX88ISgK3Y7AHAuI/3w=
X-Google-Smtp-Source: AAOMgpfDR0R2lb4NWPvDgd/XZY8OnHm9a/tIq5ozuZSA6EAie2j+rO7om7LdqHE1o8NY3Y/cPB5dAg==
X-Received: by 2002:a65:5cc5:: with SMTP id b5-v6mr25155910pgt.425.1531290948995;
        Tue, 10 Jul 2018 23:35:48 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id h190-v6sm24731891pge.85.2018.07.10.23.35.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 23:35:48 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 0/2] Tests for preempt/irq disabled sections
Date:   Tue, 10 Jul 2018 23:35:38 -0700
Message-Id: <20180711063540.91101-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Only resending the test module and kselftest patches with minor changes
as suggested by Steve.

Previous posting of the series is at: https://lkml.org/lkml/2018/6/7/1162

Joel Fernandes (Google) (2):
  lib: Add module for testing preemptoff/irqsoff latency tracers
  kselftests: Add tests for the preemptoff and irqsoff tracers

 kernel/trace/Kconfig                          | 15 ++++
 kernel/trace/Makefile                         |  1 +
 kernel/trace/preemptirq_delay_test.c          | 72 ++++++++++++++++++
 tools/testing/selftests/ftrace/config         |  3 +
 .../test.d/preemptirq/irqsoff_tracer.tc       | 73 +++++++++++++++++++
 5 files changed, 164 insertions(+)
 create mode 100644 kernel/trace/preemptirq_delay_test.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc

-- 
2.18.0.203.gfac676dfb9-goog
unction incase tracepoints aren't enabled, did that.
