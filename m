Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2E2C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108FA21564
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108FA21564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbeI0HnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 03:43:01 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:35884 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbeI0Hm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 03:42:59 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 0B44129A03; Wed, 26 Sep 2018 21:27:14 -0400 (EDT)
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Ondrey Zary <linux@rainbow-software.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <cover.1538011031.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 00/10] NCR5380: Various improvements
Date:   Thu, 27 Sep 2018 11:17:11 +1000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[This patch series is being re-sent unchanged due to email problems.]

This series addresses issues which became apparent when Michael Schmitz
tried to use an AztecMonster II SATA/SCSI adapter with a 5380 host.

That target seems to have some bugs which thoroughly exercise driver
error paths and EH.

The patch by Hannes Reinecke was cherry-picked from his 'eh-reset.v5'
branch.


Finn Thain (9):
  NCR5380: Reduce goto statements in NCR5380_select()
  NCR5380: Have NCR5380_select() return a bool
  NCR5380: Withhold disconnect privilege for REQUEST SENSE
  NCR5380: Use DRIVER_SENSE to indicate valid sense data
  NCR5380: Check for invalid reselection target
  NCR5380: Don't clear busy flag when abort fails
  NCR5380: Don't call dsprintk() following reselection interrupt
  NCR5380: Handle BUS FREE during reselection
  NCR5380: Check for bus reset

Hannes Reinecke (1):
  NCR5380: Clear all unissued commands on host reset

 drivers/scsi/NCR5380.c | 167 +++++++++++++++++++++++++++++--------------------
 drivers/scsi/NCR5380.h |   2 +-
 2 files changed, 101 insertions(+), 68 deletions(-)

-- 
2.16.4

