Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD45C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7909F2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebFNjIOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7909F2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731403AbeJQBOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:14:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:33324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730397AbeJQBOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:14:51 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE71B2098A;
        Tue, 16 Oct 2018 17:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710605;
        bh=hfhCmn5zSjUA1s8HcqHU6I+SzEuuxmKov/22585+2Us=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ebFNjIOWtUMozE4F+mLpBdlQI63qyojqtUBUm9P7LdsDb+wx7aepf0nTH0ZRJXMax
         9wmVZEGHZcFS6FKR/e4t9SuK1OCboPan8v/SaBgLtpQnj2KKbMM1Ob0vgHVv+uovC6
         pQgzgC1jT648gGr7ePN7FkfgCCcznodbc61mQQG8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Quinn Tran <Quinn.Tran@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 07/71] scsi: qla2xxx: Fix an endian bug in fcpcmd_is_corrupted()
Date:   Tue, 16 Oct 2018 19:09:04 +0200
Message-Id: <20181016170539.778784383@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170539.315587743@linuxfoundation.org>
References: <20181016170539.315587743@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_target.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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


