Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49vXPa7fXW2RnTkKB/NHeFlf/t3s+FOPeLTbdGe62fUWs+81UYL6kr2jmT9KZowQBBdJk1A
ARC-Seal: i=1; a=rsa-sha256; t=1523399765; cv=none;
        d=google.com; s=arc-20160816;
        b=cpJMDF6mfapNdimJEG2oQjeyN3TEn+sWH04TYMdGRyg8LfE+avGc1GTCl5jaaX1hTe
         TmGQxwsHxG+VxZjEQMCeqBmAt4X2sBNvRvKng3oQHtymguzONCU6PzW/bW8fLMctD5fP
         GAWN2V9LExQ2H0+YwpRxiwOHSdbXaffESer0K3SMeqEkLb1ufwSaVKvRYhRhNrghgIIr
         khLUiwigMhEQ0pWZpk3PUp/cHkTY0vCRaKjgUKz5R4d8FIyxlysWHosstxAj4bHqZ35P
         L0rX9pQ2WN8WXX+p+LQ6grEhI6UohlIrfhrABwU4tTsxoHhz7LoAHICF9NT+sZDg5Y6G
         7d4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Isp4NHX9TO3RkQoNFweQ8rbbB+3/mZOABk94fKj2qMY=;
        b=yAKwHGZ8O8YScvT3o0ERKNX6VeDS/xToLFAnK1ArIFgLRjFhR+RJTRthb1wuniNu2M
         0FHw3xN5+RJLJp9ehAyrjILSXOXo5VMZZzoveD88mKCsJieegbunqrCz7eUmdXHKyN/u
         lEOwX91gKZU5FLpU8+4k0xREhvbMBooKuvHG07cQVIGQuPlYE0Y36NYp/5+BhKG61lv7
         BX/r2shhzVfajzOUdWlYC6fR0w6xwj306XL0sJcsAt7YgTAN3MaaBBvwJUEFrON+b03L
         /VhTIoiQA7LmFj9qA5Ek/mR/h/ZJ5CNw/YXZHOloCQsGHyVTPivI1RlSA7kLZ/1T1G8C
         mCQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Fuyun Liang <liangfuyun1@huawei.com>,
	Peng Li <lipeng321@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 056/138] net: hns3: fix for changing MTU
Date: Wed, 11 Apr 2018 00:24:06 +0200
Message-Id: <20180410212908.583415353@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399984249014896?=
X-GMAIL-MSGID: =?utf-8?q?1597400432454166132?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fuyun Liang <liangfuyun1@huawei.com>


[ Upstream commit 5bad95a1e55f4d5bb41e130db859d57eaf1b1549 ]

when changing MTU, The new MTU must need to be set to netdevice.

Fixes: a8e8b7ff3517 ("net: hns3: Add support to change MTU in HNS3 hardware")
Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c
@@ -1313,6 +1313,8 @@ static int hns3_nic_change_mtu(struct ne
 		return ret;
 	}
 
+	netdev->mtu = new_mtu;
+
 	/* if the netdev was running earlier, bring it up again */
 	if (if_running && hns3_nic_net_open(netdev))
 		ret = -EINVAL;
