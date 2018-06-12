Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2370EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7BF20693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C7BF20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753317AbeFLEOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 00:14:41 -0400
Received: from gate.crashing.org ([63.228.1.57]:41468 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752583AbeFLEOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 00:14:40 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5C4EPZE005211;
        Mon, 11 Jun 2018 23:14:26 -0500
Message-ID: <7c268f5bb58cb45a2868020b3c5b8f48ac6844ea.camel@kernel.crashing.org>
Subject: [GIT PULL]  FSI updates
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        openbmc@lists.ozlabs.org
Date:   Tue, 12 Jun 2018 14:14:25 +1000
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg !

There are a first round of updates of the FSI stack, aiming at reducing/removing
the gap with the OpenBMC tree and a first step in getting dependent drivers
upstream.

These changes significantly improve the FSI bitbanging driver performance
and reliability, and add the new "sbefifo" driver for communicating with
the POWER9 Self Boot Engine (which will be needed for some upcoming
additional drivers).

[ Apologies if I got part of the process wrong, I haven't
  sent a pull request in years ;-) ]

Cheers,
Ben.

The following changes since commit 8efcf34a263965e471e3999904f94d1f6799d42a:

  Merge tag 'armsoc-late' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2018-06-11 18:19:45 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/benh/linux-fsi.git 

for you to fetch changes up to 9f4a8a2d7f9d71093f41c4bb0ef8707e8145bad3:

  fsi/sbefifo: Add driver for the SBE FIFO (2018-06-12 14:05:39 +1000)

----------------------------------------------------------------
Andrew Jeffery (2):
      fsi: gpio: Trace busy count
      fsi: gpio: Remove unused 'id' variable

Benjamin Herrenschmidt (8):
      fsi/fsi-master-gpio: Sample input data on different clock phase
      fsi/fsi-master-gpio: Add "no-gpio-delays" option
      fsi/fsi-master-gpio: Reduce turnaround clocks
      fsi/fsi-master-gpio: Reduce dpoll clocks
      fsi/fsi-master-gpio: Delay sampling of FSI data input
      fsi/fsi-master-gpio: Implement CRC error recovery
      fsi/fsi-master-gpio: More error handling cleanup
      fsi/sbefifo: Add driver for the SBE FIFO

Eddie James (1):
      fsi: scom: Remove PIB reset during probe

Jeremy Kerr (4):
      fsi: gpio: Use a mutex to protect transfers
      fsi/gpio: Include command build in locked section
      fsi/gpio: Use relative-addressing commands
      fsi/master-gpio: Replace bit_bit lock with IRQ disable/enable

 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts     |    1 +
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts |    1 +
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts       |    1 +
 drivers/fsi/Kconfig                              |    7 +
 drivers/fsi/Makefile                             |    1 +
 drivers/fsi/fsi-master-gpio.c                    |  349 +++++++++++++++++++++++++++--------
 drivers/fsi/fsi-sbefifo.c                        | 1005 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/fsi/fsi-scom.c                           |    8 -
 include/linux/fsi-sbefifo.h                      |   33 ++++
 include/trace/events/fsi_master_gpio.h           |   43 +++++
 10 files changed, 1362 insertions(+), 87 deletions(-)
 create mode 100644 drivers/fsi/fsi-sbefifo.c
 create mode 100644 include/linux/fsi-sbefifo.h
