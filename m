Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F247ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 15:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A582083E
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 15:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aV05YE61"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A582083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbeJUXXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 19:23:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727613AbeJUXXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 19:23:20 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D14192083E;
        Sun, 21 Oct 2018 15:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540134523;
        bh=RBQpfNiTUe4XXWnR3NnPRcWEmuOhWdz3Ej0TYIJPx/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aV05YE61KgaM4fyXXVYU4jdbd7JzLz6CaYa6upx0F+9TWCTpizBGdIVjqnNY/KZVU
         5NhFOZugebbdr2gr6SAjcQaBywvRO5Qr7xdqFoXVOrFKhuo0GtZM1cda0eoESAZoiq
         WvlGJ+SVJrPFHx0acRoWxBF/OA2T/V6t5i2VZ3e0=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>
Cc:     Rajvi Jingar <rajvi.jingar@intel.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 1/2] tracing: Return -ENOENT if there is no target synthetic event
Date:   Mon, 22 Oct 2018 00:08:20 +0900
Message-Id: <154013449986.25576.9487131386597290172.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154013446976.25576.14780785912268176178.stgit@devbox>
References: <154013446976.25576.14780785912268176178.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return -ENOENT error if there is no target synthetic event.
This notices an operation failure to user as below;

  # echo 'wakeup_latency u64 lat; pid_t pid;' > synthetic_events
  # echo '!wakeup' >> synthetic_events
  sh: write error: No such file or directory

Fixes: 4b147936fa50 ('tracing: Add support for 'synthetic' events')
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index d239004aaf29..eb908ef2ecec 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1063,8 +1063,10 @@ static int create_synth_event(int argc, char **argv)
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

