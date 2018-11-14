Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B195EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78AD72145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFaTiqPr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78AD72145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbeKOIuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:50:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728371AbeKOI1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:16 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 514DF22511;
        Wed, 14 Nov 2018 22:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234133;
        bh=+MKdJKOpLvla1wJwnzIL8imnFfohNKRmpDA6j49/qgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cFaTiqPr7a8meEMl0M/uzQYjeA/s3nTHC7hrPg8EvTGGNWWfBcstTemsb2kB8pd5W
         XrEwfOQmgLrAn3+VtIPdcsMkrjh+IW9/T/qqJSpTyOFZL7GvNbmH2Ri/WxzxyCzsbX
         ytma7gv+zlC260n8ZBEcyv8DtdVT1C7AvlQ89wmM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Taehee Yoo <ap420073@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 21/73] netfilter: xt_IDLETIMER: add sysfs filename checking routine
Date:   Wed, 14 Nov 2018 17:21:15 -0500
Message-Id: <20181114222207.98701-21-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taehee Yoo <ap420073@gmail.com>

[ Upstream commit 54451f60c8fa061af9051a53be9786393947367c ]

When IDLETIMER rule is added, sysfs file is created under
/sys/class/xt_idletimer/timers/
But some label name shouldn't be used.
".", "..", "power", "uevent", "subsystem", etc...
So that sysfs filename checking routine is needed.

test commands:
   %iptables -I INPUT -j IDLETIMER --timeout 1 --label "power"

splat looks like:
[95765.423132] sysfs: cannot create duplicate filename '/devices/virtual/xt_idletimer/timers/power'
[95765.433418] CPU: 0 PID: 8446 Comm: iptables Not tainted 4.19.0-rc6+ #20
[95765.449755] Call Trace:
[95765.449755]  dump_stack+0xc9/0x16b
[95765.449755]  ? show_regs_print_info+0x5/0x5
[95765.449755]  sysfs_warn_dup+0x74/0x90
[95765.449755]  sysfs_add_file_mode_ns+0x352/0x500
[95765.449755]  sysfs_create_file_ns+0x179/0x270
[95765.449755]  ? sysfs_add_file_mode_ns+0x500/0x500
[95765.449755]  ? idletimer_tg_checkentry+0x3e5/0xb1b [xt_IDLETIMER]
[95765.449755]  ? rcu_read_lock_sched_held+0x114/0x130
[95765.449755]  ? __kmalloc_track_caller+0x211/0x2b0
[95765.449755]  ? memcpy+0x34/0x50
[95765.449755]  idletimer_tg_checkentry+0x4e2/0xb1b [xt_IDLETIMER]
[ ... ]

Fixes: 0902b469bd25 ("netfilter: xtables: idletimer target implementation")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/xt_IDLETIMER.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/netfilter/xt_IDLETIMER.c b/net/netfilter/xt_IDLETIMER.c
index 5ee859193783..25453a16385e 100644
--- a/net/netfilter/xt_IDLETIMER.c
+++ b/net/netfilter/xt_IDLETIMER.c
@@ -116,6 +116,22 @@ static void idletimer_tg_expired(struct timer_list *t)
 	schedule_work(&timer->work);
 }
 
+static int idletimer_check_sysfs_name(const char *name, unsigned int size)
+{
+	int ret;
+
+	ret = xt_check_proc_name(name, size);
+	if (ret < 0)
+		return ret;
+
+	if (!strcmp(name, "power") ||
+	    !strcmp(name, "subsystem") ||
+	    !strcmp(name, "uevent"))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int idletimer_tg_create(struct idletimer_tg_info *info)
 {
 	int ret;
@@ -126,6 +142,10 @@ static int idletimer_tg_create(struct idletimer_tg_info *info)
 		goto out;
 	}
 
+	ret = idletimer_check_sysfs_name(info->label, sizeof(info->label));
+	if (ret < 0)
+		goto out_free_timer;
+
 	sysfs_attr_init(&info->timer->attr.attr);
 	info->timer->attr.attr.name = kstrdup(info->label, GFP_KERNEL);
 	if (!info->timer->attr.attr.name) {
-- 
2.17.1

