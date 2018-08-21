Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32C2C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755B42086D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fj1DQRrp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755B42086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeHUQZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 12:25:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727153AbeHUQZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 12:25:25 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6044C208CC;
        Tue, 21 Aug 2018 13:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534856720;
        bh=DGMdDu7mzDtm6McZQ1pw/2PYygRZsuzocodO69g4nbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Fj1DQRrpWCCG61nbF+JxQ+5blZruYACU0SokFP8S769kF/0xUJThp95lQ//VOKgLs
         0eHjflcMZoAXc+PyzHAPHL++Tt79vnrpLjr99BezNdxJ8r/mZCKy/C5moQj7chQif6
         Qz8+wUEs9dZmbky8mJ/hPUBa1mC9RWqoEzGo9BVk=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     rostedt@goodmis.org
Cc:     Francis Deslauriers <francis.deslauriers@efficios.com>,
        peterz@infradead.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        Michael Rodin <michael@rodin.online>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [BUGFIX PATCH] tracing/kprobes: Fix to check notrace function with correct range
Date:   Tue, 21 Aug 2018 22:04:57 +0900
Message-Id: <153485669706.16611.17726752296213785504.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180821212448.d20ea26fa998b206adf4ece6@kernel.org>
References: <20180821212448.d20ea26fa998b206adf4ece6@kernel.org>
In-Reply-To: <20180821212448.d20ea26fa998b206adf4ece6@kernel.org>
References: <20180821212448.d20ea26fa998b206adf4ece6@kernel.org>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix within_notrace_func() to check notrace function correctly.

Since the ftrace_location_range(start, end) function checks
the range inclusively (start <= ftrace-loc <= end), the end
address must not include the entry address of next function.

However, within_notrace_func() uses kallsyms_lookup_size_offset()
to get the function size and calculate the end address from
adding the size to the entry address. This means the end address
is the entry address of the next function.

In the result, within_notrace_func() fails to find notrace
function if the next function of the target function is
ftraced.

Let's subtract 1 from the end address so that ftrace_location_range()
can check it correctly.

Fixes: commit 45408c4f9250 ("tracing: kprobes: Prohibit probing on notrace function")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reported-by: Michael Rodin <michael@rodin.online>
---
 kernel/trace/trace_kprobe.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 65a4157af851..ad384b31fe01 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -513,7 +513,14 @@ static bool within_notrace_func(struct trace_kprobe *tk)
 	if (!addr || !kallsyms_lookup_size_offset(addr, &size, &offset))
 		return false;
 
-	return !ftrace_location_range(addr - offset, addr - offset + size);
+	/* Get the entry address of the target function */
+	addr -= offset;
+
+	/*
+	 * Since ftrace_location_range() does inclusive range check, we need
+	 * to subtract 1 byte from the end address.
+	 */
+	return !ftrace_location_range(addr, addr + size - 1);
 }
 #else
 #define within_notrace_func(tk)	(false)

