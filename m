Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12F6C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7790B20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7790B20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754937AbeFTJeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:34:14 -0400
Received: from mga06.intel.com ([134.134.136.31]:29118 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754848AbeFTJeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:34:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 02:34:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,246,1526367600"; 
   d="scan'208";a="51386365"
Received: from sandybridge-desktop.sh.intel.com ([10.239.160.116])
  by orsmga006.jf.intel.com with ESMTP; 20 Jun 2018 02:34:09 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc:     "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/3][RFC] Introduce the in-kernel hibernation encryption
Date:   Wed, 20 Jun 2018 17:39:37 +0800
Message-Id: <cover.1529486870.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
As security becomes more and more important, we add the in-kernel
encryption support for hibernation.

This prototype is a trial version to implement the hibernation
encryption in the kernel, so that the users do not have to rely
on third-party tools to encrypt the hibernation image. The only
dependency on user space is that, the user space should provide
a valid key derived from passphrase to the kernel for image encryption.

There was a discussion on the mailing list on whether this key should
be derived in kernel or in user space. And it turns out to be generating
the key by user space is more acceptable[1]. So this patch set is divided
into two parts:
1. The hibernation snapshot encryption in kernel space,
2. the key derivation implementation in user space.

Please refer to each patch for detail, and feel free to comment on
this, thanks.

[1] https://www.spinics.net/lists/linux-crypto/msg33145.html

Chen Yu (3):
  PM / Hibernate: Add helper functions for hibernation encryption
  PM / Hibernate: Encrypt the snapshot pages before submitted to the
    block device
  tools: create power/crypto utility

 MAINTAINERS                           |   8 +
 kernel/power/Kconfig                  |  13 +
 kernel/power/Makefile                 |   1 +
 kernel/power/crypto_hibernation.c     | 405 ++++++++++++++++++++++++++++++
 kernel/power/power.h                  |  38 +++
 kernel/power/swap.c                   | 215 +++++++++++++++-
 tools/power/crypto/Makefile           |  26 ++
 tools/power/crypto/crypto_hibernate.c | 447 ++++++++++++++++++++++++++++++++++
 8 files changed, 1142 insertions(+), 11 deletions(-)
 create mode 100644 kernel/power/crypto_hibernation.c
 create mode 100644 tools/power/crypto/Makefile
 create mode 100644 tools/power/crypto/crypto_hibernate.c

-- 
2.7.4

