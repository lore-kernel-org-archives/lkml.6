Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8917C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D141222B1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897541;
	bh=p3uxImhjP4ZgXH3oZzDf9vXNm0HvsHH6rfqeElaz4Z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OIqzbjjqxgmj0cmn9KucTu6CfIFzhyHnbV+chGkgxp4nexpSBiqQhRV3gtnDvfPrG
	 duvilN7gi2ITnaKBogIjgA/ujSLhlK6g8AiBdrcDWiTsx6ZJszkTDTUmAgQIbV49XK
	 hVrLW71eBVFlbw+mhdf6JCcIjDGFl9OsIP0JbIWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391050AbfBKPFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:05:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:54812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391020AbfBKPFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:05:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A302A222A7;
        Mon, 11 Feb 2019 15:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897531;
        bh=p3uxImhjP4ZgXH3oZzDf9vXNm0HvsHH6rfqeElaz4Z8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EdS3CF0ZAQc2JHpPynQLVHo8EJlNxWPD3cKD/qffJ/FJeI9YZzQcaU3laRKSOrumI
         cArpRNvbWFTni7WgxRrVjmrN/p1upOTtCqKAtPmVAFK/SaJhuaFoMWjr0oEpr4bQKY
         ixmzQnr7k4OW7Kg9ur4h0ae3F80DFoBAM6+qHL2g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anatoly Trosinenko <anatoly.trosinenko@gmail.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 029/137] nfsd4: fix crash on writing v4_end_grace before nfsd startup
Date:   Mon, 11 Feb 2019 15:18:30 +0100
Message-Id: <20190211141814.649559189@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
References: <20190211141811.964925535@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
index 36b2af931e06..797a155c9a67 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1103,6 +1103,8 @@ static ssize_t write_v4_end_grace(struct file *file, char *buf, size_t size)
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



