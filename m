Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqOiU55zqj01mIt3vzF3g4Y52JPm0ltbs+1/2VWuxe7sIWJuS8iSkhVrbsjuXhc+QV0wp5X
ARC-Seal: i=1; a=rsa-sha256; t=1526631628; cv=none;
        d=google.com; s=arc-20160816;
        b=juuD1/Xtzfifd/cbJz1l/SwG7evIxhQu7g/Pe5+o1wk6Szx5Udt9S11OVMwR7zHVpZ
         ZRx1xpFRIndr1SfNbJq/+lDCFXOiUiqVdnLXAAD4EtJcJO9Cdp1KVMMeAL3UoOygvKZj
         vdR1/33SfAvRu2K2qnJKnjYnl/owVeV05G+9wciiB3Norzir8LINGPUSwQex+FnBMl+R
         mXBLqOIykc4S6d4HCWKlfkHU5KiIffqTzDNOLNsWQQTW/yUDr/7guxhK24E4P2TpLmWC
         8OMs47RyhzZgMfYHPxdvNVx5vmCSdhmgftDnU8xj6/Pdh4YS6HAFIBj1OIsIRR7YWkHM
         ed2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=0cFEzakhzj/6haQp7THSeM1pCwzQGR0nXhqHS6YxvUU=;
        b=HeQV1zyDVUgNLY6MBDvxvLITaIksKBkyooq47Tx5WOfUKE1hCN9gFEYfOZPptDjzRt
         asBFW1+iqwddV6Rnl6KQeAzv1C2m6VoKCgTR5SdeEzJSxgOyN0dtO8ktRKz6HTJBKC5T
         EwPf//L96+msJKs2o5fL5792ck9ZEyKHXuurrIzWbiMfkA8d0mxSoHk6mv1qewe6PeUA
         f++bUnO3Lf+XVbd1egEnvX3Rses+T0j+bUd/8S7wY2JZfFqKOEviEW/8FXX0RuAY4Owj
         1g3QckkmnNvOLprW7bN8/lQMOj9b92tW+CfytbTWeHEUOYYypoJSpfOTZO3S9XOtnD0s
         JSEw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=oKoXZ53Z;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=oKoXZ53Z;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 35/45] hv_netvsc: set master device
Date: Fri, 18 May 2018 10:15:52 +0200
Message-Id: <20180518081532.160649207@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789134050894901?=
X-GMAIL-MSGID: =?utf-8?q?1600789285790413024?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Hemminger <stephen@networkplumber.org>

[ Upstream commit 97f3efb64323beb0690576e9d74e94998ad6e82a ]

The hyper-v transparent bonding should have used master_dev_link.
The netvsc device should look like a master bond device not
like the upper side of a tunnel.

This makes the semantics the same so that userspace applications
looking at network devices see the correct master relationshipship.

Fixes: 0c195567a8f6 ("netvsc: transparent VF management")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/netvsc_drv.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -1742,7 +1742,8 @@ static int netvsc_vf_join(struct net_dev
 		goto rx_handler_failed;
 	}
 
-	ret = netdev_upper_dev_link(vf_netdev, ndev);
+	ret = netdev_master_upper_dev_link(vf_netdev, ndev,
+					   NULL, NULL);
 	if (ret != 0) {
 		netdev_err(vf_netdev,
 			   "can not set master device %s (err = %d)\n",
