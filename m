Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D586C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C74420818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nj2jVj/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C74420818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387576AbeKLJgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:36:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:39684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730330AbeKLITB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:01 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E670208A3;
        Sun, 11 Nov 2018 22:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975345;
        bh=FU6rwPi4QsYhX3tal/NH5BXn1uyR2hn3xZ2FyPqtRgs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nj2jVj/x5g7jOiIKqHiubHKClQ1gCQfXOnkaDGIRExKWhmJOgcYkjK5Sn4x4oHgrd
         ynTbzfhT84CgroCKd76GPGVvatWa0RbQkUtgvdgfhGDpzoxCjaTGog7R9BB2l25t07
         oFvJvFTFzqJ69qoN8ciCO8LLt1C3eIs0+cnDj0q0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Zanussi <zanussi@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Rajvi Jingar <rajvi.jingar@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.19 325/361] tracing: Return -ENOENT if there is no target synthetic event
Date:   Sun, 11 Nov 2018 14:21:12 -0800
Message-Id: <20181111221659.409469592@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 18858511fd8a877303cc34c06efa461b26a0e070 upstream.

Return -ENOENT error if there is no target synthetic event.
This notices an operation failure to user as below;

  # echo 'wakeup_latency u64 lat; pid_t pid;' > synthetic_events
  # echo '!wakeup' >> synthetic_events
  sh: write error: No such file or directory

Link: http://lkml.kernel.org/r/154013449986.25576.9487131386597290172.stgit@devbox

Acked-by: Tom Zanussi <zanussi@linux.intel.com>
Tested-by: Tom Zanussi <zanussi@linux.intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Rajvi Jingar <rajvi.jingar@intel.com>
Cc: stable@vger.kernel.org
Fixes: 4b147936fa50 ('tracing: Add support for 'synthetic' events')
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_events_hist.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1063,8 +1063,10 @@ static int create_synth_event(int argc,
 		event = NULL;
 		ret = -EEXIST;
 		goto out;
-	} else if (delete_event)
+	} else if (delete_event) {
+		ret = -ENOENT;
 		goto out;
+	}
 
 	if (argc < 2) {
 		ret = -EINVAL;


