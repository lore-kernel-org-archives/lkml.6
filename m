Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD5DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D57932183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216291;
	bh=rILEalZgrYX0O1yMi/HY7cWmoD6zYoZ/giOELnVpwnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Og3V+V3VDzQXEul35cq5M+cDYFK9ahcyk83toCIa9aPbKtxK6VloFJM68RiKg07p6
	 F50fCSqWNfsRmgZQoVbQLFg9DDgrGPVdy12Ht5R8QHosz63h03XsqMgnlza3Nky9yS
	 y3XYmMzzL5t4aGYuXUNDpzYFWwB+Neu1Z5mGFTaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387962AbfAKOSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:18:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:34534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387954AbfAKOSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:18:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E251F21841;
        Fri, 11 Jan 2019 14:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216285;
        bh=rILEalZgrYX0O1yMi/HY7cWmoD6zYoZ/giOELnVpwnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hmuOOil+BDP/lvrYzKGOsfdIeStetx5cLWkG2Pd3pi2XO6TnJdRP+wkw7fsJ1Cm1j
         0H3ucZr1iPfUHUai1h9kyO9lbdxs0DU4DmbVECGSVnAO5e//sx1HwKpDfSIXtSNX4H
         5OBrTuUVhGDxmMdwAC+7EDDjFkklGtpT4Gjz8+5A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Pan Bian <bianpan2016@163.com>, Theodore Tso <tytso@mit.edu>,
        stable@kernel.org
Subject: [PATCH 4.4 42/88] ext4: fix possible use after free in ext4_quota_enable
Date:   Fri, 11 Jan 2019 15:08:11 +0100
Message-Id: <20190111131052.131637332@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131045.137499039@linuxfoundation.org>
References: <20190111131045.137499039@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5184,9 +5184,9 @@ static int ext4_quota_enable(struct supe
 	qf_inode->i_flags |= S_NOQUOTA;
 	lockdep_set_quota_inode(qf_inode, I_DATA_SEM_QUOTA);
 	err = dquot_enable(qf_inode, type, format_id, flags);
-	iput(qf_inode);
 	if (err)
 		lockdep_set_quota_inode(qf_inode, I_DATA_SEM_NORMAL);
+	iput(qf_inode);
 
 	return err;
 }


