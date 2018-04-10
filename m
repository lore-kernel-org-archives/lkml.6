Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48+HKINlP7se7zyP2DHlwZN/+q2AS7Q0pc5WzzOG4OnljTmPxs6rtc+VoRuWuMikoiJtKfN
ARC-Seal: i=1; a=rsa-sha256; t=1523399800; cv=none;
        d=google.com; s=arc-20160816;
        b=oM5mF3AqUurMM5fTDAYZyAgc5o5c33jXEqGHCOnElhM9r0GXtRpuynonUmmh78AQ1T
         jVsh8WF2zFp8mhe9XQJCJzWBjBU4+hARjlZavIy1xZn7xVjg0370g9iUq59NFjAH/LI9
         zIORa6q+9JTdYPLidVlTQMbJpMlXgFwdPIutJkpXndn0dvglCAE0hI59JV2LVHV72uDL
         Rgi4TfCOr55jG3ACgU/13WyAgrMtk6mScbSkySP7VVrJ+DBl/O2HtTxirzisYuAr7fZj
         zJax8WwWIqKd1ZHGcJP5lMgjgtzQ08JTTWFhO6dEEiMIQ90llEAonHcY9RKWtFCtxGV+
         UizQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UGkDYiOOpOelxj7AZg+76zPwMgtCNN2COgQcX+MeO6g=;
        b=VYSHOydw6XT+zHPDFBQkJEzF8UQJGu/bVFmdkIynfZy8p7PrnMMER82DDiG7ZorTXa
         vfwlbxGfNZTGZ94WTEV3WmtWSfK6+BQ6I/ErL7YOMT2CuKjKA6stRbbK8Wjqp8vcz+R9
         bIvdInNJlfs1aZq+fDf7CauZc7x3NOcXH5wF6nhJvlOo6tZOW4Esk4M+iUtm/9dzi5Ll
         g3UQSQHcq2L3sRIlLWutmTHEfi/0Q/XX2bqTuRGAUAVpvbpRyMeTzK72VG0VJWEaYtpf
         +t+7YNXdhItfEZSKSJvQNlJ1Q5P3NjCvQxOoZ5vewL/jdZEvmlUNNhIAdkDsGNhcYvHp
         k7JA==
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
Subject: [PATCH 4.14 062/138] scsi: libsas: initialize sas_phy status according to response of DISCOVER
Date: Wed, 11 Apr 2018 00:24:12 +0200
Message-Id: <20180410212909.329692446@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400062767198893?=
X-GMAIL-MSGID: =?utf-8?q?1597400469219879771?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -293,6 +293,7 @@ static void sas_set_ex_phy(struct domain
 	phy->phy->minimum_linkrate = dr->pmin_linkrate;
 	phy->phy->maximum_linkrate = dr->pmax_linkrate;
 	phy->phy->negotiated_linkrate = phy->linkrate;
+	phy->phy->enabled = (phy->linkrate != SAS_PHY_DISABLED);
 
  skip:
 	if (new_phy)
