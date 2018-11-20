Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A12C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE862145D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE862145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbeKUIIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 03:08:09 -0500
Received: from mga17.intel.com ([192.55.52.151]:35018 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbeKUIIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 03:08:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 13:36:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,258,1539673200"; 
   d="scan'208";a="281632602"
Received: from pmvancle-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.10.84])
  by fmsmga005.fm.intel.com with ESMTP; 20 Nov 2018 13:36:55 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        liam.r.girdwood@linux.intel.com, andriy.shevchenko@linux.intel.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 0/6] ASoC:Intel:Skylake: Enable HDaudio legacy fallback
Date:   Tue, 20 Nov 2018 15:36:38 -0600
Message-Id: <20181120213644.19103-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is provided as an RFC and should not be merged as is
(Turkey break in the USA and more validation needed). This is however
a good time to gather comments. This work is the result of multiple
email discussions to finally provide more flexibility for
distributions to chose whether to stick with the legacy HDaudio driver
or to enable the SST/Skylake driver for newer platforms (required
e.g. for digital microphone support)

The patches add support for CoffeeLake, simplify the probe for the
Skylake driver, introduce more compile-time granularity so that
platforms can be selected individually and last provide a dynamic
fallback mechanism when two drivers are registered for the same PCI
ID.

When the SOF driver is released, the same mechanism will be used to
enable the SOF-legacy fallback. There will be no plans to enable an
SOF->SST falback.

Pierre-Louis Bossart (4):
  ASoC: Intel: Skylake: stop init/probe if DSP is not present
  ASoC: Intel: Skylake: remove useless tests on DSP presence
  ASoC: Intel: Skylake: Add more platform granularity
  ALSA: hda: add fallback capabilities for SKL+ platforms

Takashi Iwai (2):
  ASoC: Intel: Skylake: Add CFL-S support
  ALSA: hda: Allow fallback binding with legacy HD-audio for Intel SKL+

 include/sound/hdaudio.h                |   6 +
 sound/pci/hda/Kconfig                  |  40 +++++++
 sound/pci/hda/hda_controller.h         |   2 +-
 sound/pci/hda/hda_intel.c              |  51 ++++++--
 sound/soc/intel/Kconfig                |  86 ++++++++++++--
 sound/soc/intel/boards/Kconfig         |  16 ++-
 sound/soc/intel/skylake/skl-messages.c |   8 ++
 sound/soc/intel/skylake/skl.c          | 154 +++++++++++++++++++------
 8 files changed, 311 insertions(+), 52 deletions(-)

-- 
2.17.1

