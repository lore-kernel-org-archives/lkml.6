Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48NOUFFvPQifS3s4Q8Osq3xR/Wo6o19uQ2+nsgSzmfANRSfhph/0lthqDqirnNRrtUrA4Li
ARC-Seal: i=1; a=rsa-sha256; t=1523472118; cv=none;
        d=google.com; s=arc-20160816;
        b=mOrakgy65zZBX12IwBNHNew7T77FwmzHWsSNw2Tzwm+eGgIthCuOaQlaP3re6/jz0G
         PmtQDChukjUv104j1Fd6D+k72u5SU2XKzwGZspaZ40SkIyD6BsiMMthtmTNm1u2UMk6K
         yXQdHdESeVoCsEN/9yavAC+kHUejb35hObwg4DTT9dT2i6Iq8B1lR/bKXvZgL2i3S/ZI
         7FfE+jj2xsYXlxRu8mMUZuqNkM8RPLsJfCn2DQCXPhJYWZrpPJM4nsf/rBaxDj32u5qM
         dKAzkJvfl9A2G0Ul9HGw/ReNZ3KnpYt2k0xo2M1MeXLmXJC9HvAZgsNwRCORfkAsQ8sG
         DRxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FLYyJZw/csdcMqYMrOjn7iXHlIUwxcg0fuuqg84KS30=;
        b=w3YIrq24HQ7OT8shZ3xnBEievB7g+WxZHcWw8w0fUPGGd6hZ9uU10zDO27cc3qy6wA
         ZsquuyOIBGnRlWn8ZKVp46B+/O8LK4RqT0XkK5QabmysFOEfwWHWt4ENjyEzSkTPANWX
         65qOeu7yQqQb5WljBOMo7ZTnJftxTQRI57vgqbdNU2wXHFIpD+qmTbEJuCbA4Sj9Nlp4
         5y0Lk+DW0XFmtMjuGRqxEwUzQBxa6dmsQHcPwkYRkZsSNe47ioA4cgz+0STvLM9Z0St0
         G9Ot+wkLtXxseFScVLFwrpkIQCjvVnyGcZ5YLgijKbCsB/zkH9cjiuEQ787+P5dlEF9b
         l1sA==
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
Subject: [PATCH 3.18 094/121] scsi: libsas: initialize sas_phy status according to response of DISCOVER
Date: Wed, 11 Apr 2018 20:36:37 +0200
Message-Id: <20180411183502.265625848@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476300437496411?=
X-GMAIL-MSGID: =?utf-8?q?1597476300437496411?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
