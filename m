Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F304DC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0332084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="ucMSt13+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfAUMfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:35:23 -0500
Received: from mail.kapsi.fi ([91.232.154.25]:52709 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728011AbfAUMfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:35:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Msfr76tfx+tcI5ozZwIa6iBs23v+S99MmthJrPTnC+Q=; b=ucMSt13+CxrXUlXTF09MB7/pbt
        sE/Q80o362kZFSJmUNm6q6fzJzLnNxnPUbFj7tIh2eNTXVSAPD0TtGFYUjMNI1j59+VcIQPHhmCEo
        BfwEI5FZvtlxgLjGRCfz7NcfUrXF8GM5Agv0GutkZKYroRQeh/gkc+VCDb4zcr/SZQdLVdk2g3S5y
        v+ZnGVeOd9gmbtBJ8lt2j4cN8OD2F9UsxzzeJz0sDplcAjrBgKFclqnJxv71MOwxXExZhKujASsP4
        bt+CjogU1mKnRUhZ7uCM8K7kGvecKabxIsnID30ffQaCvFltsy/Q+NjUDvA9aAZms3RwZHXAJR/Fn
        yZhEXZHw==;
Received: from lakka.kapsi.fi ([2001:67c:1be8::1] ident=Debian-exim)
        by mail.kapsi.fi with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <mcfrisk@kapsi.fi>)
        id 1glYnJ-0003qx-QT; Mon, 21 Jan 2019 14:35:13 +0200
Received: from mcfrisk by lakka.kapsi.fi with local (Exim 4.84_2)
        (envelope-from <mcfrisk@lakka.kapsi.fi>)
        id 1glYnJ-0004MV-MO; Mon, 21 Jan 2019 14:35:13 +0200
From:   Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Some new features for the preempt/irqsoff tracers
Date:   Mon, 21 Jan 2019 14:35:09 +0200
Message-Id: <1548074113-16599-1-git-send-email-Viktor.Rosendahl@bmw.de>
X-Mailer: git-send-email 2.1.4
X-SA-Exim-Connect-IP: 2001:67c:1be8::1
X-SA-Exim-Mail-From: mcfrisk@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

This series is meant to address two issues with the latency tracing.

The first three patches provide a method to trace latencies that
always occurs very close to each other and to differentiate between
them, in spite of the fact that the latency tracers always work in
overwrite mode.

[PATCH 1/4] This implement fs notification for preempt/irqsoff. It
makes it possible for userspace to detect when a new latency has
been detected.

[PATCH 2/4] This extends the preemptirq_delay_test module so that
it can be used to generate a burst of closely occurring latencies.

[PATCH 3/4] This adds a user space program to the tools directory
that utilizes the fs notification feature and a randomized algorithm
to print out any of the latencies in a burst with approximately equal
probability.

The last patch is not directly connected but doesn't apply cleanly on
its own:

[PATCH 4/4] This adds the option CONFIG_TRACE_CONSOLE_LATENCY to
decide whether we want to trace prints to the console or not.

best regards,

Viktor Rosendahl

Viktor Rosendahl (4):
  ftrace: Implement fs notification for preempt/irqsoff tracers
  preemptirq_delay_test: Add the burst feature and a sysfs trigger
  Add the latency-collector to tools
  ftrace: Add an option for tracing console latencies

 include/linux/irqflags.h             |   13 +
 kernel/printk/printk.c               |    5 +-
 kernel/trace/Kconfig                 |   21 +
 kernel/trace/preemptirq_delay_test.c |  139 ++-
 kernel/trace/trace.c                 |   31 +-
 kernel/trace/trace.h                 |    5 +
 kernel/trace/trace_irqsoff.c         |   35 +
 tools/Makefile                       |   14 +-
 tools/trace/Makefile                 |   20 +
 tools/trace/latency-collector.c      | 1190 ++++++++++++++++++++++++++
 10 files changed, 1444 insertions(+), 29 deletions(-)
 create mode 100644 tools/trace/Makefile
 create mode 100644 tools/trace/latency-collector.c

-- 
2.17.1

