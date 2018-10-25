Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538ABECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 096AE20848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="avg8XtLc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096AE20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbeJYWvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:51:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729938AbeJYWvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:51:06 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCC0B2085A;
        Thu, 25 Oct 2018 14:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477089;
        bh=Fp2Bw3X6/3nzHSMJ2ZTAM6CPL3xDzDyudNmBshgP+7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=avg8XtLctCTsbiEWHpnkYhliG0eEGZM67dGPEmi3y/S1qmWCMza267M9E7Q6TqQE0
         wBOENLp/dUXv7frC0JhDWbAT3M+OO4yidSNleF5pQaIwPA9l+tkVj868r70a7q6r+R
         1uJtMNcjvGUBUi89ZgZ2XVjS9kW5inG6PF9FYF/Y=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Emil Tantilov <emil.s.tantilov@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 39/65] ixgbe: fix RSS limit for X550
Date:   Thu, 25 Oct 2018 10:16:39 -0400
Message-Id: <20181025141705.213937-39-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Tantilov <emil.s.tantilov@intel.com>

[ Upstream commit e9ee3238f8a480bbca58e51d02a93628d7c1f265 ]

X550 allows for up to 64 RSS queues, but the driver can have max
of 63 (-1 MSIX vector for link).

On systems with >= 64 CPUs the driver will set the redirection table
for all 64 queues which will result in packets being dropped.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 1d2174526a4c..18e4e4a69262 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -312,7 +312,7 @@ enum ixgbe_ring_f_enum {
 };
 
 #define IXGBE_MAX_RSS_INDICES		16
-#define IXGBE_MAX_RSS_INDICES_X550	64
+#define IXGBE_MAX_RSS_INDICES_X550	63
 #define IXGBE_MAX_VMDQ_INDICES		64
 #define IXGBE_MAX_FDIR_INDICES		63	/* based on q_vector limit */
 #define IXGBE_MAX_FCOE_INDICES		8
-- 
2.17.1

