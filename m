Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8381FC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 425172089E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 425172089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbeGYQhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 12:37:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57213 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728528AbeGYQhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 12:37:40 -0400
Received: from 1-161-144-158.dynamic-ip.hinet.net ([1.161.144.158] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1fiLfL-00011h-CI; Wed, 25 Jul 2018 15:25:27 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     ulf.hansson@linaro.org, stern@rowland.harvard.edu,
        bauer.chen@realtek.com, ricky_wu@realtek.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 0/5 v3] Keep rtsx_usb suspended when there's no card
Date:   Wed, 25 Jul 2018 23:25:10 +0800
Message-Id: <20180725152515.1833-1-kai.heng.feng@canonical.com>
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

Kai-Heng Feng (5):
  misc: rtsx_usb: Use USB remote wakeup signaling for card insertion
    detection
  memstick: Prevent memstick host from getting runtime suspended during
    card detection
  memstick: rtsx_usb_ms: Use ms_dev() helper
  memstick: rtsx_usb_ms: Support runtime power management
  misc: rtsx_usb: / memstick: rtsx_usb_ms: Avoid long delay before
    system suspend
--
v3: Skip parent device check in rtsx_usb_resume_child() .
    Remove dev_dbg() if it only prints function name.
    Use ms_dev() helper at more places.
    Remove const qualifier for UNIVERSAL_DEV_PM_OPS.

v2: Resend to linux-usb and LKML.

 drivers/memstick/core/memstick.c    |   4 +
 drivers/memstick/host/rtsx_usb_ms.c | 148 +++++++++++++++-------------
 drivers/misc/cardreader/rtsx_usb.c  |   9 ++
 3 files changed, 91 insertions(+), 70 deletions(-)

-- 
2.17.1

