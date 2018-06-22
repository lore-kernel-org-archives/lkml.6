Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737F0C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3AA243FF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B3AA243FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933888AbeFVOvS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:51:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:44026 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933542AbeFVOvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:51:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 082C2ABDD;
        Fri, 22 Jun 2018 14:51:14 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: fixes for 4.18-rc2
Date:   Fri, 22 Jun 2018 16:51:12 +0200
Message-Id: <20180622145112.21586-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-4.18-rc2-tag

xen: fixes for 4.18-rc2

It contains the following fixes/cleanups:

- the removal of a BUG_ON() which wasn't necessary and which could
  trigger now due to a recent change

- a correction of a long standing bug happening very rarely in Xen
  dom0 when a hypercall buffer from user land was not accessible by
  the hypervisor for very short periods of time due to e.g. page
  migration or compaction

- usage of EXPORT_SYMBOL_GPL() instead EXPORT_SYMBOL() in a Xen-related
  driver (no breakage possible as using those symbols without others
  already exported via EXPORT-SYMBOL_GPL() wouldn't make any sense)

- a simplification for Xen PVH or Xen ARM guests

- some additional error handling for callers of xenbus_printf()


Thanks.

Juergen

 arch/arm/xen/enlighten.c         |   7 +-
 arch/x86/xen/enlighten.c         |   7 ++
 arch/x86/xen/enlighten_pv.c      |   1 +
 arch/x86/xen/enlighten_pvh.c     |   1 +
 drivers/scsi/xen-scsifront.c     |  33 ++++--
 drivers/xen/Makefile             |   2 +-
 drivers/xen/events/events_base.c |   2 -
 drivers/xen/grant-table.c        |   4 +-
 drivers/xen/manage.c             |  18 +++-
 drivers/xen/privcmd-buf.c        | 210 +++++++++++++++++++++++++++++++++++++++
 drivers/xen/privcmd.c            |   9 ++
 drivers/xen/privcmd.h            |   3 +
 drivers/xen/xen-scsiback.c       |  16 ++-
 include/xen/xen.h                |   6 +-
 14 files changed, 297 insertions(+), 22 deletions(-)

Boris Ostrovsky (1):
      xen: Remove unnecessary BUG_ON from __unbind_from_irq()

Juergen Gross (2):
      xen: add new hypercall buffer mapping device

Oleksandr Andrushchenko (1):
      xen/grant-table: Export gnttab_{alloc|free}_pages as GPL

Roger Pau Monne (1):
      xen: share start flags between PV and PVH

Zhouyang Jia (3):
      xen: add error handling for xenbus_printf
      scsi: xen-scsifront: add error handling for xenbus_printf
      xen/scsiback: add error handling for xenbus_printf
