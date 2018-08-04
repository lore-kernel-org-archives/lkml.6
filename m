Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47BCC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A9A2177A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A9A2177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388873AbeHDLKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:10:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49928 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732962AbeHDLKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:10:03 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2CD1389C;
        Sat,  4 Aug 2018 09:10:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>,
        Adam Radford <aradford@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 074/124] scsi: 3w-xxxx: fix a missing-check bug
Date:   Sat,  4 Aug 2018 11:01:03 +0200
Message-Id: <20180804082705.280674614@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082702.434482435@linuxfoundation.org>
References: <20180804082702.434482435@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wenwen Wang <wang6495@umn.edu>

[ Upstream commit 9899e4d3523faaef17c67141aa80ff2088f17871 ]

In tw_chrdev_ioctl(), the length of the data buffer is firstly copied
from the userspace pointer 'argp' and saved to the kernel object
'data_buffer_length'. Then a security check is performed on it to make
sure that the length is not more than 'TW_MAX_IOCTL_SECTORS *
512'. Otherwise, an error code -EINVAL is returned. If the security
check is passed, the entire ioctl command is copied again from the
'argp' pointer and saved to the kernel object 'tw_ioctl'. Then, various
operations are performed on 'tw_ioctl' according to the 'cmd'. Given
that the 'argp' pointer resides in userspace, a malicious userspace
process can race to change the buffer length between the two
copies. This way, the user can bypass the security check and inject
invalid data buffer length. This can cause potential security issues in
the following execution.

This patch checks for capable(CAP_SYS_ADMIN) in tw_chrdev_open() to
avoid the above issues.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
Acked-by: Adam Radford <aradford@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/3w-xxxx.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -1034,6 +1034,9 @@ static int tw_chrdev_open(struct inode *
 
 	dprintk(KERN_WARNING "3w-xxxx: tw_ioctl_open()\n");
 
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
 	minor_number = iminor(inode);
 	if (minor_number >= tw_device_extension_count)
 		return -ENODEV;


