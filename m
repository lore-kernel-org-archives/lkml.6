Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AF4C07E85
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 00:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6554320831
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 00:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6554320831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbeLJAfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 19:35:17 -0500
Received: from mail.windriver.com ([147.11.1.11]:41790 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbeLJAfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 19:35:16 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id wBA0Z0PG002699
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 9 Dec 2018 16:35:00 -0800 (PST)
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Sun, 9 Dec 2018
 16:35:00 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 0/3] phy: remove needless usage of module header
Date:   Sun, 9 Dec 2018 19:34:47 -0500
Message-ID: <1544402090-30970-1-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The most important thing to note here, is these clean-ups make no
changes to the final generated run-time.  The 1st commit removes an
unused function, otherwise the generated objects are also unchanged.

The work here represents a scan over the phy dir, looking for files
that have nothing to do with a modular use case, but are using modular
infrastructure regardless.

We are trying to make driver code consistent with the Makefiles/Kconfigs
that control them.  This means not using modular functions/macros for
drivers that can never be built as a module.  This has been done in quite
a lot of other mainline subsystem dirs already.

Using modular infrastructure in non-modules might seem harmless, but some
of the downfalls this leads to are:

 (1) it is easy to accidentally write unused module_exit and remove code
 (2) it can be misleading when reading the source, thinking it can be
     modular when the Makefile and/or Kconfig prohibit it
 (3) it requires the include of the module.h header file which in turn
     includes nearly everything else, thus adding to CPP overhead.
 (4) it gets copied/replicated into other drivers and spreads quickly.

As a data point for #3 above, an empty C file that just includes the
module.h header generates over 750kB of CPP output.  Repeating the same
experiment with init.h and the result is less than 12kB; with export.h
it is only about 1/2kB; with both it still is less than 12kB.

Build tested on x86-64 and ARM-64.

Paul.
---

Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>

Paul Gortmaker (3):
  phy: make phy-core explicitly non-modular
  phy: make phy-mvebu-sata explicitly non-modular
  phy: make phy-armada375-usb2 explicitly non-modular

 drivers/phy/marvell/phy-armada375-usb2.c |  8 +-------
 drivers/phy/marvell/phy-mvebu-sata.c     |  9 ++-------
 drivers/phy/phy-core.c                   | 12 +-----------
 3 files changed, 4 insertions(+), 25 deletions(-)

-- 
2.7.4

