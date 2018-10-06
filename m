Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FDEC67871
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 18:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4DD20875
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 18:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="jn4k6BNy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4DD20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbeJGBiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 21:38:52 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:56470 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbeJGBiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 21:38:52 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id D2D8310C9
        for <linux-kernel@vger.kernel.org>; Sat,  6 Oct 2018 18:34:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nihiilAxw7Wh for <linux-kernel@vger.kernel.org>;
        Sat,  6 Oct 2018 13:34:30 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 9A9F9113A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Oct 2018 13:34:30 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id c5-v6so15474118ioa.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Oct 2018 11:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=//46jCMo0aQEazxmlcnvQauPwoY/xdcmedK2Gsefewc=;
        b=jn4k6BNyxZTkfGk0KiCJRqhHRPfymy3UMz4UU/hf/uTmgGUkPiAZ0udKMvYDI+M7Fm
         uG68OeCCTsy7/TvlQaQI/yk6uUaoqYnRS4D4Rsr8YiC6iC4JZzGaTShCo1PYwCoujp7M
         q77fJRFPYd/cw5is4nG6sp3m22WrUDyplYMsOhQQF8FfkyKZ7WBD4mfAEo9MoJOnKBCi
         YTthsPr0B77eT03k5LfeViHB8ff4ZdZBWJ9pGOf74rYJs4xx053p2mCcYXM2nXWVAvUd
         SAQVnYzMGyypucMcGflnRNXB8OTrH33jOwWTyn4jUxGMQRDVFYy0AT6AAuZMapeFloTH
         hcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=//46jCMo0aQEazxmlcnvQauPwoY/xdcmedK2Gsefewc=;
        b=l3xvT6RUymYlnQPBUltqjNd9MxXltjJvdrvRn2RSaTtWRdfeylj4JmaJlV8jo5jY0V
         KLBd/imcVKA7vbJnOBWOYo5YDPoqZXwlfrgdTYe6I8+U25Qd6nWb0nRcw00heUKqY5tv
         yMTJk2i5qpLa48rtVoR1NmqMU2PJlfjDOp1RBSem0zhPDksYw0VIvL8E2/01+br7qp1B
         VGnIZUfX70ibTqokGKwA6uoADhQwbg0rYVPexe/VIORpr+rsP3/DVHeLMMlldUTOynZs
         z8oLyDF10Y7/FuNxORqnb47LBVGKTcn0cLTyyMUIg1prT1tMYy9eQDuQrDBh3cSBc3Hu
         9ggw==
X-Gm-Message-State: ABuFfogxgJx5/QZkZSlTZhI6Nu9rVYO8v+qUF0q099R2x3kTI/tXyl7n
        WnC9xpSKIr0tMBNGjV696e0xC96Ezpb6ZTt9CRjzwPiJW+ojMQpLbU4GlAeSjXLv3/NyWT6EXyL
        /mMIHZrQOXf0h8UecSSnMjbsjCuMI
X-Received: by 2002:a6b:c917:: with SMTP id z23-v6mr11504417iof.297.1538850870230;
        Sat, 06 Oct 2018 11:34:30 -0700 (PDT)
X-Google-Smtp-Source: ACcGV61fLamsx61u91GT6c6BnY3XE7Bu7OdTVHz6sdS5GUADnDi5o4t8bhvRphpVkyv7iu4EuHgAYA==
X-Received: by 2002:a6b:c917:: with SMTP id z23-v6mr11504405iof.297.1538850870034;
        Sat, 06 Oct 2018 11:34:30 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id t190-v6sm2585924ita.39.2018.10.06.11.34.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Oct 2018 11:34:29 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com (open list:MEGARAID SCSI/SAS DRIVERS),
        linux-scsi@vger.kernel.org (open list:MEGARAID SCSI/SAS DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] scsi: megaraid_sas: fix a missing-check bug
Date:   Sat,  6 Oct 2018 13:34:21 -0500
Message-Id: <1538850861-26882-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In megasas_mgmt_compat_ioctl_fw(), to handle the structure
compat_megasas_iocpacket 'cioc', a user-space structure megasas_iocpacket
'ioc' is allocated before megasas_mgmt_ioctl_fw() is invoked to handle the
packet. Since the two data structures have different fields, the data is
copied from 'cioc' to 'ioc' field by field. In the copy process,
'sense_ptr' is prepared if the field 'sense_len' is not null, because it
will be used in megasas_mgmt_ioctl_fw(). To prepare 'sense_ptr', the
user-space data 'ioc->sense_off' and 'cioc->sense_off' are copied and saved
to kernel-space variables 'local_sense_off' and 'user_sense_off'
respectively. Given that 'ioc->sense_off' is also copied from
'cioc->sense_off', 'local_sense_off' and 'user_sense_off' should have the
same value. However, 'cioc' is in the user space and a malicious user can
race to change the value of 'cioc->sense_off' after it is copied to
'ioc->sense_off' but before it is copied to 'user_sense_off'. By doing so,
the attacker can inject different values into 'local_sense_off' and
'user_sense_off'. This can cause undefined behavior in the following
execution, because the two variables are supposed to be same.

This patch enforces a check on the two kernel variables 'local_sense_off'
and 'user_sense_off' to make sure they are the same after the copy. In case
they are not, an error code EINVAL will be returned.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 9aa9590..f6de752 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -7523,6 +7523,9 @@ static int megasas_mgmt_compat_ioctl_fw(struct file *file, unsigned long arg)
 		get_user(user_sense_off, &cioc->sense_off))
 		return -EFAULT;
 
+	if (local_sense_off != user_sense_off)
+		return -EINVAL;
+
 	if (local_sense_len) {
 		void __user **sense_ioc_ptr =
 			(void __user **)((u8 *)((unsigned long)&ioc->frame.raw) + local_sense_off);
-- 
2.7.4

