Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B10FDC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6860920020
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNv2Ys7T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6860920020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965864AbeFNOLh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:11:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965846AbeFNOLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:11:32 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36518208DD;
        Thu, 14 Jun 2018 14:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985491;
        bh=k4p2TT9GiQ0jbMwWTGQ2RCtNr3bg4h1Od/zDCupqx/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XNv2Ys7TfUtW4BcvrEvouAuHzwIk58OKGPGQ5Em3+WT5qmHpAtr4K+UBI4nZdbCot
         fidPah4f8tNiUMz9J4uGEKbXh4iYBZ7dM1t/0OHtU6J80BL6101I2NeM1qSNqgmBHV
         0TIMcp1S6cKyq7yeKEdlNw8smTbpJKvmNpqkho0I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Wilck <mwilck@suse.com>,
        Sagi Grimberg <sagi@grimbeg.me>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4.9 10/30] nvmet: dont overwrite identify sn/fr with 0-bytes
Date:   Thu, 14 Jun 2018 16:04:51 +0200
Message-Id: <20180614132600.685059845@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132600.255515394@linuxfoundation.org>
References: <20180614132600.255515394@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Wilck <mwilck@suse.com>

commit 42819eb7a0957cc340ad4ed8bba736bab5ebc464 upstream.

The merged version of my patch "nvmet: don't report 0-bytes in serial
number" fails to remove two lines which should have been replaced,
so that the space-padded strings are overwritten again with 0-bytes.
Fix it.

Fixes: 42de82a8b544 nvmet: don't report 0-bytes in serial number
Signed-off-by: Martin Wilck <mwilck@suse.com>
Reviewed-by: Sagi Grimberg <sagi@grimbeg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvme/target/admin-cmd.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -197,12 +197,6 @@ static void nvmet_execute_identify_ctrl(
 	copy_and_pad(id->mn, sizeof(id->mn), model, sizeof(model) - 1);
 	copy_and_pad(id->fr, sizeof(id->fr), UTS_RELEASE, strlen(UTS_RELEASE));
 
-	memset(id->mn, ' ', sizeof(id->mn));
-	strncpy((char *)id->mn, "Linux", sizeof(id->mn));
-
-	memset(id->fr, ' ', sizeof(id->fr));
-	strncpy((char *)id->fr, UTS_RELEASE, sizeof(id->fr));
-
 	id->rab = 6;
 
 	/*


