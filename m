Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/LYjyVipod5LWJ12nin5rBm7A/iMktqo48h1Ni8riwlLvTL47WjBXt05uAMGnwcdir8968
ARC-Seal: i=1; a=rsa-sha256; t=1523472618; cv=none;
        d=google.com; s=arc-20160816;
        b=HyKESow7jM9V+fi+sakA/M8bdXFAbUNhbbwH3MZO84tLyKwDycOLUjbiij82VbpwfA
         jZ1cq9ea7PfUIHWG+/hnN9wqUZOf3NfbgFwXgPL6yGZH13Lb24Nm+k804rkNWGdRgxwY
         nhLYzuwM+BcBkjym2W8vCUPLcWhzRiHpLi7sO2v/xPnB+dUTHwOK20OwvdUzaqfd528+
         C0jnCuyQGXX6bLKdPSdzCVeVsdDGx7hHe5vDWRs6hX0KRk1ki3M2wy6wxznwX8OxKH4V
         fNLgUeS4H+bXdj/DAacClge+FcN8iSSzCM/0OoS87dz4s56ESCPozjNHl2+A5TmygZwX
         eS+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pxmP/gD5EXH4LfMBDfWUq8fGU/mxcVirWQUlF7Sfwb4=;
        b=BG62MZmdPVc64e3+YpLk1ZBFIET0TPv8kM6FD64wN2PLcr7Sje94BeXj86ntJR2lr+
         Ib8sTIw4WdSMBOKpJM5eZAnHiB+tCBbvOlKXeT9w/1I+l4fc54dy5z6gq9rVzXtC3w9+
         NgWZxPHlOJJUTMRZV6KlVS/bGZp4X7fnOdBI9XnxCtxg1NnLAjlJ+9bK1cFyBl/8i+s0
         vsj64tHC7cELSKFj8IyH9BRhQCs/uy6cXAr5CxBT4FrGyI9FMMZR2CVK3sHda8ttqAnD
         DhfPO4I36fG0mRlqr/5MOmzhkv7ltSRfCRE1AOhKtd7hqRXaKLL3PcVIKakWNt3VssMk
         u9Ig==
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
Subject: [PATCH 4.4 151/190] scsi: libsas: fix memory leak in sas_smp_get_phy_events()
Date: Wed, 11 Apr 2018 20:36:37 +0200
Message-Id: <20180411183601.450144801@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476394956038418?=
X-GMAIL-MSGID: =?utf-8?q?1597476824773372402?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -684,6 +684,7 @@ int sas_smp_get_phy_events(struct sas_ph
 	phy->phy_reset_problem_count = scsi_to_u32(&resp[24]);
 
  out:
+	kfree(req);
 	kfree(resp);
 	return res;
 
