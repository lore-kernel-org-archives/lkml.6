Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrv/LT5eZMHhlia7/FbbXqsO0nlPj8C4d3nW+JO9khQsJbTP0CbhOSEfon1XyAlqNhgjoTV
ARC-Seal: i=1; a=rsa-sha256; t=1526631482; cv=none;
        d=google.com; s=arc-20160816;
        b=W7Y0mO5OC58EOhRhaqGVYPae1IYkScJx6ROB+D9xirIjbc9AOBbLiL8L8IaZOm4XBL
         cVyjCoDhBijAcpVF9FjmW4vDesUz1MZbkM9JOs+1su5/ErvnNWAS8Bvd2dFLww3QzFJ4
         yJEzEscp5e23kfta20FzYGNZGG14SQKwpUKgTRkCyzpEI6AqkvwS/iRNnS2ww0pw1LJ+
         dDWjp7CgUOniR3mpTncslbnEAHL3nrzzE1ym/v5tN8PDCkSu9F6Ia7ZfH3kGP81J5WK1
         +IhPpyG6TIOrhwhC0NQ7rNJ+vvqyeX0qkYAaIWWK0h4NNCH93rFimo/XiKNVILQvZK6G
         bxPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=rf7XFg6fkSjTUbsUCkRP/hrj7jZ8yEMaNsUA18dMRbM=;
        b=cEmwkd5XS7vNx+UByX9MHQ81o56MycRM0oS9X93ReMjsxKbXRuCMclxmoDaUJecEuM
         9R7VR+mG0SEH0BPCgSwCqKntHM7MBMIlXEN7ApKRt05NZGZAmYrQ98iFxgofVT2pDbk4
         pBoD/HTbItabe5P57UaSwFeRwAx113Ihxm0FaKu+XKt6AOtBWt6HHN5IGk4+iIzQrH2L
         iBV5dYDR/TSBGOiZUTGB3QuKakSP37BeaVHMYteOFp4/sqUarmSGAYK0elJYXNPbVoc+
         QZyMhCAS7KNn7mITuJI2oZ+rp5X0lAcO8RlR60wrCi3+ELkaSQLVUScrGNdiWXyZEtxu
         V6EA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=WGOCjyOY;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=WGOCjyOY;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 36/55] hv_netvsc: set master device
Date: Fri, 18 May 2018 10:15:32 +0200
Message-Id: <20180518081459.171692814@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789134050894901?=
X-GMAIL-MSGID: =?utf-8?q?1600789134050894901?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1840,7 +1840,8 @@ static int netvsc_vf_join(struct net_dev
 		goto rx_handler_failed;
 	}
 
-	ret = netdev_upper_dev_link(vf_netdev, ndev, NULL);
+	ret = netdev_master_upper_dev_link(vf_netdev, ndev,
+					   NULL, NULL, NULL);
 	if (ret != 0) {
 		netdev_err(vf_netdev,
 			   "can not set master device %s (err = %d)\n",
