Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5DCC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 04:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395B020844
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 04:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 395B020844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388423AbeGXFR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 01:17:56 -0400
Received: from gate.crashing.org ([63.228.1.57]:59360 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388191AbeGXFR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 01:17:56 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w6O4DGGP026402;
        Mon, 23 Jul 2018 23:13:18 -0500
Message-ID: <9071d5c82539c93f4a6cc8a76a11b14c3f507f09.camel@kernel.crashing.org>
Subject: [GIT PULL] FSI updates round 3 for 4.19
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        openbmc@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>
Date:   Tue, 24 Jul 2018 14:13:16 +1000
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg !

This adds support for offloading the FSI low level bitbanging to the
ColdFire coprocessor of the Aspeed SoCs. All the pre-requisites have
already been merged, this is the final piece in the puzzle.

This branch also pull gpio/ib-aspeed which is a topic branch already
in gpio/for-next (and thus in next) whic contains pre-requisites.

Finally, there's also a bug fix to the sbefifo driver for some
inconsistent use of a mutex in the error handling code.

Note: The oddball "origin" commit of that pull request comes from
the fact that Linus Walleij gpio/ib-aspeed tree is ahead of mine,
so pulling his branch pulled a bunch of already upstream other things
in. As such, i had to base this pull request off a local merge. This
shouldn't affect you at all, and allows the diffstat below to be
correct.

The bindings updates have been acked by Rob and the corresponding
device-tree updates will be merged by Joel via the ARM SoC tree.

Thanks !
Ben.

The following changes since commit d5e748ff2b996d83489ac76c072e8b99f9ecef13:

  Merge remote-tracking branch 'gpio/ib-aspeed' into upstream-ready (2018-07-23 15:21:39 +1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/linux-fsi.git tags/fsi-updates-2018-07-24

for you to fetch changes up to 0a213777d1dd879092225a7aa847b6e9b3a1c267:

  fsi: Add support for device-tree provided chip IDs (2018-07-23 16:27:32 +1000)

----------------------------------------------------------------
Benjamin Herrenschmidt (6):
      devres: Add devm_of_iomap()
      dt-bindings: fsi: Document binding for the fsi-master-ast-cf "device"
      fsi: master-ast-cf: Add new FSI master using Aspeed ColdFire
      fsi: sbefifo: Fix inconsistent use of ffdc mutex
      dt-bindings: fsi: Add optional chip-id to CFAMs
      fsi: Add support for device-tree provided chip IDs

 Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt |   36 +++++++
 Documentation/devicetree/bindings/fsi/fsi.txt               |    5 +
 drivers/fsi/Kconfig                                         |    9 ++
 drivers/fsi/Makefile                                        |    1 +
 drivers/fsi/cf-fsi-fw.h                                     |  157 ++++++++++++++++++++++++++++
 drivers/fsi/fsi-core.c                                      |   24 +++++
 drivers/fsi/fsi-master-ast-cf.c                             | 1438 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/fsi/fsi-sbefifo.c                                   |   13 ++-
 include/linux/device.h                                      |    4 +
 include/trace/events/fsi_master_ast_cf.h                    |  150 ++++++++++++++++++++++++++
 lib/devres.c                                                |   36 +++++++
 11 files changed, 1869 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
 create mode 100644 drivers/fsi/cf-fsi-fw.h
 create mode 100644 drivers/fsi/fsi-master-ast-cf.c
 create mode 100644 include/trace/events/fsi_master_ast_cf.h

