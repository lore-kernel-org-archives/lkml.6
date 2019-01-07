Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A626C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F762089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866157;
	bh=DK8kc45JHbV1LTYj2EhQQApniJ/xhsHuepLRRaWpUqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YVa9eR7/kZyCvgOZLDpC1uJyRbbDpmPzY72YVA5KfRCrS6PlUYT3mVh5wFeX+AmOw
	 NoUlDyZqLhy7rsHDduVwIE6Qe+jMoH/ezDH9cbevsVXBLExY8AVSrRshkU3rYBBZuo
	 /cwwzA0Rg1x2PlZuJs7VxKHVc9zX5bg9Q+u3vwaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbfAGNCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:02:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:50102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfAGNCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:02:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7DAB206BB;
        Mon,  7 Jan 2019 13:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866153;
        bh=DK8kc45JHbV1LTYj2EhQQApniJ/xhsHuepLRRaWpUqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mEfJxQPP/1iks8Nrj0x9XnHg+OodLiP0pRLp3sgojCmXavjLCXn/sttjTW8SHMRTV
         2/X1OkorMegZ3MQOvMp/7Mo4JBeGRTwymTt/YuDKzCqbZBPcCjjCEMu9e7m/Vkgkpl
         PD9sZtrQ38rApA1milmPf3V19SVq6AkA3yfnkUSI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Pan Bian <bianpan2016@163.com>, Theodore Tso <tytso@mit.edu>,
        stable@kernel.org
Subject: [PATCH 4.14 063/101] ext4: fix possible use after free in ext4_quota_enable
Date:   Mon,  7 Jan 2019 13:32:51 +0100
Message-Id: <20190107105336.408700250@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5636,9 +5636,9 @@ static int ext4_quota_enable(struct supe
 	qf_inode->i_flags |= S_NOQUOTA;
 	lockdep_set_quota_inode(qf_inode, I_DATA_SEM_QUOTA);
 	err = dquot_enable(qf_inode, type, format_id, flags);
-	iput(qf_inode);
 	if (err)
 		lockdep_set_quota_inode(qf_inode, I_DATA_SEM_NORMAL);
+	iput(qf_inode);
 
 	return err;
 }


