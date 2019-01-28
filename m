Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D63C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3AA32082C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693562;
	bh=7lbrLmN+dMzPsF9X48Pi2QUOZc7ITnPeCNhiX4z38Uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=byzf0uFz1VYvKS/rg/rA5tbcPiCUAX1x51U8dmTQdBZ1ZiPpMoRn/sgCvyZEFQUtO
	 x+aYFYk3OEkBnKsjPE311QGeK/RY49lq7y/up24hbRSZ+g2jhzcMCSUSjFTGig6le5
	 Mr4y2dqyP1VcTkNwJq2RqtUsUOicfwZM9o7fBjjE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389966AbfA1QjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:39:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:33212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389750AbfA1QYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:24:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1830B2175B;
        Mon, 28 Jan 2019 16:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692675;
        bh=7lbrLmN+dMzPsF9X48Pi2QUOZc7ITnPeCNhiX4z38Uk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZWHiHsWqbwGsjzlnfuzbzV5Y8DvY16eGUG9wEGlEmNtf0p+jjGfg4FsgMRZk5JoOz
         Ye4D9GIm0VNewbn1eyiXZf5qvXk8eXGIaCfz31T05TQRCrwkAPl/59TcI72Gk6Bjn/
         Lmh+r79pJbll2K1JHuXiJ6tkSbZtyUYDIw0ZZGKE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 23/80] nfsd4: fix crash on writing v4_end_grace before nfsd startup
Date:   Mon, 28 Jan 2019 11:23:04 -0500
Message-Id: <20190128162401.58841-23-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128162401.58841-1-sashal@kernel.org>
References: <20190128162401.58841-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

[ Upstream commit 62a063b8e7d1db684db3f207261a466fa3194e72 ]

Anatoly Trosinenko reports that this:

1) Checkout fresh master Linux branch (tested with commit e195ca6cb)
2) Copy x84_64-config-4.14 to .config, then enable NFS server v4 and build
3) From `kvm-xfstests shell`:

results in NULL dereference in locks_end_grace.

Check that nfsd has been started before trying to end the grace period.

Reported-by: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfsctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 9690cb4dd588..03c7a4e7b6ba 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1106,6 +1106,8 @@ static ssize_t write_v4_end_grace(struct file *file, char *buf, size_t size)
 		case 'Y':
 		case 'y':
 		case '1':
+			if (nn->nfsd_serv)
+				return -EBUSY;
 			nfsd4_end_grace(nn);
 			break;
 		default:
-- 
2.19.1

