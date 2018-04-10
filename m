Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/UaQ6zBfZeDPu+O7h+TioRiy6ixc08EMrHLgJM42C+eI/GxitOPlDvHtHZ97HxtpzoEKnS
ARC-Seal: i=1; a=rsa-sha256; t=1523399407; cv=none;
        d=google.com; s=arc-20160816;
        b=ICQ4SZ0sUDUzm1OKkBezSAoXjXOTpS68z1R+CGNzH9ZmAxkTi3opYaqcdiNvNXUkRS
         eiLpyNyGkf7MTLno6EDq8kaIl/I5yaPHXIKFlzflOLtfEEddmv1tRF9pfo+23kQpFjYH
         DrKSH3BhH4p5XZTDVydnMTDzdDWIlukGrF/UQdnsfIdqdvsmmRmvRt6Wd/qA14wTGaGy
         hvYVSUWocUnB0WGv7XqxS2AXiIUScq5wdfWXakomvo8l3lbIgKGTVirsktFas1hX15rl
         I9DzgGeHB69QevCe/Z2ihR0cOAk1s9lsOxzO27CJKOliO89oJJUiUtTQvW16i9DbJ3Ox
         B1yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NXUBaGSHg6DPxKhXlntqnHz9CQmfGcc11UUYC0e5rVU=;
        b=USUT5cc6Y4H/sEkSn5nVV7JBlvATPlvr4JeXM9AstW9zt5MHL4TT1zQUdMXcI+zUv+
         DEK5G7/GcG+wuckh4A38/mH5sVX8fKXOWpEJ2WLvG9pSBgvpBaHBg8ETZ4fBZiCiXD78
         4+dxq/x6iAXnw/PTmcUdzrrnzVVsW01+LRZk1esLEF98ehYF9+3mmbe5Oulsnf+M7BVc
         qvlC/SoqWvZimeRll2zwrkJmsqcMS7HD7UC14C1KC7fSA6NBMWStMROKzaox/S6hRfCg
         A2CFWEPcrEPlbSWBjv3OrEPPXh4uKJz22jU1pk7fToCBMs74Rck1M7hFyUiBMuZ3Dy7w
         TA3A==
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
Subject: [PATCH 4.15 077/168] scsi: libsas: fix memory leak in sas_smp_get_phy_events()
Date: Wed, 11 Apr 2018 00:23:39 +0200
Message-Id: <20180410212803.555086065@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400057700696475?=
X-GMAIL-MSGID: =?utf-8?q?1597400057700696475?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
