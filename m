Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0FBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA8F20672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T26+PCyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA8F20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbeKZTVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:21:44 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45332 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbeKZTVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:21:44 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so13497426plm.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 00:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VkXkOn/FIUa4MSfzquiFq2NHsW/QxC2cM7bzOac3mzA=;
        b=T26+PCytcCEQXc14N1V4l15wGkwVlcQ8ENqjmEcRZNDCGM1flxVazMC2AudLnPlzKB
         8v0MqDLBkkQwj0kNT4PFLMNDoadTem1sdfQ7ZJ1rnaAg5IMJ0DOJ15cM/6//OUcEi7qX
         KnDkV7SqxkOSLfaw/k13Qk7OmR0bVBYlQDOTKkab5uKKYVDH2+3gtjw0ARs6qG3GMvaR
         D4iEh2VpBpwihOAXlTZUvMh/IRDGrQckVG/vOXI4AkMH2FbmhWzOGpa/GTQSCBM9eU81
         TUTtbrbKh/BIU5ynKEKoS0i7EJuP+F0YVxDWE6ttGU2w/NWFJIKBfzT8lIJsDqE1CsXB
         hgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=VkXkOn/FIUa4MSfzquiFq2NHsW/QxC2cM7bzOac3mzA=;
        b=bh9jJJx/ij6eFLszzBou5uTevxPnTKrV2XtuYjC7MmT9lU2fhF943WMC7IOZk8b+xp
         7zMizLrwO+04U9XVOd7R9QR4sabzE4/uaYqmkjJWPj07yaQ8SA9HdEFKf8XqeJfRieXO
         +3NPy0NJ4d2aHDTUckRNXEmFgmbTKnYJ4ZMB/1wjYfqsukd2I2+/aGRbQRqhFNhDfUfo
         KTqsR4GM9SvXlMzis30Z6tcia85p9SVoXYZPXK3OL+l5NpK6pSeTB+1PkIzO5r9oMRS/
         VDfSd3c4RvsMK2q2yBWFA5ZTssb0FY87+ysRgC4SF39VyRra4DFlBrY5Y1vBb7TeXnIF
         DVgQ==
X-Gm-Message-State: AA+aEWbPvtjhYFqBcwjPA5HkfV6QLPp/cDGjSlQuDHUPzSxAW7q7Cxo3
        yNyhDQt9g/L1LsLZA13cqHnbDt1PiRc=
X-Google-Smtp-Source: AFSGD/VHTbsI6csIs9zP0OGbh97xlV6MGYHupUhOK4bwvCZ00ctOStyzT8nokAWwFq/2EvG7vgRYjg==
X-Received: by 2002:a17:902:e18c:: with SMTP id cd12mr10515454plb.279.1543220901701;
        Mon, 26 Nov 2018 00:28:21 -0800 (PST)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id j197sm82846611pgc.76.2018.11.26.00.28.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 00:28:20 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2 0/7] zram idle page writeback
Date:   Mon, 26 Nov 2018 17:28:06 +0900
Message-Id: <20181126082813.81977-1-minchan@kernel.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inherently, swap device has many idle pages which are rare touched since
it was allocated. It is never problem if we use storage device as swap.
However, it's just waste for zram-swap.

This patchset supports zram idle page writeback feature.

* Admin can define what is idle page "no access since X time ago"
* Admin can define when zram should writeback them
* Admin can define when zram should stop writeback to prevent wearout

Detail is on each patch's description.

Below first two patches are -stable material so it could go first
separately with others in this series.

  zram: fix lockdep warning of free block handling
  zram: fix double free backing device

* from v1
  - add fix dobule free backing device - minchan
  - change writeback/idle interface - minchan 
  - remove direct incompressible page writeback - sergey

Minchan Kim (7):
  zram: fix lockdep warning of free block handling
  zram: fix double free backing device
  zram: refactoring flags and writeback stuff
  zram: introduce ZRAM_IDLE flag
  zram: support idle/huge page writeback
  zram: add bd_stat statistics
  zram: writeback throttle

 Documentation/ABI/testing/sysfs-block-zram |  32 ++
 Documentation/blockdev/zram.txt            |  51 +-
 drivers/block/zram/Kconfig                 |   5 +-
 drivers/block/zram/zram_drv.c              | 516 +++++++++++++++------
 drivers/block/zram/zram_drv.h              |  18 +-
 5 files changed, 463 insertions(+), 159 deletions(-)

-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

