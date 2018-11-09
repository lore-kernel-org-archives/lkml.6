Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F775C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66D820827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E66D820827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbeKIUsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:48:02 -0500
Received: from 8bytes.org ([81.169.241.247]:48912 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728170AbeKIUr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:47:27 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 3ED47433; Fri,  9 Nov 2018 12:07:19 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jroedel@suse.de
Subject: [PATCH 0/7] iommu/amd: Always allow to map huge pages
Date:   Fri,  9 Nov 2018 12:07:05 +0100
Message-Id: <20181109110712.12469-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the AMD IOMMU driver had an issue for a long time where it
didn't allow to map a huge-page when smaller mappings
existed at that address range before. The VFIO driver even
had a workaround for that behavior.

These patches fix the issue and remove the workaround from
the VFIO driver.

Please review.

Thanks,

	Joerg

Joerg Roedel (7):
  iommu/amd: Collect page-table pages in freelist
  iommu/amd: Introduce free_sub_pt() function
  iommu/amd: Ignore page-mode 7 in free_sub_pt()
  iommu/amd: Allow downgrading page-sizes in alloc_pte()
  iommu/amd: Restart loop if cmpxchg64 succeeded in alloc_pte()
  iommu/amd: Allow to upgrade page-size
  vfio/type1: Remove map_try_harder() code path

 drivers/iommu/amd_iommu.c       | 204 +++++++++++++++++++++-----------
 drivers/iommu/amd_iommu_types.h |   1 +
 drivers/vfio/vfio_iommu_type1.c |  33 +-----
 3 files changed, 137 insertions(+), 101 deletions(-)

-- 
2.17.1

