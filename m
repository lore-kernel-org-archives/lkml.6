Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E09DECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D03208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D03208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbeIXRis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:38:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50158 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728598AbeIXRir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:38:47 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 009F41065;
        Mon, 24 Sep 2018 11:37:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 023/105] btrfs: replace: Reset on-disk dev stats value after replace
Date:   Mon, 24 Sep 2018 13:33:09 +0200
Message-Id: <20180924113115.974794861@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113113.268650190@linuxfoundation.org>
References: <20180924113113.268650190@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>

[ Upstream commit 1e7e1f9e3aba00c9b9c323bfeeddafe69ff21ff6 ]

on-disk devs stats value is updated in btrfs_run_dev_stats(),
which is called during commit transaction, if device->dev_stats_ccnt
is not zero.

Since current replace operation does not touch dev_stats_ccnt,
on-disk dev stats value is not updated. Therefore "btrfs device stats"
may return old device's value after umount/mount
(Example: See "btrfs ins dump-t -t DEV $DEV" after btrfs/100 finish).

Fix this by just incrementing dev_stats_ccnt in
btrfs_dev_replace_finishing() when replace is succeeded and this will
update the values.

Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/dev-replace.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -584,6 +584,12 @@ static int btrfs_dev_replace_finishing(s
 	btrfs_rm_dev_replace_unblocked(fs_info);
 
 	/*
+	 * Increment dev_stats_ccnt so that btrfs_run_dev_stats() will
+	 * update on-disk dev stats value during commit transaction
+	 */
+	atomic_inc(&tgt_device->dev_stats_ccnt);
+
+	/*
 	 * this is again a consistent state where no dev_replace procedure
 	 * is running, the target device is part of the filesystem, the
 	 * source device is not part of the filesystem anymore and its 1st


