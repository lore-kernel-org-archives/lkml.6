Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA14CC5ACC9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B471B20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuvjqamW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B471B20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbeJQBLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:11:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729271AbeJQBLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:11:36 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A03FC20866;
        Tue, 16 Oct 2018 17:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710411;
        bh=3Nd0dNr7UxJtsvvNg0RJDXApq75L4EKcWpYPVYevMFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OuvjqamWWkn8ET4B/B9LId73j+WRe6FRw0rDEkIUR1tpvj+u0k15sROI4GX0OT7tO
         jjcdB9p9ONx/E+vl2vDNxH3770QP82BfCJR3ICFxJAqXg+aKZ140/XISp0DweA0gMi
         fPtVLlW2WL50mz9JPo2LpYNNYmnZDZO8m7pDTWxo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shenghui Wang <shhuiw@foxmail.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.14 068/109] dm cache: destroy migration_cache if cache target registration failed
Date:   Tue, 16 Oct 2018 19:05:36 +0200
Message-Id: <20181016170528.533077236@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shenghui Wang <shhuiw@foxmail.com>

commit c7cd55504a5b0fc826a2cd9540845979d24ae542 upstream.

Commit 7e6358d244e47 ("dm: fix various targets to dm_register_target
after module __init resources created") inadvertently introduced this
bug when it moved dm_register_target() after the call to KMEM_CACHE().

Fixes: 7e6358d244e47 ("dm: fix various targets to dm_register_target after module __init resources created")
Cc: stable@vger.kernel.org
Signed-off-by: Shenghui Wang <shhuiw@foxmail.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-cache-target.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -3571,14 +3571,13 @@ static int __init dm_cache_init(void)
 	int r;
 
 	migration_cache = KMEM_CACHE(dm_cache_migration, 0);
-	if (!migration_cache) {
-		dm_unregister_target(&cache_target);
+	if (!migration_cache)
 		return -ENOMEM;
-	}
 
 	r = dm_register_target(&cache_target);
 	if (r) {
 		DMERR("cache target registration failed: %d", r);
+		kmem_cache_destroy(migration_cache);
 		return r;
 	}
 


