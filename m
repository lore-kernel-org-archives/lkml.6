Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64697C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F5720645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:02:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F5720645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbeJNXn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:43:56 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35748 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727165AbeJNXLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:45 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLY-0004cA-NA; Sun, 14 Oct 2018 16:30:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLV-0000TL-Rr; Sun, 14 Oct 2018 16:30:21 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Srikar Dronamraju" <srikar@linux.vnet.ibm.com>,
        "Dmitry Safonov" <dsafonov@virtuozzo.com>,
        "Oleg Nesterov" <oleg@redhat.com>,
        "Steven Rostedt" <rostedt@goodmis.org>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.426141349@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 230/366] tracing/uprobe: Drop isdigit() check in
 create_trace_uprobe
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Safonov <dsafonov@virtuozzo.com>

commit 5ba8a4a96f6eaa6af88e24c7794f142217aa3b6f upstream.

It's useless. Before:
  [tracing]# echo 'p:test /a:0x0' >> uprobe_events
  [tracing]# echo 'p:test a:0x0' >> uprobe_events
  -bash: echo: write error: No such file or directory
  [tracing]# echo 'p:test 1:0x0' >> uprobe_events
  -bash: echo: write error: Invalid argument

After:
  [tracing]# echo 'p:test 1:0x0' >> uprobe_events
  -bash: echo: write error: No such file or directory

Link: http://lkml.kernel.org/r/20160825152110.25663-3-dsafonov@virtuozzo.com

Acked-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Dmitry Safonov <dsafonov@virtuozzo.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/trace/trace_uprobe.c | 4 ----
 1 file changed, 4 deletions(-)

--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -430,10 +430,6 @@ static int create_trace_uprobe(int argc,
 		pr_info("Probe point is not specified.\n");
 		return -EINVAL;
 	}
-	if (isdigit(argv[1][0])) {
-		pr_info("probe point must be have a filename.\n");
-		return -EINVAL;
-	}
 	arg = strchr(argv[1], ':');
 	if (!arg) {
 		ret = -EINVAL;

