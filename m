Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBD6C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309A5222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900097;
	bh=QNPEAArGD5P+q2r4b1/40uemuAapDTeLw1j64+4a5MY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k7PZy7pZKHF3ZOMHnDybZncI3+xlmZEiW7Vfh3QDiXDHzrSAASGrTu7xyLJZVnGJm
	 0H1JYwRDY6QM3N5esuYXINLBwJmmesOxYeNko2KoqN0/EAwbHcrnj0GvfshcN8jWEZ
	 4/RNMyvaiHDq7ZroVKWuFsRqJUc1zHEbZ4h0wGlo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732614AbfBKPsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:48:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:51900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732132AbfBKOkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:40:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7E272081B;
        Mon, 11 Feb 2019 14:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896050;
        bh=QNPEAArGD5P+q2r4b1/40uemuAapDTeLw1j64+4a5MY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GYjCg0NREPe3Bp7LuBW37zyWMvEKSRlTZKuTA2w3YjglA6cri1OBxV/ARFTvDWojT
         XRZ6F9tGT+2LCQuxeZWvMMSOZlOuQNHaRRJcCYtremkTlb1z8sDdLDBHpKOpIaADs6
         y3IqkSJX0DqBCupZIawrehfk1/AlUd5P5zGG+aHo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 027/313] ptp: check gettime64 return code in PTP_SYS_OFFSET ioctl
Date:   Mon, 11 Feb 2019 15:15:07 +0100
Message-Id: <20190211141855.232406720@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 2012551d93e0..796eeffdf93b 100644
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



