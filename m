Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933579AbeCSOWM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 10:22:12 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:12050 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932708AbeCSOWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 10:22:10 -0400
From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        davem@davemloft.net, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, ganeshgr@chelsio.com,
        nirranjan@chelsio.com, indranil@chelsio.com,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Subject: [RFC PATCH 0/3] kernel: add support for 256-bit IO access
Date: Mon, 19 Mar 2018 19:50:33 +0530
Message-Id: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
X-Mailer: git-send-email 2.5.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches add support for 256-bit IO read and write.
The APIs are readqq and writeqq (quad quadword - 4 x 64), that read
and write 256-bits at a time from IO, respectively.

Patch 1 adds u256 type and adds necessary non-atomic accessors.  Also
adds byteorder conversion APIs.

Patch 2 adds 256-bit read and write to x86 via VMOVDQU AVX CPU
instructions.

Patch 3 updates cxgb4 driver to use the readqq API to speed up
reading on-chip memory 256-bits at a time.

Feedback and suggestions will be much appreciated.

Thanks,
Rahul

Rahul Lakkireddy (3):
  include/linux: add 256-bit IO accessors
  x86/io: implement 256-bit IO read and write
  cxgb4: read on-chip memory 256-bits at a time

 arch/x86/include/asm/io.h                      | 57 ++++++++++++++++++++++++-
 drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c | 16 +++----
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h     |  6 +++
 include/linux/byteorder/generic.h              | 48 +++++++++++++++++++++
 include/linux/io-64-nonatomic-hi-lo.h          | 59 ++++++++++++++++++++++++++
 include/linux/io-64-nonatomic-lo-hi.h          | 59 ++++++++++++++++++++++++++
 include/linux/types.h                          |  7 +++
 7 files changed, 243 insertions(+), 9 deletions(-)

-- 
2.14.1
