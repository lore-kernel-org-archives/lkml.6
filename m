Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FBEC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4C520664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="buj2rQch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4C520664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbeKAIq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:46:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728784AbeKAIHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:07:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC32D20821;
        Wed, 31 Oct 2018 23:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027229;
        bh=tEXz/++tMGKHr86NZqpb8GAUuYfZPpJ2ks7AzX/qbNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=buj2rQchKu+grc8Tc5RuOMGnKJp1CvlPmsgmSyQ3U6XHOIVH+GpxzlmmC64b5IzRm
         HtGf9bbL925NdLTBTGzjnlT9+Nr1pBcI1MMspL+SPDOjPCBIFYnFrV1QcwBsM4tqnn
         O3R+YnCc042BjRq1eEN88RDvGirkWc14bx80C5as=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wenwen Wang <wang6495@umn.edu>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 096/146] scsi: megaraid_sas: fix a missing-check bug
Date:   Wed, 31 Oct 2018 19:04:51 -0400
Message-Id: <20181031230541.28822-96-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
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
index 9aa9590c5373..f6de7526ded5 100644
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
2.17.1

