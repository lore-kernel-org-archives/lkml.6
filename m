Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60083C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3312087F
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VFGD5aON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3312087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbeKLTuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 14:50:03 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35834 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729389AbeKLTuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 14:50:02 -0500
Received: by mail-wm1-f66.google.com with SMTP id t15-v6so7517739wmt.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 01:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MpOWBJhYX62m+dv0e4xXNBLs0Dhr3TZXbDUpfWqj7Ic=;
        b=VFGD5aONmJPgDKVWuSsADhnuupo20davPrcXxMNwaQMZewp7EC2pNfPmhVeF7QXgpS
         akGJu9VK0L9wXDLo3UCtHJXHfph1HyHmjiXaGZ/dtlh85gW/caRxP0MJp6ZsuOqy8afm
         oR3leMzaETYNT3djwxxEJi91rWG0izRRGxgJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MpOWBJhYX62m+dv0e4xXNBLs0Dhr3TZXbDUpfWqj7Ic=;
        b=ZwsI1m/WQR1HXRkM6jKeK7WEV5DI2HJyoNt7hf/NUNyGRPWpYH+oE88T1vTrOZeB4l
         nbga3DcgDR1N7U3xfWtFihcmK0Ztt7Z8sEFUtqRUihbqs7XdraZcbiYidJXa8uHbH0r4
         UwdqxTLjdhYEaKXPNllA299VsRaJmK1x7heBACAHoLBwKrYqcMKZcnZ8RExyUwNS2QD3
         YxP6oMNaGolMH4Kd30s22X7ScIAvoc/Xk8SjLtGIcVeditU0v8WiEmvsf1u8fGr0u+GQ
         y78a1hC5e+3o0R4lJr2M68jZF6WNjh/FQk37w9ugrwcF85da8SXDFKB+mgGEMQnomklm
         NyAg==
X-Gm-Message-State: AGRZ1gK9TuOqAoJs+tTLEwzY8g0F9XuoGiLEDu8DMxu3oaF9UG6AGuBr
        htdfeunR4m6RREyxz5maJeeaDw==
X-Google-Smtp-Source: AJdET5fFs+lCHzRwboWRo84U8qMS4Iw1ZzFVDfw3E3P+yyuWPwOR1BS7Eetdc7j7kFYPiTHMWupTEg==
X-Received: by 2002:a1c:111:: with SMTP id 17-v6mr1356272wmb.55.1542016652729;
        Mon, 12 Nov 2018 01:57:32 -0800 (PST)
Received: from localhost.localdomain ([93.68.220.21])
        by smtp.gmail.com with ESMTPSA id r14-v6sm21273089wro.8.2018.11.12.01.57.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 01:57:32 -0800 (PST)
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
Subject: [PATCH 12/12] doc, bfq-iosched: make it consistent with the new cgroup interface
Date:   Mon, 12 Nov 2018 10:56:32 +0100
Message-Id: <20181112095632.69114-13-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20181112095632.69114-1-paolo.valente@linaro.org>
References: <20181112095632.69114-1-paolo.valente@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BFQ now shares interface files with CFQ, for the proportional-share
policy. Make documentation consistent with that.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 Documentation/block/bfq-iosched.txt | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/Documentation/block/bfq-iosched.txt b/Documentation/block/bfq-iosched.txt
index 6d7dd5ab8554..b1faf091266e 100644
--- a/Documentation/block/bfq-iosched.txt
+++ b/Documentation/block/bfq-iosched.txt
@@ -508,12 +508,11 @@ process.
 To get proportional sharing of bandwidth with BFQ for a given device,
 BFQ must of course be the active scheduler for that device.
 
-Within each group directory, the names of the files associated with
-BFQ-specific cgroup parameters and stats begin with the "bfq."
-prefix. So, with cgroups-v1 or cgroups-v2, the full prefix for
-BFQ-specific files is "blkio.bfq." or "io.bfq." For example, the group
-parameter to set the weight of a group with BFQ is blkio.bfq.weight
-or io.bfq.weight.
+BFQ shares interface files with CFQ. So, if one reads/writes a file
+provided by the proportional share policy for a group, then the
+associated operation is performed by/on BFQ for each device where BFQ
+is the active scheduler, and by/on CFQ for each device where CFQ is
+the active scheduler.
 
 As for cgroups-v1 (blkio controller), the exact set of stat files
 created, and kept up-to-date by bfq, depends on whether
@@ -521,13 +520,13 @@ CONFIG_DEBUG_BLK_CGROUP is set. If it is set, then bfq creates all
 the stat files documented in
 Documentation/cgroup-v1/blkio-controller.txt. If, instead,
 CONFIG_DEBUG_BLK_CGROUP is not set, then bfq creates only the files
-blkio.bfq.io_service_bytes
-blkio.bfq.io_service_bytes_recursive
-blkio.bfq.io_serviced
-blkio.bfq.io_serviced_recursive
+blkio.io_service_bytes
+blkio.io_service_bytes_recursive
+blkio.io_serviced
+blkio.io_serviced_recursive
 
 The value of CONFIG_DEBUG_BLK_CGROUP greatly influences the maximum
-throughput sustainable with bfq, because updating the blkio.bfq.*
+throughput sustainable with BFQ, because updating the blkio.*
 stats is rather costly, especially for some of the stats enabled by
 CONFIG_DEBUG_BLK_CGROUP.
 
@@ -536,8 +535,8 @@ Parameters to set
 
 For each group, there is only the following parameter to set.
 
-weight (namely blkio.bfq.weight or io.bfq-weight): the weight of the
-group inside its parent. Available values: 1..10000 (default 100). The
+weight (namely blkio.weight or io.weight): the weight of the group
+inside its parent. Available values: 1..10000 (default 100). The
 linear mapping between ioprio and weights, described at the beginning
 of the tunable section, is still valid, but all weights higher than
 IOPRIO_BE_NR*10 are mapped to ioprio 0.
-- 
2.16.1

