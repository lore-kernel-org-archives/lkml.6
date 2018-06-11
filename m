Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E0E2BC07D5F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964FB20839
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uhrile6E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964FB20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934339AbeFKSXW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 14:23:22 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34498 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934263AbeFKSXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 14:23:20 -0400
Received: by mail-pl0-f68.google.com with SMTP id g20-v6so12808466plq.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 11:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=sXZeh43wR5vYfPHFhJN2HbDyqMV+8Ov5WjULRQ22Vjc=;
        b=Uhrile6Ef6fqGEW4SDywq7nxnvqtTpHgZ3h0v58FFu24UcjmrL27vTgXVfGWuj4lOP
         iolhR/GepXcHAwJjEYPr2EQkVXNSM3zc6yIKwKJU3SSLqDJH7ACoP1w522E/taiGoPw8
         8XKNvbFvogzPXm89+levop5tkfopOIrCq7WcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sXZeh43wR5vYfPHFhJN2HbDyqMV+8Ov5WjULRQ22Vjc=;
        b=MXh561nql4DNN0nyqP+qATnVHpvi7+QMqIIxdX/VSIMcwIekr+mPRidOyKl6zfYnfn
         tCDH4yEo+vi3JiuOPBMWy7UzoXeWZAhi4zBlKbwKCDwCT07q3oCZF2vDZN712QTNBOlF
         X+l/7c129wF/Y3CegTXah9BGZNkzVFay/GsvJz3yVqART7H25F4Am8YQ6IMEsV+MrDNk
         bleEJQxXQ4gwhJQuFIzHdTxR7bhCQ64pQFA/FBZmX/fNYW+m6iR7FDNlZewiG1Sij1ke
         R0OtggPdL+BB/g4exk/wzKngd4trY0g8Jn6pfmAqG9/f+d9lB1TvhINwI/ahhEDCpk7j
         zpDg==
X-Gm-Message-State: APt69E26Dt0Bh3D7PVCX7mjSjDMpoJ5U+Siu0hGQJRdxax8CLWeJD3GX
        X6VoEmPCcmbgVQkgddeIgXCbVQ==
X-Google-Smtp-Source: ADUXVKK1KfNgjn/EN0SKnjuV6RdDmh6MHSoMAvYQMU7owWxhsHQk4u8SgNKc7Tp8EVF1e6/lJO3QbQ==
X-Received: by 2002:a17:902:7e42:: with SMTP id a2-v6mr264271pln.151.1528741400408;
        Mon, 11 Jun 2018 11:23:20 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m10-v6sm51676035pgq.89.2018.06.11.11.23.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 11:23:19 -0700 (PDT)
Date:   Mon, 11 Jun 2018 11:23:17 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Suman Anna <s-anna@ti.com>,
        Baolin Wang <baolin.wang@linaro.org>
Subject: [GIT PULL] hwspinlock updates for v4.18
Message-ID: <20180611182317.GC3206@builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://github.com/andersson/remoteproc tags/hwlock-v4.18

for you to fetch changes up to e759176c7f6b6d84a31276e11d687f232f6e4ecf:

  hwspinlock/u8500: Switch to SPDX license identifier (2018-05-24 12:05:11 -0700)

----------------------------------------------------------------
hwspinlock updates for v4.18

In addition to migrating the files to use SPDX license headers this
introduces the ability for clients to operate a hwlock without the
framework taking any additional locks.

----------------------------------------------------------------
Baolin Wang (2):
      hwspinlock: Convert to use 'switch' statement
      hwspinlock: Introduce one new mode for hwspinlock

Suman Anna (6):
      hwspinlock/core: Switch to SPDX license identifier
      hwspinlock/omap: Switch to SPDX license identifier
      hwspinlock: qcom: Switch to SPDX license identifier
      hwspinlock/sirf: Switch to SPDX license identifier
      hwspinlock: sprd: Switch to SPDX license identifier
      hwspinlock/u8500: Switch to SPDX license identifier

 drivers/hwspinlock/Kconfig               |  1 +
 drivers/hwspinlock/hwspinlock_core.c     | 77 +++++++++++++++++++++-----------
 drivers/hwspinlock/hwspinlock_internal.h | 10 +----
 drivers/hwspinlock/omap_hwspinlock.c     | 10 +----
 drivers/hwspinlock/qcom_hwspinlock.c     | 10 +----
 drivers/hwspinlock/sirf_hwspinlock.c     |  3 +-
 drivers/hwspinlock/sprd_hwspinlock.c     | 10 +----
 drivers/hwspinlock/u8500_hsem.c          | 10 +----
 include/linux/hwspinlock.h               | 68 ++++++++++++++++++++++++----
 9 files changed, 118 insertions(+), 81 deletions(-)

