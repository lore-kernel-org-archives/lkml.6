Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03B7C46462
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E79320857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OpgjqZUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E79320857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732676AbeGaVeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:34:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37630 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732532AbeGaVd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:33:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id a26-v6so6607300pfo.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 12:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=J917hlJwULr6t35bbsk9fwjW3plGhyyNeLJG8ZXmTjQ=;
        b=OpgjqZUpWeCQ6UwzWFad6jiuh/ckBc14r8nRghS2td/IsdrW4tY+hCkyAKJTpl9FJo
         Z5Fow34Tp9z+nf43qI4H1eg34V0GomzGXyB3oPieidO+fAUEt74FwMk5+Y+0SUtxu7M2
         x5Kb4MVArmMVPrv6rdJ/xCZsI4fah4viA7TRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J917hlJwULr6t35bbsk9fwjW3plGhyyNeLJG8ZXmTjQ=;
        b=EQ1FuCedvUMJaKTytB4b1rUv8cJZ2DPHUkMFjX6NFKew8r2Xkh0Zg+NtXFDdR1en98
         WLeFosRj29c+OW3XwhJOhlzHPX2MMdFgXXfndKZ5HVCwzRPQvh3Hr3Y+5UJuof7XAy5I
         ydpQqHkOVLkU6LXY5U3GgvYfOG43rhLoCoj/wm4AjObD9XxA/Wps62n7owcp8CKWuWpb
         KGZ1g+SxhXS4rFKV6hfKDUpf0kDZPKxgjxo6tpFAZesm2xNTPJ/Ia0Ew+IfC6ShtjbRj
         wNtXe+X6hxo0W7S7S82eSB3GOtItyzyd3Q/3YZIBDzEzJ6mTt6ezsG9pOxBqbUZlQMjY
         vxog==
X-Gm-Message-State: AOUpUlEvJmV4fwYJFaxziGfwDm7M4aRwg7+U02VESBulLsu+PX7KT9EP
        vMPRVvH7QMXCubCmQmgSyc4hhw==
X-Google-Smtp-Source: AAOMgpeVu3iMR+3CLOFE11Z/sNMLVPJiJAYCNkdcT34WHwlsTmv9/rnXjevNuDqHUB1kDXrderLKLA==
X-Received: by 2002:a65:6143:: with SMTP id o3-v6mr22161045pgv.52.1533066726720;
        Tue, 31 Jul 2018 12:52:06 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id b62-v6sm32348115pfm.97.2018.07.31.12.52.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 12:52:02 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Kees Cook <keescook@chromium.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
        Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Juergen Gross <jgross@suse.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vinod Koul <vinod.koul@intel.com>,
        David Kershner <david.kershner@unisys.com>,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/9] block: Consolidate scsi sense buffer usage
Date:   Tue, 31 Jul 2018 12:51:45 -0700
Message-Id: <20180731195155.46664-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow-up to commit f7068114d45e ("sr: pass down correctly
sized SCSI sense buffer") which further cleans up and removes needless
sense character array buffers and "struct request_sense" usage in favor
of the common "struct scsi_sense_hdr".

First, drop a bunch of unused sense buffers:
 [PATCH 1/9] ide-cd: Drop unused sense buffers
 [PATCH 2/9] scsi: cxlflash: Drop unused sense buffers

Next, allow the sense buffer to be usable outside SCSI tree:
 [PATCH 3/9] scsi: build scsi_common.o for all scsi passthrough request users
 [PATCH 4/9] target: don't depend on SCSI

Then move all request_sense usage to scsi_sense_hdr:
 [PATCH 5/9] block: Switch struct packet_command to use struct scsi_sense_hdr

And do some further cleanups for scsi_sense_hdr now that we can:
 [PATCH 6/9] ide-cd: Remove redundant sense buffer
 [PATCH 7/9] cdrom: Use struct scsi_sense_hdr internally

Finally add a build-time check to make sure we don't pass bad buffer sizes:
 [PATCH 8/9] libata-scsi: Move sense buffers onto stack
 [PATCH 9/9] scsi: Check sense buffer size at build time


-Kees

Christoph Hellwig (2):
  scsi: build scsi_common.o for all scsi passthrough request users
  target: don't depend on SCSI

Kees Cook (7):
  ide-cd: Drop unused sense buffers
  scsi: cxlflash: Drop unused sense buffers
  block: Switch struct packet_command to use struct scsi_sense_hdr
  ide-cd: Remove redundant sense buffer
  cdrom: Use struct scsi_sense_hdr internally
  libata-scsi: Move sense buffers onto stack
  scsi: Check sense buffer size at build time

 drivers/Makefile                  |  2 +-
 drivers/ata/libata-scsi.c         | 18 +++------
 drivers/block/Kconfig             |  2 +-
 drivers/block/pktcdvd.c           | 36 +++++++++---------
 drivers/cdrom/cdrom.c             | 30 ++++++++-------
 drivers/ide/ide-cd.c              | 58 ++++++++++++++---------------
 drivers/ide/ide-cd.h              |  6 +--
 drivers/ide/ide-cd_ioctl.c        | 62 +++++++++++++------------------
 drivers/scsi/Makefile             |  2 +-
 drivers/scsi/cxlflash/superpipe.c |  8 +---
 drivers/scsi/cxlflash/vlun.c      |  7 +---
 drivers/scsi/scsi_lib.c           |  6 +--
 drivers/scsi/sr_ioctl.c           | 22 +++++------
 drivers/target/Kconfig            |  5 ++-
 include/linux/cdrom.h             |  3 +-
 include/scsi/scsi_cmnd.h          |  6 +--
 include/scsi/scsi_device.h        | 14 ++++++-
 17 files changed, 136 insertions(+), 151 deletions(-)

-- 
2.17.1

