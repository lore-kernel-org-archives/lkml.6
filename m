Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECD0C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE3620817
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiwoZodQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE3620817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389963AbeKLIVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:21:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:49388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389759AbeKLIVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:21:42 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 845F0208A3;
        Sun, 11 Nov 2018 22:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975505;
        bh=2bf9X94KUezpqZ+NIPGOulsK9+9ZiojTnJIZHkcL9aY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YiwoZodQqFbXeJ9o/skruyy7v7wR6kpwrYd2p7of9oGMbjl71gyH/hbJdT1EbBT93
         zQSCrDdInxYjU1/5Mv+vA74y7oGPymUhRBbsObrW0fPT0JFVk/ymAq9NLM7Yw1mzhZ
         9DwInSkO4e4Ctr9XV+5iLTOjqCWCSs9zuZErofCY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Mahoney <jeffm@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.18 325/350] btrfs: dont attempt to trim devices that dont support it
Date:   Sun, 11 Nov 2018 14:23:09 -0800
Message-Id: <20181111221721.672461528@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Mahoney <jeffm@suse.com>

commit 0be88e367fd8fbdb45257615d691f4675dda062f upstream.

We check whether any device the file system is using supports discard in
the ioctl call, but then we attempt to trim free extents on every device
regardless of whether discard is supported.  Due to the way we mask off
EOPNOTSUPP, we can end up issuing the trim operations on each free range
on devices that don't support it, just wasting time.

Fixes: 499f377f49f08 ("btrfs: iterate over unused chunk space in FITRIM")
CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Jeff Mahoney <jeffm@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/extent-tree.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -10905,6 +10905,10 @@ static int btrfs_trim_free_extents(struc
 
 	*trimmed = 0;
 
+	/* Discard not supported = nothing to do. */
+	if (!blk_queue_discard(bdev_get_queue(device->bdev)))
+		return 0;
+
 	/* Not writeable = nothing to do. */
 	if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state))
 		return 0;


