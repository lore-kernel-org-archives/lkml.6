Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/nPoAIPugossYWNYSSBBw7YQazNIYDrx/jM60l1ESshm1EIr9CseJ5MZ7yFfDpEuak4HgS
ARC-Seal: i=1; a=rsa-sha256; t=1523472208; cv=none;
        d=google.com; s=arc-20160816;
        b=wCJ9tnx6aGJjzChOfGiTzsIKmlvL0W0NMcPSjdZNGmghI1yAy36odRYL3cVkVPt5do
         hb3OTxoEKU14EA8Uj04AIjqcx3URFygw4B2q5nLSIYUinV0B7UxNewaoQfp/Ig8ZcihU
         q50lZsa3oYkZ4uqrB427cnmlUekfXqjE3fZjzP+nO4cUx42ekmmxmrVdB486cDEWJbQQ
         dONlo+rtzlopR7Qd/HF2YGsOrzICaWRAdffQo31sz58W4oxqqv9luE2fObbtJBZO5tnc
         mmaIPact2LTMfwbgY34gInWNK8J9ohkbJZBzGLQn8QrYj8kaF4sBNhsSWbWB0sXovBvI
         G9zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HFRl2VGSkH0n63D7M4il3Q5OWn5ltrCR52Q+dD4+444=;
        b=FC8OgQKhmilXZJfF8TpqH6w4nTMsBoEDLkvdK84fLIFnvEVxuspBA9YfT7qhZz7pJx
         8ZRXC1QmEWTK+77LWRPOwZeRdoWa2s1kPeWojxvow+7CVrkaafiOlK3ggpEaA+vCOHbk
         RLkfXXbU0UZCX3DYbuUWoqjxPx54rJvjSqjHVmK4AkBlzE0jvZ2ssoBEc0bVlQcx7AfB
         sa32hWSPeUYegltRYrI70rVO3mQf/R1/wJeIkFPnHLBD8SNnwg1uCb+VbdAHm2H5k30W
         qthVd1UmIz6K0aAuZMDYAA+dJONJ8CN7UXgIK6kMgKXxQka9cugeyDth2vdzMoRXwFBv
         ZKwQ==
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
Subject: [PATCH 3.18 092/121] scsi: libsas: fix memory leak in sas_smp_get_phy_events()
Date: Wed, 11 Apr 2018 20:36:35 +0200
Message-Id: <20180411183502.101242628@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476394956038418?=
X-GMAIL-MSGID: =?utf-8?q?1597476394956038418?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
 
