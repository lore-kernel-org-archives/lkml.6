Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B429C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B26F20842
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498548;
	bh=IFP9yUe8JFH4iDsZsYMPFMjz+ADJFR9RY1M1x8u6quU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gk2GQecgcH2P/mAeG8mIt3l8j2TIY6U4OAuxEKTmcjrHwR7TYcg5W+2MFJKfhxrtL
	 aC9QaLey1Dz9Cns8TuG5K6Je23caem4qh5IufswTkK1pvjRkMf4euEv5FpqhAAKI1o
	 MyC2UYVQmK0jMEIhqGAwy+4mTror1ON+7CdMSkEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388465AbfBROC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:02:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:44138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388703AbfBROCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:02:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E17202070D;
        Mon, 18 Feb 2019 14:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498544;
        bh=IFP9yUe8JFH4iDsZsYMPFMjz+ADJFR9RY1M1x8u6quU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aZJLoavGK0XU1rj3nTSq3lrQ7/nDK58sEmkw5lWVMHALwKz3v9FAokE+dSzWmYzva
         /vo24/AYXzYMpybLFCtj+cGk0e4ve01QrXHwt95L/lP39jrjZRxDIhEXlY4dEkEfpe
         SQHghTQ4Z6/ygVCBF6e8rvFppMsXtBgAXnGrGans=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anatoly Trosinenko <anatoly.trosinenko@gmail.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 020/143] nfsd4: fix crash on writing v4_end_grace before nfsd startup
Date:   Mon, 18 Feb 2019 14:42:28 +0100
Message-Id: <20190218133529.895609420@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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



