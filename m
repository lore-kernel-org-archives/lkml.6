Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8F7C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01793222A4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899342;
	bh=CMj7OnYv5bRVvqyDaE8QqzSu2Aqt2fz/Bh07KMwF0gQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iUvxt9nrZbEutt2/WVD9sIP/Nq2BfEyw3szZ8PRZfjc3eFcqAEM9HP229q0WzYpnt
	 HtNmMllv3HaVHOF6EfHDVozzK2kMCKK4L9L6fRzEiRM1oJeCBMVAVfQDrCwv97lpWy
	 TXdma1rA4JOT3Gstn5tPQrfK0xKA5cC4YPI4nDvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388768AbfBKPfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:35:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:38648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733153AbfBKOwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:52:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97B20214DA;
        Mon, 11 Feb 2019 14:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896743;
        bh=CMj7OnYv5bRVvqyDaE8QqzSu2Aqt2fz/Bh07KMwF0gQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a/LIUDRIlpY+aq5QLpX+WwVcmLnPm6JrB1Dc+bBJ+Dqn0IVDe8GQUmyKFzdKRs3Jo
         9dwdFSlEmNTjd8Czqt487XzkJDuwzZQ8Onx41GCIgO2SByhbMD4gSeewlAxJZjmr4X
         uaXTbYlcnxLlF5wSqnlLycad4ou7pxVAD8oYTWU4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ye Yin <dbyin@tencent.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 255/313] fs/xfs: fix f_ffree value for statfs when project quota is set
Date:   Mon, 11 Feb 2019 15:18:55 +0100
Message-Id: <20190211141910.372677531@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

commit de7243057e7cefa923fa5f467c0f1ec24eef41d2 upsream.

When project is set, we should use inode limit minus the used count

Signed-off-by: Ye Yin <dbyin@tencent.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_qm_bhv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_qm_bhv.c b/fs/xfs/xfs_qm_bhv.c
index 73a1d77ec187..3091e4bc04ef 100644
--- a/fs/xfs/xfs_qm_bhv.c
+++ b/fs/xfs/xfs_qm_bhv.c
@@ -40,7 +40,7 @@ xfs_fill_statvfs_from_dquot(
 		statp->f_files = limit;
 		statp->f_ffree =
 			(statp->f_files > dqp->q_res_icount) ?
-			 (statp->f_ffree - dqp->q_res_icount) : 0;
+			 (statp->f_files - dqp->q_res_icount) : 0;
 	}
 }
 
-- 
2.19.1



