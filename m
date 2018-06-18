Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4F5C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4988C20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4988C20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965071AbeFRIVQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:21:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55254 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933337AbeFRIVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:21:13 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 387CAC7F;
        Mon, 18 Jun 2018 08:21:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 130/279] RDMA/iwpm: fix memory leak on map_info
Date:   Mon, 18 Jun 2018 10:11:55 +0200
Message-Id: <20180618080614.212813300@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit f96416cea7bce9afe619c15e87fced70f93f9098 ]

In the cases where iwpm_hash_bucket is NULL and where function
get_mapinfo_hash_bucket returns NULL then the map_info is never added
to hash_bucket_head and hence there is a leak of map_info. Fix this
by nullifying hash_bucket_head and if that is null we know that
that map_info was not added to hash_bucket_head and hence map_info
should be free'd.

Detected by CoverityScan, CID#1222481 ("Resource Leak")

Fixes: 30dc5e63d6a5 ("RDMA/core: Add support for iWARP Port Mapper user space service")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/iwpm_util.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/core/iwpm_util.c
+++ b/drivers/infiniband/core/iwpm_util.c
@@ -114,7 +114,7 @@ int iwpm_create_mapinfo(struct sockaddr_
 			struct sockaddr_storage *mapped_sockaddr,
 			u8 nl_client)
 {
-	struct hlist_head *hash_bucket_head;
+	struct hlist_head *hash_bucket_head = NULL;
 	struct iwpm_mapping_info *map_info;
 	unsigned long flags;
 	int ret = -EINVAL;
@@ -142,6 +142,9 @@ int iwpm_create_mapinfo(struct sockaddr_
 		}
 	}
 	spin_unlock_irqrestore(&iwpm_mapinfo_lock, flags);
+
+	if (!hash_bucket_head)
+		kfree(map_info);
 	return ret;
 }
 


