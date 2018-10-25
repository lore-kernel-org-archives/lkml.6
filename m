Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63DBECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F029208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0lOIGdLj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F029208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbeJYWwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:52:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728763AbeJYWwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:52:36 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D899208A3;
        Thu, 25 Oct 2018 14:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477178;
        bh=bjc1o1ghS9UtN+QSDZ2lwi3YpNtKziUAtnA6tki1lLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0lOIGdLj9O/BdAB8rP9qoPFE9GHuvXJtsMLsRzfv5BFu0GxdSOcYSocascZxpL0+C
         mWTyzm/EXFsv9KNclw/HilAlXL0C088q2VacXM9LUEOCKqYrVKwHRMqURRPI7Pw3xv
         mO5jMLm2BaYHmJujIGoTk5YZbuskF3bR7kc3S5o8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 29/98] scsi: ->queue_rq can't sleep
Date:   Thu, 25 Oct 2018 10:17:44 -0400
Message-Id: <20181025141853.214051-29-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 70a0f2c1898c6abf53670e55642b6e840b003892 ]

The blk-mq ->queue_rq method is always called from process context,
but might have preemption disabled.  This means we still always
have to use GFP_ATOMIC for memory allocations, and thus need to
revert part of commit 3c356bde1 ("scsi: stop passing a gfp_mask
argument down the command setup path").

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Sasha Levin <sasha.levin@oracle.com>
Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>
Tested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index a11837054d6c..0d5c218b7ad1 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -616,7 +616,7 @@ static int scsi_alloc_sgtable(struct scsi_data_buffer *sdb, int nents,
 	}
 
 	ret = __sg_alloc_table(&sdb->table, nents, SCSI_MAX_SG_SEGMENTS,
-			       first_chunk, gfp_mask, scsi_sg_alloc);
+			       first_chunk, GFP_ATOMIC, scsi_sg_alloc);
 	if (unlikely(ret))
 		scsi_free_sgtable(sdb, mq);
 	return ret;
-- 
2.17.1

