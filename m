Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223ACECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF95720861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mvu4/+q+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF95720861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbeINP1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:27:07 -0400
Received: from m12-12.163.com ([220.181.12.12]:45775 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726868AbeINP1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=5LYAsr7R3L+7NM5eB+
        7I4i5+RFUvwLjoUKcL0LC7swY=; b=mvu4/+q+uJZ1ShrYTnq+46wuX/MxREmIRx
        XsUbE+DeqjSsufeBTP+q91rra88iD8VACL30Ztls/dmkki/Dtnod1fU8+bObJLO9
        tob8O/qstiTuSP8j9onxxpT4KR/nadaHKUp11vr0dJdSjNHUTIn6M7Ep1YuLVH3+
        Y6iYliD94=
Received: from localhost.localdomain (unknown [117.136.0.171])
        by smtp8 (Coremail) with SMTP id DMCowABnzqa4iZtbcIyaQg--.20838S4;
        Fri, 14 Sep 2018 18:13:13 +0800 (CST)
From:   Dongbo Cao <cdbdyx@163.com>
To:     colyli@suse.de
Cc:     kent.overstreet@gmail.com, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dongbo Cao <cdbdyx@163.com>
Subject: [PATCH 2/2] add some safety checks for label store interface of flash dev in sysfs
Date:   Fri, 14 Sep 2018 18:12:59 +0800
Message-Id: <20180914101259.4169-1-cdbdyx@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DMCowABnzqa4iZtbcIyaQg--.20838S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrur43JrW7GFyfuF18Xr1fJFb_yoW3WFg_Cr
        WUWr4kGwsYkr17Z34xAF4IqFyYgrWqvryFgF4jvr1SvF43AryfW3yvvr93Jws5WFySkay7
        JryDG34YkwnakjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8tPE7UUUUU==
X-Originating-IP: [117.136.0.171]
X-CM-SenderInfo: xfgev5r06rljoofrz/1tbiGRnB3FXlf+4kvQAAsl
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do some checks on the label's length and ending.

Signed-off-by: Dongbo Cao <cdbdyx@163.com>
---
 drivers/md/bcache/sysfs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index e64c718f..cce793ef 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -447,8 +447,15 @@ STORE(__bch_flash_dev)
 	}
 
 	if (attr == &sysfs_label) {
+		if (size > SB_LABEL_SIZE)
+			return -EINVAL;
 		memcpy(u->label, buf, SB_LABEL_SIZE);
-		bch_uuid_write(d->c);
+		if (size < SB_LABEL_SIZE)
+			u->label[size] = '\0';
+		if (size && u->label[size - 1] == '\n')
+			u->label[size - 1] = '\0';
+		if(d->c)
+			bch_uuid_write(d->c);
 	}
 
 	if (attr == &sysfs_unregister) {
-- 
2.17.1


