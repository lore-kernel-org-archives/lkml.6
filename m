Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052B6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C273621707
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LP+n/uXl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C273621707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405208AbeKTDYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:24:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:36376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404390AbeKTDYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:24:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D31F215EA;
        Mon, 19 Nov 2018 16:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646793;
        bh=CuI2TlyF4iFg5uzMeGuehEqFaOerVCMk+M8jbHiJlqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LP+n/uXlMuGh+sbWw/ZNvoykSqnuJFAfxeKV2zX6Kw2PYgsrepOfSxo8Tmi5kTLXD
         ixM3bO9j+IgUtuv7iuQ5if3nMKu4MMuUWKW/8oa/4zv1vpVzAMQc6Baw8Y+GnSqqyh
         UaOzPwW6H4vbm8d8oL2kg/d9MC+hCV5YhcjFm2fA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH 4.4 092/160] btrfs: qgroup: Dirty all qgroups before rescan
Date:   Mon, 19 Nov 2018 17:28:51 +0100
Message-Id: <20181119162640.126151253@linuxfoundation.org>
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

From: Qu Wenruo <wqu@suse.com>

commit 9c7b0c2e8dbfbcd80a71e2cbfe02704f26c185c6 upstream.

[BUG]
In the following case, rescan won't zero out the number of qgroup 1/0:

  $ mkfs.btrfs -fq $DEV
  $ mount $DEV /mnt

  $ btrfs quota enable /mnt
  $ btrfs qgroup create 1/0 /mnt
  $ btrfs sub create /mnt/sub
  $ btrfs qgroup assign 0/257 1/0 /mnt

  $ dd if=/dev/urandom of=/mnt/sub/file bs=1k count=1000
  $ btrfs sub snap /mnt/sub /mnt/snap
  $ btrfs quota rescan -w /mnt
  $ btrfs qgroup show -pcre /mnt
  qgroupid         rfer         excl     max_rfer     max_excl parent  child
  --------         ----         ----     --------     -------- ------  -----
  0/5          16.00KiB     16.00KiB         none         none ---     ---
  0/257      1016.00KiB     16.00KiB         none         none 1/0     ---
  0/258      1016.00KiB     16.00KiB         none         none ---     ---
  1/0        1016.00KiB     16.00KiB         none         none ---     0/257

So far so good, but:

  $ btrfs qgroup remove 0/257 1/0 /mnt
  WARNING: quotas may be inconsistent, rescan needed
  $ btrfs quota rescan -w /mnt
  $ btrfs qgroup show -pcre  /mnt
  qgoupid         rfer         excl     max_rfer     max_excl parent  child
  --------         ----         ----     --------     -------- ------  -----
  0/5          16.00KiB     16.00KiB         none         none ---     ---
  0/257      1016.00KiB     16.00KiB         none         none ---     ---
  0/258      1016.00KiB     16.00KiB         none         none ---     ---
  1/0        1016.00KiB     16.00KiB         none         none ---     ---
	     ^^^^^^^^^^     ^^^^^^^^ not cleared

[CAUSE]
Before rescan we call qgroup_rescan_zero_tracking() to zero out all
qgroups' accounting numbers.

However we don't mark all qgroups dirty, but rely on rescan to do so.

If we have any high level qgroup without children, it won't be marked
dirty during rescan, since we cannot reach that qgroup.

This will cause QGROUP_INFO items of childless qgroups never get updated
in the quota tree, thus their numbers will stay the same in "btrfs
qgroup show" output.

[FIX]
Just mark all qgroups dirty in qgroup_rescan_zero_tracking(), so even if
we have childless qgroups, their QGROUP_INFO items will still get
updated during rescan.

Reported-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Tested-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/qgroup.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2446,6 +2446,7 @@ qgroup_rescan_zero_tracking(struct btrfs
 		qgroup->rfer_cmpr = 0;
 		qgroup->excl = 0;
 		qgroup->excl_cmpr = 0;
+		qgroup_dirty(fs_info, qgroup);
 	}
 	spin_unlock(&fs_info->qgroup_lock);
 }


