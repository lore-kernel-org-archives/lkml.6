Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52855C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE6621871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfADQBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 11:01:46 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:35487 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727022AbfADQBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 11:01:33 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5A26F861F7BB6;
        Sat,  5 Jan 2019 00:01:28 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Sat, 5 Jan 2019 00:00:25 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <yanaijie@huawei.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 0/3] libsas: SATA PHY connection rate matching during disovery
Date:   Sat, 5 Jan 2019 00:01:25 +0800
Message-ID: <1546617688-240623-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset looks to resolve an issue we see whereby a SATA end device
negotiated linkrate may exceed the min linkrate to the initiator, and
not be able to establish a connection.

According to the SAS spec, we should lower the SATA PHY linkrate when this
condition occurs.

It appears that some SAS HBAs (whose driver do not use libsas) already do
this automatically (via firmware, I assume).

This patchset solves this issue during device discovery phase when
detecting a new device, but not during revalidation after the user has
reprogrammed some PHY linkrates in the topology. Solving for the latter is
much more complicated, and will be done as follow-up to this series.

A minor tidy-up to libsas.h is also included.

John Garry (3):
  scsi: libsas: Fix some indentation in libsas.h
  scsi: libsas: Check SMP PHY control function result
  scsi: libsas: Support SATA PHY connection rate unmatch fixing during
    discovery

 drivers/scsi/libsas/sas_expander.c | 29 +++++++++++++++++++-
 include/scsi/libsas.h              | 56 ++++++++++++++++++--------------------
 2 files changed, 55 insertions(+), 30 deletions(-)

-- 
1.9.1

