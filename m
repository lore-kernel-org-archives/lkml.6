Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12388C67871
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 18:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECDB21473
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 18:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BECDB21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbeJGBKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 21:10:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60194 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbeJGBKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 21:10:48 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 03ACED5702;
        Sat,  6 Oct 2018 18:06:33 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-200-33.brq.redhat.com [10.40.200.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 254482010D67;
        Sat,  6 Oct 2018 18:06:30 +0000 (UTC)
Date:   Sat, 6 Oct 2018 20:07:03 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     nbd@other.debian.org, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] nbd: avoid losing the pointer to reallocated config->socks
 in nbd_add_socket()
Message-ID: <20181006180703.GA1870@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sat, 06 Oct 2018 18:06:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the (very unlikely) case of config->socks reallocation success and
nsock allocation failure config->nsock will not get updated with the new pointer
to socks array. Fix it by updating config->socks right after reallocation
successfulness check.

Fixes: 9561a7ade0c2 ("nbd: add multi-connection support")
Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
Cc: stable@vger.kernel.org # 4.10+
---
 drivers/block/nbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 14a5125..bfeaf68 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -951,14 +951,14 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 		sockfd_put(sock);
 		return -ENOMEM;
 	}
+	config->socks = socks;
+
 	nsock = kzalloc(sizeof(struct nbd_sock), GFP_KERNEL);
 	if (!nsock) {
 		sockfd_put(sock);
 		return -ENOMEM;
 	}
 
-	config->socks = socks;
-
 	nsock->fallback_index = -1;
 	nsock->dead = false;
 	mutex_init(&nsock->tx_lock);
-- 
2.1.4

