Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754156AbeE1I6v (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 04:58:51 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39078 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753493AbeE1I6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 04:58:50 -0400
X-Google-Smtp-Source: ADUXVKI0Hsp64BreaADubno33JhKNlo26rbyNPoYuNP4xnb3s6KDeJPkA0xExo46wEkv4NoIW7nj8A==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 00/20] lightnvm updates for 4.18
Date: Mon, 28 May 2018 10:58:21 +0200
Message-Id: <20180528085841.26684-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

Please pick up the following patches.

 - Hans reworked the write error recovery path in pblk.
 - Igor added extra error handling for lines, and fixed a bug in the
   pblk ringbuffer during GC.
 - Javier refactored the pblk code a bit, added extra error
   handling, and added checks to verify that data returned from drive
   is appropriate.
 - Marcin added some extra logic to manage the write buffer. Now
   MW_CUNITS can be zero and the size of write buffer can be changed
   at module load time.

Thanks,
Matias

Hans Holmberg (3):
  lightnvm: pblk: rework write error recovery path
  lightnvm: pblk: garbage collect lines with failed writes
  lightnvm: pblk: fix smeta write error path

Igor Konopko (4):
  lightnvm: proper error handling for pblk_bio_add_pages
  lightnvm: error handling when whole line is bad
  lightnvm: fix partial read error path
  lightnvm: pblk: sync RB and RL states during GC

Javier González (11):
  lightnvm: pblk: fail gracefully on line alloc. failure
  lightnvm: pblk: recheck for bad lines at runtime
  lightnvm: pblk: check read lba on gc path
  lightnvn: pblk: improve error msg on corrupted LBAs
  lightnvm: pblk: warn in case of corrupted write buffer
  lightnvm: pblk: return NVM_ error on failed submission
  lightnvm: pblk: remove unnecessary indirection
  lightnvm: pblk: remove unnecessary argument
  lightnvm: pblk: check for chunk size before allocating it
  lightnvn: pass flag on graceful teardown to targets
  lightnvm: pblk: remove dead function

Marcin Dziegielewski (2):
  lightnvm: pblk: handle case when mw_cunits equals to 0
  lightnvm: pblk: add possibility to set write buffer size manually

 drivers/lightnvm/core.c          |  10 +-
 drivers/lightnvm/pblk-core.c     | 149 +++++++++++++++------
 drivers/lightnvm/pblk-gc.c       | 112 ++++++++++------
 drivers/lightnvm/pblk-init.c     | 112 +++++++++++-----
 drivers/lightnvm/pblk-map.c      |  33 +++--
 drivers/lightnvm/pblk-rb.c       |  51 +------
 drivers/lightnvm/pblk-read.c     |  83 +++++++++---
 drivers/lightnvm/pblk-recovery.c |  91 -------------
 drivers/lightnvm/pblk-rl.c       |  29 +++-
 drivers/lightnvm/pblk-sysfs.c    |  15 ++-
 drivers/lightnvm/pblk-write.c    | 281 +++++++++++++++++++++++++--------------
 drivers/lightnvm/pblk.h          |  43 +++---
 drivers/nvme/host/lightnvm.c     |   1 -
 include/linux/lightnvm.h         |   2 +-
 14 files changed, 604 insertions(+), 408 deletions(-)

-- 
2.11.0
