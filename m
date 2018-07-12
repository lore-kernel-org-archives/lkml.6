Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB67EA4F86
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB6E2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="TwPZv2lf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB6E2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbeGLSFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 14:05:06 -0400
Received: from mail.efficios.com ([167.114.142.138]:55348 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbeGLSFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 14:05:06 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id BCD26233C13;
        Thu, 12 Jul 2018 13:54:28 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id mghX3p6sgFmv; Thu, 12 Jul 2018 13:54:28 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 09C02233C0F;
        Thu, 12 Jul 2018 13:54:28 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 09C02233C0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1531418068;
        bh=6A+qjiSgpKcEvrVimnH93nJDXjX249xYUd5PFKYJnuk=;
        h=From:To:Date:Message-Id;
        b=TwPZv2lf82gVSghnlVETF8qwSA8BDx081sX9BleumwQV96jCodJjrQZXjAJ2zRk6p
         ClFl3DpIrOINf6VmAjxLCfThWUlUJBjh+Yn8DnCjFmmT55y6BuvLkWYGs5RRmPtTsh
         anKWBeLJwC/x4+8z1uzLTaf4crkLWajkxwHDMdp2pVOS3wTIfxmep/U7L61ofNZZe5
         mMzUOUAHcs9O7q7Rzlajkmp57tnC/WH61yuH9iJkyMo3pF5fChhf3u8HU58bz9tydz
         P3zd5ZzwnjaaDZwdsgN+8ULbbZv2+uNWNEy90KZZsma5ZU8NEkmfjm06Gb9BrYO/j+
         l0TFevBGETnjQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 0_XhU2F8gwQU; Thu, 12 Jul 2018 13:54:27 -0400 (EDT)
Received: from raton.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 32F4E233C0A;
        Thu, 12 Jul 2018 13:54:27 -0400 (EDT)
From:   Francis Deslauriers <francis.deslauriers@efficios.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org, peterz@infradead.org
Cc:     mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        Francis Deslauriers <francis.deslauriers@efficios.com>
Subject: [PATCH 0/2]    tracing: kprobes: Prohibit probing on notrace functions 
Date:   Thu, 12 Jul 2018 13:54:11 -0400
Message-Id: <1531418053-21414-1-git-send-email-francis.deslauriers@efficios.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1500044315-9508-3-git-send-email-francis.deslauriers@efficios.com>
References: <1500044315-9508-3-git-send-email-francis.deslauriers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kprobe code has a mecanism protecting against triggering kprobe during
the handling of an event. If a kprobe is placed between the kprobe
handling entry point and the activation of this protection, the user can
cause an infinite kprobe recursion leading to a kernel crash.

To avoid this, prevent kprobes from being placed in notrace functions.

Also, move the kprobe selftest target function in its own compile unit
so it's not marked as notrace and can thus be used in the ftrace startup
tests.

Francis Deslauriers (1):
  selftest/ftrace: Move kprobe selftest function to separate compile
    unit

Masami Hiramatsu (1):
  tracing: kprobes: Prohibit probing on notrace functions

 kernel/trace/Makefile                |  5 +++++
 kernel/trace/trace_kprobe.c          | 35 ++++++++++++++++++++++++-----------
 kernel/trace/trace_kprobe_selftest.c | 10 ++++++++++
 kernel/trace/trace_kprobe_selftest.h |  7 +++++++
 4 files changed, 46 insertions(+), 11 deletions(-)
 create mode 100644 kernel/trace/trace_kprobe_selftest.c
 create mode 100644 kernel/trace/trace_kprobe_selftest.h

-- 
2.7.4

