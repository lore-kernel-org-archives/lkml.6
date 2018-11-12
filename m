Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE80AC0044B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9C4223D1
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QG+hymxr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D9C4223D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbeKLTtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 14:49:53 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53849 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbeKLTtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 14:49:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id f10-v6so7788142wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 01:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BhhSrhl3GPkKSUoXIhn9nAMo7Bh19cGOMzxu3Gi9vPg=;
        b=QG+hymxrp0k2JHc1mCXq7bGzmIVfKn8kyei84SG0+Y3J9yu8gRuP/KiUBxNO6H35Yw
         PAM/xy0h10htiE9hYdXK9BcdZPCqgmM0bjBMsEt8TvvDzFJTQMZNtCgl4n1iF4YqNIE/
         nqEomghns5VaEzxAIC/4QDraAfkZx5bQG9Ixk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BhhSrhl3GPkKSUoXIhn9nAMo7Bh19cGOMzxu3Gi9vPg=;
        b=K0Z4fNtPx29BcohML4GPZ9krN4/CG7etL/qaQozxfPm32yNl2tPrJfkcsdLczzobAV
         BAu6gRXfzDT2EG7aYs5JUU07cM+DCD7EnyH8BIj8e4wCvJHHxfy3BC6ZEHFhiCGfmcWM
         yFsDO6Eujdk8WdiD96t4AOHemK6fT+XDK7PEdw2SavIgzaoHUsOi4/m3svR+EAMZC+V/
         YR7pRSi9i7Ah/1R65ApdvW+Y5aKNLuuv2jFsiDxjNDtC6GiUTboL53OB2vbApHy1uCFB
         HDdZH0X/FkIjZ+U+7x6u4B/nZjjC4AHCkH9mMvpZ+u3BRm6MD8EqDix3T9ZjeO7hrwiv
         jCAg==
X-Gm-Message-State: AGRZ1gIbdbSv7gdxThrePXXfAxq9+cYwy7s9nlKb48zulmciRVgmncCJ
        cPXM93OTjWc04l5vMBG/5uYFcL7LtByutyVq
X-Google-Smtp-Source: AJdET5ciK+vocmPu6b60UpX73AaZ1OTTiPWtswUD/U+3dbiFmTt0CYEpBhnfnlzDg3PvsctIzLIX7w==
X-Received: by 2002:a1c:3c83:: with SMTP id j125-v6mr6771922wma.65.1542016642661;
        Mon, 12 Nov 2018 01:57:22 -0800 (PST)
Received: from localhost.localdomain ([93.68.220.21])
        by smtp.gmail.com with ESMTPSA id r14-v6sm21273089wro.8.2018.11.12.01.57.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 01:57:22 -0800 (PST)
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
Subject: [PATCH 08/12] block, cfq: allow cgroup files to be shared
Date:   Mon, 12 Nov 2018 10:56:28 +0100
Message-Id: <20181112095632.69114-9-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20181112095632.69114-1-paolo.valente@linaro.org>
References: <20181112095632.69114-1-paolo.valente@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Angelo Ruocco <angeloruocco90@gmail.com>

Some of the files exposed in a cgroup by cfq have the same meaning as
the files exposed by bfq and throttle.

This commit allows these files to be shared.

Signed-off-by: Angelo Ruocco <angeloruocco90@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/cfq-iosched.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index af0c59c2dcde..f046039bdfc6 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -2016,7 +2016,8 @@ static struct cftype cfq_blkcg_legacy_files[] = {
 	},
 	{
 		.name = "weight",
-		.flags = CFTYPE_NOT_ON_ROOT,
+		.owner_name = "cfq",
+		.flags = CFTYPE_NOT_ON_ROOT | CFTYPE_SHARES_FILE,
 		.seq_show = cfq_print_weight,
 		.write_u64 = cfq_set_weight,
 	},
