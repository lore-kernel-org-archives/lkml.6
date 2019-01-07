Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4791CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9202147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864985;
	bh=YOIw7zvEkTgTJDWDFwP3NXl1DMIfZaCZMGo8CFGKjoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HJbI9TSYgFM0a9uUxc7vl7f97x/VUhm0cuPuBMWhj9w+ssXBW2WuojPibSiHVq5tZ
	 jUMgSanEN1eOihS+4IWO0TsdKgPh68pZgVPq1NM9xpH7BUzpEHIn+2xWRc2voFsJDW
	 JiSo2qaE5m8iExfpKAfr7oZ+tnie8S5VcO3vhEKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbfAGMnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:43:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:58752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728347AbfAGMm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:42:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF5FB20665;
        Mon,  7 Jan 2019 12:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864978;
        bh=YOIw7zvEkTgTJDWDFwP3NXl1DMIfZaCZMGo8CFGKjoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ObhC4V5hlTNsiFHbw7EsG+zTBumBGV2Z4GlvyEk29aAgGA4uvvce0HDgXhRZ4tHl9
         dUgOd1kULCGw58P2RBtRcxwCROtv7qSzuA5cSptwTHn3tfqozvkmWFANvYRCHf9i1D
         5JAHQCEDOk0CZiX53oQ0m3Tsex2XfrSCKBjsu5b4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.20 093/145] btrfs: dev-replace: go back to suspend state if another EXCL_OP is running
Date:   Mon,  7 Jan 2019 13:32:10 +0100
Message-Id: <20190107104449.402881288@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anand Jain <anand.jain@oracle.com>

commit 05c49e6bc1e8866ecfd674ebeeb58cdbff9145c2 upstream.

In a secnario where balance and replace co-exists as below,

  - start balance
  - pause balance
  - start replace
  - reboot

and when system restarts, balance resumes first. Then the replace is
attempted to restart but will fail as the EXCL_OP lock is already held
by the balance. If so place the replace state back to
BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED state.

Fixes: 010a47bde9420 ("btrfs: add proper safety check before resuming dev-replace")
CC: stable@vger.kernel.org # 4.18+
Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/dev-replace.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -897,6 +897,10 @@ int btrfs_resume_dev_replace_async(struc
 	 * dev-replace to start anyway.
 	 */
 	if (test_and_set_bit(BTRFS_FS_EXCL_OP, &fs_info->flags)) {
+		btrfs_dev_replace_write_lock(dev_replace);
+		dev_replace->replace_state =
+					BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED;
+		btrfs_dev_replace_write_unlock(dev_replace);
 		btrfs_info(fs_info,
 		"cannot resume dev-replace, other exclusive operation running");
 		return 0;


