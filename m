Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08C3ECDFC0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7F820854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="StQf6CJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A7F820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeIKOpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:45:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60006 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbeIKOpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:45:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8B9i58n056993;
        Tue, 11 Sep 2018 09:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=/eeE9o2543Ry61C4pHgkg8n5pWDVO6HlGw/KhKAAoHI=;
 b=StQf6CJn8bC1/CgIYks2F1wICAUl50J+FUH3CBsBUvjXLMBsLFlxOknX0i+XoY5w8PGr
 ksJOmD42OjCHQCiMtwcLfKPEyQHOaeSlehcu6phTYar1G3fr4uFojIml7ySa+ezY2V80
 kXJW+AjJuCWK0FjuTFys2QwegjMCsUPBxfCPbnnvX3KTYbK1h0jWP8FVPNlqLhcY0Kox
 cVNcnmWZvf5SZDa4XjO+qEn5u9sSZW/Uqwt9/by7dyYvUmtkwW68l719IDLKeDHAKkue
 0w0Nwzy7qf2fpJCGDn17GEGQyCsgWt5m0GZv1sc2rD9owaSuir0tQyT/1KP8iz+DU/DX dA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2mc72qjwjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Sep 2018 09:46:58 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8B9kqpZ026569
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Sep 2018 09:46:52 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8B9kpi2003960;
        Tue, 11 Sep 2018 09:46:51 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Sep 2018 02:46:51 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk, ming.lei@redhat.com, bart.vanassche@wdc.com,
        sagi@grimberg.me, keith.busch@intel.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH 2/4] blk-mq: retrieve bios before update nr_hw_queues
Date:   Tue, 11 Sep 2018 17:48:12 +0800
Message-Id: <1536659294-2321-3-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536659294-2321-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1536659294-2321-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9012 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=587
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809110102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

retrieve bios of requests on queue to drain requests, then:
 - avoid fail requests on dying hw queue
 - needn't depend on storage device to drain the queue any more

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3d59741..adc14f0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3013,7 +3013,15 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		return;
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
-		blk_mq_freeze_queue(q);
+		blk_freeze_queue_start(q);
+
+	/*
+	 * Wait the percpu ref to be switched to atomic mode.
+	 */
+	synchronize_sched();
+
+	list_for_each_entry(q, &set->tag_list, tag_set_list)
+		blk_mq_sched_retrieve_bios(q);
 	/*
 	 * Sync with blk_mq_queue_tag_busy_iter.
 	 */
-- 
2.7.4

