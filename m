Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF920C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869192083B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762753;
	bh=ZkGroI5MD2nsDXYDZmaTPRxsiCD/73NJ7sHkL4Npcq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gvYLFNxhE8zc/h4eCz1EFBzrO/6zv1tz6KivrXAdmOrQLXVxIjmKqOjPFbIzIpQV3
	 yd4tmZjdGuajK0YB0Z1whl1bx/4eXd+63nHVgZcicFGIhzD2d6lRvJ9XJe0jvNuzsB
	 JO1O+KwQrO53VBOu9w/FPRHlrZMQFoI96oRjRFY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732112AbfA2Lwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:52:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:44282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729750AbfA2Lw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:52:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 728C120882;
        Tue, 29 Jan 2019 11:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762747;
        bh=ZkGroI5MD2nsDXYDZmaTPRxsiCD/73NJ7sHkL4Npcq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YWzYeFsy9a/1alZSQcLYGpql/9o7HBfDHKwecE4K3TVPSp64E2RI5WH/z0scSS7K3
         SLL7mc72RZdvV+TNdv9vLGAI5TXaSiJBEzbaPubYKhAN+mfhyhJVrktDHrP6+aN4dN
         ru2sHuifTH49y4Z0LF4s8VffUU0K1Ri+/T4vbu7k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.9 44/44] btrfs: dev-replace: go back to suspended state if target device is missing
Date:   Tue, 29 Jan 2019 12:36:39 +0100
Message-Id: <20190129113143.540292866@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113139.826927690@linuxfoundation.org>
References: <20190129113139.826927690@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/dev-replace.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -787,6 +787,8 @@ int btrfs_resume_dev_replace_async(struc
 			   "cannot continue dev_replace, tgtdev is missing");
 		btrfs_info(fs_info,
 			   "you may cancel the operation after 'mount -o degraded'");
+		dev_replace->replace_state =
+					BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED;
 		btrfs_dev_replace_unlock(dev_replace, 1);
 		return 0;
 	}


