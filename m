Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BB8C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7EAF2084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbfBCOUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:20:48 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55546 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730115AbfBCOUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:46 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIdZ-0006Lt-1i; Sun, 03 Feb 2019 14:20:45 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9h-0007Cs-JX; Sun, 03 Feb 2019 14:49:53 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Filipe Manana" <fdmanana@suse.com>,
        "Anand Jain" <anand.jain@oracle.com>,
        "David Sterba" <dsterba@suse.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.620103039@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 201/305] Btrfs: ensure path name is null terminated
 at btrfs_control_ioctl
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit f505754fd6599230371cb01b9332754ddc104be1 upstream.

We were using the path name received from user space without checking that
it is null terminated. While btrfs-progs is well behaved and does proper
validation and null termination, someone could call the ioctl and pass
a non-null terminated patch, leading to buffer overrun problems in the
kernel.  The ioctl is protected by CAP_SYS_ADMIN.

So just set the last byte of the path to a null character, similar to what
we do in other ioctls (add/remove/resize device, snapshot creation, etc).

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/btrfs/super.c | 1 +
 1 file changed, 1 insertion(+)

--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1771,6 +1771,7 @@ static long btrfs_control_ioctl(struct f
 	vol = memdup_user((void __user *)arg, sizeof(*vol));
 	if (IS_ERR(vol))
 		return PTR_ERR(vol);
+	vol->name[BTRFS_PATH_NAME_MAX] = '\0';
 
 	switch (cmd) {
 	case BTRFS_IOC_SCAN_DEV:

