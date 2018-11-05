Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489ABC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1702085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="leeO7G3B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1702085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbeKFE6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:58:33 -0500
Received: from plaes.org ([188.166.43.21]:44038 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728945AbeKFE6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:58:32 -0500
Received: from localhost (85.253.196.132.cable.starman.ee [85.253.196.132])
        by plaes.org (Postfix) with ESMTPSA id 4BC0F403FA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Nov 2018 19:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1541446639; bh=Tp2VpaSoqU54gxxeYHSeAP+EH+WMWEwZH+xOdtCmBjo=;
        h=From:To:Subject:Date:From;
        b=leeO7G3Bj7YgFEgsGOUilgJ+xPhcBuWSMVRP4fr5QZNsUXWnmgkr4EpgLETD3FQpI
         +O6v1FTxc9boup5JPKFXWJUJtdVJv4GXEW1l6nqTQgTQlhNK184cFewg9E8OOoivNI
         IuWaIAWfeaZWd5lrLsEbE3BiU24+TJRs04Uwu/V1quTAfKrEKZGJDLgRqJ+59VdE1s
         2Tnzrei0Y8sahlpw6KzaENQ/IksVF2aIhY+LPJWnfRCvwkTD3yWdhf4RCd2QfY8tzM
         A0IyZR9CZMnkQFM9ZFhzL4nugvhbbqJhEKtkXIPjJYQszeOuzEgB0s4MPVevb2Fsev
         qVYNAMkd9fJdw==
From:   Priit Laes <plaes@plaes.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] wireless: Use common cordic algorithm for b43 driver
Date:   Mon,  5 Nov 2018 21:37:15 +0200
Message-Id: <cover.9ec98292c595a111ae78f31383ff8618c9cb04da.1541446422.git-series.plaes@plaes.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

b43 wireless driver includes an internal implementation of
cordic algorithm, although there's a common cordic library
which was split out from brcmsmac driver. Use that and drop
internal implementation.

During the process, brcmfmac was driver was also cleaned up.

Please note that this series is only compile-tested, as I
do not have access to the hardware.

Changes:
- Merged brcmsmac driver patches into single patch
- Merged b43 driver patches into single patch

Priit Laes (3):
  lib: cordic: Move cordic macros and defines to header file
  brcmsmac: Use cordic-related macros from common cordic library
  b43: Use cordic algorithm from kernel library

 drivers/net/wireless/broadcom/b43/Kconfig                      |  1 +-
 drivers/net/wireless/broadcom/b43/phy_common.c                 | 47 +-------
 drivers/net/wireless/broadcom/b43/phy_common.h                 |  9 +-
 drivers/net/wireless/broadcom/b43/phy_lp.c                     | 13 +-
 drivers/net/wireless/broadcom/b43/phy_n.c                      | 13 +-
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_int.h |  7 +-
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c |  4 +-
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c   |  4 +-
 include/linux/cordic.h                                         |  9 +-
 lib/cordic.c                                                   | 23 +---
 10 files changed, 35 insertions(+), 95 deletions(-)

base-commit: 651022382c7f8da46cb4872a545ee1da6d097d2a
-- 
git-series 0.9.1
