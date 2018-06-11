Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Py3eMIZeHltcNAAAmS7hNA
	; Mon, 11 Jun 2018 11:36:11 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 05BF4607E4; Mon, 11 Jun 2018 11:36:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5F4DF601C3;
	Mon, 11 Jun 2018 11:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F4DF601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=lucaceresoli.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932950AbeFKLgI (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:36:08 -0400
Received: from srv-hp10-72.netsons.net ([94.141.22.72]:52260 "EHLO
        srv-hp10-72.netsons.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932894AbeFKLgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:36:07 -0400
Received: from [109.168.11.45] (port=54392 helo=pc-ceresoli.dev.aim)
        by srv-hp10.netsons.net with esmtpa (Exim 4.89_1)
        (envelope-from <luca@lucaceresoli.net>)
        id 1fSL7C-00B1A2-B8; Mon, 11 Jun 2018 13:36:02 +0200
From: Luca Ceresoli <luca@lucaceresoli.net>
To: linux-media@vger.kernel.org
Cc: Luca Ceresoli <luca@lucaceresoli.net>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Leon Luo <leonl@leopardimaging.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/8] media: imx274: cleanups, improvements and SELECTION API support
Date: Mon, 11 Jun 2018 13:35:31 +0200
Message-Id: <1528716939-17015-1-git-send-email-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - srv-hp10.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: srv-hp10.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: srv-hp10.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patchset introduces cropping support for the Sony IMX274 sensor
using the SELECTION API.

With respect to v3, this version uses the SELECTION API with taget
V4L2_SEL_TGT_COMPOSE to change the output resolution. This is the
recommended API for cropping + downscaling. However for backward
compatibility the set_format callback is still supported and is
equivalent to setting the compose rect as far as resolutions are
concerned.

Patches 1-5 are overall improvements and restructuring, mostly useful
to implement the SELECTION API in a clean way.

Patch 6 introduces a helper to allow setting many registers computed
at runtime in a straightforward way. This would not have been very
useful before because all long register write sequences came from
const tables, but it's definitely a must for the cropping code where
several register values are computed at runtime.

Patch 7 is new in this series, it's a trivial typo fix that can be
applied independently.

Patch 8 implements the set_selection pad operation for cropping
(V4L2_SEL_TGT_CROP) and binning (V4L2_SEL_TGT_COMPOSE). The most
tricky part was respecting all the device constraints on the
horizontal crop.

Usage examples:

 * Capture the entire 4K area, downscaled to 1080p with 2:1 binning:
   media-ctl -V '"IMX274":0[crop:(0,0)/3840x2160]'
   media-ctl -V '"IMX274":0[compose:(0,0)/1920x1080]'

 * Capture the central 1080p area (no binning):
   media-ctl -V '"IMX274":0[crop:(960,540)/1920x1080]'
   (this also sets the compose and fmt rects to 1920x1080)

Regards,
Luca


Luca Ceresoli (8):
  media: imx274: initialize format before v4l2 controls
  media: imx274: consolidate per-mode data in imx274_frmfmt
  media: imx274: get rid of mode_index
  media: imx274: actually use IMX274_DEFAULT_MODE
  media: imx274: simplify imx274_write_table()
  media: imx274: add helper function to fill a reg_8 table chunk
  media: imx274: fix typo
  media: imx274: add SELECTION support for cropping

 drivers/media/i2c/imx274.c | 686 ++++++++++++++++++++++++++++++---------------
 1 file changed, 461 insertions(+), 225 deletions(-)

-- 
2.7.4
