Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAAFC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B111C20665
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865800;
	bh=tSes+2HF3ndVvAHiHKF0WMd+4NvA33pUaLn2HabUZdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MfD38kyjRZdAVBTZSQKT9WO8wS57wFM9zVS8nhr8IJ+s9LXB8JTvhT45zTRDUuu/q
	 dTuQLjcqsdyjUnpMtk6YaiAFzxNgDL0nOvW2EfQzw3KlnXB04+FY8YTAIq1z0T6D6I
	 N2tK08bV/G05hqRUvfK8axK0WzQQQJHmmSeQNwCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbfAGM4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:56:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:44570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbfAGM4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:56:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36CEA20651;
        Mon,  7 Jan 2019 12:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865796;
        bh=tSes+2HF3ndVvAHiHKF0WMd+4NvA33pUaLn2HabUZdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kuc3e7jKg/jXC+88Iz68xjOJMIkZKrBBQlzmkXuHs17LHCMj1lwm4EqQuQJhyfgsz
         h1mqUedcLtH70eAzEOvezGBeaL6KfkvOzjQPXXuAHJ8M/oo34Mkqdp5L9JwlfI3MK0
         oKrwiPzpqBWfqmcuW11R5SAmrCPwKgP4DdCIBloM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 126/170] btrfs: dev-replace: go back to suspended state if target device is missing
Date:   Mon,  7 Jan 2019 13:32:33 +0100
Message-Id: <20190107104507.786435316@linuxfoundation.org>
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

commit 0d228ece59a35a9b9e8ff0d40653234a6d90f61e upstream.

At the time of forced unmount we place the running replace to
BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED state, so when the system comes
back and expect the target device is missing.

Then let the replace state continue to be in
BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED state instead of
BTRFS_IOCTL_DEV_REPLACE_STATE_STARTED as there isn't any matching scrub
running as part of replace.

Fixes: e93c89c1aaaa ("Btrfs: add new sources for device replace code")
CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/dev-replace.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -887,6 +887,8 @@ int btrfs_resume_dev_replace_async(struc
 			   "cannot continue dev_replace, tgtdev is missing");
 		btrfs_info(fs_info,
 			   "you may cancel the operation after 'mount -o degraded'");
+		dev_replace->replace_state =
+					BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED;
 		btrfs_dev_replace_write_unlock(dev_replace);
 		return 0;
 	}


