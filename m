Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD95C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D602080F
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FDIijxyz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D602080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbeKLTt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 14:49:58 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38612 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729343AbeKLTt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 14:49:57 -0500
Received: by mail-wm1-f65.google.com with SMTP id f2-v6so7461593wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 01:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tJzqIZ4whiBiBt1HUGz+jcfYWcwBBnR88Hf7l4Y3mww=;
        b=FDIijxyzwzKUw8K/20a1vK7NhMkivhaxGdBShwBbInbBKMPrlnQRfW4Q14WNLJlAgk
         +5kolkin8wKT5bN1KavHsyCPbdwxMplfi0IRkntZ056n0gKQV+UuCM8samekxvyVvzGV
         rA+3TSy9ixB0Rhl9TjcTj+dGLIzKf73wxGTX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tJzqIZ4whiBiBt1HUGz+jcfYWcwBBnR88Hf7l4Y3mww=;
        b=Yn1ZcOZW1WLQPoupo7djaxDykIsDBTLQVRF7wfM7h/WPlrVPyViDmsp0p6sR5xLBE9
         u2MGs8MCWVzc6D12lBK2aoxvgnLIfATvfZdqrzdcqnxEwvv66curDtTd2jn+Dh+u57sv
         tSW9lIZIiiFxnBuOzIZKVLWOGsg1leNjD+4q403Mh37+7610I9eot/7l+tpzX9m9T7R9
         DuPOHMYLxzfPd/j94Qr4E8lQpif40ixPhhf7w1oNjE1o0N1z2uGUa7mJ0WJ/67ougUqY
         TEBhN7Tk6CzNxGiYk4L9HAH0fVf9ezGUHEw2oC2T6LyrxEed8cZVm/QdYNOrkNFzAr8f
         F/qA==
X-Gm-Message-State: AGRZ1gJNQ0Gd+ipziPh/0pV4AoH0hoEFf4/cHd5avBAPpF8l5arjtsaz
        MRkbXpMVVR1uYA4d1ajG7ZgBeg==
X-Google-Smtp-Source: AJdET5fawr7GnsFjWBfAqQNwc0WTsbuL0TF0A5Vo5Qb1Eh1UMzTSTTRDuv41Dqraj6jvyVn0dIwu2g==
X-Received: by 2002:a1c:58c5:: with SMTP id m188-v6mr6705885wmb.85.1542016647902;
        Mon, 12 Nov 2018 01:57:27 -0800 (PST)
Received: from localhost.localdomain ([93.68.220.21])
        by smtp.gmail.com with ESMTPSA id r14-v6sm21273089wro.8.2018.11.12.01.57.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 01:57:27 -0800 (PST)
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
Subject: [PATCH 10/12] block, throttle: allow sharing cgroup statistic files
Date:   Mon, 12 Nov 2018 10:56:30 +0100
Message-Id: <20181112095632.69114-11-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20181112095632.69114-1-paolo.valente@linaro.org>
References: <20181112095632.69114-1-paolo.valente@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Angelo Ruocco <angeloruocco90@gmail.com>

Some of the cgroup files defined in the throttle policy have the same
meaning as those defined in the proportional share policy.

This commit uses the new file sharing interface in cgroup to share
these files.

Signed-off-by: Angelo Ruocco <angeloruocco90@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/blk-throttle.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 5c43821dc528..239957c12d34 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1491,22 +1491,30 @@ static struct cftype throtl_legacy_files[] = {
 		.write = tg_set_conf_uint,
 	},
 	{
-		.name = "throttle.io_service_bytes",
+		.name = "io_service_bytes",
+		.owner_name = "throttle",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = (unsigned long)&blkcg_policy_throtl,
 		.seq_show_cft = blkg_print_stat_bytes,
 	},
 	{
-		.name = "throttle.io_service_bytes_recursive",
+		.name = "io_service_bytes_recursive",
+		.owner_name = "throttle",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = (unsigned long)&blkcg_policy_throtl,
 		.seq_show_cft = blkg_print_stat_bytes_recursive,
 	},
 	{
-		.name = "throttle.io_serviced",
+		.name = "io_serviced",
+		.owner_name = "throttle",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = (unsigned long)&blkcg_policy_throtl,
 		.seq_show_cft = blkg_print_stat_ios,
 	},
 	{
-		.name = "throttle.io_serviced_recursive",
+		.name = "io_serviced_recursive",
+		.owner_name = "throttle",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = (unsigned long)&blkcg_policy_throtl,
 		.seq_show_cft = blkg_print_stat_ios_recursive,
 	},
-- 
2.16.1

