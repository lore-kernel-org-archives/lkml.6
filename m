Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9BFC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 06:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371E120821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 06:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371E120821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbeJaP4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 11:56:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43173 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbeJaP4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 11:56:01 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gHkT6-0005lj-Hb; Wed, 31 Oct 2018 06:59:09 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     ulf.hansson@linaro.org, stern@rowland.harvard.edu,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 0/4 v6] Keep rtsx_usb suspended when there's no card
Date:   Wed, 31 Oct 2018 14:58:59 +0800
Message-Id: <20181031065903.6209-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is based on Ulf's work [1] [2].

This patch series can keep rtsx_usb suspended, to save ~0.5W on Intel
platforms and ~1.5W on AMD platforms.

[1] https://patchwork.kernel.org/patch/10440583/
[2] https://patchwork.kernel.org/patch/10445725/

Kai-Heng Feng (4):
  misc: rtsx_usb: Use USB remote wakeup signaling for card insertion
    detection
  memstick: Prevent memstick host from getting runtime suspended during
    card detection
  memstick: rtsx_usb_ms: Use ms_dev() helper
  memstick: rtsx_usb_ms: Support runtime power management

v6: Move pm_runtime_get_noresume() to media_check(), to avoid
    potentially unblanced rpm count.

v5: Corretly use system suspend/resume and runtime suspend/resume callback.
    Prevent runtime callbacks get call during system suspend.

v4: Use pm_runtime_put() in memstick_check().

v3: Skip parent device check in rtsx_usb_resume_child().
    Remove dev_dbg() if it only prints function name.
    Use ms_dev() helper at more places.
    Remove const qualifier for UNIVERSAL_DEV_PM_OPS.

v2: Resend to linux-usb and LKML.

 drivers/memstick/core/memstick.c    |   3 +
 drivers/memstick/host/rtsx_usb_ms.c | 173 +++++++++++++++++-----------
 drivers/misc/cardreader/rtsx_usb.c  |   8 ++
 3 files changed, 116 insertions(+), 68 deletions(-)

-- 
2.17.1

