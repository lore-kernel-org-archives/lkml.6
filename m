Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751157AbeEEGby (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 02:31:54 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:34172 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbeEEGbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 02:31:52 -0400
X-Google-Smtp-Source: AB8JxZoxucysB60diXS5v9bTKMzh5FsgUzE4wrmJ0V+X5ok9ul8mccs4CMMaZpnb80h37RuGKEfokA==
From: Wenwen Wang <wang6495@umn.edu>
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com (open list:LSILOGIC MPT FUSION DRIVERS
        (FC/SAS/SPI)),
        linux-scsi@vger.kernel.org (open list:LSILOGIC MPT FUSION DRIVERS
        (FC/SAS/SPI)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] scsi: mpt3sas: fix a missing-check bug
Date: Sat,  5 May 2018 01:31:35 -0500
Message-Id: <1525501896-8235-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In _ctl_ioctl_main(), 'ioctl_header' is first copied from the userspace
pointer 'arg'. 'ioctl_header.ioc_number' is then verified by
_ctl_verify_adapter(). If the verification is failed, an error code -ENODEV
is returned. Otherwise, the verification result, i.e., the MPT3SAS adapter
that matches with the 'ioctl_header.ioc_number', is saved to 'ioc'. Later
on, if the 'cmd' is MPT3COMMAND, the whole ioctl command struct is copied
again from the userspace pointer 'arg' and saved to 'karg'. Then the
function _ctl_do_mpt_command() is invoked to execute the command with the
adapter 'ioc' and 'karg' as inputs.

Given that the pointer 'arg' resides in userspace, a malicious userspace
process can race to change the 'ioc_number' between the two copies, which
will cause inconsistency issues, potentially security issues since an
inconsistent adapter could be used with the command struct 'karg' as inputs
of _ctl_do_mpt_command(). Moreover, the user can potentially provide a
valid 'ioc_number' to pass the verification, and then modify it to an
invalid 'ioc_number'. That means, an invalid 'ioc_number' can potentially
bypass the verification check.

To fix this issue, we need to recheck the 'ioc_number' copied after the
second copy to make sure it is not changed since the first copy.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/scsi/mpt3sas/mpt3sas_ctl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index d3cb387..0c140c7 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -2388,6 +2388,11 @@ _ctl_ioctl_main(struct file *file, unsigned int cmd, void __user *arg,
 			break;
 		}
 
+		if (karg.hdr.ioc_number != ioctl_header.ioc_number) {
+			ret = -EINVAL;
+			break;
+		}
+
 		if (_IOC_SIZE(cmd) == sizeof(struct mpt3_ioctl_command)) {
 			uarg = arg;
 			ret = _ctl_do_mpt_command(ioc, karg, &uarg->mf);
-- 
2.7.4
