Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF8AC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8397A21841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130309;
	bh=XRzJEFQ5vVV1Rlmq2Bv2lZ4nDGRNdKGPODoGTiY+DjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WDNyzkY00u/Z+SPDfKaHHHAqv74O2TYOGdHIHUCIDm16yEKKwSwc/Fz1su4tjbvfa
	 xJeA8Nw84soj2iKuJ0KAmumyZldf/pd3FRFdrlRIrTb1biGUsTgbsEWYe0XEOVhXSj
	 Xm936L+lJpxoVu3uEj/EQ826wf+56o38QYXT4o84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732385AbfBYVbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:31:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:37282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732383AbfBYVbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:31:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C81D21841;
        Mon, 25 Feb 2019 21:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130302;
        bh=XRzJEFQ5vVV1Rlmq2Bv2lZ4nDGRNdKGPODoGTiY+DjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pW8UMqD19mfD6GnY3y/8Cfo84swPxq/C81aIi2zDEe1iaWUAj+qLfCAs8/kCHVpBI
         zkPKKHzDn30lnrt42Udfr/EwfDmi2pzJzW3OVkdor0q8uz34RRXifayXUxLJSmgWY7
         KOAoPZqMjWvD2O3eC52qTQGVsOWxkDnz2I4l6N40=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stanley Chu <stanley.chu@mediatek.com>,
        Avri Altman <avri.altman@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 078/183] scsi: ufs: Fix system suspend status
Date:   Mon, 25 Feb 2019 22:10:51 +0100
Message-Id: <20190225195107.604569902@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ce9e7bce43526626f7cffe2e657953997870197e ]

hba->is_sys_suspended is set after successful system suspend but
not clear after successful system resume.

According to current behavior, hba->is_sys_suspended will not be set if
host is runtime-suspended but not system-suspended. Thus we shall aligh the
same policy: clear this flag even if host remains runtime-suspended after
ufshcd_system_resume is successfully returned.

Simply fix this flag to correct host status logs.

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufshcd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 1cb35ab8a4ec2..2772ff4357fc4 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -7924,6 +7924,8 @@ int ufshcd_system_resume(struct ufs_hba *hba)
 	trace_ufshcd_system_resume(dev_name(hba->dev), ret,
 		ktime_to_us(ktime_sub(ktime_get(), start)),
 		hba->curr_dev_pwr_mode, hba->uic_link_state);
+	if (!ret)
+		hba->is_sys_suspended = false;
 	return ret;
 }
 EXPORT_SYMBOL(ufshcd_system_resume);
-- 
2.19.1



