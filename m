Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37AAC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481362082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 481362082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbeJ3DDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:03:44 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:41185 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728530AbeJ3DDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:03:44 -0400
X-Originating-IP: 2.224.242.101
Received: from w540.lan (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id DDD0940003;
        Mon, 29 Oct 2018 18:13:55 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     geert+renesas@glider.be, laurent.pinchart@ideasonboard.com,
        horms@verge.net.au
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>, linus.walleij@linaro.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] pinctrl: sh-pfc: r8a77965: Add VIN4 and VIN5
Date:   Mon, 29 Oct 2018 19:13:42 +0100
Message-Id: <1540836824-4636-1-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
   this two patches add supports for VIN4 and VIN5 interfaces to R-Car M3-N.

On this SoC (and in the forthcoming support for E3 R8A77990) the VIN groups
could appear on different sets of pins, usually the 'a' and 'b' one.

With the existing VIN_DATA_PIN_GROUP macro we have to specify group names as:

VIN_DATA_PIN_GROUP(vin4_data_a, 8)

which results in the group being named as "vin4_data_a_8" which is
un-consistent with the canonical group names (eg. "vin4_data8_a").

This series adds a macro that allows to specify the group 'version' along with
the pin and mux numbers in patch [1/1]. I haven't been able to find a better
term than 'version' as 'group' was already taken. Suggestions welcome.

As I cannot test VIN4 nor VIN5 on Salvator-XS as the parallel pins are not
wired, I made sure the macro creates correct names and fields not only by
compile testing it, but with a small C program [1] that replicates the VIN data
layout defined in the PFC module and access fields (and has helped me testing
more easily the preprocessor stringification/concatenation process).

Final note: Simon, you took the E3 patches in your tree, and I expect them to
land on v4.20-rc1. They use the old macros, are follow up patches ok?)

Thanks
   j

[1] https://paste.debian.net/1049603/

Jacopo Mondi (2):
  pinctrl: sh-pfc: Introduce VIN_DATA_PIN_GROUP_VER
  pinctrl: sh-pfc: r8a77965: Add VIN[4|5] groups/functions

 drivers/pinctrl/sh-pfc/pfc-r8a77965.c | 254 ++++++++++++++++++++++++++++++++++
 drivers/pinctrl/sh-pfc/sh_pfc.h       |  20 ++-
 2 files changed, 269 insertions(+), 5 deletions(-)

--
2.7.4

