Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED1EC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF14A2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AnS9t9DZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF14A2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbeJLAVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:21:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40122 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729991AbeJLAVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 20:21:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id s5-v6so4713351pfj.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 09:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Xrsb9HMDUmffhVfhoK8DfIaTFfzYkH/3JUt5b4B+JiY=;
        b=AnS9t9DZnG7hyedIxsM0PMEYXXATkCthbqT/w9zYcBzCAL9ymYuaDF9HRLYDT98aXU
         eKTkVRX9vOwPZt1Ev7fO4JZcqI4Y7xqDJ2xxYUANzRnx7yklAPBYzndyXGVO8NvvsF3X
         hx8wf/eQ/J1C+mlwiReJjztSvZ9tlrn7kTK7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Xrsb9HMDUmffhVfhoK8DfIaTFfzYkH/3JUt5b4B+JiY=;
        b=DS0K7cegmkqR2Vh4kp0ZpG7a08bq1Qy45OPZ0+pOJyR6QLsPhLMd9BSS63ANLVDDBt
         1WcHTgcwdZvTT+SR9Ip7AUcI0mhuaR6WEJeiXI6tv7YQxpWvv5Y4W3Qh3XbtTae3mCqB
         qK1N6vfhFGuAul/vqg/RepYaZuMktzLmz6sd08qUtXFywDbdkqydfoYau3N/+LjtyTR4
         XUpYAkCQdAcuhSf3AQ1LO5ZtaMz3J815S5RfNBq1yol+P/HVLi+oQV7//TqYI+5v9lbH
         9kdRbyUot9zgI+ReYVhOHhHkE8e+vyTpIG8KfXNDJo1awcu48aMHpP1ZcW/cIwx7detj
         zE+A==
X-Gm-Message-State: ABuFfoiPiphqocWb/NB1rzyv8K+53ZW/7SYDxS4CjAifmAzpkHmXUrWc
        TmI2/vXeLl3lRwt6/UTHy2FnpA==
X-Google-Smtp-Source: ACcGV62diu/dWbn8PALTbRbKYsZRJ3q2+Rc8MjLrqqE5RlwNw7/VXp8o5FTiN4+hOd0Xw0t0EA9bTA==
X-Received: by 2002:a63:b08:: with SMTP id 8-v6mr2108912pgl.130.1539276778862;
        Thu, 11 Oct 2018 09:52:58 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id k71-v6sm50145135pge.44.2018.10.11.09.52.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 09:52:57 -0700 (PDT)
Date:   Thu, 11 Oct 2018 09:52:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] allocator argument fixes for v4.19-rc8
Message-ID: <20181011165256.GA34463@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please pull this fix for open-coded multiplication in allocator arguments
for v4.19-rc8. This has been in linux-next for almost a week with no
reported issues. As discussed last week[1] this catches 4.19 up to
the same level of coverage we had in 4.18 for avoiding these kinds of
unchecked multiplications.

Thanks!

-Kees

[1] https://lkml.kernel.org/r/CAGXu5jJfs0KpRa6yag=ud0sJVW-tM-E4xuvgCMnBdFfDck5E1g@mail.gmail.com

The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

  Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/alloc-args-v4.19-rc8

for you to fetch changes up to 329e09893909d409039f6a79757d9b80b67efe39:

  treewide: Replace more open-coded allocation size multiplications (2018-10-05 18:06:30 -0700)

----------------------------------------------------------------
Fix open-coded multiplication arguments to allocators

- Fixes several new open-coded multiplications added in the 4.19 merge window.

----------------------------------------------------------------
Kees Cook (1):
      treewide: Replace more open-coded allocation size multiplications

 drivers/bluetooth/hci_qca.c                 |  2 +-
 drivers/crypto/inside-secure/safexcel.c     |  8 +++++---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c     |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_io_util.c |  4 ++--
 drivers/hwmon/npcm750-pwm-fan.c             |  2 +-
 drivers/md/dm-integrity.c                   |  3 ++-
 drivers/net/wireless/mediatek/mt76/usb.c    | 10 +++++-----
 drivers/pci/controller/pcie-cadence.c       |  4 ++--
 drivers/tty/serial/qcom_geni_serial.c       |  4 ++--
 net/sched/sch_cake.c                        |  2 +-
 10 files changed, 22 insertions(+), 19 deletions(-)

-- 
Kees Cook
Pixel Security
