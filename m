Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2E6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B16E2243B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rg5OfuRn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B16E2243B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbeKLTt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 14:49:58 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54615 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729341AbeKLTt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 14:49:56 -0500
Received: by mail-wm1-f68.google.com with SMTP id r63-v6so7829068wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 01:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0oaKQg1Db4rRhO3WCbNaQdRbhtsjokz1BpBDDqQDnH0=;
        b=Rg5OfuRnIxfiEqH0WAirw+p5zFFM2A3eP+/qNVgYtz/p1XWMtJQwYM05UW/C4+j5gX
         IaZnE3XI6wvJCXcd4FQ1Hx5aghznqX87ea65MY8LBS1tfU6fXt06wlGlTPcLKrs9JP1t
         5iM+S+o9ye6yz2LV6kWJfSIofPFST2APQ3GVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0oaKQg1Db4rRhO3WCbNaQdRbhtsjokz1BpBDDqQDnH0=;
        b=Ef8Qn95TBgcp+oSGdgXiM+cTs92DNDQV8iKC+1sOXqsMAIj4lbEQxI+ZZlT/F8csnN
         wJTsXyG125PPlU0YxGbjcC6v07Nb7aRZ5YCLBGgPa5SOPu3snmPKtySZAcp1LY0N4ZWI
         2MeFsIg1bOPNnyKDpoTp9b/0AxIkM9mQunrbyzNzrMsR8n9AxcGUaSng5e9BQuHkHqi3
         fJAE89ws9EQttOVcYZ+6GlVCvrS0qGTFKxDSBFwmWnthL8M/+M8r6O6udRgU7Gi2/Asf
         Wiq1tyQqRoOU25+GOhr+qTndVudzYyCFJX14KpUfhuuMhqkU3vt27PI3RYlnS9Be7WsG
         9l5g==
X-Gm-Message-State: AGRZ1gJd34JnkR7/aYXI528oYVpjJxnvr6W0vC0SZSPMTyeu2kNZb0oT
        A/EEkWyu8fFG2+MRzSx21y0LsA==
X-Google-Smtp-Source: AJdET5dc+MYjthZUBqOb8v1Uac6VYFwMsLxCFBwUwclICSmMMWw45pmt4ZJKD8ArEZEhDeAuhckI4w==
X-Received: by 2002:a7b:c84f:: with SMTP id c15-v6mr6284511wml.79.1542016645423;
        Mon, 12 Nov 2018 01:57:25 -0800 (PST)
Received: from localhost.localdomain ([93.68.220.21])
        by smtp.gmail.com with ESMTPSA id r14-v6sm21273089wro.8.2018.11.12.01.57.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 01:57:24 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 09/12] block, bfq: use standard file names for the proportional-share policy
Date:   Mon, 12 Nov 2018 10:56:29 +0100
Message-Id: <20181112095632.69114-10-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20181112095632.69114-1-paolo.valente@linaro.org>
References: <20181112095632.69114-1-paolo.valente@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the files exposed in a cgroup by bfq, for the proportional
share policy, have the same meaning as the files owned by cfq.

The old implementation of the cgroup interface didn't allow different
entities to create cgroup files with the same name (in the same
subsystem). So, for bfq, we had to add the prefix "bfq" to the names
of its cgroup files.

This commit renames the cgroup files of the bfq scheduler as those
exposed by cfq, and makes bfq share these files with any other policy.

Signed-off-by: Angelo Ruocco <angeloruocco90@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-cgroup.c | 94 +++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 69 insertions(+), 25 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 50b2d7ba6b9d..9148fc38c737 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -1055,50 +1055,67 @@ struct blkcg_policy blkcg_policy_bfq = {
 
 struct cftype bfq_blkcg_legacy_files[] = {
 	{
-		.name = "bfq.weight",
-		.flags = CFTYPE_NOT_ON_ROOT,
+		.name = "weight",
+		.owner_name = "bfq",
+		.flags = CFTYPE_NOT_ON_ROOT | CFTYPE_SHARES_FILE,
 		.seq_show = bfq_io_show_weight,
 		.write_u64 = bfq_io_set_weight_legacy,
 	},
 
 	/* statistics, covers only the tasks in the bfqg */
 	{
-		.name = "bfq.io_service_bytes",
+		.name = "io_service_bytes",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = (unsigned long)&blkcg_policy_bfq,
 		.seq_show_cft = blkg_print_stat_bytes,
 	},
 	{
-		.name = "bfq.io_serviced",
+		.name = "io_serviced",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = (unsigned long)&blkcg_policy_bfq,
 		.seq_show_cft = blkg_print_stat_ios,
 	},
 #ifdef CONFIG_DEBUG_BLK_CGROUP
 	{
-		.name = "bfq.time",
+		.name = "time",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct bfq_group, stats.time),
 		.seq_show_cft = bfqg_print_stat,
 	},
 	{
-		.name = "bfq.sectors",
+		.name = "sectors",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.seq_show = bfqg_print_stat_sectors,
 	},
 	{
-		.name = "bfq.io_service_time",
+		.name = "io_service_time",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct bfq_group, stats.service_time),
 		.seq_show_cft = bfqg_print_rwstat,
 	},
 	{
-		.name = "bfq.io_wait_time",
+		.name = "io_wait_time",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct bfq_group, stats.wait_time),
 		.seq_show_cft = bfqg_print_rwstat,
 	},
 	{
-		.name = "bfq.io_merged",
+		.name = "io_merged",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct bfq_group, stats.merged),
 		.seq_show_cft = bfqg_print_rwstat,
 	},
 	{
-		.name = "bfq.io_queued",
+		.name = "io_queued",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct bfq_group, stats.queued),
 		.seq_show_cft = bfqg_print_rwstat,
 	},
