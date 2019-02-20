Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D372EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32B72086D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfBTPwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:52:05 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:39377 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfBTPwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:52:05 -0500
X-Originating-IP: 90.88.23.190
Received: from localhost.localdomain (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 0E94FFF818;
        Wed, 20 Feb 2019 15:52:01 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v5 0/3] drm/vc4: Add a load tracker
Date:   Wed, 20 Feb 2019 16:51:21 +0100
Message-Id: <20190220155124.25022-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a fourth iteration of the VC4 load tracking series, which was
initially developed by Boris Brezillon and that I have now taken over.

This new iteration takes in account comments from v3 and comes with a
new approach for avoiding underrun reports when reconfiguring the
pipeline. It is now based on detection instead of delaying the underrun
interrupt unmasking.

It can be tested with a dedicated IGT GPU Tools series:
  VC4 load tracker testing

Changes since v4:
* Unmasked underrun in vc4_crtc_handle_page_flip instead of the previous
  workaround for detecting out-of-sync display lists causing underruns;
* Added comments where it felt relevant;
* Made underrun masking/unmasking per-channel to avoid race conditions
  resulting in unwanted masking/unmasking;
* Added a check for unmasked interrupt before acting upon it;
* Disabled shortline/underrun interrupts at initial config time;
* Added collected Reviewed-by tags.

Changes since v3:
* Returned IRQ_NONE for short line interrupt to avoid storm;
* Made register definitions with per-channel offsets more direct;
* cleaned all IRQ fields instead of writing back the status bit as
  advised by docs;
* Reworked first commit's message;
* Removed in-commit changelogs with inconsistent revision numbers;
* Removed explicit wait for sync before unmasking underrun interrupt;
* Checked that the display lists are synced before reporting underrun;

Cheers,

Paul

Boris Brezillon (2):
  drm/vc4: Report HVS underrun errors
  drm/vc4: Add a load tracker to prevent HVS underflow errors

Paul Kocialkowski (1):
  drm/vc4: Add a debugfs entry to disable/enable the load tracker

 drivers/gpu/drm/vc4/vc4_crtc.c    |   8 ++
 drivers/gpu/drm/vc4/vc4_debugfs.c |  10 +++
 drivers/gpu/drm/vc4/vc4_drv.c     |   1 +
 drivers/gpu/drm/vc4/vc4_drv.h     |  24 ++++++
 drivers/gpu/drm/vc4/vc4_hvs.c     |  95 +++++++++++++++++++++++
 drivers/gpu/drm/vc4/vc4_kms.c     | 122 +++++++++++++++++++++++++++++-
 drivers/gpu/drm/vc4/vc4_plane.c   |  57 ++++++++++++++
 drivers/gpu/drm/vc4/vc4_regs.h    |  51 ++++---------
 8 files changed, 332 insertions(+), 36 deletions(-)

-- 
2.20.1

