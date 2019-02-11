Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B03C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D64D222A5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899451;
	bh=hhDSW1lFIIPVssCJeMVCjgY2Dcajb/kRSLhGisWVbtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g9xV65x3D4ytRo8C/lPzSbAyZN9/CIvblVLtIIuHGoIJrAQf8Sz0CV9klUsP71How
	 IKgPYji6sS0Ctu3V8QLTKUV9OLv9AEzgOHTkoquuuttKwpNRNgUUCsLeOl1K3wo+6k
	 K34bi/zdjaU8qeHKdvFRInFdSnIvnkDeXgTI/Lm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388198AbfBKOvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:51:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:36976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387775AbfBKOu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:50:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DCC22081B;
        Mon, 11 Feb 2019 14:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896657;
        bh=hhDSW1lFIIPVssCJeMVCjgY2Dcajb/kRSLhGisWVbtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2AU9tIJIQocJetrRMoxSHU+Qh1er2SUkP26P+0boDZSY493uinzipL5BjknsNTtAB
         DqWsu4krDjDyEf/aI6ZbWBBfCnn+1pTVT97z0JyHWO1FBjxFApTFhJ7tpEnaKqgG3V
         s5Pawx2RdQvS2YmvcdUW3zDyEFbug0PX4B1O+JyE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 250/313] xfs: Fix error code in xfs_ioc_getbmap()
Date:   Mon, 11 Feb 2019 15:18:50 +0100
Message-Id: <20190211141910.046563451@linuxfoundation.org>
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

commit 132bf6723749f7219c399831eeb286dbbb985429 upstream.

In this function, once 'buf' has been allocated, we unconditionally
return 0.
However, 'error' is set to some error codes in several error handling
paths.
Before commit 232b51948b99 ("xfs: simplify the xfs_getbmap interface")
this was not an issue because all error paths were returning directly,
but now that some cleanup at the end may be needed, we must propagate the
error code.

Fixes: 232b51948b99 ("xfs: simplify the xfs_getbmap interface")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 0ef5ece5634c..bad90479ade2 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1616,7 +1616,7 @@ xfs_ioc_getbmap(
 	error = 0;
 out_free_buf:
 	kmem_free(buf);
-	return 0;
+	return error;
 }
 
 struct getfsmap_info {
-- 
2.19.1



