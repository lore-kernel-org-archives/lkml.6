Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+us2m3EQeLCTkNrDqVoDiqXq4nV353qUaNVPgAIa8I+uXL3yyRgPukpB1zGZovjU7DzZ+l
ARC-Seal: i=1; a=rsa-sha256; t=1523473472; cv=none;
        d=google.com; s=arc-20160816;
        b=dJOv5D3j6gQf2BaRcevJvDfKPGM5ATe64XIWNx48axBT3+o2/EgHhA12SqXq352zPv
         YzvP0itRePXnoHxXSaLwXMB3xVE8eohdZa7gLSyt7miCX21sN1G6cQp4dK4M+7Mq5ei9
         k225zIwlYNBlrHjfsCTNouK6gneJUzv/Ca/NDY3dUGoGlh0nKyjoXatrvy5i01/DhV3e
         D0M4qpOSwc1+a7dAT53GnEqR0Kqhy1fGtWGLt3uD6pswaybmz5BYLAVlS/2uDlHH050q
         N8PISc+unr0lvxvIqjMaxf8VyhQjuKPezYsRyXoJQveFp2tAuWcbafOMsO5KWM7yglPV
         NAdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jInV9zgxaOgKFlgq3fa4umUhoGr85PguNaaFLoblaOM=;
        b=QdjQ5xPXVm/u/aQn1JhB5lTtDt2iM/8yyxMWgG0XE9yn7Mli8IQSyW1mZxfehknDhS
         qct96//jM0FwyVFw3ldtZRLNSt3IIPY3h1DECYdbIiaYzekgUxUoc5KCL1ObXItPSi9z
         ReNBRGaAbjgLC5ks7a6ZNfpqOKH+bQUSvQlEeP9uoN+H/hEkmdRuaAY96ild1fbOG0Aa
         Ru0jOnWl/1bAzMboalEWv9gbSL3GGSsZdIlPJkIBfDGSc1VOjl6H7eZt4iInibFGWHI8
         9xBFM2yRbI06gw7RwEu6UDXbO6EWX2AvPJw+ugwld9ePfAZLwEq78DA35xA5SdevDXH8
         Up4A==
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
Subject: [PATCH 4.9 261/310] scsi: libsas: initialize sas_phy status according to response of DISCOVER
Date: Wed, 11 Apr 2018 20:36:40 +0200
Message-Id: <20180411183633.891745764@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476300437496411?=
X-GMAIL-MSGID: =?utf-8?q?1597477720170527894?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
