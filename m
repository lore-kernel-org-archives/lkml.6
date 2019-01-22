Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9F1C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CD521721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548169754;
	bh=6H2+DNncCpk2y88T7iRTCBhL9SBS8giDaQDz10mmGoc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=JrSHZKSPbcc1fz72mFupCZ24mrglgQq8lAyYrHumCFxfNrKyGzO0EVPCI8UFc+0xs
	 gEIVo/qiJm6F/o/A9bagaMYUuZnBzFj0dJx91MlIF98tMaW8p23y20ewlMy/fz0gPV
	 5bB3B4QnrpsNPk5rZGNQyZNubToaHdRmWDeHYpLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfAVPJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:09:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:48398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728687AbfAVPJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:09:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB38320879;
        Tue, 22 Jan 2019 15:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548169752;
        bh=6H2+DNncCpk2y88T7iRTCBhL9SBS8giDaQDz10mmGoc=;
        h=From:To:Cc:Subject:Date:From;
        b=LTcdv2bOhvh89n0Aeh4I4WAFYAhix7KP6HHEbmYDOkLTX2JezmR0sqIoJEPezwP9h
         WJp5McgbUZqJ/8xvjcekvfxopINp5RnmprdaD5EKk8tIoER+9wEJqJBLvpqDMWOlE8
         Sa8lbxDz1WTxuzp3e0N2Yz1ryDsGkaumdu8Jpc/I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     James Bottomley <jejb@linux.ibm.com>,
        Martin Petersen <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/7] SCSI: cleanup debugfs usage
Date:   Tue, 22 Jan 2019 16:08:59 +0100
Message-Id: <20190122150906.12470-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs code, there is no need to ever check the return
value of the call, as no logic should ever change if a call works
properly or not.  Fix up a bunch of x86-specific code to not care about
the results of debugfs.

Greg Kroah-Hartman (7):
  scsi: bfa: no need to check return value of debugfs_create functions
  scsi: csiostor: no need to check return value of debugfs_create
    functions
  scsi: fnic: no need to check return value of debugfs_create functions
  scsi: snic: no need to check return value of debugfs_create functions
  scsi: lpfc: no need to check return value of debugfs_create functions
  scsi: qlogic: no need to check return value of debugfs_create
    functions
  scsi: qla2xxx: no need to check return value of debugfs_create
    functions

 drivers/scsi/bfa/bfad_debugfs.c   |  17 ---
 drivers/scsi/csiostor/csio_init.c |   6 +-
 drivers/scsi/fnic/fnic_debugfs.c  |  88 +---------------
 drivers/scsi/fnic/fnic_main.c     |   7 +-
 drivers/scsi/fnic/fnic_stats.h    |   2 +-
 drivers/scsi/fnic/fnic_trace.c    |  17 +--
 drivers/scsi/fnic/fnic_trace.h    |   4 +-
 drivers/scsi/lpfc/lpfc_debugfs.c  | 170 ------------------------------
 drivers/scsi/qedf/qedf_debugfs.c  |  18 +---
 drivers/scsi/qedi/qedi_debugfs.c  |  17 +--
 drivers/scsi/qla2xxx/qla_dfs.c    |  43 +-------
 drivers/scsi/snic/snic_debugfs.c  | 133 +++++------------------
 drivers/scsi/snic/snic_main.c     |  14 +--
 drivers/scsi/snic/snic_stats.h    |   2 +-
 drivers/scsi/snic/snic_trc.c      |  12 +--
 drivers/scsi/snic/snic_trc.h      |   4 +-
 16 files changed, 48 insertions(+), 506 deletions(-)

-- 
2.20.1

