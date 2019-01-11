Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B26C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E842183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216106;
	bh=2NZSfYukwalUDfQ9Y9jEhAxn/OaFTcYdJwMAEJbKuHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ldl9LX8ShvvyFZHwdoMBXC2UU0k10uJvycZb/tkVblMRsfG4bzqiTxp7+t0RlYySd
	 +B+sUKXlGOLgh3nCnhcU9gYzR8KzFNfN0zEzwy3aVhajVsqQPcGKzAdq14yugfrFfg
	 ANBGO+KlDhoEJ/nDFy62Ygs0ojaNNn7SAHRwVjzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733218AbfAKOPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:15:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:59050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728954AbfAKOPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:15:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 608BE2177B;
        Fri, 11 Jan 2019 14:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216102;
        bh=2NZSfYukwalUDfQ9Y9jEhAxn/OaFTcYdJwMAEJbKuHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=grgzce2XP11Rebow5mh3+ltlUy4vs7IkMWSjULjuZgVkKHPsM0szupMhu3QRcNjR/
         bjGwKUgNMNOgjMsPxuq3uQ4wIfviN1Mu+mo6bUQ6S2x5Yl/EqAlkiGs423JFrAhUjc
         5+Y07JPhc66KomvIsYTHeNciuNYos8kA2f8PIegc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Pan Bian <bianpan2016@163.com>, Theodore Tso <tytso@mit.edu>,
        stable@kernel.org
Subject: [PATCH 3.18 23/47] ext4: fix possible use after free in ext4_quota_enable
Date:   Fri, 11 Jan 2019 15:08:08 +0100
Message-Id: <20190111130959.068004970@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111130956.170952125@linuxfoundation.org>
References: <20190111130956.170952125@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5389,9 +5389,9 @@ static int ext4_quota_enable(struct supe
 	qf_inode->i_flags |= S_NOQUOTA;
 	lockdep_set_quota_inode(qf_inode, I_DATA_SEM_QUOTA);
 	err = dquot_enable(qf_inode, type, format_id, flags);
-	iput(qf_inode);
 	if (err)
 		lockdep_set_quota_inode(qf_inode, I_DATA_SEM_NORMAL);
+	iput(qf_inode);
 
 	return err;
 }


