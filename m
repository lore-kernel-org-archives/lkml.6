Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22ECDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8B32089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPRzKUNF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE8B32089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbeKZVxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:53:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:35138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728810AbeKZVxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:53:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A71BD2089F;
        Mon, 26 Nov 2018 10:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229978;
        bh=SQzqzrLtLAoiygphQaBNNFAlkiHS0EBmu7VhCxfKZ5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IPRzKUNFF5XQk0QEX8JKZ6y7jAod86ZSQEFCW0uQV0qa3Nm9An0cx3G8U0yQyEkjo
         4T7n96mt7KCqh4JpY3MXygsCV6SPyA6+S2KoalK/KYkUKvi1KWU13WSpddnXSU9tZv
         EnJ3Gf+q5jExBIkvsOwzJzAANwpB0e7HJ8BHo83E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 25/62] netfilter: xt_IDLETIMER: add sysfs filename checking routine
Date:   Mon, 26 Nov 2018 11:51:06 +0100
Message-Id: <20181126105052.858446162@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105050.592727680@linuxfoundation.org>
References: <20181126105050.592727680@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 1141f08810b6..3fef8c2e545d 100644
--- a/net/netfilter/xt_IDLETIMER.c
+++ b/net/netfilter/xt_IDLETIMER.c
@@ -116,6 +116,22 @@ static void idletimer_tg_expired(unsigned long data)
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



