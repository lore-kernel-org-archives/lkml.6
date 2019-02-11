Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970ADC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679B220700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896940;
	bh=ETFiV5DaBSdzle91qOZKMG018vNCbfgcJez5Ws9ae1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LY+mLSsOvHiIHdTbEOyP73Wdz9ZK1ti2WoYjHqlapteADrXDBTyxP3gQOidA2eBjp
	 ruLRX/jsOaJNBhc1PdmkWJfjkQhxUWtd1j1UrOK9/SyN2Tc5AbHrdOClEOQAxbDzFG
	 wngPKFhYUtnybsU5dFNR4bL3t7xKH7fUed2lvKpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389015AbfBKOzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:55:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:42646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388998AbfBKOzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:55:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF01D2229E;
        Mon, 11 Feb 2019 14:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896935;
        bh=ETFiV5DaBSdzle91qOZKMG018vNCbfgcJez5Ws9ae1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qGGEdjVGgwvLKqYRAw+9E18fwUeXwp0ckr/gU67h4yWcTrgmBOMSoReix2VQd9RNQ
         7wabZj373yTZRx8yTio37liBho6hImt+yWNDKGHXsIPCQagsHIRm0u8imqDffg6LeJ
         mSYQ8//OQSRaLssYyhVz9Cc5q4ySVsm//6P00EJ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 019/205] ptp: check gettime64 return code in PTP_SYS_OFFSET ioctl
Date:   Mon, 11 Feb 2019 15:16:57 +0100
Message-Id: <20190211141828.403909563@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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



