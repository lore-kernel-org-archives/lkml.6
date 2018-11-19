Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129AEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4222148E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXDm6E1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF4222148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732496AbeKTDCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:02:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:34930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732476AbeKTDCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:02:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AE7E20989;
        Mon, 19 Nov 2018 16:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645505;
        bh=rgOK3BIZaq0IEDCcf3XFisQ7OMob6jzmXE4uZgiCDyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dXDm6E1phaJXM7uflFUCL7vOOGFW9t0PVpuEPjN6C0m5Pl2YtP0tolvLRY1UI4jeB
         D6y7gtNhcDg7LqLmHtYcWVcDaVMKdm9qxdAeY+sFZ2zpO7yfB/ZFCN76SaO/9MuJcx
         RIpG2vRHI/qqX2wZUeOAdex5vL4M40XZN3bObV7E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Benjamin Coddington <bcodding@redhat.com>
Subject: [PATCH 4.19 150/205] mnt: fix __detach_mounts infinite loop
Date:   Mon, 19 Nov 2018 17:27:37 +0100
Message-Id: <20181119162638.599154127@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Coddington <bcodding@redhat.com>

commit 1e9c75fb9c47a75a9aec0cd17db5f6dc36b58e00 upstream.

Since commit ff17fa561a04 ("d_invalidate(): unhash immediately")
immediately unhashes the dentry, we'll never return the mountpoint in
lookup_mountpoint(), which can lead to an unbreakable loop in
d_invalidate().

I have reports of NFS clients getting into this condition after the server
removes an export of an existing mount created through follow_automount(),
but I suspect there are various other ways to produce this problem if we
hunt down users of d_invalidate().  For example, it is possible to get into
this state by using XFS' d_invalidate() call in xfs_vn_unlink():

truncate -s 100m img{1,2}

mkfs.xfs -q -n version=ci img1
mkfs.xfs -q -n version=ci img2

mkdir -p /mnt/xfs
mount img1 /mnt/xfs

mkdir /mnt/xfs/sub1
mount img2 /mnt/xfs/sub1

cat > /mnt/xfs/sub1/foo &
umount -l /mnt/xfs/sub1
mount img2 /mnt/xfs/sub1

mount --make-private /mnt/xfs

mkdir /mnt/xfs/sub2
mount --move /mnt/xfs/sub1 /mnt/xfs/sub2
rmdir /mnt/xfs/sub1

Fix this by moving the check for an unlinked dentry out of the
detach_mounts() path.

Fixes: ff17fa561a04 ("d_invalidate(): unhash immediately")
Cc: stable@vger.kernel.org
Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/namespace.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -695,9 +695,6 @@ static struct mountpoint *lookup_mountpo
 
 	hlist_for_each_entry(mp, chain, m_hash) {
 		if (mp->m_dentry == dentry) {
-			/* might be worth a WARN_ON() */
-			if (d_unlinked(dentry))
-				return ERR_PTR(-ENOENT);
 			mp->m_count++;
 			return mp;
 		}
@@ -711,6 +708,9 @@ static struct mountpoint *get_mountpoint
 	int ret;
 
 	if (d_mountpoint(dentry)) {
+		/* might be worth a WARN_ON() */
+		if (d_unlinked(dentry))
+			return ERR_PTR(-ENOENT);
 mountpoint:
 		read_seqlock_excl(&mount_lock);
 		mp = lookup_mountpoint(dentry);


