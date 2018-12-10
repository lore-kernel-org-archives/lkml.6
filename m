Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A03C07E85
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 01:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867952064D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 01:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IGakDlDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867952064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbeLJBPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 20:15:17 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44057 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbeLJBPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 20:15:17 -0500
Received: by mail-pl1-f196.google.com with SMTP id k8so4404261pls.11
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 17:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MkSsWMVSAeJSTGMkLIBUq4R1LV61HkOQXyu0ciWvNcA=;
        b=IGakDlDC4jzbyobxgJg+2BtK6pRzujiaHW9b/NlUxa0oN4Q+v0nQbxHrvV6rztYHh8
         d3fr24CtYwIkYSO3HiHHaG/leWfyED+lGSqnIV7h/Xbo2OepSP1vmM9e307pfWp5Ne7t
         7rnRbEZVNe0rbWbSsRsAUfgBYrhNOmlCsnIq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MkSsWMVSAeJSTGMkLIBUq4R1LV61HkOQXyu0ciWvNcA=;
        b=GacebjeX6lhGgQ3AL5cx7ZqCz/lcl2S4PG1gFzgC9ImsbAIfRJgSSafqUeyF/YE8w/
         VjeL6A7OSBvLEUEZT/iQmNoXK4/1aeSwIGx7rENyASuWnhUTn/yDm3LwaoSf3/FH028L
         /9dvANMQRcDrMYU72ENlGym4mW4hMAqg52ztavPGdrYxfKuITN5b3aaYWNjORTvRI9db
         Q7/fSS4n768X8dTsWkJzBPLPis8U/Ilq+H8uipwjunghe7RfAftyB6CkBoGCtf7bUslJ
         AlbLd0Cg6UDgvEHyDDstnFyrmb6i3knWz+1g/WnL607XyNmPy8Czi6fgNYOWnGCppEMW
         ta/Q==
X-Gm-Message-State: AA+aEWaOCvq2x/1i0gjifkxmzn+x2lTv5aHmS3faXayqdA2RigWu6XqB
        3HuzcQ2DJ6MI34/nrsqhZq0HTg==
X-Google-Smtp-Source: AFSGD/WjUF0Gawkk7vT2zAOu4MoHSXVpXqw+NlA2IDYWtN/771s4IQ/JHyV568QM+ZRV7zANefqpgA==
X-Received: by 2002:a17:902:7d90:: with SMTP id a16mr9818780plm.249.1544404516350;
        Sun, 09 Dec 2018 17:15:16 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:f659:7f17:ea11:4e8e])
        by smtp.gmail.com with ESMTPSA id b10sm16516336pfj.183.2018.12.09.17.15.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 17:15:15 -0800 (PST)
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
        hch@infradead.org, Matthew Wilcox <willy@infradead.org>,
        hsinyi@chromium.org, stable@vger.kernel.org
Subject: [PATCH v6 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page tables
Date:   Mon, 10 Dec 2018 09:15:01 +0800
Message-Id: <20181210011504.122604-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
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

stable@ note:
  We confirmed that this is a regression, and IOMMU errors happen on 4.19
  and linux-next/master on MT8173 (elm, Acer Chromebook R13). The issue
  most likely starts from commit ad67f5a6545f ("arm64: replace ZONE_DMA
  with ZONE_DMA32"), i.e. 4.15, and presumably breaks a number of Mediatek
  platforms (and maybe others?).

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

Changes since v4:
 - Dropped change that removed GFP_DMA32 from GFP_SLAB_BUG_MASK:
   instead we can just call kmem_cache_*alloc without GFP_DMA32
   parameter. This also means that we can drop PATCH v4 1/3, as we
   do not make any changes in GFP flag verification.
 - Dropped hunks that added cache_dma32 sysfs file, and moved
   the hunks to PATCH v5 3/3, so that maintainer can decide whether
   to pick the change independently.

Changes since v5:
 - Rename ARM_V7S_TABLE_SLAB_CACHE to ARM_V7S_TABLE_SLAB_FLAGS.
 - Add stable@ to cc.

Nicolas Boichat (3):
  mm: Add support for kmem caches in DMA32 zone
  iommu/io-pgtable-arm-v7s: Request DMA32 memory, and improve debugging
  mm: Add /sys/kernel/slab/cache/cache_dma32

 Documentation/ABI/testing/sysfs-kernel-slab |  9 +++++++++
 drivers/iommu/io-pgtable-arm-v7s.c          | 19 +++++++++++++++----
 include/linux/slab.h                        |  2 ++
 mm/slab.c                                   |  2 ++
 mm/slab.h                                   |  3 ++-
 mm/slab_common.c                            |  2 +-
 mm/slub.c                                   | 16 ++++++++++++++++
 tools/vm/slabinfo.c                         |  7 ++++++-
 8 files changed, 53 insertions(+), 7 deletions(-)

-- 
2.20.0.rc2.403.gdbc3b29805-goog

