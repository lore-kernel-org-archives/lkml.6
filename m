Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D83C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A29520664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKDFaOmB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A29520664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731773AbeKAILh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:11:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731702AbeKAILd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:11:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 941ED20854;
        Wed, 31 Oct 2018 23:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027481;
        bh=b1KXZhS9fKMgqU5LYH/sDnEQPpIHyskRvrEj/EhizC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vKDFaOmBihyxm9i+eSLq7wb+M8EJwiv0hTy40XbEafrTSbIxXSs/YXkTJwyIZB/r0
         heBWqIF4koK3O7SHaPzKex3oZKBGJmR2flNhQEp3iz1sJy6VzbL0h2FRxkh8zHClMm
         fYLdTJG8WJYMu+mbYOytjMGdFLuhQYZe6AGi13Po=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wenwen Wang <wang6495@umn.edu>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 30/48] scsi: megaraid_sas: fix a missing-check bug
Date:   Wed, 31 Oct 2018 19:10:36 -0400
Message-Id: <20181031231054.29333-30-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031231054.29333-1-sashal@kernel.org>
References: <20181031231054.29333-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wang6495@umn.edu>

[ Upstream commit 47db7873136a9c57c45390a53b57019cf73c8259 ]

In megasas_mgmt_compat_ioctl_fw(), to handle the structure
compat_megasas_iocpacket 'cioc', a user-space structure megasas_iocpacket
'ioc' is allocated before megasas_mgmt_ioctl_fw() is invoked to handle
the packet. Since the two data structures have different fields, the data
is copied from 'cioc' to 'ioc' field by field. In the copy process,
'sense_ptr' is prepared if the field 'sense_len' is not null, because it
will be used in megasas_mgmt_ioctl_fw(). To prepare 'sense_ptr', the
user-space data 'ioc->sense_off' and 'cioc->sense_off' are copied and
saved to kernel-space variables 'local_sense_off' and 'user_sense_off'
respectively. Given that 'ioc->sense_off' is also copied from
'cioc->sense_off', 'local_sense_off' and 'user_sense_off' should have the
same value. However, 'cioc' is in the user space and a malicious user can
race to change the value of 'cioc->sense_off' after it is copied to
'ioc->sense_off' but before it is copied to 'user_sense_off'. By doing
so, the attacker can inject different values into 'local_sense_off' and
'user_sense_off'. This can cause undefined behavior in the following
execution, because the two variables are supposed to be same.

This patch enforces a check on the two kernel variables 'local_sense_off'
and 'user_sense_off' to make sure they are the same after the copy. In
case they are not, an error code EINVAL will be returned.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 090fdcdd15c9..5de024a50e15 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -6901,6 +6901,9 @@ static int megasas_mgmt_compat_ioctl_fw(struct file *file, unsigned long arg)
 		get_user(user_sense_off, &cioc->sense_off))
 		return -EFAULT;
 
+	if (local_sense_off != user_sense_off)
+		return -EINVAL;
+
 	if (local_sense_len) {
 		void __user **sense_ioc_ptr =
 			(void __user **)((u8 *)((unsigned long)&ioc->frame.raw) + local_sense_off);
-- 
2.17.1

