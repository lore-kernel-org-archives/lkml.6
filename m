Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F71C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D8021852
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762312;
	bh=khrKJE3QI547w6xfLR8ci5KPXaUt/pOpkWFmDJPI9yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T/891Fdk29csnA0i1bxyuQhye05muYQFG4vHlcIrRUB1DToMLC+m/AdazMomECmt9
	 kDWmQuRWiq8NIFOHooYKtTdzGMDPs3Ze5PJ/jKwGlfsX3G5trwbwQan1ThwexUPWl9
	 5zn835ezWPmsZDp/6kHzNyvreQqaQsbmKtdu90dY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbfA2LpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:45:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:35496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729530AbfA2LpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:45:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C3C220882;
        Tue, 29 Jan 2019 11:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762302;
        bh=khrKJE3QI547w6xfLR8ci5KPXaUt/pOpkWFmDJPI9yo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i33xtBOsZ4guO3SC7G4i4GHCYJCtJ/moC14TTE4oFFXzXjSKQ3/ta41rmJEfCVUZA
         7ruHPKOq2oD0EWttPMrnT5RxoRDoiPc6MPXfHSSGyLpqC5cRcxkJTB+ujdJxG/66Jp
         AWl34JHgZiIYSZmCB3ZkHR8O7th1YUos28eOB4Ho=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Yan, Zheng" <zyan@redhat.com>,
        Luis Henriques <lhenriques@suse.com>,
        Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4.19 027/103] ceph: clear inode pointer when snap realm gets dropped by its inode
Date:   Tue, 29 Jan 2019 12:35:04 +0100
Message-Id: <20190129113201.216709806@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
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

From: Yan, Zheng <zyan@redhat.com>

commit d95e674c01cfb5461e8b9fdeebf6d878c9b80b2f upstream.

snap realm and corresponding inode have pointers to each other.
The two pointer should get clear at the same time. Otherwise,
snap realm's pointer may reference freed inode.

Cc: stable@vger.kernel.org # 4.17+
Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
Reviewed-by: Luis Henriques <lhenriques@suse.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ceph/caps.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1030,6 +1030,8 @@ static void drop_inode_snap_realm(struct
 	list_del_init(&ci->i_snap_realm_item);
 	ci->i_snap_realm_counter++;
 	ci->i_snap_realm = NULL;
+	if (realm->ino == ci->i_vino.ino)
+		realm->inode = NULL;
 	spin_unlock(&realm->inodes_with_caps_lock);
 	ceph_put_snap_realm(ceph_sb_to_client(ci->vfs_inode.i_sb)->mdsc,
 			    realm);


