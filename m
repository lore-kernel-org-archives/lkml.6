Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/nRKytMXwrSPZ1vrtEgxNG06B/8aynEg8cqaX6D0YryiW2t2/kxcMbSLWWVU6zobA/HUhK
ARC-Seal: i=1; a=rsa-sha256; t=1523399784; cv=none;
        d=google.com; s=arc-20160816;
        b=G43uxrey01fhNbLGVtfO5fL8BMudqFLr6SH6Q1V4n4Xt/JbGHvmxdpwpNeuoV6VVJl
         TUkBrVv7PfWDyuv54gCV/WnYchJPZeEDz7ozV6Ohupvjn9jKGWFzSUS4GcEvKS/FeaVn
         dZpGRLc78BCuBkqKRxt9ve47RNiB1JYtYB3vU7na42BfQSqrmJQE3kcV+GBMpPrA84jV
         fG7YU+U0qKDbWiIllMg2FJRVh4PkNF39bTIEaphiGZilzNj7+W6zNHnYfQDpeRVSo9I0
         4MY02yuemW0Psuofut1qlbKX4p9JbTEqkx96VcHPaYCtAgXW1beb97Pno/HL6+YN88nv
         a8fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZLipAjt/tfAbRvaMNojmDpbZBgP7LOhIfKOagy3idZQ=;
        b=M+OhAFASFcIPvkHE9v0LDESLsYwwYEpk1rKI0F01DCvyYWGQUzmZiUk186HnzocTDm
         xVFXMNb1OpHID1S+jUo2laMxCqITB/CJhKoOMN1RhtShGyy6n7+ZJyeKfFQX7oMif0fW
         nJTvXMOveN8p6YEKGphrAIrCW3f860NyT9uXpA8EUqaorul/xtSRHIzMPxwt4zJJMSV5
         31xQEO4ls0CTH0JEqqTCq7zJEzNZxbw+Iryc8qqTeN93ztVGFHMqmUuqo2fb03FNvMoO
         ZV37bcRAznv0okpa1gGriF41MhTNa6HZgI0VKmkwSL5imXeD6cXRWUTBWXtAL9U1zk/l
         jL1w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jason Yan <yanaijie@huawei.com>,
	John Garry <john.garry@huawei.com>,
	chenqilin <chenqilin2@huawei.com>,
	chenxiang <chenxiang66@hisilicon.com>,
	Hannes Reinecke <hare@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 061/138] scsi: libsas: fix error when getting phy events
Date: Wed, 11 Apr 2018 00:24:11 +0200
Message-Id: <20180410212909.194826721@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400060314382853?=
X-GMAIL-MSGID: =?utf-8?q?1597400452761555958?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Yan <yanaijie@huawei.com>


[ Upstream commit 2b23d9509fd7174b362482cf5f3b5f9a2265bc33 ]

The intend purpose here was to goto out if smp_execute_task() returned
error. Obviously something got screwed up. We will never get these link
error statistics below:

~:/sys/class/sas_phy/phy-1:0:12 # cat invalid_dword_count
0
~:/sys/class/sas_phy/phy-1:0:12 # cat running_disparity_error_count
0
~:/sys/class/sas_phy/phy-1:0:12 # cat loss_of_dword_sync_count
0
~:/sys/class/sas_phy/phy-1:0:12 # cat phy_reset_problem_count
0

Obviously we should goto error handler if smp_execute_task() returns
non-zero.

Fixes: 2908d778ab3e ("[SCSI] aic94xx: new driver")
Signed-off-by: Jason Yan <yanaijie@huawei.com>
CC: John Garry <john.garry@huawei.com>
CC: chenqilin <chenqilin2@huawei.com>
CC: chenxiang <chenxiang66@hisilicon.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/libsas/sas_expander.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -686,7 +686,7 @@ int sas_smp_get_phy_events(struct sas_ph
 	res = smp_execute_task(dev, req, RPEL_REQ_SIZE,
 			            resp, RPEL_RESP_SIZE);
 
-	if (!res)
+	if (res)
 		goto out;
 
 	phy->invalid_dword_count = scsi_to_u32(&resp[12]);
