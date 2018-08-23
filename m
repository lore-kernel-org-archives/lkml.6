Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FFCC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0FF2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C0FF2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387968AbeHWM2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:28:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53142 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732607AbeHWM2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:28:15 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A85E1C83;
        Thu, 23 Aug 2018 08:59:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 217/324] gpu: host1x: Skip IOMMU initialization if firewall is enabled
Date:   Thu, 23 Aug 2018 09:54:43 +0200
Message-Id: <20180823075007.028549831@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Osipenko <digetx@gmail.com>

[ Upstream commit 4466b1f0e022f94a026bd700fee34bff15cdc4ef ]

Host1x's CDMA can't access the command buffers if IOMMU and Host1x
firewall are enabled in the kernels config because firewall doesn't map
the copied buffer into IOVA space. Fix this by skipping IOMMU
initialization if firewall is enabled as firewall merges sparse cmdbufs
into a single contiguous buffer and hence IOMMU isn't needed in this case.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/host1x/dev.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -218,6 +218,9 @@ static int host1x_probe(struct platform_
 		return err;
 	}
 
+	if (IS_ENABLED(CONFIG_TEGRA_HOST1X_FIREWALL))
+		goto skip_iommu;
+
 	host->group = iommu_group_get(&pdev->dev);
 	if (host->group) {
 		struct iommu_domain_geometry *geometry;


