Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A7DC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC8520897
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lkj0fpsA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DC8520897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeH1UKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:10:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbeH1UKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:10:34 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E76020897;
        Tue, 28 Aug 2018 16:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535473090;
        bh=y5aOxzS+yl7fE6a1b9GJo0C6/Kay1Jr77sXbOYdlB18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lkj0fpsAb2ddTMIQOLTO2zzNWhGCdOin3iNRP1UhYwBhg9nySspEfk4AFtZtQOhu9
         h7gamiBCI5jlZ91ddo8XUHS6HXSTryT7ZpM2OupAWtGqZ5h3x/c1N5EoMTlYEx3pp2
         lLMHsvu4a3f0IIJ/C5FTmb0tPJeGdp6EqNeUTblE=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [ftrace/kprobes PATCH 1/3] tracing/uprobes: Fix to return -EFAULT if copy_from_user failed
Date:   Wed, 29 Aug 2018 01:17:47 +0900
Message-Id: <153547306719.26502.8353484532699160223.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153547303754.26502.5265242979168613920.stgit@devbox>
References: <153547303754.26502.5265242979168613920.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix probe_mem_read() to return -EFAULT if copy_from_user()
failed. The copy_from_user() returns remaining bytes
when it failed, but probe_mem_read() caller expects it
returns error code like as probe_kernel_read().

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_uprobe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 12bdbdf772ed..63e99ee716fe 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -104,7 +104,7 @@ probe_mem_read(void *dest, void *src, size_t size)
 {
 	void __user *vaddr = (void __force __user *)src;
 
-	return copy_from_user(dest, vaddr, size);
+	return copy_from_user(dest, vaddr, size) ? -EFAULT : 0;
 }
 /*
  * Fetch a null-terminated string. Caller MUST set *(u32 *)dest with max

