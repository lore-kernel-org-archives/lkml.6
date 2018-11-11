Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A40C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC31223C6
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3N88ora"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC31223C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390147AbeKLIV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:21:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:50044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388732AbeKLIVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:21:53 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED2372243B;
        Sun, 11 Nov 2018 22:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975516;
        bh=kMtSP4OZI565RyD5PA5YsS90QxIZGwAzfR/wgwgsjd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j3N88oraIpIR90//tJQKd+DuewGxPmRmlRcKM6g9ttPDIc8U3ttyodFAW/YZ0EoSy
         E7f4NWqiI0yp2xQx7UgYEUDp6yBfbMEo50xMz4RDqcdkVrKVKD0oB5smguzE7VnTiS
         UJbreZxv6606QoS0tTE/O/DWk4zrgmI4gSsmxcDM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Zanussi <zanussi@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Rajvi Jingar <rajvi.jingar@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.18 316/350] tracing: Return -ENOENT if there is no target synthetic event
Date:   Sun, 11 Nov 2018 14:23:00 -0800
Message-Id: <20181111221721.284161758@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1072,8 +1072,10 @@ static int create_synth_event(int argc,
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


