Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717A8C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 20:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226D9208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 20:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="RTG7nr5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226D9208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbeJADAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 23:00:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36818 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbeJADAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 23:00:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id y16so3317565wrw.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 13:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=kPWU9qWXg2wD4YYXp2dt6Omce9wVEUby+5K7h8DQ4Lk=;
        b=RTG7nr5W3k+7tfKqUQQ5yyRp+sFMIII5cr+HaiP67ImdruGjKzKIsW8bL+nGTNXrYg
         riOKMBZWba/1JzyQPnxphliX0j2WtbAC913qvVKuRXb/TUimkLjLTzYj9WAWwzZe7Z2+
         1BwyG9U+PcGJzZey9h1Hb6AXok69+TxxcTtFRmvcG140nfeRidLsELThmWXIjOfR6fsi
         woyr0nV9uCH774RWQCTugkIxU9zCMF6Xa5FZyUMtPlgEP66x+9FZ98f/XTjqfujIyKyY
         qynhPID9aB7DBM8KLaBqpE/VcVUDOZk4ExY2kUqdQ/VFMTVUa6YSwt6MWMB9/QNWKyHP
         49Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kPWU9qWXg2wD4YYXp2dt6Omce9wVEUby+5K7h8DQ4Lk=;
        b=Ob5isxdYLkoB1A5H9wPQ4m8euzAFJM3E6AxmxsIyrj2YKYns6hNOqtK9P3/1jTsGxa
         i9q2UdJvvbecaGUIarj4lZNcm6y2PiiB/SzsmUFSFyk5EJ+VmG/oxRjzCJAUhBUMSUMj
         fMIadhoQsJtW7lVIyshFfVVzOM0tM2x2/KwnRuVR55SMxltTA/glwdfJDni+gJPWje6N
         9hZc246LxH95i0Wv0/Urw+RmhTDXKC0RP91s2zYjVmZ9cESL3K9RlwYckFj49qxFkSjX
         4w51eJ+I8dJBI4QPhiGQQ2fB74A6QJNOkfR+g61luSavznQLjeXROTuFsNEQR9uchgLM
         x8pA==
X-Gm-Message-State: ABuFfogp7EHH+JrnpIzor5MBMzVyLSCo1wLmxp2rNQ9mcSV/tJieelDh
        8fdWocolk0zQ8u49OsYwTZ2J0A==
X-Google-Smtp-Source: ACcGV631weybSJ0bZYphtQgjwGRe76oXZkUimE7buWzI8JptUn/6jQgNV5wSVG+E5Dmpa79oUOJkKw==
X-Received: by 2002:a05:6000:100f:: with SMTP id a15mr5075231wrx.271.1538339180575;
        Sun, 30 Sep 2018 13:26:20 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id v16-v6sm18566465wrw.12.2018.09.30.13.26.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 13:26:19 -0700 (PDT)
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
Subject: [PATCH v6 0/4] devres: provide and use devm_kstrdup_const()
Date:   Sun, 30 Sep 2018 22:26:11 +0200
Message-Id: <20180930202615.12951-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements devm_kstrdup_const() together with some
prerequisite changes and uses it in tegra-hsp driver.

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

v5 -> v6:
- fixed the commit message in patch 2/4 (s/devm_kfree_const/devm_kfree/)
- collected even more tags

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

