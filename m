Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8228C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7901F2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=obeliks.de header.i=@obeliks.de header.b="ZA+th1bO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7901F2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nospam.obeliks.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbeIGWWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:22:42 -0400
Received: from scopuli.esotechnik.de ([79.143.188.15]:55560 "EHLO
        mail.esotechnik.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbeIGWWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:22:42 -0400
X-Greylist: delayed 325 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Sep 2018 18:22:41 EDT
Received: by mail.esotechnik.net (Postfix) with ESMTPSA id 22677AE0B80;
        Fri,  7 Sep 2018 19:35:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=obeliks.de; s=jul2017;
        t=1536341716; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=VdVLmCnfLqvEiEfXLye5tP73oQHmOZ7WHMmfVw8WW8s=;
        b=ZA+th1bOfhkXfs+jIHmm7/9RkbAVAU0rdge2J+8Sc8vz89poovL/IMhpBnhKyKZxOox+zo
        U4xRLp4s/1pSyiQWexl1rqvhI7wIWrqnf/vEEOpY6kBSiGG08AczJhObmTyY3SX26by9jb
        euIrAmnTIGxh6fRNAaJUBbR31+sO8UbW5a3TkDAIZ6sFWxvJOo97qjMcWJWSpWUxs7NhHI
        6Wqz5PFSXAw6BayVIYGzzTYLgAwlR5km2ZY7b2/TqFljRi0tDhPQeiiCoZoqx1GitVVp3A
        WiBeOPrLxBg/kUxks3149iEeRA5Wf8iZQQaJUdi0cLKpzBmUyResg6yqhw9dug==
From:   Bernhard Frauendienst <kernel@nospam.obeliks.de>
To:     linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 0/3] mtd concat device driver
Date:   Fri,  7 Sep 2018 19:35:12 +0200
Message-Id: <20180907173515.19990-1-kernel@nospam.obeliks.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

when porting my router board from a mach-file based OpenWRT target to a
device-tree based target, I found that there is no generic way to create
a mtd_concat device from within the dts. The following patches attempt
to provide that possibility.

This is a second roll of that patch series, the first one can be seen at
[1]. Apologies for not including the correct recipients in the first
roll.

In this first discussion, concerns were raised that a driver for a
"virtual" device like this might have no place in the device tree
system. However, I would argue that this very similar to specifying the
partitions of a mtd device, which can also done in the device tree. In
fact, I believe this is the only way to be able to specify the
partitions of such a concat device in the dts file (but I'm happy to be
corrected if I'm mistaken).
I have made the example in the dt-binding documentation a little bit
more expressive in this detail.

In this second roll I have also addressed all issues that reviewers have
brought up so far, hopefully to their satisfaction.

Best Regards
Bernhard

[1] http://lists.infradead.org/pipermail/linux-mtd/2018-September/083832.html

Bernhard Frauendienst (3):
  mtd: core: add get_mtd_device_by_node
  dt-bindings: add bindings for mtd-concat devices
  mtd: mtdconcat: add dt driver for concat devices

 .../devicetree/bindings/mtd/mtd-concat.txt    |  36 +++++
 drivers/mtd/Kconfig                           |   2 +
 drivers/mtd/Makefile                          |   3 +
 drivers/mtd/composite/Kconfig                 |  12 ++
 drivers/mtd/composite/Makefile                |   7 +
 drivers/mtd/composite/virt_concat.c           | 128 ++++++++++++++++++
 drivers/mtd/mtdcore.c                         |  38 ++++++
 include/linux/mtd/mtd.h                       |   2 +
 8 files changed, 228 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/mtd-concat.txt
 create mode 100644 drivers/mtd/composite/Kconfig
 create mode 100644 drivers/mtd/composite/Makefile
 create mode 100644 drivers/mtd/composite/virt_concat.c

-- 
2.17.1

