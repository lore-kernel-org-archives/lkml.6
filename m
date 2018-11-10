Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144D5C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 16:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34A72133D
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 16:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34A72133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbeKKCVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 21:21:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbeKKCVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 21:21:12 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3E24E7F3F4;
        Sat, 10 Nov 2018 16:35:37 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-24.ams2.redhat.com [10.36.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 49D03608C2;
        Sat, 10 Nov 2018 16:35:35 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: [PATCH 0/3] SG_IO command filtering via sysfs
Date:   Sat, 10 Nov 2018 17:35:30 +0100
Message-Id: <1541867733-7836-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Sat, 10 Nov 2018 16:35:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, SG_IO ioctls are implemented so that non-CAP_SYS_RAWIO users
can send commands from a predetermined whitelist.  The whitelist is very
simple-minded though, and basically corresponds to MMC commands---the idea
being that it would be nice for local users to read/copy/burn CDs.

This was probably sensible when the whitelist was first added (in the pre-git
era), but quite a few things have changed since then:

- there is a lot more focus on not running things as root unnecessarily;
it is generally much more common to have non-root processes accessing disks
and we would like that to happen more, not less.

- there is also a lot more focus on not giving capabilities unnecessarily.
Using CAP_SYS_RAWIO, which gives full access to all commands, allows
you to send a WRITE SCSI command to a file opened for reading, which is
a nice recipe for data corruption.  A more fine-grained whitelist allows
you to give the desired access to the application.

- we've discovered that some commands conflict between the various
SCSI standards.  UNMAP (a write command) in SBC has the same number as
the obscure MMC command READ SUBCHANNEL.  As such it's allowed if a
block device is opened for reading!

This series, which was last sent in 2012 before I lost interest in the
endless discussions that followed, adds the possibility to make the filter
mutable via sysfs, so that it can be set up per device.  This of course can
go both ways; interested applications can set a wider filter, but one can
also imagine setting much more restrictive filters by default (possibly
allowing little more than INQUIRY, TEST UNIT READY, READ CAPACITY and the
like).

Back then there was opposition to giving unfettered access to "dangerous"
or "too easily destructive" commands such as WRITE SAME or PERSISTENT
RESERVE OUT to unprivileged users.  Even then, I think this objection
is now moot thanks to the following things that have happened in 2012:

- WRITE SAME commands, which were considered too destructive, have
been added to the filter since commit 25cdb6451064 ("block: allow
WRITE_SAME commands with the SG_IO ioctl", 2016-12-15, Linux 4.10).
They are basically the only non-MMC commands included in the filter,
by the way.

- persistent reservations are also allowed now via PR ioctls (commit
924d55b06347, "sd: implement the Persistent Reservation API", 2015-10-21,
Linux 4.4).  These require CAP_SYS_ADMIN, which is the same capability
that is needed to *grant* access to PR commands via the SG_IO filter.

So, here is the 2018 version of these patches.  Please review! :)

Paolo

Paolo Bonzini (3):
  block: add back queue-private command filter
  scsi: create an all-one filter for scanners
  block: add back command filter modification via sysfs

 Documentation/block/queue-sysfs.txt |  19 +++++
 block/Kconfig                       |  10 +++
 block/blk-sysfs.c                   |  43 ++++++++++++
 block/bsg-lib.c                     |   4 +-
 block/bsg.c                         |   8 +--
 block/scsi_ioctl.c                  | 136 +++++++++++++++++++++++++++++++++---
 drivers/scsi/scsi_scan.c            |  13 ++++
 drivers/scsi/sg.c                   |   6 +-
 include/linux/blkdev.h              |  18 ++++-
 include/linux/bsg.h                 |   4 +-
 10 files changed, 238 insertions(+), 23 deletions(-)

-- 
1.8.3.1

