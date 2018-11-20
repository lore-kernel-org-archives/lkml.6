Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D0BC18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685C920870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 685C920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbeKUBXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:23:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:39164 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726557AbeKUBXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:23:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ABB74AC24;
        Tue, 20 Nov 2018 14:54:06 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     stefan.wahren@i2se.com, eric@anholt.net,
        dave.stevenson@raspberrypi.org
Cc:     linux-rpi-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 00/16] staging: vchiq: dead code removal & misc fixes
Date:   Tue, 20 Nov 2018 15:53:35 +0100
Message-Id: <20181120145351.30390-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This series was written in parallel with reading and understanding the
vchiq code. So excuse me for the lack of logic in the sequence of
patches.

The main focus was to delete as much code as possible, I've counted
around 550 lines, which is not bad. Apart from that there are some
patches enforcing proper kernel APIs usage.

The only patch that really changes code is the
vchiq_ioc_copy_element_data() rewrite.

The last commit updates the TODO list with some of my observations, I
realise some of the might be a little opinionated. If anything it's
going to force a discussion on the topic, which is nice.

It was developed on top of the latest linux-next, and was tested on a
RPIv3B+ with audio, video and running vchiq_test.

Regards,
Nicolas

RFC -> PATCH, as per Stefan's comments:
  - Remove semaphore initialization from remove_event_create()
    (commit 9)
  - Join all three semaphore to completion patches (commit 11)
  - Update probe/init commit message (commit 14)
  - Update TODO commit message and clean up (commit 16)
  - Fix spelling on some of the patches

===

Nicolas Saenz Julienne (16):
  staging: vchiq_core: rework vchiq_get_config
  staging: vchiq_arm: rework close/remove_service IOCTLS
  staging: vchiq_shim: delete vchi_service_create
  staging: vchiq_arm: use list_for_each_entry when accessing
    bulk_waiter_list
  staging: vchiq_arm: get rid of vchi_mh.h
  staging: vchiq_arm: rework vchiq_ioc_copy_element_data
  staging: vchiq-core: get rid of is_master distinction
  staging: vchiq_core: remove unnecessary safety checks in
    vchiq_init_state
  staging: vchiq_core: do not initialize semaphores twice
  staging: vchiq_core: don't add a wmb() before remote_event_signal()
  staging: vchiq: use completions instead of semaphores
  staging: vchiq_util: get rid of unneeded memory barriers
  staging: vchiq_core: fix logic redundancy in parse_open
  staging: vchiq_arm: rework probe and init functions
  staging: vchiq_arm: fix open/release cdev functions
  staging: vchiq: add more tasks to the TODO list

 .../staging/vc04_services/interface/vchi/TODO |  42 ++
 .../vc04_services/interface/vchi/vchi.h       |   8 -
 .../vc04_services/interface/vchi/vchi_mh.h    |  42 --
 .../interface/vchiq_arm/vchiq_2835_arm.c      |  18 +-
 .../interface/vchiq_arm/vchiq_arm.c           | 598 ++++++++----------
 .../interface/vchiq_arm/vchiq_core.c          | 523 ++++-----------
 .../interface/vchiq_arm/vchiq_core.h          |  47 +-
 .../interface/vchiq_arm/vchiq_if.h            |  11 +-
 .../interface/vchiq_arm/vchiq_shim.c          |  32 -
 .../interface/vchiq_arm/vchiq_util.c          |  48 +-
 .../interface/vchiq_arm/vchiq_util.h          |   6 +-
 11 files changed, 435 insertions(+), 940 deletions(-)
 delete mode 100644 drivers/staging/vc04_services/interface/vchi/vchi_mh.h

-- 
2.19.1

