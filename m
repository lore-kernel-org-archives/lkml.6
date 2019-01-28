Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C421DC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C48C2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692672;
	bh=hwiPqgd0UQPwcsBCDyyGiEyspVzuXHZZLocL4+Sx5B0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J+zVHKaXJBr0EZFgpqC1WcrFCiMZvmxZZa95E3POt08HqK/9baO6V8Z+XVsdcIMur
	 sNJO9EGGk7AA5lLWrtByc8tdiJ3YYgtNFnRQG+T/G4M0mGNJdD4RVv84qHt9zjxlJx
	 33KYjg47Wsm0ymmjJkPXSphHWRsEYu30hqnOZVdo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389726AbfA1QYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:24:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:32802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389689AbfA1QYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:24:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B80020879;
        Mon, 28 Jan 2019 16:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692661;
        bh=hwiPqgd0UQPwcsBCDyyGiEyspVzuXHZZLocL4+Sx5B0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TcSmB7IKZdSJ2l7oPD4DARAv3bV7AwuKB1+PWRFCt1w+HfjPMeW4iIm7tjWwjRRxX
         0p7SuQbxz61GKyEE8Nnwaqk3LrOjpw+GEtytF1lMmfVWVvpbV1WRXivuaGMFEnp6y1
         GNZVJqTNtumEnfJUYcfGFYdlKIhlNXZUNiWLIWeU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Miroslav Lichvar <mlichvar@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 13/80] ptp: check gettime64 return code in PTP_SYS_OFFSET ioctl
Date:   Mon, 28 Jan 2019 11:22:54 -0500
Message-Id: <20190128162401.58841-13-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128162401.58841-1-sashal@kernel.org>
References: <20190128162401.58841-1-sashal@kernel.org>
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
index 4eb254a273f8..4861cfddcdd3 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -204,7 +204,9 @@ long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
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
@@ -257,6 +259,7 @@ long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
 		break;
 	}
 
+out:
 	kfree(sysoff);
 	return err;
 }
-- 
2.19.1

