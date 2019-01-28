Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B763AC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894C42175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691980;
	bh=52WIR35QiUgQA1IQdVVDR3Kk8OLiKLRjOtHUbmMO080=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CoWPksPEcsCJO4now0kRcNNi9YoYYVf3f01cXFDa40JE7CmRT2o3aN96/0fL96pkh
	 5p9kkZSwk7l3D2DhPXMGwNbTe3aaflaGxzVXjOuXha6J/ljfz90Zd3rrj+KGXe2lfD
	 ajZ5yByB4X17VjE76yI5S7k3heMKA8qy8dc4W6FI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733256AbfA1QM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:12:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:41406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732850AbfA1QMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:12:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A1B72184D;
        Mon, 28 Jan 2019 16:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691972;
        bh=52WIR35QiUgQA1IQdVVDR3Kk8OLiKLRjOtHUbmMO080=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F2Lr1oX6F/SHrgGaK1fChKk8yvqUX9s1MwsM4PC4pQpEJ8AJykT/+o0ahfsPwpSFe
         LXpkcBaGU0VmbA1lsL7L+0u9GY/HuD0/nfMFidrXSdWbOIsYRXBoefbAU+eLXas2n1
         Xjh2BA2XjYPCWrgyVzBu2QBRgNiaWfXk5Pi8rTRU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Miroslav Lichvar <mlichvar@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 022/170] ptp: check gettime64 return code in PTP_SYS_OFFSET ioctl
Date:   Mon, 28 Jan 2019 11:09:32 -0500
Message-Id: <20190128161200.55107-22-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miroslav Lichvar <mlichvar@redhat.com>

[ Upstream commit 83d0bdc7390b890905634186baaa294475cd6a06 ]

If a gettime64 call fails, return the error and avoid copying data back
to user.

Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ptp/ptp_chardev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index a421d6c551b6..ecb41eacd74b 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -228,7 +228,9 @@ long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
 			pct->sec = ts.tv_sec;
 			pct->nsec = ts.tv_nsec;
 			pct++;
-			ptp->info->gettime64(ptp->info, &ts);
+			err = ptp->info->gettime64(ptp->info, &ts);
+			if (err)
+				goto out;
 			pct->sec = ts.tv_sec;
 			pct->nsec = ts.tv_nsec;
 			pct++;
@@ -281,6 +283,7 @@ long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
 		break;
 	}
 
+out:
 	kfree(sysoff);
 	return err;
 }
-- 
2.19.1

