Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B8DC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 05:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1445218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 05:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfBGFii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 00:38:38 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:51265 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfBGFih (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 7 Feb 2019 00:38:37 -0500
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Thu, 07 Feb 2019 06:38:36 +0100
Received: from localhost.localdomain (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Thu, 07 Feb 2019 05:38:02 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, dave@stgolabs.net,
        linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Bjorn Topel <bjorn.topel@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        netdev@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 1/2] xsk: do not use mmap_sem
Date:   Wed,  6 Feb 2019 21:37:39 -0800
Message-Id: <20190207053740.26915-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190207053740.26915-1-dave@stgolabs.net>
References: <20190207053740.26915-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Holding mmap_sem exclusively for a gup() is an overkill.
Lets replace the call for gup_fast() and let the mm take
it if necessary.

Cc: David S. Miller <davem@davemloft.net>
Cc: Bjorn Topel <bjorn.topel@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>
CC: netdev@vger.kernel.org
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 net/xdp/xdp_umem.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index 5ab236c5c9a5..25e1e76654a8 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -265,10 +265,8 @@ static int xdp_umem_pin_pages(struct xdp_umem *umem)
 	if (!umem->pgs)
 		return -ENOMEM;
 
-	down_write(&current->mm->mmap_sem);
-	npgs = get_user_pages(umem->address, umem->npgs,
-			      gup_flags, &umem->pgs[0], NULL);
-	up_write(&current->mm->mmap_sem);
+	npgs = get_user_pages_fast(umem->address, umem->npgs,
+				   gup_flags, &umem->pgs[0]);
 
 	if (npgs != umem->npgs) {
 		if (npgs >= 0) {
-- 
2.16.4

