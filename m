Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756075AbeDXFpu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 01:45:50 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38296 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755809AbeDXFpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 01:45:47 -0400
X-Google-Smtp-Source: AIpwx48ORMDAN9A3Vgj1adsJ6YIP8SCU5svbRLNHJb3b0/bAQ91qsuGg5TM1U4N21HzUk6f1Y0X8IA==
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, Javier Gonzales <javier@cnexlabs.com>,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH v2 0/3] Rework write error handling in pblk
Date: Tue, 24 Apr 2018 08:45:29 +0300
Message-Id: <1524548732-4326-1-git-send-email-hans.ml.holmberg@owltronix.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

This patch series fixes the(currently incomplete) write error handling 
in pblk by:

 * queuing and re-submitting failed writes in the write buffer
 * evacuating valid data data in lines with write failures, so the
   chunk(s) with write failures can be reset to a known state by the fw

Lines with failures in smeta are put back on the free list.
Failed chunks will be reset on the next use.

If a write failes in emeta, the lba list is cached so the line can be 
garbage collected without scanning the out-of-band area.

Changes in V2:
- Added the recov_writes counter increase to the new path
- Moved lba list emeta reading during gc to a separate function
- Allocating the saved lba list with pblk_malloc instead of kmalloc
- Fixed formatting issues
- Removed dead code

Hans Holmberg (3):
  lightnvm: pblk: rework write error recovery path
  lightnvm: pblk: garbage collect lines with failed writes
  lightnvm: pblk: fix smeta write error path

 drivers/lightnvm/pblk-core.c     |  52 +++++++-
 drivers/lightnvm/pblk-gc.c       | 102 +++++++++------
 drivers/lightnvm/pblk-init.c     |  47 ++++---
 drivers/lightnvm/pblk-rb.c       |  39 ------
 drivers/lightnvm/pblk-recovery.c |  91 -------------
 drivers/lightnvm/pblk-rl.c       |  29 ++++-
 drivers/lightnvm/pblk-sysfs.c    |  15 ++-
 drivers/lightnvm/pblk-write.c    | 269 ++++++++++++++++++++++++++-------------
 drivers/lightnvm/pblk.h          |  36 ++++--
 9 files changed, 384 insertions(+), 296 deletions(-)

-- 
2.7.4
