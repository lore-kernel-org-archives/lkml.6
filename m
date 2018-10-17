Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F1DECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5336021476
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="JgKcXOUR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5336021476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbeJRDQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:16:04 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:48384 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbeJRDQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:16:04 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 4FA44850
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 19:18:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UMo3JK2yrHsJ for <linux-kernel@vger.kernel.org>;
        Wed, 17 Oct 2018 14:18:56 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 26363842
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 14:18:56 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id 207-v6so3402500itj.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 12:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=VJmTvf9fwMahrOxn+4Cqyagy54ffAgpYYBhMn1PncGE=;
        b=JgKcXOURR/x8MNHRWIi7MlbKGH3i8EEJ8kfKh4q6ruMwSwdQQSvwdDKBDn0ZJW/R3m
         6EWsT/KtWI0AE7WLzujtDUSbblv1QtL+qM3uCHKJ9WAjUiBQCuL3jY52cwLJY4EKea2P
         ERONHSTxG/K576mjEFX5e8RNa402m+vn9tNt3xQJO1nTOS3J0iyWTK8nQuBDzUN8sOtA
         hp96Gubc3JtygL6EYF7GEhjR1MAVzJFdzpHDupAspq3Y2GfNmgZJqZUT0Wo+wppayDap
         5CtRzrYsqJHcqz//XxgXEFWotQq2NygwQ6Wp7KwvfBSqKy3ZNbE4vkkE1VURsv9s7YPl
         lvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VJmTvf9fwMahrOxn+4Cqyagy54ffAgpYYBhMn1PncGE=;
        b=Ua73JDjW3zXBfUf9Yp1u4YUbHtLE3bYGiGOmFmp0crIsdzVGYiyf07Dm6xjktpStu9
         yqbyzq+AeI+wOusbcfyn+SJEeapfwDVzpGwDy+DOfKQy3wbeaoTytxUcDrU3CNrsnpcC
         EB/F+KS168twFROL5wMWeB3jDiym+/cug8iRId2OFYYp9wnAZ9Kwk8y5yY/bqx0d11dS
         Uv5HLmQ4/KiSwED/dQ0J8LJMmnNNhBNaVfrG0WAzqJ5cCurOrGgrQN/CC9bIUjE4g7Wd
         gzshw60LoefoELCvkhW8XGv0ti56AjpLwzqlw0MXIGf8QiS0E451uFip2ZNA10ROyhPj
         mIiw==
X-Gm-Message-State: ABuFfoj4y1uJZi5BDN2YFnjpZLInt8lKsXA0AByliGFsyuxk3knzjipp
        qIJWsQhppJ6swCYLTmVRtJbEX2dhswEi/hASmWoSLnXGis9rgJu8vZziyFSzEE4z6wyIZjCy0Dd
        9BYIb29AZyLpLqReh+z0CcCOAKeyq
X-Received: by 2002:a6b:5807:: with SMTP id m7-v6mr17325948iob.47.1539803935535;
        Wed, 17 Oct 2018 12:18:55 -0700 (PDT)
X-Google-Smtp-Source: ACcGV60GKplTA2LMNIy14EfLgRvR1JHQGjDIhjvd+phtlMOZC+bm1bZfLXcrUKc4m20DQlg79DrA0w==
X-Received: by 2002:a6b:5807:: with SMTP id m7-v6mr17325936iob.47.1539803935311;
        Wed, 17 Oct 2018 12:18:55 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id f20-v6sm1154560itc.13.2018.10.17.12.18.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Oct 2018 12:18:54 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Alex Williamson <alex.williamson@redhat.com>,
        kvm@vger.kernel.org (open list:VFIO DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4] drivers/vfio: Fix a redundant copy bug
Date:   Wed, 17 Oct 2018 14:18:44 -0500
Message-Id: <1539803924-3190-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In vfio_spapr_iommu_eeh_ioctl(), if the ioctl command is VFIO_EEH_PE_OP,
the user-space buffer 'arg' is copied to the kernel object 'op' and the
'argsz' and 'flags' fields of 'op' are checked. If the check fails, an
error code EINVAL is returned. Otherwise, 'op.op' is further checked
through a switch statement to invoke related handlers. If 'op.op' is
VFIO_EEH_PE_INJECT_ERR, the whole user-space buffer 'arg' is copied again
to 'op' to obtain the err information. However, in the following execution
of this case, the fields of 'op', except the field 'err', are actually not
used. That is, the second copy has a redundant part. Therefore, for
performance consideration, the redundant part of the second copy should be
removed.

This patch removes such a part in the second copy. It only copies from
'err.type' to 'err.mask', which is exactly required by the
VFIO_EEH_PE_INJECT_ERR op.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/vfio/vfio_spapr_eeh.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/vfio_spapr_eeh.c b/drivers/vfio/vfio_spapr_eeh.c
index 38edeb4..66634c6 100644
--- a/drivers/vfio/vfio_spapr_eeh.c
+++ b/drivers/vfio/vfio_spapr_eeh.c
@@ -37,6 +37,7 @@ long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
 	struct eeh_pe *pe;
 	struct vfio_eeh_pe_op op;
 	unsigned long minsz;
+	unsigned long start, end;
 	long ret = -EINVAL;
 
 	switch (cmd) {
@@ -86,10 +87,12 @@ long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
 			ret = eeh_pe_configure(pe);
 			break;
 		case VFIO_EEH_PE_INJECT_ERR:
-			minsz = offsetofend(struct vfio_eeh_pe_op, err.mask);
-			if (op.argsz < minsz)
+			start = offsetof(struct vfio_eeh_pe_op, err.type);
+			end = offsetofend(struct vfio_eeh_pe_op, err.mask);
+			if (op.argsz < end)
 				return -EINVAL;
-			if (copy_from_user(&op, (void __user *)arg, minsz))
+			if (copy_from_user(&op.err, (char __user *)arg +
+						start, end - start))
 				return -EFAULT;
 
 			ret = eeh_pe_inject_err(pe, op.err.type, op.err.func,
-- 
2.7.4

