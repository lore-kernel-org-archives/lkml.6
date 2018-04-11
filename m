Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+buxiGfHPjQsHBp5/XAfWYXE3qcTNOZUNTO+tUpVDbEZW+i3cemt+hhJrieJ9du/HFA4L6
ARC-Seal: i=1; a=rsa-sha256; t=1523472624; cv=none;
        d=google.com; s=arc-20160816;
        b=A6+DAtrPCN94PJzu23FhZAtQKfMShw2WNwjCtiylMuJHCqXFNRdt35QytgiAnldToH
         12Fc+sF/cnbRrb2oCOIATKB13vNhbINQU7HKI5k/A+Mt7qU8PpJ2NuJ42+bOit1CeIMG
         AY2MW09Liet1Zy605bBVVJd9TsduPEwVhtsIkrJ8h+6ASesVJTU2sHrNHkWuIsg4MgMn
         OD1rGfAlBUA78FsQZ1eV6FlRKdyGGvuetxLCWEvkBfART0PlaMQ2r/5P+33+nm4oziFz
         PdMDEw3/M9ZFHJbaLkU0OoBqtFchI2sgL94qrWd2btTQICleC0dXRzo8tY8sXcU9ewIB
         UOmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZEvmEU+vdHWVxmIORG2czB0Wv5sopYvBW9COL8qv0tM=;
        b=PwsvsL28ktJztEIQAzzhlTX4m+8gQRM1/IXbb0245U4X2NWczbRjqArabcyK6pYTTs
         1JB973gq40TPCDDLnS5yJZZluUYPWdjnoJeicjoEbgMwjccvxyO8QY+dP2+nsctdKL6r
         akm3995LkemQZeeFMtmAw5LAvVGKIBFS7sDFpplMDvu5pdBqiPaa/+6Tfq+GZhNqwvNx
         aHJ5Ha90IHvf2jpHgP0lhYV2kK+7El7UdIdPSzB3wuLYTo0xwLE6LgeR1/mEbdcZPQA3
         KEmHx/PbJ7jsVY3+ynzjiy3j7Ckn4WQ6OOnNs0Lt6SNYwaQr1AwT+HP/8UEM7upeW5nI
         EyDw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	chenxiang <chenxiang66@hisilicon.com>,
	John Garry <john.garry@huawei.com>,
	Jason Yan <yanaijie@huawei.com>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 153/190] scsi: libsas: initialize sas_phy status according to response of DISCOVER
Date: Wed, 11 Apr 2018 20:36:39 +0200
Message-Id: <20180411183601.553309708@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476300437496411?=
X-GMAIL-MSGID: =?utf-8?q?1597476830429010582?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: chenxiang <chenxiang66@hisilicon.com>


[ Upstream commit affc67788fe5dfffad5cda3d461db5cf2b2ff2b0 ]

The status of SAS PHY is in sas_phy->enabled. There is an issue that the
status of a remote SAS PHY may be initialized incorrectly: if disable
remote SAS PHY through sysfs interface (such as echo 0 >
/sys/class/sas_phy/phy-1:0:0/enable), then reboot the system, and we
will find the status of remote SAS PHY which is disabled before is
1 (cat /sys/class/sas_phy/phy-1:0:0/enable). But actually the status of
remote SAS PHY is disabled and the device attached is not found.

In SAS protocol, NEGOTIATED LOGICAL LINK RATE field of DISCOVER response
is 0x1 when remote SAS PHY is disabled. So initialize sas_phy->enabled
according to the value of NEGOTIATED LOGICAL LINK RATE field.

Signed-off-by: chenxiang <chenxiang66@hisilicon.com>
Reviewed-by: John Garry <john.garry@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
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
@@ -282,6 +282,7 @@ static void sas_set_ex_phy(struct domain
 	phy->phy->minimum_linkrate = dr->pmin_linkrate;
 	phy->phy->maximum_linkrate = dr->pmax_linkrate;
 	phy->phy->negotiated_linkrate = phy->linkrate;
+	phy->phy->enabled = (phy->linkrate != SAS_PHY_DISABLED);
 
  skip:
 	if (new_phy)
