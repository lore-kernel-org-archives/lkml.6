Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3746C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4A120894
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZ2esawI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E4A120894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbeH1UKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbeH1UKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:10:05 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1084C20893;
        Tue, 28 Aug 2018 16:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535473061;
        bh=ZG0P6IwIddk1fnlcr9qidm1eygd5enSXRzEXTC/Sp3w=;
        h=From:To:Cc:Subject:Date:From;
        b=HZ2esawIym4OCGdVCLCgSoZ5ePuueBSznZ338warTS9smjEIuGKBkGnGCzDrahxWp
         dd6l1MHpxYWu+QwFBg9CBBdt9Q/UB3UZDDVfIgg30dEkcShCG04KboCrqmUUzyzUOM
         gWpg9Ss5MG5cEt2Bgh+VY7VuHlCSfxpONMvNM6oc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [ftrace/kprobes PATCH 0/3] tracing: probeevent: Fix module symbol probing
Date:   Wed, 29 Aug 2018 01:17:18 +0900
Message-Id: <153547303754.26502.5265242979168613920.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series is for fixing some bugs in Steve's ftrace/kprobes branch.

git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git

Which is based on my fetcharg improvement series.

https://lkml.org/lkml/2018/4/25/601

This includes following fixes.

- Fix copy_from_user() misusing which Dan was reported.
- Fix to reject incorrect probeevent on loaded kernel module.
- Fix to update symbol-based argument on module.
  This also checks the symbol-based argument is correct or not when
  target module is loaded. If it is not correct, the event is kept
  unavailable.

Thank you,

---

Masami Hiramatsu (3):
      tracing/uprobes: Fix to return -EFAULT if copy_from_user failed
      tracing/kprobes: Check the probe on unloaded module correctly
      tracing/kprobes: Allow kprobe-events to record module symbol


 kernel/trace/trace_kprobe.c |   51 ++++++++++++++++++++++++++---------
 kernel/trace/trace_probe.c  |   62 +++++++++++++++++++++++++++++++++++++------
 kernel/trace/trace_probe.h  |    4 ++-
 kernel/trace/trace_uprobe.c |    2 +
 4 files changed, 95 insertions(+), 24 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
