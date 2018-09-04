Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59D6C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0F920645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A0F920645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeIDUYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:24:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:50724 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726200AbeIDUYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:24:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 80CB9ADD6;
        Tue,  4 Sep 2018 15:59:01 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/29] staging: bcm2835-audio: Cleanups and fixes
Date:   Tue,  4 Sep 2018 17:58:29 +0200
Message-Id: <20180904155858.8001-1-tiwai@suse.de>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

since I had an opportunity to play with RPi3B+ recently, I took a look
at the existing bcm2835-audio driver code and was amused very much :)

So here is the result, a cleanup and fix patch series.

Most of the patches are trivial cleanups, just brushing up, removing
many redundant and buggy codes, as well as code simplifications.

A big functional change is that now it uses non-atomic PCM ops, so
that we can kill the ugly workqueue usages.  Also, the resource
management was simplified.

As a result, we can get rid of ca 1000 lines.  Not too bad.


Takashi

===

Takashi Iwai (29):
  staging: bcm2835-audio: Clean up mutex locks
  staging: bcm2835-audio: Remove redundant spdif stream ctls
  staging: bcm2835-audio: Clean up include files in bcm2835-ctl.c
  staging: bcm2835-audio: Remove redundant substream mask checks
  staging: bcm2835-audio: Fix mute controls, volume handling cleanup
  staging: bcm2835-audio: Remove redundant function calls
  staging: bcm2835-audio: Remove superfluous open flag
  staging: bcm2835-audio: Drop useless running flag and check
  staging: bcm2835-audio: Fix incorrect draining handling
  staging: bcm2835-audio: Kill unused spinlock
  staging: bcm2835-audio: Use PCM runtime values instead
  staging: bcm2835-audio: Drop unnecessary pcm indirect setup
  staging: bcm2835-audio: Drop useless NULL check
  staging: bcm2835-audio: Propagate parameter setup error
  staging: bcm2835-audio: Drop debug messages in bcm2835-pcm.c
  staging: bcm2835-audio: Drop superfluous mutex lock during prepare
  staging: bcm2835-audio: Add 10ms period constraint
  staging: bcm2835-audio: Make single vchi handle
  staging: bcm2835-audio: Code refactoring of vchiq accessor codes
  staging: bcm2835-audio: Operate non-atomic PCM ops
  staging: bcm2835-audio: Use card->private_data
  staging: bcm2835-audio: Use standard error print helpers
  staging: bcm2835-audio: Remove unnecessary header file includes
  staging: bcm2835-audio: Move module parameter description
  staging: bcm2835-audio: Use coherent device buffers
  staging: bcm2835-audio: Set SNDRV_PCM_INFO_SYNC_APPLPTR
  staging: bcm2835-audio: Simplify PCM creation helpers
  staging: bcm2835-audio: Simplify kctl creation helpers
  staging: bcm2835-audio: Simplify card object management

 .../vc04_services/bcm2835-audio/bcm2835-ctl.c | 235 ++---
 .../vc04_services/bcm2835-audio/bcm2835-pcm.c | 338 ++-----
 .../bcm2835-audio/bcm2835-vchiq.c             | 893 +++++-------------
 .../vc04_services/bcm2835-audio/bcm2835.c     | 222 ++---
 .../vc04_services/bcm2835-audio/bcm2835.h     |  85 +-
 5 files changed, 413 insertions(+), 1360 deletions(-)

-- 
2.18.0

