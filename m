Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9096C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713C720868
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMIm+sAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 713C720868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbeJYWsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:48:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728919AbeJYWsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:48:18 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6C0520854;
        Thu, 25 Oct 2018 14:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476922;
        bh=SbngomlX9o96OXBRAGaak/c/3XUg6WWxxcIvJhG/xnU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DMIm+sADkSTsRA/itSdwEGAHaDL4dRnDx46VTzhJlzIjKSvl0pD2/bb3x2LpAifeE
         rFxT0Zvg7swLd/ky8Kw8geRMn841aeOtaAux07SaEsPUfTGIaSJUYrptrZBRZDreDh
         yJcz+n2RvD8OSNP66NhChAkKj/6KKl41WNPagLOc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Eric Biggers <ebiggers@google.com>, Jens Axboe <axboe@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 39/98] elevator: fix truncation of icq_cache_name
Date:   Thu, 25 Oct 2018 10:13:24 -0400
Message-Id: <20181025141423.213774-39-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit 9bd2bbc01d17ddd567cc0f81f77fe1163e497462 ]

gcc 7.1 reports the following warning:

    block/elevator.c: In function ‘elv_register’:
    block/elevator.c:898:5: warning: ‘snprintf’ output may be truncated before the last format character [-Wformat-truncation=]
         "%s_io_cq", e->elevator_name);
         ^~~~~~~~~~
    block/elevator.c:897:3: note: ‘snprintf’ output between 7 and 22 bytes into a destination of size 21
       snprintf(e->icq_cache_name, sizeof(e->icq_cache_name),
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         "%s_io_cq", e->elevator_name);
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The bug is that the name of the icq_cache is 6 characters longer than
the elevator name, but only ELV_NAME_MAX + 5 characters were reserved
for it --- so in the case of a maximum-length elevator name, the 'q'
character in "_io_cq" would be truncated by snprintf().  Fix it by
reserving ELV_NAME_MAX + 6 characters instead.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Bart Van Assche <Bart.VanAssche@sandisk.com>
Signed-off-by: Jens Axboe <axboe@fb.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/elevator.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index e7f358d2e5fc..eaa58c0f894b 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -102,7 +102,7 @@ struct elevator_type
 	struct module *elevator_owner;
 
 	/* managed by elevator core */
-	char icq_cache_name[ELV_NAME_MAX + 5];	/* elvname + "_io_cq" */
+	char icq_cache_name[ELV_NAME_MAX + 6];	/* elvname + "_io_cq" */
 	struct list_head list;
 };
 
-- 
2.17.1

