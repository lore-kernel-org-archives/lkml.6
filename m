Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BF1C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A603F21746
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="eLHi1vG8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A603F21746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbeI1Ngo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:36:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40506 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728691AbeI1Ngo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:36:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id o2-v6so1068934wmh.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 00:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=NgeYDmY9zJkHiLqjgSY9G479HjGWfDMkcTrDB/sBJU8=;
        b=eLHi1vG8iNNZYy7EXijkDm/dJ94FohQEoJ5RBT4T9X1gKicmDAsy5hgnmIceZLXYr9
         jYdourd/Cl5cZnstoAcsYz990m+2l5kxyRZ925F2w+S0oIib76fduPXAgy+nvN72MdWM
         0cwppZ5vQE3ssSS9mIjKgKLtxTm4gWmBrxtYuEqRBjYyC6KjL0tUX85VmBX8D2U25FGM
         re6G/QvQFIaXykUZvw610i1AVNmzbu977OCeihtAwXS6yGttFfK/4bCErbvPX9TnVJ68
         IUWJ5jOmS7PhbJlCemCXdIHJySy731CLwERlQmNLnFUJEhrn4lVQrAFedOafm7Czlm2s
         f2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NgeYDmY9zJkHiLqjgSY9G479HjGWfDMkcTrDB/sBJU8=;
        b=grHJYnN9Y3D03VyuTpJ0KQrSyVLh5268BVVVOA70JPGW0vhB24IujPiJJHLoBD9eGa
         6SVhSVrj1Y8vaVIU2DPrG/ygK4bSZhUEOaJGu42X4gzEvSbbjy9YTxolgChdkG573KLx
         gZmurt4WVY45vF8LehLh+jNuW1kR/XZcTgCRFIfq+iXbwCyBN96fiKUz63JwYyG6QS3p
         IH2MlI8At2cr7zLbpVn0wCJ8wyp+MLbkBoF19mmkWEvFt/hKGfAnYAKLVRpen5y9t81o
         6O4ECr4OgTocOCnFtdGhSms13kzEIPPLBLFCRmZ/OQvsYZEhsu7xKkT4hAPPkhWVP7cX
         UeJQ==
X-Gm-Message-State: ABuFfojELP9kozVDf1770whwz3feA3ewbpf82le/mwloVISrn5aSsAPk
        fWqE5w6kk7dHasvAGMT8JBklhg==
X-Google-Smtp-Source: ACcGV61r81WVl7JeWcGVJGdRT8hEZyo311xqRU77l/y5jsZ6F8Ms69pp4JnP/b8R6MmLpVRYUCh12Q==
X-Received: by 2002:a1c:4054:: with SMTP id n81-v6mr749853wma.82.1538118862907;
        Fri, 28 Sep 2018 00:14:22 -0700 (PDT)
Received: from brgl-bgdev.sitez.s.ibrowse.com (93-158-26-51.subs.ibrowse.com. [93.158.26.51])
        by smtp.gmail.com with ESMTPSA id w3-v6sm2699580wru.93.2018.09.28.00.14.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 00:14:22 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v5 0/4] devres: provide and use devm_kstrdup_const()
Date:   Fri, 28 Sep 2018 09:14:10 +0200
Message-Id: <20180928071414.30703-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements devm_kstrdup_const() together with some
prerequisite changes and uses it in pmc-atom driver.

v1 -> v2:
- fixed the changelog in the patch implementing devm_kstrdup_const()
- fixed the kernel doc
- moved is_kernel_rodata() to asm-generic/sections.h
- fixed constness

v2 -> v3:
- rebased on top of 4.19-rc5 as there were some conflicts in the
  pmc-atom driver
- collected Reviewed-by tags

v3 -> v4:
- Andy NAK'ed patch 4/4 so I added a different example
- collected more tags

v4 -> v5:
- instead of providing devm_kfree_const(), make devm_kfree() check if
  given pointer is not in .rodata and act accordingly

Bartosz Golaszewski (4):
  devres: constify p in devm_kfree()
  mm: move is_kernel_rodata() to asm-generic/sections.h
  devres: provide devm_kstrdup_const()
  mailbox: tegra-hsp: use devm_kstrdup_const()

 drivers/base/devres.c          | 36 +++++++++++++++++++++++++++--
 drivers/mailbox/tegra-hsp.c    | 41 ++++++++--------------------------
 include/asm-generic/sections.h | 14 ++++++++++++
 include/linux/device.h         |  4 +++-
 mm/util.c                      |  7 ------
 5 files changed, 60 insertions(+), 42 deletions(-)

-- 
2.18.0

