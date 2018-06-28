Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10295C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4517D2240B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="G+S5nWa7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4517D2240B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934708AbeF1INj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 04:13:39 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:49398 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934056AbeF1INg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 04:13:36 -0400
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 93CD75C0070;
        Thu, 28 Jun 2018 10:13:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1530173614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=EUHUXhhEy2o4J5rrnu5f10WOpSCVshkBgwpdYeho8qw=;
        b=G+S5nWa7BC1oGg91/vREjHMw1r3w6SY//3A26XYBnkK+ZhYIIMJPGcD6/CAyILJWJDTwTV
        jAtA8/av1Q8/5TialYFUfJmxel2newrytQOfn3i3kHOihpaLqDWmbr5u2wTa/Rqae72Vz9
        6p3TanBQkgD9HRI0gEoenrppaWg2l1g=
From:   Stefan Agner <stefan@agner.ch>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     fabio.estevam@nxp.com, haibo.chen@nxp.com, aisheng.dong@nxp.com,
        michael@amarulasolutions.com, rmk+kernel@armlinux.org.uk,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 0/3] mmc: sdhci-esdhc-imx: fix no UHS modes
Date:   Thu, 28 Jun 2018 10:13:28 +0200
Message-Id: <20180628081331.13051-1-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
X-Spamd-Result: default: False [-0.53 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-1.43)[91.14%];
         TAGGED_RCPT(0.00)[kernel];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[10];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MID_CONTAINS_FROM(1.00)[];
         ASN(0.00)[asn:6830, ipnet:46.140.0.0/17, country:AT];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently sdhci-esdhc-imx.c sets SDHCI_QUIRK2_NO_1_8_V if no
100MHz/200MHz pinctrl configurations are present in order to
prevent the stack from choosing high speed modes.

This does work for SD cards quite well, since 1.8V matches all
higher speed modes, and all lower speed modes run with 3.3V.

However, when running a eMMC on 1.8V only, this causes issues:
If vqmmc-supply is set to 1.8V only, and the driver at the same
time sets SDHCI_QUIRK2_NO_1_8_V, the stack has troubls selecting
a valid mode and continuously prints:
  mmc1: Switching to 3.3V signalling voltage failed

There are already board device trees which work around this by
not setting vqmmc-supply, e.g.
arch/arm/boot/dts/imx6qdl-sr-som-ti.dtsi.

Introducing a new quirk was the only way which I came up with,
but maybe there is a better way to prevent higher speed modes
while allowing 1.8V eMMC?

Stefan Agner (3):
  mmc: sdhci-esdhc-imx: get rid of support_vsel
  mmc: sdhci: add quirk to prevent higher speed modes
  mmc: sdhci-esdhc-imx: prevent stack from using higher speed modes

 drivers/mmc/host/sdhci-esdhc-imx.c          | 12 ++++--------
 drivers/mmc/host/sdhci.c                    |  8 ++++++++
 drivers/mmc/host/sdhci.h                    |  2 ++
 include/linux/platform_data/mmc-esdhc-imx.h |  2 --
 4 files changed, 14 insertions(+), 10 deletions(-)

-- 
2.18.0

