Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9BEC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F11DD21B1C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbfBKQPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:15:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:55904 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727887AbfBKQPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:15:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6684CAC8D;
        Mon, 11 Feb 2019 16:15:40 +0000 (UTC)
Date:   Mon, 11 Feb 2019 08:15:29 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Bjorn Topel <bjorn.topel@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        netdev@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH v2] xsk: share the mmap_sem for page pinning
Message-ID: <20190211161529.uskq5ca7y3j5522i@linux-r8p5>
Mail-Followup-To: akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Bjorn Topel <bjorn.topel@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>, netdev@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
References: <20190207053740.26915-1-dave@stgolabs.net>
 <20190207053740.26915-2-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190207053740.26915-2-dave@stgolabs.net>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Holding mmap_sem exclusively for a gup() is an overkill.
Lets share the lock and replace the gup call for gup_longterm(),
as it is better suited for the lifetime of the pinning.

Cc: David S. Miller <davem@davemloft.net>
Cc: Bjorn Topel <bjorn.topel@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>
CC: netdev@vger.kernel.org
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 net/xdp/xdp_umem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index 5ab236c5c9a5..e7fa8d0d7090 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -265,10 +265,10 @@ static int xdp_umem_pin_pages(struct xdp_umem *umem)
 	if (!umem->pgs)
 		return -ENOMEM;
 
-	down_write(&current->mm->mmap_sem);
-	npgs = get_user_pages(umem->address, umem->npgs,
+	down_read(&current->mm->mmap_sem);
+	npgs = get_user_pages_longterm(umem->address, umem->npgs,
 			      gup_flags, &umem->pgs[0], NULL);
-	up_write(&current->mm->mmap_sem);
+	up_read(&current->mm->mmap_sem);
 
 	if (npgs != umem->npgs) {
 		if (npgs >= 0) {
-- 
2.16.4

