Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C699AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C04120818
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfBVPbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:31:32 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:45368 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbfBVPb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:31:29 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id A119318689;
        Fri, 22 Feb 2019 16:31:27 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id De7AKFePIvYf; Fri, 22 Feb 2019 16:31:22 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id 8631A1857B;
        Fri, 22 Feb 2019 16:31:21 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 530851A07E;
        Fri, 22 Feb 2019 16:31:21 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 478CB1A075;
        Fri, 22 Feb 2019 16:31:21 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Fri, 22 Feb 2019 16:31:21 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by thoth.se.axis.com (Postfix) with ESMTP id 3B8722048;
        Fri, 22 Feb 2019 16:31:21 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 34ED380DC0; Fri, 22 Feb 2019 16:31:21 +0100 (CET)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH v2 char-misc-next 0/7] Virtio-over-PCIe on non-MIC
Date:   Fri, 22 Feb 2019 16:30:46 +0100
Message-Id: <20190222153056.18878-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the drivers/misc/mic/vop/ code to be used on other architectures
and adds a loopback driver to be able to use/test/evaluate it without special
hardware.

See v1 for more info:
https://lore.kernel.org/lkml/20190116163253.23780-1-vincent.whitchurch@axis.com/

v2:
- Rebase on top of the patches which have merged
- Use unsigned long instead of uintptr_t
- Drop "Use consistent DMA" for now since it's not needed for loopback
- Add race fix
- Build on all architectures, not just ARM and x86
- Add sample userspace code

Vincent Whitchurch (7):
  mic: vop: Cast pointers to unsigned long
  mic: Rename ioremap pointer to remap
  mic: vop: Allow building on more systems
  mic: vop: Add loopback driver
  mic: vop: Fix init race with shared interrupts
  samples: mic: Split out vop code from mpssd
  samples: mic: Add sample VOP userspace

 drivers/misc/mic/Kconfig            |   13 +-
 drivers/misc/mic/bus/scif_bus.h     |    8 +-
 drivers/misc/mic/bus/vop_bus.h      |    8 +-
 drivers/misc/mic/card/mic_device.c  |    8 +-
 drivers/misc/mic/host/mic_boot.c    |    8 +-
 drivers/misc/mic/scif/scif_map.h    |    4 +-
 drivers/misc/mic/vop/Makefile       |    2 +
 drivers/misc/mic/vop/vop_loopback.c |  382 ++++++++
 drivers/misc/mic/vop/vop_main.c     |   62 +-
 drivers/misc/mic/vop/vop_vringh.c   |   15 +-
 samples/mic/mpssd/.gitignore        |    1 +
 samples/mic/mpssd/Makefile          |    9 +-
 samples/mic/mpssd/mpssd.c           | 1317 +-------------------------
 samples/mic/mpssd/mpssd.h           |    1 +
 samples/mic/mpssd/vop.c             | 1357 +++++++++++++++++++++++++++
 samples/mic/mpssd/vopd.c            |   25 +
 16 files changed, 1866 insertions(+), 1354 deletions(-)
 create mode 100644 drivers/misc/mic/vop/vop_loopback.c
 create mode 100644 samples/mic/mpssd/vop.c
 create mode 100644 samples/mic/mpssd/vopd.c

-- 
2.20.0

