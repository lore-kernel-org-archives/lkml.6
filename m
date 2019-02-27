Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EEBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D2C20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kBY+67Rn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbfB0STR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 13:19:17 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:34703 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfB0STR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 13:19:17 -0500
Received: by mail-qt1-f201.google.com with SMTP id b40so16208230qte.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 10:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=UpQ34x9CJVo3jIMuwrBGFvwnwF44v09YiYrvYmOwAnw=;
        b=kBY+67RnConXudAKvBsaaC/cxQHODIak9C5jRm/kYX6Xs9VWyQuFJMpLGonDuRuCwc
         cUOqVFSUAaRS7sudGD6pNMX2GGjHvc+r7nevfstPhDUMNZUfMVlx7CpyljKMGiOamLxa
         hLnhNxcepKnr/T5zTYEiGor79r/0g4GnC6nD/Ke2Tt0Vj8JP6jTuCX3x3y6NV7tWhvTc
         6qxsEUyM9dvTmVv+0IMt4I9niLEgC/bWN3mqu8o9oudt3Uw3NZWKEceaDoGzNF4TPEU4
         scwRM2+CLZReB+pmDED7HA9dR3EnlTTpzYTxFbxryiHhrKFGquemMw9QtsyeaqlVYbr4
         MGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=UpQ34x9CJVo3jIMuwrBGFvwnwF44v09YiYrvYmOwAnw=;
        b=gVUKy60gvnzrpd1Cr5qn0cGmLrJKVk1imrxmZNBack2qo5sZeJFQsgnCTgJZSU5W57
         FImnCoMoJ0dgiBX5RR1NzULPi3ggkQ1o3ey3Q7ZdwwU8hV5ycA4frcuzABj16cBMr94t
         AcibyQQWV+jMnjZD9AW6Hb3/NmLZ/O7aam/YKKGI+Rkyeq1/VrMk63K1db1X/cEoD8Hu
         8AGqa2gozRK8Xu3jXF1++OGB6+Z1haNLXcKzHhsS3luPQ+4uj2ItH80MGqak2r4qUlWX
         cS4x9WoEZE4U0bWlCcUm2D+A+mGTXYNsOhvyd7yDetbk9MPDjOnpu6yELrTHfmtUOlIf
         Bb1g==
X-Gm-Message-State: APjAAAW85csTupVBfzG8z2JjRQX/VSmq1X+r6qzFZ0nBA9SR69/h3MRY
        beP0d/SWvTd9LMTALWqLwSMfUgL3HMpM27nSjvU=
X-Google-Smtp-Source: APXvYqyTEcfylfczLKKO+Uy3tBvxna+EpFnnsCLzBzUf1+5vsWgzdiYRmBZMAZARQaM4nKu2x2jqf/A/627mC/pZyrE=
X-Received: by 2002:a05:6214:1048:: with SMTP id l8mr1473264qvr.46.1551291556128;
 Wed, 27 Feb 2019 10:19:16 -0800 (PST)
Date:   Wed, 27 Feb 2019 10:19:10 -0800
Message-Id: <20190227181910.229008-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
Subject: [PATCH] netfilter: xt_IDLETIMER: fix sysfs callback function type
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>
Cc:     "David S . Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use struct device_attribute instead of struct idletimer_tg_attr, and
the correct callback function type to avoid indirect call mismatches
with Control Flow Integrity checking.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 net/netfilter/xt_IDLETIMER.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/net/netfilter/xt_IDLETIMER.c b/net/netfilter/xt_IDLETIMER.c
index eb4cbd244c3d..5f9b37e12801 100644
--- a/net/netfilter/xt_IDLETIMER.c
+++ b/net/netfilter/xt_IDLETIMER.c
@@ -41,19 +41,13 @@
 #include <linux/workqueue.h>
 #include <linux/sysfs.h>
 
-struct idletimer_tg_attr {
-	struct attribute attr;
-	ssize_t	(*show)(struct kobject *kobj,
-			struct attribute *attr, char *buf);
-};
-
 struct idletimer_tg {
 	struct list_head entry;
 	struct timer_list timer;
 	struct work_struct work;
 
 	struct kobject *kobj;
-	struct idletimer_tg_attr attr;
+	struct device_attribute attr;
 
 	unsigned int refcnt;
 };
@@ -76,15 +70,15 @@ struct idletimer_tg *__idletimer_tg_find_by_label(const char *label)
 	return NULL;
 }
 
-static ssize_t idletimer_tg_show(struct kobject *kobj, struct attribute *attr,
-				 char *buf)
+static ssize_t idletimer_tg_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
 {
 	struct idletimer_tg *timer;
 	unsigned long expires = 0;
 
 	mutex_lock(&list_mutex);
 
-	timer =	__idletimer_tg_find_by_label(attr->name);
+	timer =	__idletimer_tg_find_by_label(attr->attr.name);
 	if (timer)
 		expires = timer->timer.expires;
 
-- 
2.21.0.rc2.261.ga7da99ff1b-goog

