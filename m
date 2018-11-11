Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A832C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D8721707
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ia9sVMsk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D8721707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390020AbeKLIVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:21:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:50100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389997AbeKLIVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:21:49 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CC77223C6;
        Sun, 11 Nov 2018 22:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975512;
        bh=nBahuODGq/Q3hJIJdWdLaNvC6SU/oYd4B6ANXTtDf6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ia9sVMskyz+6rRRbforUdMTEVj0u82+s9V+9EVJ0fHe9lBUqi6R+u6ZyyS19UM8Gz
         CoLLi8GKtCxMVJxQvPr7+rAfE1WRHnI9+rfuuA4a+F0PI328f5UcxjMMeg+9RxmtDM
         RH8v5VdtMc+mHikND6xk0SrR83EqufUCpVwFTwv8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>,
        Johan Hovold <johan@kernel.org>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH 4.18 313/350] soc/tegra: pmc: Fix child-node lookup
Date:   Sun, 11 Nov 2018 14:22:57 -0800
Message-Id: <20181111221721.157850244@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 1dc6bd5e39a29453bdcc17348dd2a89f1aa4004e upstream.

Fix child-node lookup during probe, which ended up searching the whole
device tree depth-first starting at the parent rather than just matching
on its children.

To make things worse, the parent pmc node could end up being prematurely
freed as of_find_node_by_name() drops a reference to its first argument.

Fixes: 3568df3d31d6 ("soc: tegra: Add thermal reset (thermtrip) support to PMC")
Cc: stable <stable@vger.kernel.org>     # 4.0
Cc: Mikko Perttunen <mperttunen@nvidia.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/soc/tegra/pmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -1288,7 +1288,7 @@ static void tegra_pmc_init_tsense_reset(
 	if (!pmc->soc->has_tsense_reset)
 		return;
 
-	np = of_find_node_by_name(pmc->dev->of_node, "i2c-thermtrip");
+	np = of_get_child_by_name(pmc->dev->of_node, "i2c-thermtrip");
 	if (!np) {
 		dev_warn(dev, "i2c-thermtrip node not found, %s.\n", disabled);
 		return;


