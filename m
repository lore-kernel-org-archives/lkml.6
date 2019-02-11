Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7E1C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79EB021B26
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896636;
	bh=yBM3jtLee7yCN1CKIhFOmr4xwUvPqub0E2KGut3M1Ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hDv8AH1xFlginlR7SJo+BONLQ8vmGaVqPS1maIEOsObzhK7oU8TxGoQMYFKYDbTUK
	 0fZBwn4I0bjU4LgT6Z+GqfocbYuPpCS5FuOR2uQjP7q7ixuIgXDEt/B3oSSWYtLPfF
	 uP1BNbDezL0Dfn30UguAkd+MGNXfD8rbk8DGOVxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388120AbfBKOuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:50:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:36418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388104AbfBKOub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:50:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97DE820700;
        Mon, 11 Feb 2019 14:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896631;
        bh=yBM3jtLee7yCN1CKIhFOmr4xwUvPqub0E2KGut3M1Ww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dN9PWPMvgncp1+tH9uoP7rcbx33wuY8GthrI51uwJwj5qCgr5/wuFfA4FIHDr6shy
         JrHTL/18tdczSSOEENm2fBMeBB6Zg/hhi6aEXwpTsFAHEs26tzn4fJ2zg9NtybdIdD
         6nP4kiQemXoXO2Xdl2DI/HsE5KkwoOYprwx/xrhQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Carlos Maiolino <cmaiolino@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 248/313] xfs: Fix xqmstats offsets in /proc/fs/xfs/xqmstat
Date:   Mon, 11 Feb 2019 15:18:48 +0100
Message-Id: <20190211141909.901135514@linuxfoundation.org>
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

commit 41657e5507b13e963be906d5d874f4f02374fd5c upstream.

The addition of FIBT, RMAP and REFCOUNT changed the offsets into
__xfssats structure.

This caused xqmstat_proc_show() to display garbage data via
/proc/fs/xfs/xqmstat, once it relies on the offsets marked via macros.

Fix it.

Fixes: 00f4e4f9 xfs: add rmap btree stats infrastructure
Fixes: aafc3c24 xfs: support the XFS_BTNUM_FINOBT free inode btree type
Fixes: 46eeb521 xfs: introduce refcount btree definitions
Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_stats.c b/fs/xfs/xfs_stats.c
index 4e4423153071..740ac9674848 100644
--- a/fs/xfs/xfs_stats.c
+++ b/fs/xfs/xfs_stats.c
@@ -119,7 +119,7 @@ static int xqmstat_proc_show(struct seq_file *m, void *v)
 	int j;
 
 	seq_printf(m, "qm");
-	for (j = XFSSTAT_END_IBT_V2; j < XFSSTAT_END_XQMSTAT; j++)
+	for (j = XFSSTAT_END_REFCOUNT; j < XFSSTAT_END_XQMSTAT; j++)
 		seq_printf(m, " %u", counter_val(xfsstats.xs_stats, j));
 	seq_putc(m, '\n');
 	return 0;
-- 
2.19.1



