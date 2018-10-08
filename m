Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4054AC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067C02145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="PJMh5AHZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067C02145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeJIBTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:19:31 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:47264 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbeJIBTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:19:30 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id B8B39FC5
        for <linux-kernel@vger.kernel.org>; Mon,  8 Oct 2018 18:06:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GFBgCmHFkdje for <linux-kernel@vger.kernel.org>;
        Mon,  8 Oct 2018 13:06:34 -0500 (CDT)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 8176A1009
        for <linux-kernel@vger.kernel.org>; Mon,  8 Oct 2018 13:06:34 -0500 (CDT)
Received: by mail-it1-f200.google.com with SMTP id z136-v6so11876945itc.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 11:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=NW2oLiXs1xkho6nwIyy1q2qHL+VNYiwokideRStX/Rs=;
        b=PJMh5AHZByqhxGK0o6MyMfQktOijHi9jel47BnnVCpDfSKVwpVVYt6EJwyaIYfVQta
         fwAVuaRCPh54jhWSPLjvBOYMqKlkjQu5XSSRtsJIwgPP+1YPeq/gpas892Bc/lNXVPmS
         guIDMGUj4nxeuloQu3VDFI7/DpYLint5ftlglf1iVd5C9r7JuKPBOa9QYro+8K6hz/F5
         irnyaVKrOXWiCWKQqYszR2C/GKY8Gb4PQcmHEhIHlbZ7oZrtCJhTejvNlJs2GUYoq/wz
         Wig+90WFN/d3ZGiNS8lYO3/DwuZTEgqdEqU8s8e9Ko82sMajdSirhaEPHcwTABsYdFES
         woxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NW2oLiXs1xkho6nwIyy1q2qHL+VNYiwokideRStX/Rs=;
        b=fa8QLaOWjkbYYG5C01CQTutVqMNqwk49Dyi6+Cz+cN8x1RxMUkQ0zntVxU21zWcLhg
         FOX5A24YU/lyneDtmIzsZIVsXKWzbRuCeu2/rhS7TBrvvFlfJ94bLLKWlRRUAgJotS7b
         jmJjqkzcxkYabMa+rsb2g+XaRrtUezBqw4/c7fcSmT5zl1TPYpJxuwMNnqpGW6pTT0Ph
         aBo6Sd6N5jL1Ycz8BLHaM7sRvRMnPpP/G7+cVlUxAs32zadTFicSZR+DHZANrZZMIOoR
         9wkF4qqobhZmJuEdLzPAfJ2yQvnVIDE7ZoKmCu2zbI2tMTWt0HULnXyXX15lLF4KH4XB
         yyZQ==
X-Gm-Message-State: ABuFfogR8lq0mkytw0qkSfs/xMaKFp8WeYEt+uco+93QBnbbtrIIOwHa
        Cejxr0aEOjRvlpqLJfQHsp2FmUT5b38aWRcwm5u4iJacTQCNUxjZtj9XNKDDsWWCAEpmWYV8XDr
        yxZzjwRj7YsZ9NqW2/Llgks46P4XE
X-Received: by 2002:a02:91c9:: with SMTP id s9-v6mr20561380jag.104.1539021994186;
        Mon, 08 Oct 2018 11:06:34 -0700 (PDT)
X-Google-Smtp-Source: ACcGV63HrYkFMF6Pg9CRs+2l6z+F5YNMDuJ4p+6u/AYeM9F0+8mx3ThYHkzMjAnatFl/780yF+VUWg==
X-Received: by 2002:a02:91c9:: with SMTP id s9-v6mr20561373jag.104.1539021993995;
        Mon, 08 Oct 2018 11:06:33 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id p185-v6sm450411itg.34.2018.10.08.11.06.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Oct 2018 11:06:33 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Alex Williamson <alex.williamson@redhat.com>,
        kvm@vger.kernel.org (open list:VFIO DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] drivers/vfio: Fix a redundant copy bug
Date:   Mon,  8 Oct 2018 13:06:20 -0500
Message-Id: <1539021980-2412-1-git-send-email-wang6495@umn.edu>
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
used. That is, the second copy has a redundant part. Therefore, for both
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

