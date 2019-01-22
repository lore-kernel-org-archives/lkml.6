Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA35C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBF321019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbfAVQtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:49:20 -0500
Received: from 8bytes.org ([81.169.241.247]:58874 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729417AbfAVQtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:49:19 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 0F1021FC; Tue, 22 Jan 2019 17:49:17 +0100 (CET)
Date:   Tue, 22 Jan 2019 17:49:16 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [BUG] "access dev->iommu_fwspec" cause crash on BPI-R2
Message-ID: <20190122164916.r343pqa2dtopzrxo@8bytes.org>
References: <trinity-76e7f2ce-27ce-4f3b-809f-7da9a35e5210-1548173349245@3c-app-gmx-bs21>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-76e7f2ce-27ce-4f3b-809f-7da9a35e5210-1548173349245@3c-app-gmx-bs21>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

thanks for the report!

On Tue, Jan 22, 2019 at 05:09:09PM +0100, Frank Wunderlich wrote:
> Hi,
> 
> the following Patch breaks hdmi (at least) on Bananapi R2 (mt7623):
> 
> a9bf2eec5a6fc01a0a5250eaf0bf61dfd382a78a "iommu/mediatek: Use helper functions to access dev->iommu_fwspec"

Does the attached diff fix the issue for you?

Thanks,

	Joerg

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 6ede4286b835..f60bdb85c4c0 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -442,6 +442,10 @@ static int mtk_iommu_add_device(struct device *dev)
 		iommu_spec.args_count = count;
 
 		mtk_iommu_create_mapping(dev, &iommu_spec);
+
+		/* dev->iommu_fwspec might have changed */
+		fwspec = dev_iommu_fwspec_get(dev);
+
 		of_node_put(iommu_spec.np);
 	}
 
