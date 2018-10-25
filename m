Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D11EECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78DA2085A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfu2EPjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C78DA2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbeJYWop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:44:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728299AbeJYWoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:44:44 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A637620854;
        Thu, 25 Oct 2018 14:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476709;
        bh=gh/ygm9rslzbkik+aEhooF8MXglKfZwhbn+hwIYba3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pfu2EPjNRjwD9jSpxdI+yOZejGWIMBX30q1u4d6xZ2DWq78ACj/6XsrLDT9vg9w7/
         fF2tPLIABSs4t1+nh/4hI3Hca0l8Pt82qc257Ot2/Ld6XiiXJEG5XZ92eQd76eF/fg
         4RMksERTekLKoCqFe9uKTuwhVr1GG0OQbImkb0nY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 39/46] scsi: sd: Remember that READ CAPACITY(16) succeeded
Date:   Thu, 25 Oct 2018 10:10:46 -0400
Message-Id: <20181025141053.213330-39-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141053.213330-1-sashal@kernel.org>
References: <20181025141053.213330-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Martin K. Petersen" <martin.petersen@oracle.com>

[ Upstream commit 597d74005ba85e87c256cd732128ebf7faf54247 ]

The USB storage glue sets the try_rc_10_first flag in an attempt to
avoid wedging poorly implemented legacy USB devices.

If the device capacity is too large to be expressed in the provided
response buffer field of READ CAPACITY(10), a well-behaved device will
set the reported capacity to 0xFFFFFFFF. We will then attempt to issue a
READ CAPACITY(16) to obtain the real capacity.

Since this part of the discovery logic is not covered by the first_scan
flag, a warning will be printed a couple of times times per revalidate
attempt if we upgrade from READ CAPACITY(10) to READ CAPACITY(16).

Remember that we have successfully issued READ CAPACITY(16) so we can
take the fast path on subsequent revalidate attempts.

Reported-by: Menion <menion@gmail.com>
Reviewed-by: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/sd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 4a532318b211..b0dd8bdfdf98 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -2497,6 +2497,8 @@ sd_read_capacity(struct scsi_disk *sdkp, unsigned char *buffer)
 				sector_size = old_sector_size;
 				goto got_data;
 			}
+			/* Remember that READ CAPACITY(16) succeeded */
+			sdp->try_rc_10_first = 0;
 		}
 	}
 
-- 
2.17.1

