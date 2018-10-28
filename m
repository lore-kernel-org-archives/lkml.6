Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82721C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 17:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B84120672
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 17:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gllXGvv1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B84120672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbeJ2CJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 22:09:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45065 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbeJ2CJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 22:09:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id s3-v6so2726418pga.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 10:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=K6O8T0JW/yZqF5e35ubtRewtxR5rCSPy1fbwHFqgkyQ=;
        b=gllXGvv1nW0L7fEaB1Z2VZ31atxoS6kevyW3E3G0r33NrQewBUm387eRZUwBqgHBiI
         UC18XV1pXE8DvSmtnKQpTOXPIZRYp0oRy7KJQHSUIE7kVNqAJBpUjM3gEPwpCLw10Jrs
         kX6yZJbJE2c27ipLK2GyDx+M0SiiNaxp8b3B4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=K6O8T0JW/yZqF5e35ubtRewtxR5rCSPy1fbwHFqgkyQ=;
        b=IF5eJmtokQGL/XiqLWdJfHnvncetjBG2jxPs5aljNxw3fq7/PQTlUTYSfDclR8Q2js
         6sFZqD4fcBCONkczeq/qeB5KlII4C4M4+j7Gz5XgCCjdo97sNa3VMPvwAk1SSWuqwK0A
         dpiTbg8XuMvwtcyNzN9d3YVtIPc5vm9156IxeeH0Iy3VLdR1sI2vTuLKkbLm6g+l8K+R
         cujhBoyGAM6vTVEhom7+OwhnpPiIZ9Y8vtqgt3W/35zhFZ47ZtUoquf44PTPZR4UP1Hc
         6xRjtstOrBBnzRLPlgVwkUH7Da+oVZrNRq4qxD01NCypmRt878q8UT3USdCBIGwhRpUv
         UbLg==
X-Gm-Message-State: AGRZ1gKCUn9IKLIjpSKDpiz2iPO3VSpyfEEax5Cmb86wmCZ38+4vLJf+
        0zsao31yUAZUcos+y/fV2lKBXg==
X-Google-Smtp-Source: AJdET5dNn/t0uNG5gSHkrbtXiwoqFfF0bzEBNPqE/5AJmhGHZwLbkUZclcpZ0TwLuG4LomEgSpRa8w==
X-Received: by 2002:a63:6cc:: with SMTP id 195mr10958632pgg.52.1540747443916;
        Sun, 28 Oct 2018 10:24:03 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id z22-v6sm18611546pgv.24.2018.10.28.10.24.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 10:24:02 -0700 (PDT)
Date:   Sun, 28 Oct 2018 10:24:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kbuild@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [GIT PULL] VLA removal for v4.20-rc1
Message-ID: <20181028172401.GA41102@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these VLA removal changes for v4.20-rc1. This turns on "-Wvla"
globally now that the last few trees with their VLA removals have landed
(crypto, block, net, and powerpc). Arnd mentioned that there may be a
couple more VLAs hiding in hard-to-find randconfigs, but nothing big has
shaken out in the last month or so in linux-next. We should be basically
VLA-free now! Wheee. :)

Thanks!

-Kees

The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

  Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/vla-v4.20-rc1

for you to fetch changes up to 0bb95f80a38f82884693194ea720e9cca5e12ada:

  Makefile: Globally enable VLA warning (2018-10-11 08:17:50 -0700)

----------------------------------------------------------------
Globally warn on VLA use

- Remove unused fallback for BUILD_BUG_ON (which technically contains a VLA)
- Lift -Wvla to the top-level Makefile

----------------------------------------------------------------
Kees Cook (1):
      Makefile: Globally enable VLA warning

Masahiro Yamada (1):
      compiler.h: give up __compiletime_assert_fallback()

 Makefile                      |  3 +++
 drivers/gpu/drm/i915/Makefile |  2 +-
 include/linux/compiler.h      | 17 +----------------
 lib/Makefile                  |  2 ++
 scripts/Makefile.extrawarn    |  1 -
 5 files changed, 7 insertions(+), 18 deletions(-)

-- 
Kees Cook
