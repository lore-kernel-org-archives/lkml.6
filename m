Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C311CC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B038208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfADLWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 06:22:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:52426 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727679AbfADLVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 06:21:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 24515AEAA;
        Fri,  4 Jan 2019 11:21:44 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-lpwan@lists.infradead.org, linux-serial@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Frank Kunz <mailinglists@kunz-im-inter.net>,
        Oliver Neukum <oneukum@suse.com>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Reichel <sre@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH RFC lora-next 0/5] net: lora: sx130x: USB CDC Picocell Gateway serdev driver via fake DT nodes
Date:   Fri,  4 Jan 2019 12:21:26 +0100
Message-Id: <20190104112131.14451-1-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

Following up on a discussion in August 2018 [1] and my ELCE 2018 talk [2, 3],
I have been searching for an easy way to connect kernel network drivers to
a family of cards/adapters that expose a /dev/ttyACMx device today and
with the vendor's reference software would be accessed from userspace.

While a tty obviously works technically, it leaves us with per-vendor forks
of userspace software without a real upstream community (rare code drops).
It also doesn't allow code sharing with in-kernel protocol stacks or with
the SPI and UART based drivers we've already been working on.

One option suggested by Oliver was a line discipline - that would have the
advantage that it could work with virtually any tty, but on the downside
it would not work out-of-the-box and would require some userspace tool to
manually switch the tty into the new mode. Scalability was another concern,
as was duality of ldisc vs. serdev based implementations.

This patchset rather explores the use of Device Tree nodes to load a serdev
driver on top of the cdc-acm driver. By loading a modified cdc-acm module
plus this quickly hacked-together usb driver, I could play with it on 4.20
on an arm based Turris Omnia router with n-fuse mPCIe card, for instance.

I would hope that the shim approach taken here might also work for FTDI
MPSSE based SPI, encountered by Frank. Not with serdev then, of course,
but as pure USB interface/device driver piggy-backing on what exists.

An unsolved problem is that Semtech in version v0.2.1 switched away from
their own VID/PID to a generic STM32 VID/PID (due to Windows drivers...),
with the only distinction in iProduct string that usb_device_id does not
consider for probing. Since I'm reusing the cdc-acm driver, I can't have
it fail in probe, as it would then fail when called from my driver, too.

Various smaller issues are mentioned in the individual commit messages.

This patchset is based on my linux-lora.git lora-next staging branch.
Please consider taking the small usb patch to aid in further evaluating
serdev on cdc-acm and in resolving the remaining issues.
The others are for testing on our staging tree and for discussion.

Have a lot of fun!

Cheers,
Andreas

[1] https://marc.info/?l=linux-serial&m=153421371800416&w=2
[2] https://www.youtube.com/watch?v=Jjel65sZO9M
[3] https://events.linuxfoundation.org/wp-content/uploads/2017/12/ELCE2018_LoRa_final_Andreas-Farber.pdf

Cc: Johan Hovold <johan@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Frank Kunz <mailinglists@kunz-im-inter.net>
Cc: Oliver Neukum <oneukum@suse.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-lpwan@lists.infradead.org
Cc: linux-serial@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Cc: netdev@vger.kernel.org

Andreas Färber (5):
  net: lora: sx130x: Factor out SPI specific parts
  net: lora: sx130x: Prepare storing driver-specific data
  net: lora: sx130x: Add PicoCell serdev driver
  usb: cdc-acm: Enable serdev support
  HACK: net: lora: sx130x: Add PicoCell gateway shim for cdc-acm

 drivers/net/lora/Makefile        |   4 +
 drivers/net/lora/picogw.c        | 337 ++++++++++++++++++++++++++++
 drivers/net/lora/sx130x.c        | 158 ++++++++-----
 drivers/net/lora/sx130x_picogw.c | 466 +++++++++++++++++++++++++++++++++++++++
 drivers/usb/class/cdc-acm.c      |   8 +-
 include/linux/lora/sx130x.h      |   9 +
 6 files changed, 926 insertions(+), 56 deletions(-)
 create mode 100644 drivers/net/lora/picogw.c
 create mode 100644 drivers/net/lora/sx130x_picogw.c

-- 
2.16.4

