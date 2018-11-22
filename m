Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4348C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07B420864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCW4YfJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A07B420864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406831AbeKWGd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:33:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:32980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406810AbeKWGdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 01:33:55 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFA2B20645;
        Thu, 22 Nov 2018 19:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542916383;
        bh=+3rM5jzdyw9D3Z3dXJaI+kXz2N0qo9OEd3GUZ2CRw9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BCW4YfJc7GAGAhflBKW2rsCLFe0jeTUnbA8jzgvKn3Is2Bz67kM3B+XdffP81DDRq
         n051Qc4TXTVDLQvAWDrMY3gjXx0LpXbByaQwKPmsq0sYqzNw51Srk+7Xsyfa/IxJci
         c8Twq9EIVvasdYM8vGG04cAaY+RsrduVJJEDha2I=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 07/36] scsi: lpfc: fix remoteport access
Date:   Thu, 22 Nov 2018 14:52:11 -0500
Message-Id: <20181122195240.13123-7-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122195240.13123-1-sashal@kernel.org>
References: <20181122195240.13123-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit f8d294324598ec85bea2779512e48c94cbe4d7c6 ]

The addition of a spinlock in lpfc_debugfs_nodelist_data() introduced
a bug that lets us not skip NULL pointers correctly, as noticed by
gcc-8:

drivers/scsi/lpfc/lpfc_debugfs.c: In function 'lpfc_debugfs_nodelist_data.constprop':
drivers/scsi/lpfc/lpfc_debugfs.c:728:13: error: 'nrport' may be used uninitialized in this function [-Werror=maybe-uninitialized]
   if (nrport->port_role & FC_PORT_ROLE_NVME_INITIATOR)

This changes the logic back to what it was, while keeping the added
spinlock.

Fixes: 9e210178267b ("scsi: lpfc: Synchronize access to remoteport via rport")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index aec5b10a8c85..ca6c3982548d 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -700,6 +700,8 @@ lpfc_debugfs_nodelist_data(struct lpfc_vport *vport, char *buf, int size)
 		rport = lpfc_ndlp_get_nrport(ndlp);
 		if (rport)
 			nrport = rport->remoteport;
+		else
+			nrport = NULL;
 		spin_unlock(&phba->hbalock);
 		if (!nrport)
 			continue;
-- 
2.17.1

