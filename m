Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+AS+dOtp3rgIYOReY4I9tf+UkKSD8EBVT6OOZj5N3nvM4Qezv7/TUse4K7jTqj7/eLMaEA
ARC-Seal: i=1; a=rsa-sha256; t=1523399776; cv=none;
        d=google.com; s=arc-20160816;
        b=XmtPnNQtrQDDQFNmkp/0Vd7MmdugiVHcXks6yHyFlWvv3I8hy6dpmcnX2julwWQTdT
         aD7pcsNv4SRRTJlNrKVr/DNypEYWti9uYWwFPpcFbHTdjuPJ8k17/R4RCarCHDxBKnwS
         S63rUcRAV1DTys0MG0+60CfZrWTuCCt7rjMaHBjws3KzRdBXRVfE+E9Fv52TRLbttX8F
         tIxqVOHg4Hdd5Elr0y4oTFC/ezbshKMfJF5fi5VXfpIELbtmiWTp3E4YICUvLUy/fnIT
         GEvG20oWt4/O4IbxmAZYqjr+F2RRIWRmyaH3GEgT2VcuGk/0tvaJ8F8sVQaxo57z2C89
         V0DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QFmZxfZK+2x59kU4lw7XakKDDl8ToR+Dlk71uI7tSAM=;
        b=imiJabPfIFascxvtyO/xRJ/esfJtVyL0cazK5iKZHLXBknW9BrzMjeauI0aEu3YlWa
         R5MlfZPMj1nEQ3IYnXwptu1k5IH10PbzIwUz5rXFYeYQvxOPRc12STx90lF+w+HaeVhz
         AmJrWIDl2oOmXjn04dc90zfBTWR67zki9/hAcQRfTnpOnTXxY/ZD8JozvL87qLEbBbMw
         rDlDW+rX/aED2skYvN6Gut0fktX2eNs239ZYdw59TujA3DPoTGCpImdR3XFAqXpA11+Z
         PnFlz9vMCnfeT/+4p69ZVajBwymg76pSIVvjGczA6LxQmqgPWZ0tMmZaFhDv1ZlMmJYP
         XSSw==
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
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 060/138] scsi: libsas: fix memory leak in sas_smp_get_phy_events()
Date: Wed, 11 Apr 2018 00:24:10 +0200
Message-Id: <20180410212909.058135026@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400057700696475?=
X-GMAIL-MSGID: =?utf-8?q?1597400444079085046?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Yan <yanaijie@huawei.com>


[ Upstream commit 4a491b1ab11ca0556d2fda1ff1301e862a2d44c4 ]

We've got a memory leak with the following producer:

while true;
do cat /sys/class/sas_phy/phy-1:0:12/invalid_dword_count >/dev/null;
done

The buffer req is allocated and not freed after we return. Fix it.

Fixes: 2908d778ab3e ("[SCSI] aic94xx: new driver")
Signed-off-by: Jason Yan <yanaijie@huawei.com>
CC: John Garry <john.garry@huawei.com>
CC: chenqilin <chenqilin2@huawei.com>
CC: chenxiang <chenxiang66@hisilicon.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/libsas/sas_expander.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -695,6 +695,7 @@ int sas_smp_get_phy_events(struct sas_ph
 	phy->phy_reset_problem_count = scsi_to_u32(&resp[24]);
 
  out:
+	kfree(req);
 	kfree(resp);
 	return res;
 
