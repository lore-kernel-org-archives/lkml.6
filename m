Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22178C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 00:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C669A2088E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 00:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C669A2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732047AbeG0BaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 21:30:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:47633 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731405AbeG0BaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 21:30:19 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w6R0AvN0007351;
        Thu, 26 Jul 2018 19:10:58 -0500
Message-ID: <81553544b2004efd42f256147d0d9f45df01df25.camel@kernel.crashing.org>
Subject: [GIT PULL] FSI updates round 4 (last) for 4.19
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        openbmc@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>
Date:   Fri, 27 Jul 2018 10:10:57 +1000
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg !

This adds a few fixes for things reported since the last merge,
and the latch batch of changes pending for FSI for 4.19.

That batch is a rather mechanical conversion of the misc devices
into proper char devices.

The misc devices were ill suited, the minor space for them is
limited and we can have a lot of chips in a system creating FSI
devices.

This also allows us to better control (and fix) object lifetime
getting rid of the bad devm_kzalloc() of the structures containing
the devices etc...

Finally, we add a chardev to the core FSI that provides raw CFAM
access to FSI slaves as a replacement for the current "raw" binary
sysfs file which will be ultimately deprecated and removed.

Thanks !
Ben.

The following changes since commit 0a213777d1dd879092225a7aa847b6e9b3a1c267:

  fsi: Add support for device-tree provided chip IDs (2018-07-23 16:27:32 +1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/linux-fsi.git tags/fsi-updates-2018-07-27

for you to fetch changes up to 9840fcd8cc43bfba486a53b4461044f1a1189cdc:

  fsi: Prevent multiple concurrent rescans (2018-07-27 09:58:12 +1000)

----------------------------------------------------------------
Benjamin Herrenschmidt (8):
      fsi: master-ast-cf: Fix build warnings on 64-bit platforms
      fsi: master-ast-cf: Mask unused bits in RTAG/RCRC
      fsi: master-ast-cf: Rename dump_trace() to avoid name collision
      fsi: Add new central chardev support
      fsi: sbefifo: Convert to use the new chardev
      fsi: scom: Convert to use the new chardev
      fsi: Add cfam char devices
      fsi: Prevent multiple concurrent rescans

Gustavo A. R. Silva (1):
      fsi: master-ast-cf: Fix memory leak

 drivers/fsi/Kconfig             |  15 +++
 drivers/fsi/fsi-core.c          | 375 +++++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 drivers/fsi/fsi-master-ast-cf.c |  24 +++--
 drivers/fsi/fsi-master.h        |   2 +
 drivers/fsi/fsi-sbefifo.c       |  84 ++++++++++-----
 drivers/fsi/fsi-scom.c          | 130 ++++++++++++++---------
 include/linux/fsi.h             |  12 ++-
 7 files changed, 496 insertions(+), 146 deletions(-)

