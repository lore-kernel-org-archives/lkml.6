Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D62C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 05:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99BC9214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 05:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Iomrhsnf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99BC9214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeJQNxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 09:53:20 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39644 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeJQNxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 09:53:20 -0400
Received: by mail-yw1-f68.google.com with SMTP id v1-v6so9881864ywv.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 22:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=sCauzHwXqwCjUbPk1DeKyYb1CHYEMkWxnfrc84MWjQs=;
        b=IomrhsnfaJziWJKmqJhNsJP5r28FROKz9zTZSoy1+RWrCSPaB3+7+5AQYj8spHuBie
         T1c9z1UA7SYKxfXM4zR9xy5ZH+xmkO01LNV8K9dWpY+qvE+H73bOxMo/EAKT05p3LK1z
         /dcl0RXgB+P094LeuZUTKma/wm2diCT23lMYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sCauzHwXqwCjUbPk1DeKyYb1CHYEMkWxnfrc84MWjQs=;
        b=HhQuh9zuhtrFXv6GTvTt2IYQAr5H/lQVdwlc5HVPdkZlc/dOfzSv7qosi2B5e7BBAj
         H8Y6iF8Y1iUI7dk/4P0Bq6J9tZuQtjPQRZedZdQnB7Ncjn4hZwMBzph8tQO1lXsXlnja
         3fUaW0ORbzUiON3RaVwLOTlDp2WC95mE+SkXXupU8D4HTJisxLXdJpgmqMcNGKyBuJIm
         wdj1vQraHYT7UUUa5vxwos7WB3qCqvGVNZ03JbqKJPzjdERH2NCz/4L0BiUm8s5jnNKR
         C5RIxE42mg8FyU3/im/8DJWp50ey1x9DN+GXJ8EJ2NL559npmnFMs0Al7yLkG+3EWF+D
         TmFg==
X-Gm-Message-State: ABuFfojWqV0wd95xthaz/V8v8GXOI6QnD+89YB2Htn7oKFFsHOMgseRh
        nGHmcSSdHrMjPsFJ+YvgYVdY7A==
X-Google-Smtp-Source: ACcGV62EurbfrbUeMxd5FAO+AusgU4Ptwq1OPbSnHWOge2IYtNSuWg7S9mF6ShCoTelk67QQ9NyCxQ==
X-Received: by 2002:a0d:c505:: with SMTP id h5-v6mr13709930ywd.477.1539755961550;
        Tue, 16 Oct 2018 22:59:21 -0700 (PDT)
Received: from dhcp-10-123-74-106.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id y1-v6sm3930329ywf.34.2018.10.16.22.59.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 22:59:20 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     helgaas@kernel.org, lukas@wunner.de, linux-scsi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     benh@kernel.crashing.org, ruscur@russell.cc,
        sbobroff@linux.ibm.com, oohall@gmail.com,
        andy.shevchenko@gmail.com, Sathya.Prakash@broadcom.com,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [v5 0/4] mpt3sas: Hot-Plug Surprise removal support on IOC.
Date:   Wed, 17 Oct 2018 11:29:03 +0530
Message-Id: <1539755947-27014-1-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V5 Change set:
V5 post has only defect fixes.
We are reworking and incorporating the suggestions from Bjorn.
And after covering tests, we ll be post Hot-Plug Surprise
 removal patches.

V4 Change set:
Reframe split strings in print statement, to avoid

V3 Change Set:
Simplified function "mpt3sas_base_pci_device_is_available" and
made inline

V2 changes:
Replaced mpt3sas_base_pci_device_is_unplugged with
pci_device_is_present.

V1 changes:
In Patch 0001 - unlock mutex, if active reset is in progress.

  mpt3sas: Separate out mpt3sas_wait_for_ioc_to_operational
  mpt3sas: Fix Sync cache command failure during driver unload
  mpt3sas:Fix driver modifying persistent data.
  mpt3sas: Bump driver version to 27.100.00.00.

 drivers/scsi/mpt3sas/mpt3sas_base.c      | 79 +++++++++++++++++++-------------
 drivers/scsi/mpt3sas/mpt3sas_base.h      |  8 +++-
 drivers/scsi/mpt3sas/mpt3sas_config.c    | 29 +++---------
 drivers/scsi/mpt3sas/mpt3sas_ctl.c       | 22 ++-------
 drivers/scsi/mpt3sas/mpt3sas_scsih.c     | 38 ++++++++++++++-
 drivers/scsi/mpt3sas/mpt3sas_transport.c | 73 +++++++----------------------
 6 files changed, 115 insertions(+), 134 deletions(-)

-- 
1.8.3.1

