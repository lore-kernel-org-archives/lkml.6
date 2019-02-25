Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D2FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DC82183F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129636;
	bh=FKqbBYFUbsvHY+wKUjevdnNjqwbFBjcx29FxuoxVE4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nt+WHI/EmdLIY30XalOu+7cEFjLVswLh5Nzudoiy/wvE/+bL4E/aQR4Mw8D6UlYQ4
	 qmTxXNMZFX2khjwL7mR36rAgjWLnuysSUSHOtPoq7noMflcZmDZKH0bH/0vv8+8de4
	 +2D7Oc3iEjQmpcs4Wfl33CdYhJSYbvfqVAqjHSv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbfBYVUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:20:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:53924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730114AbfBYVUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:20:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BD7D205C9;
        Mon, 25 Feb 2019 21:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129631;
        bh=FKqbBYFUbsvHY+wKUjevdnNjqwbFBjcx29FxuoxVE4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pASb4LPhjbzJAoKGK8Pe/o2FtEbxml8cWU027iHavUt97m+cdKQI6SVFMaqOtt48Z
         wE+6CcMhneIAV0CFAanR5aaQbG03/nun9o2AxwJSwDjpKW+yM0AaAWMBDh6fKzC62i
         Ys9Nh8BKkOgRBZFE7feWzK4DvUVz0s347As+puOU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefano Stabellini <stefanos@xilinx.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 018/152] pvcalls-front: read all data before closing the connection
Date:   Mon, 25 Feb 2019 22:10:10 +0100
Message-Id: <20190225195044.899983964@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

[ Upstream commit b79470b64fa9266948d1ce8d825ced94c4f63293 ]

When a connection is closing in_error is set to ENOTCONN. There could
still be outstanding data on the ring left by the backend. Before
closing the connection on the frontend side, drain the ring.

Signed-off-by: Stefano Stabellini <stefanos@xilinx.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/pvcalls-front.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
index 77224d8f3e6fe..e5d95aab2cb80 100644
--- a/drivers/xen/pvcalls-front.c
+++ b/drivers/xen/pvcalls-front.c
@@ -560,15 +560,13 @@ static int __read_ring(struct pvcalls_data_intf *intf,
 	error = intf->in_error;
 	/* get pointers before reading from the ring */
 	virt_rmb();
-	if (error < 0)
-		return error;
 
 	size = pvcalls_queued(prod, cons, array_size);
 	masked_prod = pvcalls_mask(prod, array_size);
 	masked_cons = pvcalls_mask(cons, array_size);
 
 	if (size == 0)
-		return 0;
+		return error ?: size;
 
 	if (len > size)
 		len = size;
-- 
2.19.1



