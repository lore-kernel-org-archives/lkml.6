Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B372ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28B9208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="KWh8cGcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D28B9208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbeGMJCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:02:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32933 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbeGMJCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:02:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id r5-v6so4745491pgv.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 01:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DM2dMGG1QK4kyotAoOVswElsG8eILGA3The5KTRyMw4=;
        b=KWh8cGcpw/vxxIka/2kPIpCWiRzP//D7CuYhin1HOoQivxC0tKlKYuIiKNrLgvEARu
         A0DBQgri26L8qLebx58IyCU9AcdgHch3qPo7azOULXZArQ5RraMwideYxUy0YmNKbtNf
         l4m2hYUBA5UrIEYFnVWj117o9Ilo1KcaT1/R1qO740P90AGw2tZD8d79KRkTgIX+c+BN
         Vi0r6nFr6Z5t65E7r2daZLVyYqOml6bZnCmChAZEX4k1MSpvgfhmsjhrWoGuCofwJ5OI
         PHC2h8wLBEHeYmU/UNUPQF7InWsqLnBWlhDmiewBg7S6FlfoMvyK7cMG2pAZR8Ru4TxK
         +T8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DM2dMGG1QK4kyotAoOVswElsG8eILGA3The5KTRyMw4=;
        b=h5Ez8jhNv+UtQtoOcN3FOCr2cD5H48AUKGeww8DaY3xzNsIDaEAcG0hk2+30ypi2dJ
         4nKLR3bYZvS9vaN0Ln5ZITRtrvg0r1xfo+bDzXndlMTl23HaZDq7t6ezUkwOpQPRsyol
         urAwyScNGKKpiAxSakK3T9Y+tWN01R+/qyPpX5YwcJzRxJDWeU44MT7rEBkV5ZVbZ0cl
         UvHLbbq8bb9YU1+tp4gjVwmFumRwW7H8bdwYlKs6+L/VDnYWQ24eUFLs5w5/iwS8EgMW
         6X6qawSLktUqMWPrCCrfgnwXf4byo5zZKrSUr4nk5IMF+XShWBhiuhNRk9fC/sZDqkf8
         m4Vg==
X-Gm-Message-State: AOUpUlEn+5XqPOQjXVa5JCsg17SbXAWbH6+gtHtODJjBm19SX8Il9eRv
        +nFAG8W8AfH61QZzXQoi8bmRQg==
X-Google-Smtp-Source: AAOMgpfTZVp8GaF4nzWR5RSSLK1/xVA8QJ1HlPgJDGejQNosOiqlXUUpoCUUhGIk8XRqXgT8Oyvi2Q==
X-Received: by 2002:a62:642:: with SMTP id 63-v6mr6152178pfg.222.1531471747733;
        Fri, 13 Jul 2018 01:49:07 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id d18-v6sm569357pgo.74.2018.07.13.01.49.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 01:49:06 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bart.vanassche@wdc.com, hans.holmberg@cnexlabs.com,
        javier@cnexlabs.com, hlitz@ucsc.edu, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 00/10] lightnvm updates for 4.19
Date:   Fri, 13 Jul 2018 10:48:35 +0200
Message-Id: <20180713084845.19511-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

Please pick up the following patches for 4.19.

 - A couple of small fixes from Bart, Gustavo, Hans and me.
 - Heiner has reworked the read path to issue reads in parallel on
   partial reads.
 - Marcin fixed up the case where a device does need a host-side
   cache to provide reliability.
 - I added device description to error messages in pblk,
   moved the compile DEBUG option to be pblk only, and limited the
   report chunk command size.

Thanks, Matias

Bart Van Assche (1):
  lightnvm: Remove redundant rq->__data_len initialization

Gustavo A. R. Silva (1):
  lightnvm: pblk: mark expected switch fall-through

Hans Holmberg (1):
  lightnvm: pblk: assume that chunks are closed on 1.2 devices

Heiner Litz (1):
  lightnvm: pblk: add asynchronous partial read

Marcin Dziegielewski (1):
  lightnvm: pblk: handle case when mw_cunits equals to 0

Matias Bjørling (5):
  lightnvm: move NVM_DEBUG to pblk
  lightnvm: pblk: enable line minor version detection
  lightnvm: pblk: fix read_bitmap for 32bit archs
  lightnvm: limit get chunk meta request size
  lightnvm: pblk: expose generic disk name on pr_* msgs

 drivers/lightnvm/Kconfig         |  32 +++---
 drivers/lightnvm/pblk-cache.c    |   4 +-
 drivers/lightnvm/pblk-core.c     |  78 +++++++------
 drivers/lightnvm/pblk-gc.c       |  34 +++---
 drivers/lightnvm/pblk-init.c     | 102 +++++++++--------
 drivers/lightnvm/pblk-rb.c       |  24 ++--
 drivers/lightnvm/pblk-read.c     | 242 ++++++++++++++++++++++++---------------
 drivers/lightnvm/pblk-recovery.c |  47 ++++----
 drivers/lightnvm/pblk-sysfs.c    |  13 +--
 drivers/lightnvm/pblk-write.c    |  35 +++---
 drivers/lightnvm/pblk.h          |  48 +++++---
 drivers/nvme/host/lightnvm.c     |  16 ++-
 12 files changed, 382 insertions(+), 293 deletions(-)

-- 
2.11.0

