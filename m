Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA77C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E032087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKYq0ew8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E032087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbeJEXUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:20:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729687AbeJEXQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:16:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 937F82147D;
        Fri,  5 Oct 2018 16:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756232;
        bh=dUqxByOtpEmfhfg2CqzKiGWGpkOI9hVZSvv0QQs83SY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gKYq0ew8D0F7SygWwmzidAPglinKRv5zi9yukXkF0CW05gwku13fvYIrE/M3TKYXy
         EXfwPsMQQuFp3BEYi42aICWT1gJb9tEIps4TR2tB4BWfjo2dpB4gOYg+z5EgUo75Qn
         k8j86xGGn/813QBH2CG76gUN6WneNKRuOqmaM3OQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 07/14] scsi: qla2xxx: Fix an endian bug in fcpcmd_is_corrupted()
Date:   Fri,  5 Oct 2018 12:16:57 -0400
Message-Id: <20181005161704.20704-7-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161704.20704-1-sashal@kernel.org>
References: <20181005161704.20704-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit cbe3fd39d223f14b1c60c80fe9347a3dd08c2edb ]

We should first do the le16_to_cpu endian conversion and then apply the
FCP_CMD_LENGTH_MASK mask.

Fixes: 5f35509db179 ("qla2xxx: Terminate exchange if corrupted")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Quinn Tran <Quinn.Tran@cavium.com>
Acked-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/qla2xxx/qla_target.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.h b/drivers/scsi/qla2xxx/qla_target.h
index 0824a8164a24..07ea4fcf4f88 100644
--- a/drivers/scsi/qla2xxx/qla_target.h
+++ b/drivers/scsi/qla2xxx/qla_target.h
@@ -440,8 +440,8 @@ struct atio_from_isp {
 static inline int fcpcmd_is_corrupted(struct atio *atio)
 {
 	if (atio->entry_type == ATIO_TYPE7 &&
-	    (le16_to_cpu(atio->attr_n_length & FCP_CMD_LENGTH_MASK) <
-	    FCP_CMD_LENGTH_MIN))
+	    ((le16_to_cpu(atio->attr_n_length) & FCP_CMD_LENGTH_MASK) <
+	     FCP_CMD_LENGTH_MIN))
 		return 1;
 	else
 		return 0;
-- 
2.17.1

