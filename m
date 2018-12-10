Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDADAC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A00F20672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmgSWe97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A00F20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbeLJTmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:42:20 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33177 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbeLJTmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:42:20 -0500
Received: by mail-wm1-f65.google.com with SMTP id r24so7370798wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 11:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=seO5pYUVOppQz0bc69tFmfcD8uMCJdgzegwYSbd9RdE=;
        b=pmgSWe97BeMvEoJAmtVZwmuh7IMYLeZMMwpzZ1sh7ZmpKDHDtkI/B3Fe+nSRLr7MZn
         TvkRajyvToh6yrAvg9HZMfF/ip/CGmbmYIg37T++h68gYRFqEfDG90BUmOFc68w0GO/S
         ettKAnFDAZTYWs4QHF65L1q0nybhUF922TdfKp+vsUfLgVudUIwtWzvwjcEUFh+8fNZ7
         prBPqDiONIrMJTkeoEdvHGcGfaa0pHwCdCyq8MuTlTm58Qq2X11jBegoVE3a1j5h3ozY
         A38LZ7cXEzhXQJa2aFZxvYUeiPEJBTh0U5fzeUVEk/cFPRxtLBqLzdDbjpXHGqvTn4TJ
         nd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=seO5pYUVOppQz0bc69tFmfcD8uMCJdgzegwYSbd9RdE=;
        b=mEXDE3r23KjQlpNDPZWJCIuHyEBHRw8EPS0H1s3JKKt634yCXKaYas7+FWuNHzvjn6
         CVDZ93vzE2vsA2eefLo0W+w+yJWXFn/zxDSsGnNTh+WWJ5YMvoQJknJmv9KBOb0yMr6q
         Sl3AmUurG108u+9Gi8G0HACo4UPhMNumjh6BOjT1gpzJzzQSu5hHdVAJnc6z9WsDS7hK
         hoDS7XgIKMN9s+fjXx0HRX+I/974APk55fGMbE2H4c0ZWjSLonNUVxZZhGNouZvGwfhw
         KIsX+uFsJdXDDbqPqZ2J8/E01/DQ0ruHczpNc1VMgruJLOrgup/F/aZh6pYMFX2f/tKR
         d2KQ==
X-Gm-Message-State: AA+aEWZp+Sy24ohaYtvHk102SDEgDlt5SE9JnydH4QyCIw9pIRmcEsfd
        Q1xMSGJsXM0jHbMx7Q9nzzA=
X-Google-Smtp-Source: AFSGD/Va53jognD9+iCi8cEvNeG+inGjEODlhx7tRnbyAK+kdIh0FsDfdvRWXBmnCHgLJojk1AD+zQ==
X-Received: by 2002:a1c:dd06:: with SMTP id u6mr11343522wmg.81.1544470938525;
        Mon, 10 Dec 2018 11:42:18 -0800 (PST)
Received: from osboxes.localdomain (bzq-109-67-225-236.red.bezeqint.net. [109.67.225.236])
        by smtp.googlemail.com with ESMTPSA id t4sm14565082wrm.6.2018.12.10.11.42.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 11:42:17 -0800 (PST)
From:   Carmeli Tamir <carmeli.tamir@gmail.com>
To:     hirofumi@mail.parknet.co.jp, jthumshirn@suse.de,
        sergey.senozhatsky@gmail.com, akpm@linux-foundation.org,
        axboe@kernel.dk, martin.petersen@oracle.com, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, carmeli.tamir@gmail.com
Subject: [PATCH 0/2] fat: Added macros to determine the FAT FS variant (12/16/32bit)
Date:   Mon, 10 Dec 2018 14:41:55 -0500
Message-Id: <1544470917-6443-1-git-send-email-carmeli.tamir@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Along the FAT FS code, the FAT variant (whether this is FAT12, FAT16 or FAT32) is
determined by checking the fat_bits field of struct msdos_sb_info. 
This is somewhat error prone as it forces the usage of magics (12, 16, 32)
multiple times in the code.

This series replaces the places in which the variant is checked with three simple
macros - IS_FAT12, IS_FAT16 and IS_FAT16.

The introduction of these simple macros makes a clearer API for determining the variant,
rather than searching the code for some field in a struct, and therefore
increases the code's maintainability and readability.

Carmeli Tamir (2):
  fat: Moved macros that won't work without fat.h
  fat: New macros to determine the FAT variant (32, 16 or 12)

 fs/fat/cache.c                |  2 +-
 fs/fat/dir.c                  |  4 ++--
 fs/fat/fat.h                  | 28 ++++++++++++++++++++++------
 fs/fat/fatent.c               | 17 +++++++----------
 fs/fat/inode.c                | 12 ++++++------
 fs/fat/misc.c                 |  2 +-
 include/uapi/linux/msdos_fs.h |  5 -----
 7 files changed, 39 insertions(+), 31 deletions(-)

-- 
2.7.4

