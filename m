Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48kh+3+STqJBa52oAbuB3qGEJX16vwF6N/XE7IRq0Hmii5D9LpmkcUMyKTisne8DcHrhvrh
ARC-Seal: i=1; a=rsa-sha256; t=1524652663; cv=none;
        d=google.com; s=arc-20160816;
        b=gTdmdy1oLguI8Qa37/nAJpJp3H4n3ju4yro2f10CAPTCvRm0mVY1F6vJS9NSeiuBsL
         u/A8iRUdWJSjgYQ38Zv0XntUSNKJTNtqeJQmRwD13+WxxCJLkuRykKB1s7D3tAufvytq
         vTug+8ccdwKzOa7a6ai1kX2RxCUePoAEOdYbcUBKwpQwA8p034qa3W76esO48Bf/QMI7
         4GTy1eom7GdCgXB7fuVPw+mXEqnRVpL+hREcuet87MhC/SCscwJAzwBZ3Ds0JJRQ/kI2
         l8RwGxpxtAAI37K7DKIcTrxz+7tz+GXGyMVaqr1jJeqcxpO95wGq8J5Tnw0VU4081mr+
         77xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+/Sy6G9/buQQLlRt/AZnxjmJqHirAeD3KGJb/3LZ4dI=;
        b=priE2wh4Tg7V1q1NtzzodBDOyaqpn31u6ErE5PzzitzpkQCuXaCkD8Fw3U0l6Hmb7H
         GxljPbomcDgiLeRB29uHoks+k/QbLv4PCzX0cfY/KfOdrTkkswvu1TQnyG/mgDDai7dJ
         douyQ+GzM0fZfl6gOYLEam6hLHdgK3iKn/0d+vljx/1ocy4V/39/jeXaQjHaTVHQQ+M4
         6h4rN6ohbHfcKnYXLUINBwvTfsZR2piXB+XOAKdns9fpf/fP2TYAgMk9BOyJcOUiwSZJ
         Hhnd/NG4AvBzVl6jrh8r7KJhVG8kO0WSY0CkY1/+zq5m63fyQ7rs4AYbaEbGkdLO5VuO
         8RDg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Parav Pandit <parav@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 023/183] RDMA/core: Clarify rdma_ah_find_type
Date: Wed, 25 Apr 2018 12:34:03 +0200
Message-Id: <20180425103243.537628810@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714190911088695?=
X-GMAIL-MSGID: =?utf-8?q?1598714190911088695?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Parav Pandit <parav@mellanox.com>


[ Upstream commit a6532e7139660c103dda181aa5b2c734aa26ed6c ]

iWARP does not use rdma_ah_attr_type, and for this reason we do not have a
RDMA_AH_ATTR_TYPE_IWARP. rdma_ah_find_type should not even be called on iwarp
ports and for clarity it shouldn't have a special test for iWarp.

This changes the result from RDMA_AH_ATTR_TYPE_ROCE to RDMA_AH_ATTR_TYPE_IB
when wrongly called on an iWarp port.

Fixes: 44c58487d51a ("IB/core: Define 'ib' and 'roce' rdma_ah_attr types")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/rdma/ib_verbs.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -3766,8 +3766,7 @@ static inline void rdma_ah_set_grh(struc
 static inline enum rdma_ah_attr_type rdma_ah_find_type(struct ib_device *dev,
 						       u32 port_num)
 {
-	if ((rdma_protocol_roce(dev, port_num)) ||
-	    (rdma_protocol_iwarp(dev, port_num)))
+	if (rdma_protocol_roce(dev, port_num))
 		return RDMA_AH_ATTR_TYPE_ROCE;
 	else if ((rdma_protocol_ib(dev, port_num)) &&
 		 (rdma_cap_opa_ah(dev, port_num)))
