Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA95AECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E2BA20862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dX4jRc4T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E2BA20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbeKESTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:19:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:49370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbeKESTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:19:17 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A37F320862;
        Mon,  5 Nov 2018 09:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541408438;
        bh=UoWWfEvbRM0oO+cNrgEn3kjbwCO6FsRAuztRWoTbi0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dX4jRc4TmbPtLzBN6IZ4bLBnoSHUgSURnc+N6fStNZtR48+jwOoCEPH/fb+65qnhe
         VPpLJkREbXeuIR0kBpWLEAeQqqOTjt3GPZ6kIiyw8gYRGj1UwngfTAuDbiH2xLjHnE
         2eVucgaRS/VRen14DKUC6Zx9A55tOZKuGfEl2SXg=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v2 01/12] tracing/uprobes: Add busy check when cleanup all uprobes
Date:   Mon,  5 Nov 2018 18:00:15 +0900
Message-Id: <154140841557.17322.12653952888762532401.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154140838606.17322.15294184388075458777.stgit@devbox>
References: <154140838606.17322.15294184388075458777.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a busy check loop in cleanup_all_probes() before
trying to remove all events in uprobe_events as same as
kprobe_events does.

Without this change, writing null to uprobe_events will
try to remove events but if one of them is enabled, it
stopped there but some of events are already cleared.

With this change, writing null to uprobe_events make
sure all events are not enabled before removing events.
So, it clears all events, or return an error (-EBUSY)
with keeping all events.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_uprobe.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 31ea48eceda1..b708e4ff7ea7 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -587,12 +587,19 @@ static int cleanup_all_probes(void)
 	int ret = 0;
 
 	mutex_lock(&uprobe_lock);
+	/* Ensure no probe is in use. */
+	list_for_each_entry(tu, &uprobe_list, list)
+		if (trace_probe_is_enabled(&tu->tp)) {
+			ret = -EBUSY;
+			goto end;
+		}
 	while (!list_empty(&uprobe_list)) {
 		tu = list_entry(uprobe_list.next, struct trace_uprobe, list);
 		ret = unregister_trace_uprobe(tu);
 		if (ret)
 			break;
 	}
+end:
 	mutex_unlock(&uprobe_lock);
 	return ret;
 }

