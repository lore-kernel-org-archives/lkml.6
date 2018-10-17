Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85BEECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EAAD21527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="SkEMwxMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EAAD21527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbeJQW2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:28:15 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:47698 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbeJQW2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:28:14 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 42210BA2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 14:32:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EM_giutpqEQC for <linux-kernel@vger.kernel.org>;
        Wed, 17 Oct 2018 09:32:15 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 17B465A5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 09:32:15 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id g133-v6so24443308ioa.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 07:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hdI9DbYGcHDyAgaRsTsS2Jf674vy5TQNpJMME/eH5x8=;
        b=SkEMwxMtGWfptzS4QiBOn4jM0uHosps1qwAtiuOn/BxO9d9MGDxfHsSyrvJmMOIscf
         lFwRUHrTYfsYkLDL61pwqZk/2cEdFkGG7CjoT/5XIM/zH9wkKyhc0n43fRSCInLuPDQU
         T+GJTrvuK5RBRvu1UlU36TYchbkTmunAjFbDodqrJspMrfCs0+m5lbYDl/RrtE8O2sdy
         dOeX46x4iNcIZYOBP5doNsOj4njQUFxCv0EUAcMecnvDO39nGuI4ct620bCY9OpfLXmu
         b+3uEy5LUadPy1g6j7sjSDY54xWABO52G/f99ZJUK4GBRbSK3qC03FnsqTx6fz7V+aWe
         AAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hdI9DbYGcHDyAgaRsTsS2Jf674vy5TQNpJMME/eH5x8=;
        b=OHWxsNrJIZKSWORCwxTlLv+le0jCcqz6fXpI52ZjU0Vwd4SY/BwhC+wdQiQIS2EtOz
         RjwQeb3VeQqrx2vttwh18AYr3Wc4bgPT2EwXL4Pt6oiHj65/6H0c3ysDaoZjvWV9T5mU
         9R+E3quEtIYGIuJVmCjyjoMZpQDk/M54mZEUC/rnUqLVOLjL/cqL/VzJc+PBmbbfNLEn
         KBajmrjdMqlKXS2mCeagp4nbHxoGNbR/xcKfMjqR1fPBCIcAjE936xGgkDRTnMGmDfec
         zjIopj2rBB7bxnyDHs4VnV6Fup4NNfIxOuOwp0VLd1Y4tkC/6Hkq/+QlSLF2jmdt3wRF
         qfvQ==
X-Gm-Message-State: ABuFfoiGF7jcHOaDmT72OJnwyXFkw0662XMxHwOg/AtKfPP0uOnQpXOu
        CUb7i2zaOWAiL/vvm96n6PHc+doYbWmP5tnaMhgKi6H5Pndse1QTNbiVJRzUIjA8JgYKuCQ8/CB
        3nydQos4CFhmc7DtFl5isRQ0hfuhK
X-Received: by 2002:a24:3c8:: with SMTP id e191-v6mr1861387ite.170.1539786734767;
        Wed, 17 Oct 2018 07:32:14 -0700 (PDT)
X-Google-Smtp-Source: ACcGV63ByWiH5JlWcsJdxxejrwxQwR/cNztWhQWGT9B2ZYYWGCZdLGbN6yorlIoqZYuLcCGQGc7Mig==
X-Received: by 2002:a24:3c8:: with SMTP id e191-v6mr1861372ite.170.1539786734515;
        Wed, 17 Oct 2018 07:32:14 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id y11-v6sm5914285ioa.24.2018.10.17.07.32.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Oct 2018 07:32:13 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Alex Williamson <alex.williamson@redhat.com>,
        kvm@vger.kernel.org (open list:VFIO DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] drivers/vfio: Fix a redundant copy bug
Date:   Wed, 17 Oct 2018 09:32:04 -0500
Message-Id: <1539786725-1812-1-git-send-email-wang6495@umn.edu>
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

This patch also adds a 4-byte reserved field in the structure
vfio_eeh_pe_op to make sure that the u64 fields in the structure
vfio_eeh_pe_err are 8-byte aligned.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/vfio/vfio_spapr_eeh.c | 9 ++++++---
 include/uapi/linux/vfio.h     | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

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
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 1aa7b82..d904c42 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -729,6 +729,7 @@ struct vfio_eeh_pe_op {
 	__u32 argsz;
 	__u32 flags;
 	__u32 op;
+	__u32 __resv;
 	union {
 		struct vfio_eeh_pe_err err;
 	};
-- 
2.7.4

