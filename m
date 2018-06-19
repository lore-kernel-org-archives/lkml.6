Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2812C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618742083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H5eBfVdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618742083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967237AbeFST1r (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:27:47 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44800 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966747AbeFST1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:27:46 -0400
Received: by mail-wr0-f195.google.com with SMTP id x4-v6so775944wro.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 12:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+OBAMFJ3adccbc6RuLENVKrKL2cU0VbU8cj5ndYBjdA=;
        b=H5eBfVdv9Dpmcfo9ZHgcyFeIQsBeiK9j8SjhTjeULski4C0rUvyEyJ5T5j5/LsMyCf
         bNpjivPOaapupJPwpmirVXdFx/XQiPkbZ5fsEb21sl2Xt4EwwLeZ+gUlhxr5nhO/e0rt
         u1wj76iOGGlSdjZUs9LxeXrXMEc9VmvvYZOPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+OBAMFJ3adccbc6RuLENVKrKL2cU0VbU8cj5ndYBjdA=;
        b=Ww7rEMo6eRoMx+iOO6aRQc0h9upZeQY2O2upemuVv5DjucSEhLfK+pZFhkFQcx2WgJ
         CvhsKTzqpJe0wQcTy/rJtK/3/DEsew11VEbo7VtwjwM3Jx73V/2mQF00RpSBwiX3P2ld
         6Ft+upyMpmN/8HylZH8UzGGIkHElpd3U/G9DKBoTzYMR0mOhJIVoA8ux0c7zg7kb4bIF
         oz2/lUrcfIY/TIPcMvzojFmsvw3OjqjibQIzPErmt94oaV0Oy7aoK/8MN0DP+cfnwx25
         wSsIvh+XG+qxNS9/qZOB10ah77R/iFmVbPTm2wHUPkjtZFZgVhPbqzjLh+Gvz4yv7hZ+
         yJ2g==
X-Gm-Message-State: APt69E3npA5nEmsxthKhdSeBXKGIBcvD5l/OuyM+S+0MCTRhwpL7m8Xt
        rPTiiapImnYf3ktJq+mNOS3ybQ==
X-Google-Smtp-Source: ADUXVKJMafh41hL3w5BQIxJK/PBFxbtBb6c/ejTXLGHU3+1xLYKhpSkZOhi/nbqjeWon+vLXJ7eiDA==
X-Received: by 2002:adf:e94e:: with SMTP id m14-v6mr15238567wrn.126.1529436464860;
        Tue, 19 Jun 2018 12:27:44 -0700 (PDT)
Received: from dogfood.home ([2a01:cb1d:112:6f00:a06d:5653:4fd5:13a])
        by smtp.gmail.com with ESMTPSA id c53-v6sm982601wrg.12.2018.06.19.12.27.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 12:27:43 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux@armlinux.org.uk, linux@roeck-us.net, mark.rutland@arm.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 0/2] Make badr macro compatible with newer GAS versions
Date:   Tue, 19 Jun 2018 21:26:31 +0200
Message-Id: <20180619192633.21846-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Work around the mindless and backward incompatible change in GAS that
prevents us from using a simple addition to set the Thumb bit in local
symbol references taken using 'adr' instructions (#2)

As a preparatory step, remove badr occurrences in ARM code sequences
contained in Thumb2 kernels.

Ard Biesheuvel (2):
  ARM: avoid badr macro for switching to Thumb-2 mode
  ARM: assembler: prevent ADR from setting the Thumb bit twice

 arch/arm/common/mcpm_head.S      |  5 ++---
 arch/arm/include/asm/assembler.h | 22 +++++++++++++++++++-
 arch/arm/kernel/head-nommu.S     |  7 +++----
 arch/arm/kernel/head.S           | 15 +++++++------
 arch/arm/kernel/sleep.S          |  7 +++----
 5 files changed, 36 insertions(+), 20 deletions(-)

-- 
2.17.1

