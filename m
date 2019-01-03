Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1421CC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 07:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D517A2070C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 07:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbfACHp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 02:45:58 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:41403 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730172AbfACHp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 02:45:57 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07444615|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03276;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.DgqvJY-_1546501546;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.DgqvJY-_1546501546)
          by smtp.aliyun-inc.com(10.147.43.230);
          Thu, 03 Jan 2019 15:45:51 +0800
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        liaoweixiong <liaoweixiong@allwinnertech.com>
Subject: [RFC v4 0/3] pstore/rom: new support logger for block devices
Date:   Thu,  3 Jan 2019 15:45:30 +0800
Message-Id: <1546501533-1855-1-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Why should we need pstore_rom?
1. Most embedded intelligent equipment have no persistent ram, which
increases costs. We perfer to cheaper solutions, like block devices.
In fast, there is already a sample for block device logger in driver
MTD (drivers/mtd/mtdoops.c).
2. Do not any equipment have battery, which means that it lost all data
on general ram if power failure. Pstore has little to do for these
equipments.

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

liaoweixiong (3):
  pstore/rom: new support logger for block devices
  pstore/rom: add sample for pstore_rom
  pstore/rom: support pmsg for pstore_rom

 fs/pstore/Kconfig          |   16 +
 fs/pstore/Makefile         |    5 +
 fs/pstore/rombuf.c         |   46 ++
 fs/pstore/romzone.c        | 1138 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pstore_rom.h |   62 +++
 5 files changed, 1267 insertions(+)
 create mode 100644 fs/pstore/rombuf.c
 create mode 100644 fs/pstore/romzone.c
 create mode 100644 include/linux/pstore_rom.h

-- 
1.9.1

