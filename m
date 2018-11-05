Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE19C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC06A20868
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC06A20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbeKESDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:03:48 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34906 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeKESDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:03:47 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gJaVS-0002NR-8w; Mon, 05 Nov 2018 08:45:10 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     ulf.hansson@linaro.org, stern@rowland.harvard.edu,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 0/5 v7] Keep rtsx_usb suspended when there's no card
Date:   Mon,  5 Nov 2018 16:45:01 +0800
Message-Id: <20181105084506.6476-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Kai-Heng Feng (5):
  memstick: rtsx_usb_ms: Add missing pm_runtime_disable() in probe
    function
  misc: rtsx_usb: Use USB remote wakeup signaling for card insertion
    detection
  memstick: Prevent memstick host from getting runtime suspended during
    card detection
  memstick: rtsx_usb_ms: Use ms_dev() helper
  memstick: rtsx_usb_ms: Support runtime power management

v7: Keep CONFIG_PM_SLEEP for .suspend and .resume callbacks.
    Use CONFIG_PM for .runtime_suspend and .runtime_resume callbacks.
    Reorder pm_runtime_get_noresume() before pm_runtime_enable().
    Add missing pm_runtime_disable().

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
 drivers/memstick/host/rtsx_usb_ms.c | 172 +++++++++++++++++-----------
 drivers/misc/cardreader/rtsx_usb.c  |   8 ++
 3 files changed, 117 insertions(+), 66 deletions(-)

-- 
2.19.1

