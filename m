Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63556C04EBC
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC3A2243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dt+cMgzp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC3A2243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387402AbeKOIsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:48:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:34392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728605AbeKOI1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:20 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB1F82251A;
        Wed, 14 Nov 2018 22:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234137;
        bh=dwpbcC/xzToXpkccDht6Z0VciEGWwLp1UJytnQyypBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dt+cMgzpKihBp+NfclpJsH94tcA8R2Ld1nxRuSmohWhSyTyrAfG5EvVpr7ji72TYY
         jZtaDcPHPtqV8KvcJ6SMag2GB4ZmoevQ/nVE4dk0iYfQ4YMBzI8l00nqG8DeADUnyN
         wR5E+4i5pFR+nT6+JPpx/JTYTZEcRNEJdgU1T5S4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Liam Merwick <Liam.Merwick@oracle.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 36/73] xen/grant-table: Fix incorrect gnttab_dma_free_pages() pr_debug message
Date:   Wed, 14 Nov 2018 17:21:30 -0500
Message-Id: <20181114222207.98701-36-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Merwick <Liam.Merwick@oracle.com>

[ Upstream commit d9cccfa7c4d1d9ef967ec9308df7304a18609b30 ]

If a call to xenmem_reservation_increase() in gnttab_dma_free_pages()
fails it triggers a message "Failed to decrease reservation..." which
should be "Failed to increase reservation..."

Fixes: 9bdc7304f536 ('xen/grant-table: Allow allocating buffers suitable for DMA')
Reported-by: Ross Philipson <ross.philipson@oracle.com>
Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/grant-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 84575baceebc..97341fa75458 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -914,7 +914,7 @@ int gnttab_dma_free_pages(struct gnttab_dma_alloc_args *args)
 
 	ret = xenmem_reservation_increase(args->nr_pages, args->frames);
 	if (ret != args->nr_pages) {
-		pr_debug("Failed to decrease reservation for DMA buffer\n");
+		pr_debug("Failed to increase reservation for DMA buffer\n");
 		ret = -EFAULT;
 	} else {
 		ret = 0;
-- 
2.17.1

