Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AF8C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2564D24028
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2564D24028
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lucaceresoli.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753779AbeGEOip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:38:45 -0400
Received: from srv-hp10-72.netsons.net ([94.141.22.72]:36428 "EHLO
        srv-hp10-72.netsons.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753449AbeGEOin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:38:43 -0400
Received: from [109.168.11.45] (port=32854 helo=pc-ceresoli.dev.aim)
        by srv-hp10.netsons.net with esmtpa (Exim 4.91)
        (envelope-from <luca@lucaceresoli.net>)
        id 1fb5P6-007mVR-2X; Thu, 05 Jul 2018 16:38:40 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-media@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Leon Luo <leonl@leopardimaging.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] media: imx274: cleanups, improvements and SELECTION API support
Date:   Thu,  5 Jul 2018 16:38:07 +0200
Message-Id: <1530801489-29953-1-git-send-email-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.7.4
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

Changes since v4:

 - remove most of the preliminary cleanup patches that are now on the
   linuxtv master branch
 - the V4L2_SEL_FLAG_GE and V4L2_SEL_FLAG_LE flags are not honored
 - the prepare_reg() helper function is gone, replaced by a simpler
   approach to write a multibyte register

Patch 1 introduces a helper to greatly simplify the code to write a
multibyte register.

Patch 2 implements the set_selection pad operation for cropping
(V4L2_SEL_TGT_CROP) and binning (V4L2_SEL_TGT_COMPOSE).

Usage examples:

 * Capture the entire 4K area, downscaled to 1080p with 2:1 binning:
   media-ctl -V '"IMX274":0[crop:(0,0)/3840x2160]'
   media-ctl -V '"IMX274":0[compose:(0,0)/1920x1080]'

 * Capture the central 1080p area (no binning):
   media-ctl -V '"IMX274":0[crop:(960,540)/1920x1080]'
   (this also sets the compose and fmt rects to 1920x1080)

Regards,
Luca


Luca Ceresoli (2):
  media: imx274: use regmap_bulk_write to write multybyte registers
  media: imx274: add cropping support via SELECTION API

 drivers/media/i2c/imx274.c | 567 +++++++++++++++++++++++++++++++++------------
 1 file changed, 413 insertions(+), 154 deletions(-)

-- 
2.7.4

