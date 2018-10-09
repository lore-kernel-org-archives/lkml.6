Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900F3C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49207214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="Ehts/CCw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49207214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeJIS3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:29:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34007 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeJIS3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:29:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so683516pfi.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MXyuX/eQAsmUVQCsPh/3ouIrGtbN7Q8q10YOZMYO9jQ=;
        b=Ehts/CCwdtmnZQad135C51xhugYCFS+soebIQ3RucheWZfcAmaLNTqn1+Jh1/FPMRB
         7xE1bc9nUkE+4zP2PRbTAiUlKhXlqu2tbWiBqfA9C/L7t+47R5/8kZzOdeXJyOWqGaHB
         iszoAguMMMrNaM++UlTlW6pS9EHX3oi2uqele5PLzoH/R+bTw6y4g9uarvzmq1dYvFtA
         c4IAjqJt8Sk1qWsLwdMnAUl7YsfrVXTQqOvR0OQ8rJVV+68Ak/w/3V8Ml4ha5pGpOkb+
         9YwoI8rx3Ples/ri4tMqwawj5mUXnvwwarI9okmk0p/76LYpzBXt1cVZwTHYFamaM2Us
         0Bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MXyuX/eQAsmUVQCsPh/3ouIrGtbN7Q8q10YOZMYO9jQ=;
        b=OJnMNV7e5y76es7xO6iDmu8logWCWlVJzOR3g0i3BSZ+einGErbAgebjqsRwNsf8G7
         sp4S5r+8Ixo6I1WSmojPQaPB3TaZKInYAFbj8siuZoqggeo3H/qMMDy5HJTWvWpqK71l
         6qJqfWf/M1FNgeptNPx8FRwKA1RAibFrJyVr8u9jzNDlc+cHL9hI3UkSwLDaOOu3p6lM
         5Br1kDXO9juwQEo5WPgQOheP/k48SUNPzkRoMlLjLKtlvw+FIXl+TxLBeZ8OxZpVL0+Y
         DWLFOn8gj65sU3XL9pJQu+Qrm2uUeiYg29M6zTw5zjV2ZMrDDPqOtn1MlAFO8B3vDFNv
         N7yA==
X-Gm-Message-State: ABuFfoinETac6ARdPEreplNj8kX/xhgFM1x8hDglaueHTW8GnNK3E2Ly
        RLHW6p80/EU0Sv7Akelwa2gEiA==
X-Google-Smtp-Source: ACcGV60FXQYsxlxG/viRdMZUcLvJoCP8hjrTR9mdvBHdAI0XEmY17Jg71uAShmXYgoMVRc0qFESkyg==
X-Received: by 2002:a63:501:: with SMTP id 1-v6mr24833936pgf.205.1539083594357;
        Tue, 09 Oct 2018 04:13:14 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.13.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:13:12 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 00/45] lightnvm updates for 4.20.
Date:   Tue,  9 Oct 2018 13:11:30 +0200
Message-Id: <20181009111215.7653-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

Please pick up the following patches for 4.20.

The changes include:

 - pblk trace support from Hans.
 - SPDX license header update from Javier.
 - Tons of refactoring patches from Javier, and me to cleanly abstract
   the 1.2 and 2.0 specs behind a common core interface.
 - Enable pblk to use a common interface to retrieve chunk metadata.
   From me.
 - Bug fixes from Hans, Javier, Jia-ju, Wei, Zhoujie, and me.

Thanks!,
Matias

Hans Holmberg (11):
  lightnvm: introduce nvm_rq_to_ppa_list
  lightnvm: pblk: allocate line map bitmaps using a mempool
  lightnvm: pblk: remove unused parameters in pblk_up_rq
  lightnvm: pblk: fix up prints in pblk_read_check_rand
  lightnvm: pblk: fix write amplificiation calculation
  lightnvm: pblk: add trace events for chunk states
  lightnvm: pblk: add trace events for line state changes
  lightnvm: pblk: add trace events for pblk state changes
  lightnvm: pblk: add tracing for chunk resets
  lightnvm: pblk: stop recreating global caches
  lightnvm: pblk: fix mapping issue on failed writes

Javier González (21):
  lightnvm: pblk: fix race condition on metadata I/O
  lightnvm: pblk: add helpers for chunk addresses
  lightnvm: pblk: improve line helpers
  lightnvm: pblk: fix comment typo
  lightnvm: pblk: remove unused variable.
  lightnvm: pblk: guarantee emeta on line close
  lightnvm: move ppa transformations to core
  lightnvm: pblk: calculate line pad distance in helper
  lightnvm: use internal allocation for chunk log page
  lightnvm: pblk: encapsulate rqd dma allocations
  lightnvm: pblk: refactor metadata paths
  lightnvm: pblk: take write semaphore on metadata
  lightnvm: pblk: recover open lines on 2.0 devices
  lightnvm: pblk: add SPDX license tag
  lightnvm: pblk: fix race on sysfs line state
  lightnvm: pblk: remove unused function
  lightnvm: pblk: encapsulate rb pointer operations
  lightnvm: pblk: move ring buffer alloc/free rb init
  lightnvm: pblk: guarantee mw_cunits on read buffer
  lightnvm: do no update csecs and sos on 1.2
  lightnvm: pblk: guarantee that backpointer is respected on writer
    stall

Jia-Ju Bai (1):
  lightnvm: pblk: fix two sleep-in-atomic-context bugs

Matias Bjørling (10):
  lightnvm: remove dependencies on BLK_DEV_NVME and PCI
  lightnvm: combine 1.2 and 2.0 command flags
  lightnvm: pblk: fix rqd.error return value in pblk_blk_erase_sync
  lightnvm: move device L2P detection to core
  lightnvm: move bad block and chunk state logic to core
  lightnvm: pblk: unify vector max req constants
  lightnvm: pblk: fix incorrect min_write_pgs
  lightnvm: pblk: remove size and out of bounds read check
  lightnvm: pblk: refactor put line fn on read completion
  lightnvm: pblk: remove debug from pblk_[down/up]_page

Wei Yongjun (1):
  lightnvm: pblk: fix error handling of pblk_lines_init()

Zhoujie Wu (1):
  lightnvm: pblk: consider max hw sectors supported for max_write_pgs

 drivers/lightnvm/Kconfig         |   3 +-
 drivers/lightnvm/core.c          | 334 ++++++++++++++----
 drivers/lightnvm/pblk-cache.c    |   1 +
 drivers/lightnvm/pblk-core.c     | 589 +++++++++++++++++--------------
 drivers/lightnvm/pblk-gc.c       |  11 +-
 drivers/lightnvm/pblk-init.c     | 321 +++++++----------
 drivers/lightnvm/pblk-map.c      |  13 +-
 drivers/lightnvm/pblk-rb.c       | 110 +++---
 drivers/lightnvm/pblk-read.c     |  86 ++---
 drivers/lightnvm/pblk-recovery.c | 477 +++++++++----------------
 drivers/lightnvm/pblk-rl.c       |   5 +-
 drivers/lightnvm/pblk-sysfs.c    |  12 +-
 drivers/lightnvm/pblk-trace.h    | 145 ++++++++
 drivers/lightnvm/pblk-write.c    |  90 ++---
 drivers/lightnvm/pblk.h          | 225 ++++--------
 drivers/nvme/host/lightnvm.c     |  32 +-
 include/linux/lightnvm.h         | 166 ++++++++-
 17 files changed, 1436 insertions(+), 1184 deletions(-)
 create mode 100644 drivers/lightnvm/pblk-trace.h

-- 
2.17.1

