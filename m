Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5A9C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A02420862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHBuSB7n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A02420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbeK0B4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:56:06 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45842 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbeK0B4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:56:05 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so6279233pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 07:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7aNr8lT4g0X8YaxC1dnyIkR+7Z/DPOdEpX/yqL61nHo=;
        b=IHBuSB7npTTECF1LUJ7fEZ87O/vlL+wtrpeVbiXyyhWVcxYFSO3SXKy9rw9+6nJOdb
         zjSqxwz/v6lVeSvOAy5KLhdn9vD/vwzB01rQHAFiemSWdAbQSoO9eZxLg42YMQB0IRPP
         FsQvFrTVNKWotkKvlyw/ySqAv60JP11LneSqBHWV47hquzipZdoY342dYL42aurlojCl
         gwCiDf8KSZ0rjFJ+VoPIkdSYb4Nv3N7DzY0/rTXoQWDx0MebOMF0twhfmPd14T4jEoCB
         rb/maAQLqP5ndRSWo8AGUP8AjPVcf2IpOSCUuzAECZMVJHM7mSSmAnXM4kt87JdIFr34
         GrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7aNr8lT4g0X8YaxC1dnyIkR+7Z/DPOdEpX/yqL61nHo=;
        b=F28h/bvl+UsG2t8mj/7F4UxxNDWlDtEaDwbN0MffuUzqBZw+OIVgYf4DeY7b6KNoh+
         MJ7RDdfn00EAGSsjbJok/kD4YrEjkK7/XBWbqNnEcNTmWV8njmLQOdHxNyOW6xwPrHiJ
         blQCZUFM6F0oTV2xt4kH0rk8DCnr4s67lYEwswjVOQicv0/jzinEAwEvBymNXTYJZ528
         u7RYWp+2+qmeYwDOq+bYkJ5HeUyBfUGuwNKwvkEYNx9dZ4ruFVMVaV4fKRKSehPordWJ
         bikztJTE9Tzhy8JhtPRLzyuX/Rswq1BZhwwrJpy+L5znV5PDdBUIQhl8mm6F91ros9Aq
         iA7Q==
X-Gm-Message-State: AGRZ1gJL6oRISdICX/CxWiczc9qb0NntEQpO+PfoxynWJy+CflJI5pW9
        x53vnLKIQWPz8Jxq2acT2ZI=
X-Google-Smtp-Source: AJdET5d2C9Sv0NO1TolItKqdAY4vBfrDlQJUU2yMLmVO9mObN6O6bamMr4cSzSEySphcyLg3Tri+zQ==
X-Received: by 2002:aa7:8497:: with SMTP id u23mr28191244pfn.220.1543244503327;
        Mon, 26 Nov 2018 07:01:43 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id v70sm689219pfa.152.2018.11.26.07.01.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 07:01:42 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     paul@paul-moore.com, eparis@redhat.com
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] audit/filter: remove some duplicated includes
Date:   Mon, 26 Nov 2018 10:01:39 -0500
Message-Id: <20181126150139.31989-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

audit.h and fs.h are included twice.It's unnecessary.
hence just remove them.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 kernel/auditfilter.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index bf309f2592c4..6d43928a41c2 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -22,10 +22,8 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kernel.h>
-#include <linux/audit.h>
 #include <linux/kthread.h>
 #include <linux/mutex.h>
-#include <linux/fs.h>
 #include <linux/namei.h>
 #include <linux/netlink.h>
 #include <linux/sched.h>
-- 
2.17.0

