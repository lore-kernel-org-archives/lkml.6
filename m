Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A30C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C7E20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C7E20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbeGYO43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 10:56:29 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:53195 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbeGYO43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 10:56:29 -0400
X-Originating-IP: 2.224.242.101
Received: from w540.lan (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id D3BAEC0019;
        Wed, 25 Jul 2018 13:44:39 +0000 (UTC)
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     mchehab@kernel.org, sakari.ailus@iki.fi,
        kieran.bingham@ideasonboard.com
Cc:     Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [v2 0/2] media: i2c: mt9v111 sensor driver
Date:   Wed, 25 Jul 2018 15:44:29 +0200
Message-Id: <1532526271-19639-1-git-send-email-jacopo@jmondi.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
   this is a sensor level driver for Aptina MT9V111.

Compared to v1 the biggest difference is that now auto-exposure and
auto-white-balancing are exposed through the v4l2-ctrl framework, and can be
activated/deactivated by the user.

For this reason, while auto-exposure algorithm still controls the frame rate in
low light conditions, the driver now enables it by default and let the user
disable it to more precisely control the framerate.

(Most of the) comments from Sakari and Kieran have been addressed, see changelog
for a more precise list.

Tested VGA, QVGA QQVGA resolutions at 5, 10, 15 and 30 frame per second.

v4l2-compliance fails on some tests, and I've not been able to identify what's
wrong with the driver. Copy of the failures reported here below:

fail: v4l2-test-subdevs.cpp(69): doioctl(node, VIDIOC_SUBDEV_ENUM_FRAME_INTERVAL, &fie) != EINVAL
fail: v4l2-test-subdevs.cpp(180): ret && ret != ENOTTY
fail: v4l2-test-subdevs.cpp(248): ret && ret != ENOTTY
test Active VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: FAIL

I've found no mention of ENOTTY to be reported by enum_frame_interval in the
documentation, but apparently v4l2-compliance checks for that.

v1: https://lkml.org/lkml/2018/6/11/467

Thanks
   j

v1 -> v2:
- Addressed syntax mistakes pointed out by Kieran
- Drop spinlock around address space change
- Extend mutex to cover frame rate and format get/set operations
- Add controls for auto-exposure and auto-white-balancing
- Move MAINTAINERS modifications to bindings patch
- Fix resolution in bindings document
- Drop dependency on OF
- Drop subdev 'open' function in favour of pad operation init_cfg and use a
  default configuration to initialize the sensor
- Turn off power if sensor identification fails

Jacopo Mondi (2):
  dt-bindings: media: i2c: Document MT9V111 bindings
  media: i2c: Add driver for Aptina MT9V111

 .../bindings/media/i2c/aptina,mt9v111.txt          |   46 +
 MAINTAINERS                                        |    8 +
 drivers/media/i2c/Kconfig                          |   11 +
 drivers/media/i2c/Makefile                         |    1 +
 drivers/media/i2c/mt9v111.c                        | 1299 ++++++++++++++++++++
 5 files changed, 1365 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/aptina,mt9v111.txt
 create mode 100644 drivers/media/i2c/mt9v111.c

--
2.7.4

