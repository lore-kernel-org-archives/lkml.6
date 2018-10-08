Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C05C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2662064A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aR0A5RE4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2662064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbeJIBzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:55:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730155AbeJIBzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:55:14 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1DBD21479;
        Mon,  8 Oct 2018 18:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024129;
        bh=tQyXYkY79xFbx/iCTjMmmSWNdubQY0llE5xEAZ/MCpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aR0A5RE47DFBWOBk2YERyfZJPb+TIw7nNirvOlOaBo0YeU5wZhEmQk41S6eVnebeY
         NwDEqUMGdc534OKZIkzZa9Cj6peT0Am3LpdttOjZ4PQ/pZmH9DillnJVy+yU+dbibl
         K7bB2JE8gywgtSYGq+TV0bNQy95/OmigkxWWRjlA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lu Fengqi <lufq.fnst@cn.fujitsu.com>,
        Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 08/94] btrfs: btrfs_shrink_device should call commit transaction at the end
Date:   Mon,  8 Oct 2018 20:30:49 +0200
Message-Id: <20181008175605.456547473@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175605.067676667@linuxfoundation.org>
References: <20181008175605.067676667@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anand Jain <anand.jain@oracle.com>

[ Upstream commit 801660b040d132f67fac6a95910ad307c5929b49 ]

Test case btrfs/164 reports use-after-free:

[ 6712.084324] general protection fault: 0000 [#1] PREEMPT SMP
..
[ 6712.195423]  btrfs_update_commit_device_size+0x75/0xf0 [btrfs]
[ 6712.201424]  btrfs_commit_transaction+0x57d/0xa90 [btrfs]
[ 6712.206999]  btrfs_rm_device+0x627/0x850 [btrfs]
[ 6712.211800]  btrfs_ioctl+0x2b03/0x3120 [btrfs]

Reason for this is that btrfs_shrink_device adds the resized device to
the fs_devices::resized_devices after it has called the last commit
transaction.

So the list fs_devices::resized_devices is not empty when
btrfs_shrink_device returns.  Now the parent function
btrfs_rm_device calls:

        btrfs_close_bdev(device);
        call_rcu(&device->rcu, free_device_rcu);

and then does the transactio ncommit. It goes through the
fs_devices::resized_devices in btrfs_update_commit_device_size and
leads to use-after-free.

Fix this by making sure btrfs_shrink_device calls the last needed
btrfs_commit_transaction before the return. This is consistent with what
the grow counterpart does and this makes sure the on-disk state is
persistent when the function returns.

Reported-by: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
Tested-by: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
[ update changelog ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/volumes.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4517,7 +4517,12 @@ again:
 
 	/* Now btrfs_update_device() will change the on-disk size. */
 	ret = btrfs_update_device(trans, device);
-	btrfs_end_transaction(trans);
+	if (ret < 0) {
+		btrfs_abort_transaction(trans, ret);
+		btrfs_end_transaction(trans);
+	} else {
+		ret = btrfs_commit_transaction(trans);
+	}
 done:
 	btrfs_free_path(path);
 	if (ret) {


