Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD29C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F215E20870
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fcT951Fq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F215E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbeJ3P2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 11:28:10 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:35527 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbeJ3P2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 11:28:10 -0400
Received: by mail-wm1-f41.google.com with SMTP id q12-v6so7430445wmq.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 23:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=vuipA5Fyr+hO1PFB7Fwhrz1hA0onQ/Ni/4VNsgw8se8=;
        b=fcT951FqJkJy2gvZVZtBxrc72b6N6/1KGNDiMvrPpqzaJm8ov+JzWh32W3CkvF5ksU
         aD7Urg2VE3dNXrS0Xn8Uhu3kCZgoEltoDn7NZ1wMDTaoMezAPz7PDb8vmZ084GXsdIVD
         f+Y9a3IfUE/JarG86IpygtH8Q5uFmem8NftIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vuipA5Fyr+hO1PFB7Fwhrz1hA0onQ/Ni/4VNsgw8se8=;
        b=S7TOK0y8T30vLf1RhBYmgmObzvfUTNhnmb/9SekuRdyq1HKkRVhRifwhjLz7HKR3dV
         MmVQBao4ZANKI4U9UCHXSxxBGvLjftp+klb3OkHDq1EuFEtmUBodLzCaxAaRmVQZcNua
         6St0OKOLSaLLogwyJlVkZSIz00fWAHS3BHKmL0MtZs7HwIBjAP9xYnFahiQV2Mu+D0YJ
         dufHJ/Vj+Z+1P8oMtHHEo+xm9dX0MWb6B4UxeE4d5NtcrpPkUc2DKTus88JvcfvUMKJa
         hCAn7RpsYutHk5VHkIk/OQYKiwAyGzBJJOTuyDOx8pZIUp2ksqMG0Bk+x4cbM01Ru4z7
         CiKQ==
X-Gm-Message-State: AGRZ1gKm7vmKAURgYUFXgW/+Ak9yUSSm4drx502P4RjIefIL9gQWITKs
        NqD0LyLkJ9uiT6vxVL0wiTbsdA==
X-Google-Smtp-Source: AJdET5ffInqPHaD9SjAePw4CFSwDiOZ1k+FBp4NKMMQP63/5Rdk3fQVYFAuSgP22Orj6rKtw39XaIA==
X-Received: by 2002:a1c:8e8c:: with SMTP id q134-v6mr613289wmd.112.1540881357680;
        Mon, 29 Oct 2018 23:35:57 -0700 (PDT)
Received: from dhcp-10-123-74-106.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id c64-v6sm11924731wma.44.2018.10.29.23.35.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 23:35:56 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [v1 0/2] mpt3sas: Add support to Aero controllers.
Date:   Tue, 30 Oct 2018 12:05:14 +0530
Message-Id: <1540881316-13577-1-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1) Updated MPI headers to the latest version 2.6.7.
2) Added support for Aero/Sea controllers.

V1 changes:
In Patch 2, 
ioc->name is populated later, so fixing ioc->name
before using it in ioc_warn. 
Enable Warning message only for aero configurable
controllers.

Suganath Prabu (2):
  mpt3sas: Update MPI headers to support Aero controllers.
  mpt3sas: Add support to Aero PCI IDs.

 drivers/scsi/mpt3sas/mpi/mpi2.h       |  17 +-
 drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h  |  94 +++++--
 drivers/scsi/mpt3sas/mpi/mpi2_image.h | 507 ++++++++++++++++++++++++++++++++++
 drivers/scsi/mpt3sas/mpi/mpi2_init.h  |   2 +-
 drivers/scsi/mpt3sas/mpi/mpi2_ioc.h   | 359 +-----------------------
 drivers/scsi/mpt3sas/mpi/mpi2_pci.h   |  11 +-
 drivers/scsi/mpt3sas/mpi/mpi2_raid.h  |   2 +-
 drivers/scsi/mpt3sas/mpi/mpi2_sas.h   |   2 +-
 drivers/scsi/mpt3sas/mpi/mpi2_tool.h  |  72 ++++-
 drivers/scsi/mpt3sas/mpt3sas_base.h   |   1 +
 drivers/scsi/mpt3sas/mpt3sas_scsih.c  |  30 +-
 11 files changed, 707 insertions(+), 390 deletions(-)
 create mode 100644 drivers/scsi/mpt3sas/mpi/mpi2_image.h

-- 
1.8.3.1

