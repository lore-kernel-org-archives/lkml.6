Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532F3C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 09:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10AEC2087C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 09:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nTVGFkxO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10AEC2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbeKKSwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 13:52:02 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39985 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbeKKSwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 13:52:02 -0500
Received: by mail-pl1-f194.google.com with SMTP id q19-v6so2863761pll.7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 01:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YH0dpLemzETchXwysz1a293wDlVR1tlxLKZnu56Wuas=;
        b=nTVGFkxOErxYFfdmoxWfmHfjGNbk62h55lL3zEjAkuWhGdoO61xN6eXeKEtaT789my
         lPKE0n4qgCeJCY9/4S2si17Uf5q9HNdIIzAQ9mPXiATgyxuTEa1DJLMi4kahnoegyIkW
         jTI+kdqxT/lcn8tL7VvR68HG9RudI/BJJ8bAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YH0dpLemzETchXwysz1a293wDlVR1tlxLKZnu56Wuas=;
        b=mpIM4tQOlNYQBD6TBfMn7MT4E8/P+cmvZx7FjFPoua5xgXiu2Sj6FeufHki/MjpcRb
         WjIYKcluWY5f0IAMNTkNkmbUd+xyWTk2L9rT3SKBZMTvrfhF86N1Z2/bYB8ZKxzN2JHu
         CxGR7wZKGLPlCkIH1m1koma6axRT5HRI8s0gkuqrNKqxiQaDPDTmE6gB4nuiAjKi3rWQ
         dV/0C/EXv089hxM4isJ1u6or4usP7dHPUoT/AewBZhmvYYD/+WbQ98uMsajL1V6UCgt2
         yXuI3GhT/jVdPPpy9+1dI5p0UYjDG2lvSMjZ5ZAnvQoGZxBXzy6HAYkGyAvV4racAr+8
         pZtA==
X-Gm-Message-State: AGRZ1gJaPVEpUdekUzirnD6uIQvFeeKxl89trY42AGuYfpbxHLG5x709
        jEihX37vqmB/McVlRqZoLaF/UA==
X-Google-Smtp-Source: AJdET5ejJwdcyah6PDSi2X+5m2sTUW/Lm9eyOeRrOnLflAJS5sWNkHm/wZ4Yk4wnTwUeEQLKthdWWw==
X-Received: by 2002:a17:902:8ec2:: with SMTP id x2-v6mr15716258plo.157.1541927043030;
        Sun, 11 Nov 2018 01:04:03 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:f659:7f17:ea11:4e8e])
        by smtp.gmail.com with ESMTPSA id 69sm8107956pgg.86.2018.11.11.01.03.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 01:04:02 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>,
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
        Tomasz Figa <tfiga@google.com>, yingjoe.chen@mediatek.com
Subject: [PATCH v2 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page tables
Date:   Sun, 11 Nov 2018 17:03:38 +0800
Message-Id: <20181111090341.120786-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow-up to the discussion in [1], to make sure that the page
tables allocated by iommu/io-pgtable-arm-v7s are contained within 32-bit
physical address space.

[1] https://lists.linuxfoundation.org/pipermail/iommu/2018-November/030876.html

Fixes since v1:
 - Add support for SLAB_CACHE_DMA32 in slab and slub (patches 1/2)
 - iommu/io-pgtable-arm-v7s (patch 3):
   - Changed approach to use SLAB_CACHE_DMA32 added by the previous
     commit.
   - Use DMA or DMA32 depending on the architecture (DMA for arm,
     DMA32 for arm64).

Nicolas Boichat (3):
  mm: slab/slub: Add check_slab_flags function to check for valid flags
  mm: Add support for SLAB_CACHE_DMA32
  iommu/io-pgtable-arm-v7s: Request DMA32 memory, and improve debugging

 drivers/iommu/io-pgtable-arm-v7s.c | 20 ++++++++++++++++----
 include/linux/slab.h               |  2 ++
 mm/internal.h                      | 21 +++++++++++++++++++--
 mm/slab.c                          | 10 +++-------
 mm/slab.h                          |  3 ++-
 mm/slab_common.c                   |  2 +-
 mm/slub.c                          | 24 +++++++++++++++++-------
 7 files changed, 60 insertions(+), 22 deletions(-)

-- 
2.19.1.930.g4563a0d9d0-goog

