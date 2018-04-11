Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/8sOScrEJi98pBLlwvTAErOSBqd2iAnGjpVPnyQMvje+oeIwsJunmQIil1uzidRpOD6FeQ
ARC-Seal: i=1; a=rsa-sha256; t=1523472621; cv=none;
        d=google.com; s=arc-20160816;
        b=OC8UWV/+pBOOQksxSEyA2nh6HBQlNx9dEpdE2+n1ne1ySf3/vVaYQ1LZx78vM+PaBF
         0uSKNvJzO5LZCyOyjl3Cl0HccWi8pimYcM4C82fXtdm1U6aLANq78GGCoHPXut9Lq0jp
         TbH/wfmF6GnYDk7G7FVHwfp7PlE5ytUdLudloBOVgnfnZUl2PYAywuGHLIshMf8UGdwB
         jfFZxBx4xyQ2zjRrpG7mG1XMvqvkSJVtl/6dn6ox4hepO15gMnGSOQdjnY4vg/RcRxDh
         uejyMYE/vaH2bJhOuHFELS8J/0KZvgEqC535n6VujuYzmWO1YUvXSxJRe9iswhVwTbcr
         NqSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=n/7G5jq1lmQo098ST4QtMdp07xrLd3CVJ+O/YBf1o/k=;
        b=kGCCIK78w8d5pZBC2aZ/nVtf/sEuOz9a50tSR8G+MFygsZurs5pXtKzrJ555SKK3YZ
         HoIoMbpyUKyu7b8z4ec9K7M49d3hG5NWO3L+BrJTB2cSdHHoYinpyeoj9d3LMRz558XQ
         b9znpBapO0p0j1zMnhECOZcut6Eu1714AJrsXpZc+uz20GAVG8UvUhAWn84QMMbp86xK
         wtKDs3BQMXP/3a1JANjkp+bMDM+baO2RPj3yULxJI8NKt0eVxXKbDdij9Gk6rZPqpDKo
         fvBe8cqcI6NkP+oWwZqoseEVAQTXxmoU8/yvgdKhmY9dC0c6CMmhpcFwY+rmcQUXeGxC
         A9Cw==
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
Subject: [PATCH 4.4 152/190] scsi: libsas: fix error when getting phy events
Date: Wed, 11 Apr 2018 20:36:38 +0200
Message-Id: <20180411183601.499802150@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476398473498538?=
X-GMAIL-MSGID: =?utf-8?q?1597476828043707299?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -675,7 +675,7 @@ int sas_smp_get_phy_events(struct sas_ph
 	res = smp_execute_task(dev, req, RPEL_REQ_SIZE,
 			            resp, RPEL_RESP_SIZE);
 
-	if (!res)
+	if (res)
 		goto out;
 
 	phy->invalid_dword_count = scsi_to_u32(&resp[12]);
