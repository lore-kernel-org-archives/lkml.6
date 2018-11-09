Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385D9C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87AA20855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A/SA9FCl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E87AA20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeKISE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 13:04:29 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33758 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbeKISE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 13:04:28 -0500
Received: by mail-pf1-f196.google.com with SMTP id v68-v6so618098pfk.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 00:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xt7QCGw++akA77vlfkmWoTE9LyFDe/QX/BbsCJDsPBk=;
        b=A/SA9FClORwx0R6elb0IcLTjl5KNb0T15LI40GkkJrx+BXwnXE6fcM1HCD61ERQX5w
         YmWs9aU0cWpVJfRjp0vD5bk1ab8ZBXXulsNByoHxTgM1jPmdzosCsmVIeJSh084dwyfd
         kdNi0jL3MAm5aBAQ5Clrw3O4ZdZL/5wTPxF8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xt7QCGw++akA77vlfkmWoTE9LyFDe/QX/BbsCJDsPBk=;
        b=c/tTiYwv0jhcDQJgfW/EAI1qh+nHEJyu6TIY8rg1WTTDtFwDzoaWpxiswV/A/55ToT
         K4w3TyuP44nZ/2VnesC4OvvcNEaJECO9N2WIR5t5H39zdAf3wN4V5uS11WrAwpZGobO9
         JonRRLvUF+eGumE2v2d6u/vAT+p8YeV/7h9wal5zVIQH/VSox9GHf5DiwzHzTMk41lKH
         8y6Caz3H1EJuLpA6x/8qOEc13SvhYn8RQ076r1KfbYwYgxe33M30n+YOWSDIz8nFnqeG
         yqIyJGuyKvcAmZGhnX1Hq0wkxVS8k4fjTiwHLRac+Yp30jszgnQcXB/XVwhEkeLPbtlR
         gDBw==
X-Gm-Message-State: AGRZ1gIyjn1fWNT2sF3pA0pLAluD+dfYwPLHKdYZ0IdLfhvZZDhKx0pm
        oCF0jVawUwdAuAL98tfgi7ge7g==
X-Google-Smtp-Source: AJdET5eSKbdk5UJHF0yrZ4GLXOcx7jYFXEFEDcZtMrya6XPJm7znurvMH5vqsl7N0/k3jYB0+0UiNA==
X-Received: by 2002:a62:f599:: with SMTP id b25-v6mr8149413pfm.253.1541751899094;
        Fri, 09 Nov 2018 00:24:59 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:f659:7f17:ea11:4e8e])
        by smtp.gmail.com with ESMTPSA id u2-v6sm6415667pfn.50.2018.11.09.00.24.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 00:24:58 -0800 (PST)
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
        Levin Alexander <alexander.levin@verizon.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, yingjoe.chen@mediatek.com
Subject: [PATCH RFC 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page tables
Date:   Fri,  9 Nov 2018 16:24:45 +0800
Message-Id: <20181109082448.150302-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow-up to the discussion in [1], to make sure that the page tables
allocated by iommu/io-pgtable-arm-v7s are contained within 32-bit physical
address space.

[1] https://lists.linuxfoundation.org/pipermail/iommu/2018-November/030876.html

Nicolas Boichat (3):
  mm: When CONFIG_ZONE_DMA32 is set, use DMA32 for SLAB_CACHE_DMA
  include/linux/gfp.h: Add __get_dma32_pages macro
  iommu/io-pgtable-arm-v7s: Request DMA32 memory, and improve debugging

 drivers/iommu/io-pgtable-arm-v7s.c |  6 ++++--
 include/linux/gfp.h                |  2 ++
 include/linux/slab.h               | 13 ++++++++++++-
 mm/slab.c                          |  2 +-
 mm/slub.c                          |  2 +-
 5 files changed, 20 insertions(+), 5 deletions(-)

-- 
2.19.1.930.g4563a0d9d0-goog

