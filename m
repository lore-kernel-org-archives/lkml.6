Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+iHSSQMSdrlInKvEEI1cPwiYoizHHIwzMur9EZ9dfVEJ7XoYyHtUprF90LSo2tUHLmwzsT
ARC-Seal: i=1; a=rsa-sha256; t=1523399701; cv=none;
        d=google.com; s=arc-20160816;
        b=WpWGXV+J6Fvu3YWYePz5o1q8V5AkweoBHoC0nzmj9mZbKKzFOvawX9iq9oUBYcPWgD
         DrrYdzeWBKAneGQRmqj6lpMEtXt9sl3QHaoJHDYEwdmtpRyCaTblfvKBsVxTfqWF044+
         E89lkqw9Iyzi1KCGreSsqQWbVHKJ028CuowE4MOmqsV6+nfmbLh6RHnkkBKvCr82+xQZ
         3iXH0iqnh2O/33Yd7K6rea2gOw7uHwhKDSpGoe05MCMsdU2suR6V9tygdAAfqJ8uJhNs
         zH5jPKIw1a9tVs+VzYdaSsKz2tBnf1UMAovBpXDM2RXj00DHC1PYaK2wgyo9o0h7nRxB
         bY8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PFjxhHG3U/iLvgKy52762USHC3tFu61f+3Izkz4zxcA=;
        b=bBfC1m3mGxbSOCOzHackl9remJC4ariJoJkNenCIPKpmNHPKGb0jgX9A8DhMBx/1b3
         XQ11Lv1i3wwMxXjducjfuxK6w5399fEepxLFuK9i3UZVUOCZiSCWZMiUajuwrzAp2EtD
         peglAhjzhzYA+8Plgy/yids+jUKG+a+E7mq1iFE4HdpNo7eKmf2NDZnvCOKPfcUzFsIz
         yt6dlkbq/vEG6PPmAhJekRM9xdczoq7jx1U5vBf7suM8wd01HzItQpLCByDPk2pt2pZt
         kVrx5h+G1OR/3ci3SXf0ErltO6M7v6BrH64PiYRG+oSXMn2+qdggxynnu5Vvly9ZNmqp
         OvUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Peng Li <lipeng321@huawei.com>,
	Mingguang Qu <qumingguang@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 012/138] net: hns3: free the ring_data structrue when change tqps
Date: Wed, 11 Apr 2018 00:23:22 +0200
Message-Id: <20180410212903.575782322@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399868116740967?=
X-GMAIL-MSGID: =?utf-8?q?1597400365565483708?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peng Li <lipeng321@huawei.com>


[ Upstream commit 99fdf6b1cadf41bb253408589788f025027274f3 ]

This patch fixes a memory leak problems in change tqps process,
the function hns3_uninit_all_ring and hns3_init_all_ring
may be called many times.

Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Mingguang Qu <qumingguang@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c
@@ -2687,8 +2687,12 @@ static int hns3_uninit_all_ring(struct h
 			h->ae_algo->ops->reset_queue(h, i);
 
 		hns3_fini_ring(priv->ring_data[i].ring);
+		devm_kfree(priv->dev, priv->ring_data[i].ring);
 		hns3_fini_ring(priv->ring_data[i + h->kinfo.num_tqps].ring);
+		devm_kfree(priv->dev,
+			   priv->ring_data[i + h->kinfo.num_tqps].ring);
 	}
+	devm_kfree(priv->dev, priv->ring_data);
 
 	return 0;
 }
