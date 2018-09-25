Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C795C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C552087A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="bEx+8aNU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C552087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbeIYSyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:54:05 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39105 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728906AbeIYSyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:54:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id q8-v6so13504178wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 05:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=2xZBhxtFOmBPgSWRhX67jcanr9o+ydDDgjlXoaiDoOw=;
        b=bEx+8aNUuS4NUn2Te1GjEbyLKHxIrF5GFmj1f+jRVPCyI+lNYvsP6EXiP6p5QA55Iu
         N6jkaOYEDacyHVyxClfczIP/XAD8EPh4WNwAyaitnkGIT2eoWK6jJJudce4TTSOG9dj0
         mRxbtRldL22ANnVbuRZrlgeXDcmjhmMBZ2cPz0eTwIMDF+Ekr1tmc9S0Wu2qJPhjEN0e
         r7OKAtzW+MC+HvNysFwMZlKkt9gBpVmKubL7qHOt+3078wT0iS4Q6rDryITyVnL0E3yY
         CfwlKNeW1zKNRIzZ/50AbzLeOw6CPFMAdlW3U+N4O22wtFgwZMMCoSbAoFfvkoIobUlz
         GG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2xZBhxtFOmBPgSWRhX67jcanr9o+ydDDgjlXoaiDoOw=;
        b=Lb8NKfgg1a/zPv6dBmHrWDUVRbPmy+Mwa22zE4JKJlpzcnXAuxsTI0+sKvfMjW7V2o
         Vr+sb6kldk5E+8DKVD4zHooD67+AccWrHPFi8cjTtoKIjIA86iLBcsGAX4AhWW9CMzTk
         Z7bWTg5k+vnHdIVOenp5c2GHENy9PTX3qyoqqCsb1rE1WY7lYwOxRLW3eOlx9Jb/7BTW
         zO/qAdJPUiLTZeWYiytKQk5ZgXlKIPpQ8JB7NR4HWs2wOyPoud9J5+7oWrjJrNG6Y1jf
         P4UUg+FkN3g60blnldU+dtmcJ1pkmMxkqCH3f7nZ/3n2ijn6ALSsULI52dcAoIk0AyFZ
         YNIA==
X-Gm-Message-State: ABuFfoite58s/2iEKXr3nu2v5DWcK55BRK0tNsesEDfvc7KoDVa43V6z
        fbVYGUb+IHgOrGynH9PjBw/PCA==
X-Google-Smtp-Source: ACcGV62MV/Lfx+cYKVW+wZWdSq+Pi1wdvKwLCovN1a0W/8xbuVvEv++OzXOEeGuigmAuNY6P15AdKA==
X-Received: by 2002:a1c:2351:: with SMTP id j78-v6mr558305wmj.68.1537879599436;
        Tue, 25 Sep 2018 05:46:39 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id z13sm2276160wrw.19.2018.09.25.05.46.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 05:46:38 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Joe Perches <joe@perches.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v4 0/4] devres: provide and use devm_kstrdup_const()
Date:   Tue, 25 Sep 2018 14:46:25 +0200
Message-Id: <20180925124629.20710-1-brgl@bgdev.pl>
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

Bartosz Golaszewski (4):
  devres: constify p in devm_kfree()
  mm: move is_kernel_rodata() to asm-generic/sections.h
  devres: provide devm_kstrdup_const()
  mailbox: tegra-hsp: use devm_kstrdup_const()

 drivers/base/devres.c          | 43 ++++++++++++++++++++++++++++++++--
 drivers/mailbox/tegra-hsp.c    | 41 +++++++-------------------------
 include/asm-generic/sections.h | 14 +++++++++++
 include/linux/device.h         |  5 +++-
 mm/util.c                      |  7 ------
 5 files changed, 68 insertions(+), 42 deletions(-)

-- 
2.18.0

