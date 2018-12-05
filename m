Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0130C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85DD7206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JLarozb1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85DD7206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeLEFsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 00:48:47 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46260 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbeLEFsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 00:48:46 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so9496709ply.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 21:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jlAgOUx+d9y4Koxz93q6parhhjhH4dXwDaeTxxP4nP8=;
        b=JLarozb1MoFj2iMfg32xnjapXOlEmjo9r3TV0J+hBfRbOOmqKETxBnc00LeEsw+vm0
         0lGXJEwWat/3MZeQfKcHirJYh9v82fkKBNOqII0K95iE5kfWgDpEV8M/zzzbjq3VhxYF
         04YxrC5+/zPLkcH+nofCQ656iGKoites41d8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jlAgOUx+d9y4Koxz93q6parhhjhH4dXwDaeTxxP4nP8=;
        b=kDpSouxGjomcMoq5R12iW3T47bn2AzdjNJ/5PdXmm1oighbPjVhLXpHsiczY0ELdl5
         pShmGFFYv7fS0fc0fhSfhCMI6NnWmqx8X3IrYcdKRS+lj0hpAKaR1/cZljtH1tUZAlPn
         8pYRe+1bA2RXAW7KkM21KMBVDqELPXF5r9OIsDwvH7cABCUP6wizu5uleL2s6i4F0Zod
         5Bv8oiO/2rifpdPZ7+a0ZXwJZaLFjY49TQF0+ORgQWlXrgaefBaZFt1C5BWUBgJfwZIX
         sQT8due6WIKluphcWSV0HgsjTavyvWySFfOtZvKrP/acjuUca5hmRW6kKmFrwWP51Q96
         gBLQ==
X-Gm-Message-State: AA+aEWaAL00XlElBabI2rZOPGGHIVLflKhPV/8a01R7hjH6/Bi3roenE
        /ggUcv2vNC89RwKLV2j/0cp4EA==
X-Google-Smtp-Source: AFSGD/XGIJEFyfrfyg8OULqJMVs+IAQFRiR6jXi3pWWWNF4H9mhmgzh0A9r92Lrx+0cfo5I3yXVu/g==
X-Received: by 2002:a17:902:ac1:: with SMTP id 59mr3053408plp.36.1543988926074;
        Tue, 04 Dec 2018 21:48:46 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:f659:7f17:ea11:4e8e])
        by smtp.gmail.com with ESMTPSA id 4sm30806513pfq.10.2018.12.04.21.48.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 21:48:45 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Levin Alexander <Alexander.Levin@microsoft.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, yingjoe.chen@mediatek.com,
        hch@infradead.org, Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page tables
Date:   Wed,  5 Dec 2018 13:48:25 +0800
Message-Id: <20181205054828.183476-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow-up to the discussion in [1], [2].

IOMMUs using ARMv7 short-descriptor format require page tables
(level 1 and 2) to be allocated within the first 4GB of RAM, even
on 64-bit systems.

For L1 tables that are bigger than a page, we can just use __get_free_pages
with GFP_DMA32 (on arm64 systems only, arm would still use GFP_DMA).

For L2 tables that only take 1KB, it would be a waste to allocate a full
page, so we considered 3 approaches:
 1. This series, adding support for GFP_DMA32 slab caches.
 2. genalloc, which requires pre-allocating the maximum number of L2 page
    tables (4096, so 4MB of memory).
 3. page_frag, which is not very memory-efficient as it is unable to reuse
    freed fragments until the whole page is freed. [3]

This series is the most memory-efficient approach.

[1] https://lists.linuxfoundation.org/pipermail/iommu/2018-November/030876.html
[2] https://lists.linuxfoundation.org/pipermail/iommu/2018-December/031696.html
[3] https://patchwork.codeaurora.org/patch/671639/

Changes since v1:
 - Add support for SLAB_CACHE_DMA32 in slab and slub (patches 1/2)
 - iommu/io-pgtable-arm-v7s (patch 3):
   - Changed approach to use SLAB_CACHE_DMA32 added by the previous
     commit.
   - Use DMA or DMA32 depending on the architecture (DMA for arm,
     DMA32 for arm64).

Changes since v2:
 - Reworded and expanded commit messages
 - Added cache_dma32 documentation in PATCH 2/3.

v3 used the page_frag approach, see [3].

Nicolas Boichat (3):
  mm: slab/slub: Add check_slab_flags function to check for valid flags
  mm: Add support for kmem caches in DMA32 zone
  iommu/io-pgtable-arm-v7s: Request DMA32 memory, and improve debugging

 Documentation/ABI/testing/sysfs-kernel-slab |  9 ++++++++
 drivers/iommu/io-pgtable-arm-v7s.c          | 20 +++++++++++++----
 include/linux/slab.h                        |  2 ++
 mm/internal.h                               | 22 +++++++++++++++++--
 mm/slab.c                                   | 10 +++------
 mm/slab.h                                   |  3 ++-
 mm/slab_common.c                            |  2 +-
 mm/slub.c                                   | 24 +++++++++++++++------
 8 files changed, 70 insertions(+), 22 deletions(-)

-- 
2.20.0.rc1.387.gf8505762e3-goog

