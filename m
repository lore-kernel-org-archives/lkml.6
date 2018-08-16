Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F70EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16332147C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCKCcgJN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C16332147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbeHPWmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:42:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725762AbeHPWml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:42:41 -0400
Received: from localhost.localdomain (unknown [192.55.54.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB4712148D;
        Thu, 16 Aug 2018 19:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534448538;
        bh=l2P654IfyisTADGFlDxQUK8cG+4lM4amxbjFEBzRBQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MCKCcgJNaIgg5J34KUvVT9XyO2wrxJXNf8W8m5FGnsqYkw0UZbss2/UUVMDb5DEjp
         +y7G5ar8+uYKY68dyOCSjMpTg8beCSNzmUM0M/+zzZfWdjSXCLBaQ01qlb18A7CHwD
         FW5j+SAmibupjB+dbB8hq9fy6ss2mSoXdNraLZF4=
From:   Alan Tull <atull@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH 1/2] fpga: dfl: fme: fix return value check in in pr_mgmt_init()
Date:   Thu, 16 Aug 2018 14:42:13 -0500
Message-Id: <20180816194214.3462-2-atull@kernel.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180816194214.3462-1-atull@kernel.org>
References: <20180816194214.3462-1-atull@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

In case of error, the function dfl_fme_create_region() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check should
be replaced with IS_ERR().

Fixes: 29de76240e86 ("fpga: dfl: fme: add partial reconfiguration sub feature support")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/dfl-fme-pr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
index fc9fd2d..0b84053 100644
--- a/drivers/fpga/dfl-fme-pr.c
+++ b/drivers/fpga/dfl-fme-pr.c
@@ -420,7 +420,7 @@ static int pr_mgmt_init(struct platform_device *pdev,
 		/* Create region for each port */
 		fme_region = dfl_fme_create_region(pdata, mgr,
 						   fme_br->br, i);
-		if (!fme_region) {
+		if (IS_ERR(fme_region)) {
 			ret = PTR_ERR(fme_region);
 			goto destroy_region;
 		}
-- 
2.7.4

