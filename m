Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1ADC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFEBA20868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFEBA20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbeJZWZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 18:25:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:44726 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726014AbeJZWZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 18:25:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CAF8BAF62;
        Fri, 26 Oct 2018 13:48:29 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     stefan.wahren@i2se.com, eric@anholt.net,
        dave.stevenson@raspberrypi.org
Cc:     nsaenzjulienne@suse.de, linux-rpi-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 00/18] staging: vchiq: remove dead code & misc fixes
Date:   Fri, 26 Oct 2018 15:47:55 +0200
Message-Id: <20181026134813.7775-1-nsaenzjulienne@suse.de>
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

It's an RFC for various reasons, first I think it's going to clash with
the last Stefan's series. Also I'm not used to doing big series.

The main focus was to delete as much code as possible, I've counted
around 550 lines, which is not bad. Apart from that there are some
patches enforcing proper kernel APIs usage.

The only patch that really changes code is the
vchiq_ioc_copy_element_data() rewrite, I was having doubts whether to
add it into the series, but since it's a RFC, I don't think it hurts.

The last commit updates the TODO list with some of my observations, I
realise some of the might be a little opinionated. If anything it's
going to force a discussion on the topic, which is nice.

The series was developed on top of linux-next, and was tested on a
RPIv3B+ with audio, video and running vchiq_test.

Regards,
Nicolas

===

Nicolas Saenz Julienne (18):
  staging: vchiq_core: rework vchiq_get_config
  staging: vchiq_arm: rework close/remove_service IOCTLS
  staging: vchiq_shim: delete vchi_service_create
  stagning: vchiq_arm: use list_for_each_entry when accessing
    bulk_waiter_list
  staging: vchiq_arm: get rid of vchi_mh.h
  staging: vchiq_arm: rework vchiq_ioc_copy_element_data
  staging: vchiq-core: get rid of is_master distinction
  staging: vchiq_core: remove unnecessary safety checks in
    vchiq_init_state
  staging: vchiq_core: do not initialize semaphores twice
  staging: vchiq_core: don't add a wmb() before remote_event_signal()
  staging: vchiq_arm: use completions instead of semaphores
  staging: vchiq_util: use completions instead of semaphores
  staging: vchiq_core: use completions instead of semaphores
  staging: vchiq_util: get rid of unneeded memory barriers
  stagning: vchiq_core: fix logic redundancy in parse_open
  staging: vchiq_arm: rework probe and init functions
  staging: vchiq_arm: fix open/release cdev functions
  staging: vchiq: add more tasks to the TODO list

 .../staging/vc04_services/interface/vchi/TODO |  46 +-
 .../vc04_services/interface/vchi/vchi.h       |   8 -
 .../vc04_services/interface/vchi/vchi_mh.h    |  42 --
 .../interface/vchiq_arm/vchiq_2835_arm.c      |  18 +-
 .../interface/vchiq_arm/vchiq_arm.c           | 598 ++++++++----------
 .../interface/vchiq_arm/vchiq_core.c          | 511 +++------------
 .../interface/vchiq_arm/vchiq_core.h          |  47 +-
 .../interface/vchiq_arm/vchiq_if.h            |  11 +-
 .../interface/vchiq_arm/vchiq_shim.c          |  32 -
 .../interface/vchiq_arm/vchiq_util.c          |  48 +-
 .../interface/vchiq_arm/vchiq_util.h          |   6 +-
 11 files changed, 429 insertions(+), 938 deletions(-)
 delete mode 100644 drivers/staging/vc04_services/interface/vchi/vchi_mh.h

-- 
2.19.1

