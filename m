Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E681C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A4621841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129796;
	bh=OWevSLeBBUDwYOk8mpll9TaYxlcf7g2I/e2NyLyZaHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BvrRbw3Vtudxt3GH1mgih1nHSoNQXp/4fh4indIde+zRqYwA3MhBaV6u9X7iuFFtc
	 LeZ0H4w5ZUdvifI99Zm+jZzS+MskPH2XuLVDJpVrHOheNXIV8y/o9lUPdqWlYuVzWK
	 sFxZsigyNRp+vAnZrVjjXM/VgQSRupi84ZenRQAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbfBYVXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:23:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:57628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731051AbfBYVXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:23:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCF0F217F4;
        Mon, 25 Feb 2019 21:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129790;
        bh=OWevSLeBBUDwYOk8mpll9TaYxlcf7g2I/e2NyLyZaHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L4ZUZgNctZlRvuBn1fQnW+/NCX3QNaylZDTYJ0kal8gtvNXqJxCedIlgR6qY2Kayb
         /I/o2hvB+xcuz1eV07rJlj6JFsMrwaLo87IihWJwW38R84cBHkG2JCizQfvyzdJMvu
         7wNT1OBl5zGVrrFt8/CdwjCUSuMB0uvFWQmL/4kQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 069/152] scsi: ufs: Fix geometry descriptor size
Date:   Mon, 25 Feb 2019 22:11:01 +0100
Message-Id: <20190225195048.050859306@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 9be9db9f78f52ef03ee90063730cb9d730e7032b ]

Albeit we no longer rely on those hard-coded descriptor sizes, we still use
them as our defaults, so better get it right. While adding its sysfs
entries, we forgot to update the geometry descriptor size. It is 0x48
according to UFS2.1, and wasn't changed in UFS3.0.

[mkp: typo]

Fixes: c720c091222e (scsi: ufs: sysfs: geometry descriptor)
Signed-off-by: Avri Altman <avri.altman@wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
index 14e5bf7af0bb1..c3bcaaec0fc5c 100644
--- a/drivers/scsi/ufs/ufs.h
+++ b/drivers/scsi/ufs/ufs.h
@@ -195,7 +195,7 @@ enum ufs_desc_def_size {
 	QUERY_DESC_CONFIGURATION_DEF_SIZE	= 0x90,
 	QUERY_DESC_UNIT_DEF_SIZE		= 0x23,
 	QUERY_DESC_INTERCONNECT_DEF_SIZE	= 0x06,
-	QUERY_DESC_GEOMETRY_DEF_SIZE		= 0x44,
+	QUERY_DESC_GEOMETRY_DEF_SIZE		= 0x48,
 	QUERY_DESC_POWER_DEF_SIZE		= 0x62,
 	QUERY_DESC_HEALTH_DEF_SIZE		= 0x25,
 };
-- 
2.19.1



