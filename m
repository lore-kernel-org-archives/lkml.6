Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4474EC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 13:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA9B20652
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 13:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=obeliks.de header.i=@obeliks.de header.b="N2wSLhVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA9B20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nospam.obeliks.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeIHR7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 13:59:49 -0400
Received: from scopuli.esotechnik.de ([79.143.188.15]:46652 "EHLO
        mail.esotechnik.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeIHR7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 13:59:49 -0400
Received: by mail.esotechnik.net (Postfix) with ESMTPSA id 8C970AE0B80;
        Sat,  8 Sep 2018 15:14:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=obeliks.de; s=jul2017;
        t=1536412441; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=4LYnJKN3RypvOqGGkGutjgpp46TBCgCqN/j+QiBoP4E=;
        b=N2wSLhVXFYeIq0OniZuSAg7/yuODkDGiyqcSXwU+ZxivnUUoPDAECger5DUBi1m5n4H/rw
        Za0+ZWQW/SJU/2QINVoTxWviHZYzzt2uj/V94RqgTmzkQFwOMyJfhrngHc+lBELFxvDX7R
        71lgqqlavdvmT8C+CvLxVd6KYFpQYdRXMDmBlV+URFXkJ1nd/wqjfR0BJOK/seOxrcJTyc
        TWZZtbyKzIz5S56/+aRV2Y1bvFYUfVpsLlBq63o4rWmD1k/g76Riexohz52OFpxNHdVyGa
        0Zh/Rbt1LPFUQ5G8BKDaiurcFn5/6+OsdHV5daUrl/ArQqBQzbLaCrsx9IUsuA==
From:   Bernhard Frauendienst <kernel@nospam.obeliks.de>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Bernhard Frauendienst <kernel@nospam.obeliks.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] mtd concat device driver
Date:   Sat,  8 Sep 2018 15:13:42 +0200
Message-Id: <20180908131345.8145-1-kernel@nospam.obeliks.de>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

my router firmware concatenates two identical flash chips into a single
mtd using mtd_concat_create(), and sets up partitions in a way where one
of them crosses the chip boundary. When porting OpenWRT support for the
board from a mach-file based setup to a device-tree based one, I found
that there is no generic way to create a mtd_concat device from within
the dts. The following patches attempt to provide that possibility.

This is a third roll of that patch series, the first one can be seen at
[1]. The second one [2] was a blunder of my own making. Apologies for
not being able to address the correct recipients two times in a row.

In the first discussion, concerns were raised that a driver for a
"virtual" device like this might have no place in the device tree
system. However, I would argue that specifying a composite device is
very similar to specifying the partitions of a mtd, which can also done
in the device tree. In fact, I believe this is the only way to be able
to specify the partitions of such a concat device in the dts file (but
I'm happy to be corrected if I'm mistaken).
I have made the example in the dt-binding documentation a bit more
expressive in this detail.

In the second roll I have also addressed all issues that reviewers have
brought up so far, hopefully to their satisfaction. These were mainly
whitespace fixes and improved comments.

Best regards,
Bernhard

[1] http://lists.infradead.org/pipermail/linux-mtd/2018-September/083832.html
[2] https://lkml.org/lkml/2018/9/7/1015

Bernhard Frauendienst (3):
  mtd: core: add get_mtd_device_by_node
  dt-bindings: add bindings for mtd-concat devices
  mtd: mtdconcat: add dt driver for concat devices

 .../devicetree/bindings/mtd/mtd-concat.txt    |  36 +++++
 drivers/mtd/Kconfig                           |   2 +
 drivers/mtd/Makefile                          |   3 +
 drivers/mtd/composite/Kconfig                 |  12 ++
 drivers/mtd/composite/Makefile                |   6 +
 drivers/mtd/composite/virt_concat.c           | 128 ++++++++++++++++++
 drivers/mtd/mtdcore.c                         |  38 ++++++
 include/linux/mtd/mtd.h                       |   2 +
 8 files changed, 228 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/mtd-concat.txt
 create mode 100644 drivers/mtd/composite/Kconfig
 create mode 100644 drivers/mtd/composite/Makefile
 create mode 100644 drivers/mtd/composite/virt_concat.c

-- 
2.18.0

