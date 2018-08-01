Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D54C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9BF20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9BF20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405255AbeHATGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:06:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48452 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403884AbeHATGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:06:24 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4D6EECC3;
        Wed,  1 Aug 2018 17:19:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>,
        Adam Radford <aradford@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 160/246] scsi: 3w-9xxx: fix a missing-check bug
Date:   Wed,  1 Aug 2018 18:51:10 +0200
Message-Id: <20180801165019.403168318@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wenwen Wang <wang6495@umn.edu>

[ Upstream commit c9318a3e0218bc9dacc25be46b9eec363259536f ]

In twa_chrdev_ioctl(), the ioctl driver command is firstly copied from
the userspace pointer 'argp' and saved to the kernel object
'driver_command'.  Then a security check is performed on the data buffer
size indicated by 'driver_command', which is
'driver_command.buffer_length'. If the security check is passed, the
entire ioctl command is copied again from the 'argp' pointer and saved
to the kernel object 'tw_ioctl'. Then, various operations are performed
on 'tw_ioctl' according to the 'cmd'. Given that the 'argp' pointer
resides in userspace, a malicious userspace process can race to change
the buffer size between the two copies. This way, the user can bypass
the security check and inject invalid data buffer size. This can cause
potential security issues in the following execution.

This patch checks for capable(CAP_SYS_ADMIN) in twa_chrdev_open()t o
avoid the above issues.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
Acked-by: Adam Radford <aradford@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/3w-9xxx.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/scsi/3w-9xxx.c
+++ b/drivers/scsi/3w-9xxx.c
@@ -886,6 +886,11 @@ static int twa_chrdev_open(struct inode
 	unsigned int minor_number;
 	int retval = TW_IOCTL_ERROR_OS_ENODEV;
 
+	if (!capable(CAP_SYS_ADMIN)) {
+		retval = -EACCES;
+		goto out;
+	}
+
 	minor_number = iminor(inode);
 	if (minor_number >= twa_device_extension_count)
 		goto out;


