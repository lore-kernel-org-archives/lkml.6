Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B3DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BBB321527
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnWJGO9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BBB321527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405141AbeKTDXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:23:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:36026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404671AbeKTDXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:23:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01454214E0;
        Mon, 19 Nov 2018 16:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646777;
        bh=jT9dEe2cWN/dJRx6K52neWHdvQmOpfqgE6OcLQX4JQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KnWJGO9R3nK/OojDnV/TP5NAAfE8wFzrJRVdZ+dVOwmwPihGPgdi9oakdI47hFiU9
         KYlR4RnG6GS3lr/leCDkWAiCkD0GKX5qPiBrmVtu6IxMtHZYEOWvafylajt4CK791y
         fghHV2l6tr2EOM/3Y6jM7yaKYieDg7TePJTmQ4KA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Mahoney <jeffm@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.4 086/160] btrfs: iterate all devices during trim, instead of fs_devices::alloc_list
Date:   Mon, 19 Nov 2018 17:28:45 +0100
Message-Id: <20181119162639.583338236@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Mahoney <jeffm@suse.com>

commit d4e329de5e5e21594df2e0dd59da9acee71f133b upstream.

btrfs_trim_fs iterates over the fs_devices->alloc_list while holding the
device_list_mutex.  The problem is that ->alloc_list is protected by the
chunk mutex.  We don't want to hold the chunk mutex over the trim of the
entire file system.  Fortunately, the ->dev_list list is protected by
the dev_list mutex and while it will give us all devices, including
read-only devices, we already just skip the read-only devices.  Then we
can continue to take and release the chunk mutex while scanning each
device.

Fixes: 499f377f49f ("btrfs: iterate over unused chunk space in FITRIM")
CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Jeff Mahoney <jeffm@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/extent-tree.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -10751,8 +10751,8 @@ int btrfs_trim_fs(struct btrfs_root *roo
 	}
 
 	mutex_lock(&root->fs_info->fs_devices->device_list_mutex);
-	devices = &root->fs_info->fs_devices->alloc_list;
-	list_for_each_entry(device, devices, dev_alloc_list) {
+	devices = &root->fs_info->fs_devices->devices;
+	list_for_each_entry(device, devices, dev_list) {
 		ret = btrfs_trim_free_extents(device, range->minlen,
 					      &group_trimmed);
 		if (ret)


