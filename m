Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2745C43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FF12089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865887;
	bh=sjmZtYYhNgspExqI0/PoXfa0ZE7gwV+/LgJGsSSMpQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=To3bsO3kOBXM5Rwqt8P6Ik+mOMAC1qlsP3mqWDHPBmTjeX5MLr7te/Mn9dSm9scOl
	 VGgl3bWP7eGd4Iw81I3qYfvgI+WzInrxEhS2Fv+KSe61XsuY481iywyxRM8wCShEQm
	 IFk3TNkyBvFGUfsO/K0r/2jNw/h5kYKnP6oxkyF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbfAGM6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:58:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:45596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729917AbfAGM6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:58:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D74AE206BB;
        Mon,  7 Jan 2019 12:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865883;
        bh=sjmZtYYhNgspExqI0/PoXfa0ZE7gwV+/LgJGsSSMpQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yi7A23CBD1QISMtlY9k5QYrjKsshDy6VFZwXpZVkUE5vZrq0fdMIU29VRRi8ddcGa
         +Mzx2lUb/BuLuNEKP2PqbD/IyDyRoSCdlaBOUQdVsVH/bWAi0sSZPnqKITieC8Q6Xv
         CQUbNM6+u0wUUnKleTEmdtzINnNuhcFmtvZXtaHc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Pan Bian <bianpan2016@163.com>, Theodore Tso <tytso@mit.edu>,
        stable@kernel.org
Subject: [PATCH 4.19 108/170] ext4: fix possible use after free in ext4_quota_enable
Date:   Mon,  7 Jan 2019 13:32:15 +0100
Message-Id: <20190107104505.666451490@linuxfoundation.org>
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

From: Pan Bian <bianpan2016@163.com>

commit 61157b24e60fb3cd1f85f2c76a7b1d628f970144 upstream.

The function frees qf_inode via iput but then pass qf_inode to
lockdep_set_quota_inode on the failure path. This may result in a
use-after-free bug. The patch frees df_inode only when it is never used.

Fixes: daf647d2dd5 ("ext4: add lockdep annotations for i_data_sem")
Cc: stable@kernel.org # 4.6
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/super.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5712,9 +5712,9 @@ static int ext4_quota_enable(struct supe
 	qf_inode->i_flags |= S_NOQUOTA;
 	lockdep_set_quota_inode(qf_inode, I_DATA_SEM_QUOTA);
 	err = dquot_enable(qf_inode, type, format_id, flags);
-	iput(qf_inode);
 	if (err)
 		lockdep_set_quota_inode(qf_inode, I_DATA_SEM_NORMAL);
+	iput(qf_inode);
 
 	return err;
 }


