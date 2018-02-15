Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031838AbeBONMU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 08:12:20 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36511 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030561AbeBONMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 08:12:19 -0500
X-Google-Smtp-Source: AH8x224a5tG6S+vtkAG21davFhge4TTfPpLl8jzQj+v8wLmXAEwZ8Y9thTvRISXKqTlC2RPSoInLSw==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        javier@cnexlabs.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH v2 0/6] lightnvm: base 2.0 implementation
Date: Thu, 15 Feb 2018 14:11:54 +0100
Message-Id: <20180215131200.3354-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of patches for 2.0 support for the lightnvm subsystem. They
form the foundation for the integration.

The first two patches is preparation for the 2.0 work. The third patch
implements the 2.0 data structures, the geometry command, and exposes
the sysfs attributes that comes with the 2.0 specification. Note that
the attributes between 1.2 and 2.0 are different, and it is expected
that user-space shall use the version sysfs attribute to know which
attributes will be available.

The next two patches removes max_phys_sect and max_rq_size, as they
not used.

The last patch implements support for using the nvme namespace logical
block and metadata fields and sync it with the internal lightnvm
identify structures.

Changes since v2:

 - Removed blk_queue_block_size() setup in nvm_init and made sure
   to only update csecs and sos in on the late setup path. No reason
   to set it twice. From discussion with Javier.
 - Added two extra patches, that removes max_phys_sect and
   max_rq_size.

Changes since v1:

 - pr_err fix from Randy.
 - Address type fix from Javier.
 - Also CC the nvme mailing list.

Matias Bjørling (6):
  lightnvm: make 1.2 data structures explicit
  lightnvm: flatten nvm_id_group into nvm_id
  lightnvm: add 2.0 geometry identification
  lightnvm: remove max_rq_size
  lightnvm: remove nvm_dev_ops->max_phys_sect
  nvme: lightnvm: add late setup of block size and metadata

 drivers/lightnvm/core.c          |  61 ++---
 drivers/lightnvm/pblk-init.c     |   9 +-
 drivers/lightnvm/pblk-recovery.c |   8 +-
 drivers/nvme/host/core.c         |   2 +
 drivers/nvme/host/lightnvm.c     | 513 ++++++++++++++++++++++++++++-----------
 drivers/nvme/host/nvme.h         |   2 +
 include/linux/lightnvm.h         |  71 +++---
 7 files changed, 442 insertions(+), 224 deletions(-)

-- 
2.11.0
