Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C71C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46B620811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C46B620811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbeLLSy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:54:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:46508 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726232AbeLLSy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:54:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 919C5AEE4;
        Wed, 12 Dec 2018 18:54:25 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, stefan.wahren@i2se.com, eric@anholt.net,
        gregkh@linuxfoundation.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Subject: [PATCH 0/3] staging: vchiq: fix completion routines & semaphores
Date:   Wed, 12 Dec 2018 19:51:32 +0100
Message-Id: <20181212185136.6620-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As pointed out by Arnd Bergman[1] there where some issues on how I
converted semaphores to completion routines. I wasn't aware of a
macro override happening in vchiq_killable.h, which was changing
down_interruptible()'s meaning.

This patch changes all completions so they use the proper APIs and gets
rid of vchiq_killable.h. I took into account Arnd's commit to avoid
merge conflicts.

[1] https://www.spinics.net/lists/arm-kernel/msg694422.html
===

Nicolas Saenz Julienne (3):
  staging: vchiq: switch to wait_for_completion_killable
  staging: vchiq_2835_arm: quit using custom down_interruptible()
  staging: vchiq: delete vchiq_killable.h

 .../interface/vchiq_arm/vchiq_2835_arm.c      |  3 +-
 .../interface/vchiq_arm/vchiq_arm.c           | 22 ++++----
 .../interface/vchiq_arm/vchiq_connected.c     |  1 -
 .../interface/vchiq_arm/vchiq_core.c          | 22 ++++----
 .../interface/vchiq_arm/vchiq_killable.h      | 55 -------------------
 .../interface/vchiq_arm/vchiq_util.c          |  7 +--
 6 files changed, 24 insertions(+), 86 deletions(-)
 delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_killable.h

-- 
2.19.2