@@ -2035,40 +2036,56 @@ static struct cftype cfq_blkcg_legacy_files[] = {
 	/* statistics, covers only the tasks in the cfqg */
 	{
 		.name = "time",
+		.owner_name = "cfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct cfq_group, stats.time),
 		.seq_show_cft = cfqg_print_stat,
 	},
 	{
 		.name = "sectors",
+		.owner_name = "cfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.seq_show = cfqg_print_stat_sectors,
 	},
 	{
 		.name = "io_service_bytes",
+		.owner_name = "cfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = (unsigned long)&blkcg_policy_cfq,
 		.seq_show_cft = blkg_print_stat_bytes,
 	},
 	{
 		.name = "io_serviced",
+		.owner_name = "cfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = (unsigned long)&blkcg_policy_cfq,
 		.seq_show_cft = blkg_print_stat_ios,
 	},
 	{
 		.name = "io_service_time",
+		.owner_name = "cfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct cfq_group, stats.service_time),
 		.seq_show_cft = cfqg_print_rwstat,
 	},
 	{
 		.name = "io_wait_time",
+		.owner_name = "cfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct cfq_group, stats.wait_time),
 		.seq_show_cft = cfqg_print_rwstat,
 	},
 	{
 		.name = "io_merged",
+		.owner_name = "cfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct cfq_group, stats.merged),
 		.seq_show_cft = cfqg_print_rwstat,
 	},
 	{
 		.name = "io_queued",
+		.owner_name = "cfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct cfq_group, stats.queued),
 		.seq_show_cft = cfqg_print_rwstat,
 	},
@@ -2076,70 +2093,97 @@ static struct cftype cfq_blkcg_legacy_files[] = {
 	/* the same statictics which cover the cfqg and its descendants */
 	{
 		.name = "time_recursive",
+		.owner_name = "cfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct cfq_group, stats.time),
 		.seq_show_cft = cfqg_print_stat_recursive,
 	},
 	{
 		.name = "sectors_recursive",
+		.owner_name = "cfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.seq_show = cfqg_print_stat_sectors_recursive,
 	},
 	{
 		.name = "io_service_bytes_recursive",
+		.owner_name = "cfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = (unsigned long)&blkcg_policy_cfq,
 		.seq_show_cft = blkg_print_stat_bytes_recursive,
 	},
 	{
 		.name = "io_serviced_recursive",
+		.owner_name = "cfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = (unsigned long)&blkcg_policy_cfq,
 		.seq_show_cft = blkg_print_stat_ios_recursive,
 	},
 	{
 		.name = "io_service_time_recursive",
+		.owner_name = "cfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct cfq_group, stats.service_time),
 		.seq_show_cft = cfqg_print_rwstat_recursive,
 	},
 	{
 		.name = "io_wait_time_recursive",
+		.owner_name = "cfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct cfq_group, stats.wait_time),
 		.seq_show_cft = cfqg_print_rwstat_recursive,
 	},
 	{
 		.name = "io_merged_recursive",
+		.owner_name = "cfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct cfq_group, stats.merged),
 		.seq_show_cft = cfqg_print_rwstat_recursive,
 	},
 	{
 		.name = "io_queued_recursive",
+		.owner_name = "cfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct cfq_group, stats.queued),
 		.seq_show_cft = cfqg_print_rwstat_recursive,
 	},
 #ifdef CONFIG_DEBUG_BLK_CGROUP
 	{
 		.name = "avg_queue_size",
+		.owner_name = "cfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.seq_show = cfqg_print_avg_queue_size,
 	},
 	{
 		.name = "group_wait_time",
+		.owner_name = "cfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct cfq_group, stats.group_wait_time),
 		.seq_show_cft = cfqg_print_stat,
 	},
 	{
 		.name = "idle_time",
+		.owner_name = "cfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct cfq_group, stats.idle_time),
 		.seq_show_cft = cfqg_print_stat,
 	},
 	{
 		.name = "empty_time",
+		.owner_name = "cfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct cfq_group, stats.empty_time),
 		.seq_show_cft = cfqg_print_stat,
 	},
 	{
 		.name = "dequeue",
+		.owner_name = "cfq",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = offsetof(struct cfq_group, stats.dequeue),
 		.seq_show_cft = cfqg_print_stat,
 	},
 	{
 		.name = "unaccounted_time",
+		.owner_name = "cfq",
 		.private = offsetof(struct cfq_group, stats.unaccounted_time),
 		.seq_show_cft = cfqg_print_stat,
 	},
@@ -2181,7 +2225,8 @@ static ssize_t cfq_set_weight_on_dfl(struct kernfs_open_file *of,
 static struct cftype cfq_blkcg_files[] = {
 	{
 		.name = "weight",
-		.flags = CFTYPE_NOT_ON_ROOT,
+		.owner_name = "cfq",
+		.flags = CFTYPE_NOT_ON_ROOT | CFTYPE_SHARES_FILE,
 		.seq_show = cfq_print_weight_on_dfl,
 		.write = cfq_set_weight_on_dfl,
 	},
-- 
2.16.1

