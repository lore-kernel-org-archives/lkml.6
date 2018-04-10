Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx491E2eLQJZCXSdluU3u4nYhI1jAEjJdWcu8b4XjflnhCSpaYiWFiAhYZEbzuYZBcCnDuQeR
ARC-Seal: i=1; a=rsa-sha256; t=1523399410; cv=none;
        d=google.com; s=arc-20160816;
        b=JIWVHEaAzp5reGS16Ju7AqofnMEwKoOCOl6PO0i2xKK2qE58FAPw2ZcFv4qDBwakl3
         SnEXz3nXPxZaF94gzn1NCB+/KiqMHH8yl4y5pAa7qp7zCAJN9KZxtxKUO9QuN6K22/1R
         xbHaCNL+x8tRgCssTZICLQH3e2Ym08zAhtCFadc5lJQGl+Jj5g2FeXNjCQrrylYbGKH4
         rORmcK/L4fGfQ4i7EpkiF7Pg2cFhDXmRAxEmYEXqgCz+CsiJqf+2WYy1fD4vumzJzzIx
         YV6Uafz9oIW+6m+7B2QomUWCEBAqSg22ZJLKr5P/6pkbI+NnbLaBUlM5FDOfS0u5uRCS
         MBKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tK64RKrBiNmUNUtAV9LJ8auzL3hJ/Q01IzsSOMFznhI=;
        b=hfskR9EfjQT6DtF1ysChbYefbFmHLA43nE8n4jbfGf8CKp2/+fAkiqUfR35sUkfLVH
         M3ocRwBqVWkv8IArW6HCD1FIHGepQS50iAhTzmd2KRx1180T0CIehRUSrNaI06NlMfT/
         Uw9IKxxNN+B8es1Mbx6vsEqL+4QlVCsKN6mraT2qIVZzrlXYrjwjL9wc+JIKrFR8ugBK
         zuRP2FvvBuFdJXBtQNob2bnoZwnNwkekx6kqSErsUUhu76XELxumPz6woJdAsjRhHbI3
         aQo5DJ2lyN1YzSLs1I7b5WXvXcpIkj9wE6BQgFjFgaWKkQzqarKjyXOfyPiSrZSxlS/U
         xhSA==
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
Subject: [PATCH 4.15 078/168] scsi: libsas: fix error when getting phy events
Date: Wed, 11 Apr 2018 00:23:40 +0200
Message-Id: <20180410212803.604769837@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400060314382853?=
X-GMAIL-MSGID: =?utf-8?q?1597400060314382853?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -686,7 +686,7 @@ int sas_smp_get_phy_events(struct sas_ph
 	res = smp_execute_task(dev, req, RPEL_REQ_SIZE,
 			            resp, RPEL_RESP_SIZE);
 
-	if (!res)
+	if (res)
 		goto out;
 
 	phy->invalid_dword_count = scsi_to_u32(&resp[12]);
