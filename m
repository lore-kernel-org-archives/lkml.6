Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C09C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 103A120651
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865805;
	bh=OpsOKbOIMR53Wl1YWEhALZjn14H/LTOtPKIClpkilBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=phf3VnAvlNNcjXgXudQdNnaY4Ek5vyUuv3Ed6Leewgua+pCLazvKmWXIsLXg6VROV
	 SFmfobcC5/ENQTvAnQWHSpphQO6GEfgQv+gTCv2KnwYo50s3wvK1+tZNF6hfSd8CQR
	 wLgVOJ69ABNDxJV89hSQk1n5QDNSWRWoRDmYCSpY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbfAGM4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:56:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:44614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbfAGM4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:56:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A108420651;
        Mon,  7 Jan 2019 12:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865801;
        bh=OpsOKbOIMR53Wl1YWEhALZjn14H/LTOtPKIClpkilBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wygTaktGWkUJfGRHS/fj06rDFL6kn+f8Bvr1O+cJd8WA2iRc/U3P3oKsxW++GYO8u
         I4fnuigmlhGVBVgpA2kWZZYzM5IeyQ+wX2Ey7+rVin2YOZ5rc7UkXJTWzeJkRs+Xpu
         Duqrx2ULgAAq8IpBfzo16zqJaW0fzBLyVuCVvcR8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 127/170] btrfs: dev-replace: go back to suspend state if another EXCL_OP is running
Date:   Mon,  7 Jan 2019 13:32:34 +0100
Message-Id: <20190107104507.919477491@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -900,6 +900,10 @@ int btrfs_resume_dev_replace_async(struc
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