@@ -1106,66 +1123,92 @@ struct cftype bfq_blkcg_legacy_files[] = {
 
 	/* the same statictics which cover the bfqg and its descendants */
 	{
-		.name = "bfq.io_service_bytes_recursive",
+		.name = "io_service_bytes_recursive",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = (unsigned long)&blkcg_policy_bfq,
 		.seq_show_cft = blkg_print_stat_bytes_recursive,
 	},
 	{
-		.name = "bfq.io_serviced_recursive",
+		.name = "io_serviced_recursive",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = (unsigned long)&blkcg_policy_bfq,
 		.seq_show_cft = blkg_print_stat_ios_recursive,
 	},
 #ifdef CONFIG_DEBUG_BLK_CGROUP
 	{
-		.name = "bfq.time_recursive",
+		.name = "time_recursive",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct bfq_group, stats.time),
 		.seq_show_cft = bfqg_print_stat_recursive,
 	},
 	{
-		.name = "bfq.sectors_recursive",
+		.name = "sectors_recursive",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.seq_show = bfqg_print_stat_sectors_recursive,
 	},
 	{
-		.name = "bfq.io_service_time_recursive",
+		.name = "io_service_time_recursive",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct bfq_group, stats.service_time),
 		.seq_show_cft = bfqg_print_rwstat_recursive,
 	},
 	{
-		.name = "bfq.io_wait_time_recursive",
+		.name = "io_wait_time_recursive",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct bfq_group, stats.wait_time),
 		.seq_show_cft = bfqg_print_rwstat_recursive,
 	},
 	{
-		.name = "bfq.io_merged_recursive",
+		.name = "io_merged_recursive",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct bfq_group, stats.merged),
 		.seq_show_cft = bfqg_print_rwstat_recursive,
 	},
 	{
-		.name = "bfq.io_queued_recursive",
+		.name = "io_queued_recursive",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct bfq_group, stats.queued),
 		.seq_show_cft = bfqg_print_rwstat_recursive,
 	},
 	{
-		.name = "bfq.avg_queue_size",
+		.name = "avg_queue_size",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.seq_show = bfqg_print_avg_queue_size,
 	},
 	{
-		.name = "bfq.group_wait_time",
+		.name = "group_wait_time",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct bfq_group, stats.group_wait_time),
 		.seq_show_cft = bfqg_print_stat,
 	},
 	{
-		.name = "bfq.idle_time",
+		.name = "idle_time",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct bfq_group, stats.idle_time),
 		.seq_show_cft = bfqg_print_stat,
 	},
 	{
-		.name = "bfq.empty_time",
+		.name = "empty_time",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct bfq_group, stats.empty_time),
 		.seq_show_cft = bfqg_print_stat,
 	},
 	{
-		.name = "bfq.dequeue",
+		.name = "dequeue",
+		.owner_name = "bfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct bfq_group, stats.dequeue),
 		.seq_show_cft = bfqg_print_stat,
 	},
@@ -1175,8 +1218,9 @@ struct cftype bfq_blkcg_legacy_files[] = {
 
 struct cftype bfq_blkg_files[] = {
 	{
-		.name = "bfq.weight",
-		.flags = CFTYPE_NOT_ON_ROOT,
+		.name = "weight",
+		.owner_name = "bfq",
+		.flags = CFTYPE_NOT_ON_ROOT | CFTYPE_SHARES_FILE,
 		.seq_show = bfq_io_show_weight,
 		.write = bfq_io_set_weight,
 	},
-- 
2.16.1

