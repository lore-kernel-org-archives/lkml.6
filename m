Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49eDoqiQ3JpCU8cG2f1/U2Pco99SO6WbFp10RBR7j4KRvCTIJXrghkZu3/pYt3777Qm8J+u
ARC-Seal: i=1; a=rsa-sha256; t=1523473469; cv=none;
        d=google.com; s=arc-20160816;
        b=X5VJNEkC7Qt3s/jboY11yKriyvtPEArKdM6+vsT49GhLFfFFCUGe1N+B4buu2+drsh
         +DR4aX2RoS68caNyonB+1u3BpIalzeQ8cUMHZPWjg6P0lsLFmGaedkLJtRRFC4N9RZQS
         epgm+R9F7ogHIXPQ5bRHGnLdelK4UV+/Tk67soJt86sIYwlMGRIL8CFUXYRJovGMl26j
         xe8xZ2nWPYi/SQjVP7u9HS1XOoIxdBCh+Ure61PwFc90Q+wAFb+Ion8jFFG5d8DTbkkM
         7ZDN9oGfsW2/n/8kseYGXGChrbvouCf+W/ANQ1iVjfqwLpYEE4ysTDBFEVWZLgT10dge
         RC0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FhxztfZv+cPGqv5eETrgYBOfH5qRrhiSCldP94yPzYo=;
        b=OoeoAdc0LDyAptBp2KqUkLabvKSO2jAsSQYuxGq9GFErRPtqhbxumuAW76B0DUBX8P
         pRbBNajOxzAoLi/Ab1zWo8KBm+SfVEqt5NXPFEh9dRySShR7weWx7u4oGKvM4XrbMa/P
         blLMBrTmBPIQpJAr2i0ynmmFCZGRHlJt7/dD+CeEubYAySk61VDPE5SV2P83wQ1/ncym
         +GoUSDklISPVB0RrJCGxAuDiaBO/93ebyp6H7+CkpatzBZ4WpbKZ0zqu15YnUuvFkTCt
         GlfEm48WGWsU8zdlsVC24wxFnsKpJmxMX+y7thYVw+NM2U79/a3A1Y41gtA9XRiM7KPa
         mr6g==
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
Subject: [PATCH 4.9 260/310] scsi: libsas: fix error when getting phy events
Date: Wed, 11 Apr 2018 20:36:39 +0200
Message-Id: <20180411183633.848956297@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476398473498538?=
X-GMAIL-MSGID: =?utf-8?q?1597477717008544316?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
