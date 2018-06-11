Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 75BD7C07D5F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B12F20839
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AuAn8Uhb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B12F20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934345AbeFKSY3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 14:24:29 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45914 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934096AbeFKSY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 14:24:27 -0400
Received: by mail-pl0-f67.google.com with SMTP id c23-v6so12794747plz.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 11:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=sU7czxTlopqIJjfghphxnokrvsuaVvf2+1Ex73LmAg4=;
        b=AuAn8UhbR+N5ciXwC6qd8QIC9LiKHCVlY7s59CRZYa6Qu3XuADJRBF18fvj5vD2CLm
         zclZILTvHTsjo0y1hfsPigZfjUOXiCqULNS5IMtNYv4p5ak9bYbeE5m2YHZ8ZAJJ926Z
         naAFCIlNysrWZlOgV/ViwPGlBC1mWvdu5xP0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sU7czxTlopqIJjfghphxnokrvsuaVvf2+1Ex73LmAg4=;
        b=hOP6bowUNThIkDuc2T0GP9zfIoiICDLGjsulrjPXjtRe1QaJMaWVNtYsVy1sXYj2Gm
         /j66EJ8Xg/i7abQzpsqXdSmVky7YwM4NPDrLrm/DOUSbk0H60iM6MZLidhA+dGxhM2k2
         iIlqLc80YIYW7G5Zon7G44TnA8c0seD/i0dl3GHnuvavqJoK6NXYxWgtrY9koUak4Svm
         R2WQU0Y/8ZM7Ss1Geo6EhCKTVXqMisuZQAd9W17EYlflfvL+pWCegxDmIJE+EFguHFtJ
         ORg1Y8kWe/LydfZBVaYaDVzdQ3Yd+MQhX4X826B+6XqwoEIunUg7RquCpQiKK+ipEfDv
         Ytfg==
X-Gm-Message-State: APt69E3zF6yrKfMdDcd5rBMDRgZgFdrp0J3erXsEhDvpyRGkzBkNtRr6
        GJItW9Uf0ErogHdN76O1MIXurAwZZEA=
X-Google-Smtp-Source: ADUXVKK1+xN9/2gFKiGdpZkQMTrTIUOCcbNvahGGSp8u26GeL/Q2bR3XmzynnC4Ig9dtYSYZnA8ZXg==
X-Received: by 2002:a17:902:6b86:: with SMTP id p6-v6mr279667plk.75.1528741466719;
        Mon, 11 Jun 2018 11:24:26 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g12-v6sm31915395pfh.164.2018.06.11.11.24.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 11:24:26 -0700 (PDT)
Date:   Mon, 11 Jun 2018 11:24:24 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] remoteproc updates for v4.18
Message-ID: <20180611182424.GD3206@builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 75bc37fefc4471e718ba8e651aa74673d4e0a9eb:

  Linux 4.17-rc4 (2018-05-06 16:57:38 -1000)

are available in the Git repository at:

  git://github.com/andersson/remoteproc tags/rproc-v4.18

for you to fetch changes up to 4725496e4872824fa6182d412c66c00cae978a62:

  remoteproc: q6v5: Allow defining GLINK edge for mss remoteproc (2018-05-29 20:10:34 -0700)

----------------------------------------------------------------
remoteproc updates for v4.18

This brings a few minor fixes to the Davinci driver, drops a orphan
include file from the StE cleanup done ealier and introduces support for
booting the modem on Qualcomm's SDM845 platform.

----------------------------------------------------------------
Andrzej Hajda (1):
      remoteproc/ste: remove abandoned include file

Bartosz Golaszewski (3):
      remoteproc/davinci: add the missing retval check for clk_enable()
      remoteproc/davinci: prepare and unprepare the clock where needed
      remoteproc/davinci: use octal permissions for module_param()

Bjorn Andersson (2):
      Merge tag 'v4.17-rc4' into rproc-next
      remoteproc: q6v5: Return irq from q6v5_request_irq()

Geert Uytterhoeven (1):
      remoteproc: Remove depends on HAS_DMA in case of platform dependency

Sibi Sankar (6):
      remoteproc: Prevent incorrect rproc state on xfer mem ownership failure
      remoteproc: q6v5: Move proxy unvote to handover irq handler
      dt-bindings: remoteproc: Add Q6v5 Modem PIL binding for SDM845
      remoteproc: q6v5: Introduce reset assert/deassert helper functions
      remoteproc: q6v5: Add support for mss remoteproc on SDM845
      remoteproc: q6v5: Allow defining GLINK edge for mss remoteproc

 .../devicetree/bindings/remoteproc/qcom,q6v5.txt   |   1 +
 drivers/remoteproc/Kconfig                         |   1 -
 drivers/remoteproc/da8xx_remoteproc.c              |  12 +-
 drivers/remoteproc/qcom_q6v5_pil.c                 | 201 ++++++++++++++++++---
 include/linux/ste_modem_shm.h                      |  56 ------
 5 files changed, 188 insertions(+), 83 deletions(-)
 delete mode 100644 include/linux/ste_modem_shm.h
