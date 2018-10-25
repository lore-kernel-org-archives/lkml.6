Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7939BC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40ADA2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFKtIbvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40ADA2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbeJYXPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728329AbeJYWsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:48:08 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE6CB20870;
        Thu, 25 Oct 2018 14:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476912;
        bh=E9giUEaz+rOieOVEr7MEeY2EBxnBnj5chG3mBaeTSpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iFKtIbvHktvC0QyGqFcCMbdQhFdskkW4NUYjv5Fmakr4PKHw27gt6EIBiDuuz6W1U
         qBuVbKPrsXp22pb03aOzJ4PpdAlV/aDeTcroU3iYG1dz4KMBMD5MjNAXKmAtZ4WOoz
         Pmt98kPpMEvo818LBa2+4CtNpcnWxiLGuhLdq+aU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 32/98] libata: fix error checking in in ata_parse_force_one()
Date:   Thu, 25 Oct 2018 10:13:17 -0400
Message-Id: <20181025141423.213774-32-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejun Heo <tj@kernel.org>

[ Upstream commit f7cf69ae171592d133c69b9adaa5de7cfb6038ea ]

ata_parse_force_one() was incorrectly comparing @p to @endp when it
should have been comparing @id.  The only consequence is that it may
end up using an invalid port number in "libata.force" module param
instead of rejecting it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Petru-Florin Mihancea <petrum@gmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=195785
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 73d636d35961..a166359ad5d4 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6781,7 +6781,7 @@ static int __init ata_parse_force_one(char **cur,
 	}
 
 	force_ent->port = simple_strtoul(id, &endp, 10);
-	if (p == endp || *endp != '\0') {
+	if (id == endp || *endp != '\0') {
 		*reason = "invalid port/link";
 		return -EINVAL;
 	}
-- 
2.17.1

