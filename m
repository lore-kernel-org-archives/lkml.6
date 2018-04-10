Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48ygXHZTi+5F8X50/9g+5dr5SrRFsCz5tBmR+QiMcAES16vT878D2m7j+jWMx2LAIVcOmEI
ARC-Seal: i=1; a=rsa-sha256; t=1523399583; cv=none;
        d=google.com; s=arc-20160816;
        b=RUMjveUa8Cme1tkh5xXvVL1Or7UrdA25bACgD7+7Av8a3jFVeJ8c0NK/yGRl1G5SfI
         5kbceHrqoAWm5xfmBri3X/81Jzu/qE0vPFbyVXEnqOeUc2Jn3JFUqIoNQBo+nu+6KtOc
         4glbKNrVFL+JEtD/kGhoyyYtZdiyM232GjT4zsQ8+sdPLgnORSz8WxbCpmPP6pie6muO
         0w3KuVMy3ROSo6r1jTQk3bjPy/VuGuDsNwWe6d4vRG1il1gk/TZXf3Y7+oipPVDjB2zk
         UXeE5QjkapY/R9skDoqbsy05kmnq+wVSt5xUbgfjJTaJiGL0CGyQe4rPuuQxPBtJHY1i
         puSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cYjE3uRm5o8Ex8zIo86Z4UfUpnAeZJ1shC4YWgea1i4=;
        b=F9R/NW0RSN0aAf28rtZbxrMQFOc9wr02yYh+JqOd4/2+gbqQm67+L/mIYT+6YDnADe
         94odxz+HTROHmT9CypkiZHnp2qZm0fVRqpgNDyuLFL4hcJhhkZW0/VToW+h07Q6C9ywg
         l7aaGr4lV9ayyfIwRMp1jJCAJTZAM6d0CEL6zS08yIFcFYzRPzDBjopO5DZQA1l3VwXj
         zn00q7nP+ghNfqvgteqStaeUa6llqBXvaju9NSg1JfCZ0d/iIxh7MCj/Exlz0BeOhKJ1
         T8Jm0eWY76W0J2A2cOIpbHFG7UsA8ugTs/kabz3/OrFRjPFtOKnBRdM311OdP4Vd+GmU
         scnA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xin Long <lucien.xin@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 142/168] bonding: process the err returned by dev_set_allmulti properly in bond_enslave
Date: Wed, 11 Apr 2018 00:24:44 +0200
Message-Id: <20180410212807.131508846@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400241445808107?=
X-GMAIL-MSGID: =?utf-8?q?1597400241445808107?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>


[ Upstream commit 9f5a90c107741b864398f4ac0014711a8c1d8474 ]

When dev_set_promiscuity(1) succeeds but dev_set_allmulti(1) fails,
dev_set_promiscuity(-1) should be done before going to the err path.
Otherwise, dev->promiscuity will leak.

Fixes: 7e1a1ac1fbaa ("bonding: Check return of dev_set_promiscuity/allmulti")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Andy Gospodarek <andy@greyhouse.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_main.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1706,8 +1706,11 @@ int bond_enslave(struct net_device *bond
 		/* set allmulti level to new slave */
 		if (bond_dev->flags & IFF_ALLMULTI) {
 			res = dev_set_allmulti(slave_dev, 1);
-			if (res)
+			if (res) {
+				if (bond_dev->flags & IFF_PROMISC)
+					dev_set_promiscuity(slave_dev, -1);
 				goto err_sysfs_del;
+			}
 		}
 
 		netif_addr_lock_bh(bond_dev);
