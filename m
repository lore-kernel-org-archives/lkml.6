Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAB5C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DF1222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391635AbfBMOHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:07:34 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:50134 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391585AbfBMOHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:07:33 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06712975|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03307;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.Dy6iQiS_1550066841;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.Dy6iQiS_1550066841)
          by smtp.aliyun-inc.com(10.147.40.233);
          Wed, 13 Feb 2019 22:07:27 +0800
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        liaoweixiong <liaoweixiong@allwinnertech.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [RFC v8 0/5] pstore/block: new support logger for block devices
Date:   Wed, 13 Feb 2019 22:07:03 +0800
Message-Id: <1550066828-18806-1-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Why should we need pstore_block?
1. Most embedded intelligent equipment have no persistent ram, which
increases costs. We perfer to cheaper solutions, like block devices.
In fast, there is already a sample for block device logger in driver
MTD (drivers/mtd/mtdoops.c).
2. Do not any equipment have battery, which means that it lost all data
on general ram if power failure. Pstore has little to do for these
equipments.

[PATCH v8]
On patch 2:
1. move DT to /bindings/pstore
2. Delete details for kernel.

[PATCH v7]
On patch 1:
1. Fix line over 80 characters.
On patch 2:
1. Insert a separate patch for DT bindings.

[PATCH v6]
On patch 1:
1. Fix according to email from Kees Cook, including spelling mistakes,
   explicit overflow test, none of the zeroing etc.
2. Do not recover data but metadata of dmesg when panic.
3. No need to take recovery when do erase.
4. Do not use "blkoops" for blkzone any more because "blkoops" is used for
   other module now. (rename blkbuf to blkoops)
On patch 2:
1. Rename blkbuf to blkoops.
2. Add Kconfig/device tree/module parameters settings for blkoops.
3. Add document for device tree.
On patch 3:
1. Blkoops support pmsg.
2. Fix description for new version patch.
On patch 4:
1. Fix description for new version patch.

[PATCH v5]
On patch 1:
1. rename pstore/rom to pstore/blk
2. Do not allocate any memory in the write path of panic. So, use local
array instead in function romz_recover_dmesg_meta.
3. Add C header file "linux/fs.h" to fix implicit declaration of function
   'filp_open','kernel_read'...
On patch 3:
1. If panic, do not recover pmsg but flush if it is dirty.
2. Fix erase pmsg failed.
On patch 4:
1. Create a document for pstore/blk

[PATCH v4]
On patch 1:
1. Fix always true condition '(--i >= 0) => (0-u32max >= 0)' in function
   romz_init_zones by defining variable i to 'int' rahter than
   'unsigned int'.
2. To make codes more easily to read, we use macro READ_NEXT_ZONE for
   return value of romz_dmesg_read if it need to read next zone.
   Moveover, we assign READ_NEXT_ZONE -1024 rather than 0.
3. Add 'FLUSH_META' to 'enum romz_flush_mode' and rename 'NOT_FLUSH' to
   'FLUSH_NONE'
4. Function romz_zone_write work badly with FLUSH_PART mode as badly
   address and offset to write.
On patch 3:
NEW SUPPORT psmg for pstore_rom.

[PATCH v3]
On patch 1:
Fix build as module error for undefined 'vfs_read' and 'vfs_write'
Both of 'vfs_read' and 'vfs_write' haven't be exproted yet, so we use
'kernel_read' and 'kernel_write' instead.

[PATCH v2]
On patch 1:
Fix build as module error for redefinition of 'romz_unregister' and
'romz_register'

[PATCH v1]
On patch 1:
Core codes of pstore_rom, which works well on allwinner(sunxi) platform.
On patch 2:
A sample for pstore_rom, using general ram rather than block device.

liaoweixiong (5):
  pstore/blk: new support logger for block devices
  dt-bindings: pstore-block: new support for blkoops
  pstore/blk: add blkoops for pstore_blk
  pstore/blk: support pmsg for pstore block
  Documentation: pstore/blk: create document for pstore_blk

 Documentation/admin-guide/pstore-block.rst         |  227 ++++
 .../devicetree/bindings/pstore/blkoops.txt         |   29 +
 MAINTAINERS                                        |    4 +-
 fs/pstore/Kconfig                                  |  128 +++
 fs/pstore/Makefile                                 |    5 +
 fs/pstore/blkoops.c                                |  250 +++++
 fs/pstore/blkzone.c                                | 1164 ++++++++++++++++++++
 include/linux/pstore_blk.h                         |   62 ++
 8 files changed, 1868 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/admin-guide/pstore-block.rst
 create mode 100644 Documentation/devicetree/bindings/pstore/blkoops.txt
 create mode 100644 fs/pstore/blkoops.c
 create mode 100644 fs/pstore/blkzone.c
 create mode 100644 include/linux/pstore_blk.h

-- 
1.9.1

