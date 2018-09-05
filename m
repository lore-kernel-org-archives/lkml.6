Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC809C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B6320659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cR5jXW1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B6320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeIFBpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 21:45:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43124 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeIFBpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 21:45:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id j26-v6so4097812pfi.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 14:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=PrM3TBGsiWAzwppBp1iAxyBHbfSoPrUIEmFqlambUSs=;
        b=cR5jXW1+/GuOQhU3LI5ukQMbdXrHw8Uaaj6+9R6LpvTWACJD24GexcV2aXJHz1kNV6
         KkKtX9v4CoPaIvCpnvYffkH02u2Nsexkat0zuACasmOt/mpqZs9CPtfnY/hYPqr9xSE+
         TCdI12B+KDrnpx1ZhgUnI/Vce0MTuCDBEM96zEhaR4wYhPKu1jlRFOf2bI+gbR3oVp9F
         K1a5Ed+Ta6K05sdyeBVKZfFKlztTvHeJ4ki2NinLQUGAd3c6saef38YHsPgOs5rrXyLK
         1b6lkElDvRMPY46UtsrdILPTqbt04Cu9QJwmmCWAVmZKCjcgsbx4IzZ8k/95TtP2f3cv
         f8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=PrM3TBGsiWAzwppBp1iAxyBHbfSoPrUIEmFqlambUSs=;
        b=e8cFJQ1zTU8J3PI4QXgg0olDFNj8Bh10aUBLBYWq6sa40eE46rrleNEYZw91XvfK8g
         zaM/l5gf7pcl9Rbh6jjDglTxbipeZj+mjfwZYUx+3i4QZpYzFC8v+ZxHt/oh62CUEePE
         6TOofAoNgJKTI0QCBnQaQjPbxlQF4ZS5/fz+xkOx7PD7mUVY0wZHlsRcyVVsPoNOVrsp
         PGPpxcM+3+9MeQ3w66PYWXD0h/rW09n/Pb49kf/uD1ujeUiERTkFe0G/VqS6ykok7Tgt
         IjyvH1DvWDaLkD/zW4qli6ENy5iqT5xo/VZUwPPoJBU4OuvkZO8F9cdoik95T9hrJX1b
         DUhg==
X-Gm-Message-State: APzg51Dgmu4ObYrO3i9W3AlNAHobDTFZY4BW549lTwJwGpOAU+pDJanG
        RKWRGv82Tr/MknFGL3LVUCM=
X-Google-Smtp-Source: ANB0VdbZeRNP7la+1lxRJBJ3sS1G3Lkw41HOzRklrofSZt2Ez/KriXuI1oAcTZeEjvNcS5YpPvm37A==
X-Received: by 2002:a62:45d2:: with SMTP id n79-v6mr42671057pfi.137.1536182003347;
        Wed, 05 Sep 2018 14:13:23 -0700 (PDT)
Received: from localhost.localdomain (static-50-53-21-37.bvtn.or.frontiernet.net. [50.53.21.37])
        by smtp.gmail.com with ESMTPSA id d12-v6sm4788230pfk.69.2018.09.05.14.13.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 14:13:22 -0700 (PDT)
Subject: [PATCH v2 0/2] Address issues slowing memory init
From:   Alexander Duyck <alexander.duyck@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     alexander.h.duyck@intel.com, pavel.tatashin@microsoft.com,
        mhocko@suse.com, dave.hansen@intel.com, akpm@linux-foundation.org,
        mingo@kernel.org, kirill.shutemov@linux.intel.com
Date:   Wed, 05 Sep 2018 14:13:22 -0700
Message-ID: <20180905211041.3286.19083.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is meant to address some issues I consider to be
low-hanging fruit in regards to memory initialization optimization.

With these two changes I am able to cut the hot-plug memory initialization
times in my environment in half.

v2: Added comments about why we are using __SetPageReserved
    Added new config and updated approach used for page init poisoning

---

Alexander Duyck (2):
      mm: Move page struct poisoning to CONFIG_DEBUG_VM_PAGE_INIT_POISON
      mm: Create non-atomic version of SetPageReserved for init use


 include/linux/page-flags.h |    9 +++++++++
 lib/Kconfig.debug          |   14 ++++++++++++++
 mm/memblock.c              |    5 ++---
 mm/page_alloc.c            |   13 +++++++++++--
 mm/sparse.c                |    4 +---
 5 files changed, 37 insertions(+), 8 deletions(-)

--
