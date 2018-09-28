Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704B8C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D556206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BnOLMEsl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D556206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeI2F2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:28:07 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34864 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbeI2F2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:28:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id p12-v6so5263362pfh.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 16:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=XlMXzEpl7A0j0zzL8gHRJKduxTuJfkyCwPkYZ5mhMq8=;
        b=BnOLMEslJ6/bWb2megRSBQoTdO92vXp7wVuYCuah4mO8sCCBoia+nTbBbjl/l64Xwg
         6uo41aM9z75pb+X2+pg4BbJHRv56ltJd1Acc2pC49tWOjTsq6xHyOwrLjx0xaWVngezR
         X+hps9cSJxpMArRISBdz0k02T0Pig8WW7xLPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XlMXzEpl7A0j0zzL8gHRJKduxTuJfkyCwPkYZ5mhMq8=;
        b=MFaj8zjxlOkCLVCY7MzLFDkBR6TDT1rTk6ejPcK/YG1GmTeJFWmG1P7/qociC+JG29
         oSehQJsPbIAeJZf2gkH4O53iktsBUX+CvZrtj2vykp5CSj7UO7i2AiYGtCBHrKX3w/cw
         jX82yYEriMeAHocBJhbiHc5yNEPqrj5BBupvhOADBLydv94CeZVOy5Jhu1IvSrMutcG6
         3Lq2DwaI+6xKLSxhPgiilNb4sC4c5AkJwy8BocoxqRUYxJHIZkcBhCX5C8XvdTj+cxUq
         pkZYArQYfPBwrL9qq7f3Ry/LQOfYxixJWtD3KK6Z4j7+jv/jgDw5jh/2vIVB1NpfYUuz
         aNhw==
X-Gm-Message-State: ABuFfogH5cSoXW9qbKv4+bYzZ7zk54RIkpsDRqKoIE5RujFBdcP2KSOf
        Q42Ga0Nv4AuV4QH3mV+Ip91m7Q==
X-Google-Smtp-Source: ACcGV63ASrjDB0tTqdPOIavGpn3JOoLWMMe/dd4TAk6Uq/8j/At71mEziBlX5TgORCD8UPpDpYIIng==
X-Received: by 2002:a17:902:ba8b:: with SMTP id k11-v6mr714771pls.12.1538175729079;
        Fri, 28 Sep 2018 16:02:09 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:e418:c825:76cf:5f64])
        by smtp.gmail.com with ESMTPSA id a2-v6sm7303802pgc.68.2018.09.28.16.02.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Sep 2018 16:02:08 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Stanislav Nijnikov <stanislav.nijnikov@wdc.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 0/2] scsi: ufs: Enable bInitPowerMode of sleep
Date:   Fri, 28 Sep 2018 16:02:01 -0700
Message-Id: <20180928230203.905-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change enables Linux to enumerate UFS devices that have been configured
to start in an initial power mode (bInitPowerMode) of sleep. The UFS spec
indicates that for devices in sleep mode, a START_STOP_UNIT SCSI command
must be sent to them to wake them up before doing other initialization tasks
like getting the device or geometry descriptors. This is not trivial to do
in the UFS driver, since it assumes that SCSI commands are only needed once
low level initialization of the device is complete.

These patches 1) Enable sending SCSI commands before the actual SCSI targets
are created, and 2) Sends the needed commands for devices in sleep mode.

This can be tested locally by setting byte 5 of the Configuration Descriptor
(bInitPowerMode) to zero, and rebooting. I discovered this bug by accidentally
zeroing out too many fields while I was testing provisioning functionality.

Note: This series is unrelated to (and independent of) the competing UFS
provisioning patches that have been floating around the list lately.

Changes since v1:
	* Split into two patches for easier comprehension. Can recombine to one
if this split is too contrived.
	* Fixed a leftover raw printk.

Evan Green (2):
  scsi: ufs: Allow SCSI commands early during init
  scsi: ufs: Execute START_STOP_UNIT during init

 drivers/scsi/ufs/ufshcd.c | 208 +++++++++++++++++++++++++++++++++++++++++++---
 drivers/scsi/ufs/ufshcd.h |  11 +++
 2 files changed, 206 insertions(+), 13 deletions(-)

-- 
2.16.4

