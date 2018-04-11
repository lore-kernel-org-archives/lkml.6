Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49rvANwWGSuyDYPgkL5EzX7Nk/qUt0XBlRcEWV+/AH2o9kl6zXa5M3ycZ5iBjsfThGEPClH
ARC-Seal: i=1; a=rsa-sha256; t=1523472751; cv=none;
        d=google.com; s=arc-20160816;
        b=vPAfoUY+zW7VXJGD9b7pmMsXsyuHBEOZaa5pch9wpK5ft0FOW6eSvLNz9cKbgPYN7e
         5JYXG0Cy19VdJGyZKInl2XPec3V7w5xdTP95qRhnXtdUh576b743F4576E06e8J5WkSS
         xwd88VPeAmJScwpNrsoJc9DAGcEUB7BlQzATGcNnrlY1GoZm8rzVfU/rR0ZGjMHw7UEC
         mRa/GQ+da1qAmR91Hvwj5n85Gxxt8KAhMWNBGVAJDWLGK3N6JheYnEbtY+QCHQQ4Uh/B
         h1rhP3rWX03s0stkQQt8+ydSEGGMmlrjw/eVf6gJe7busCAUVuI0R+CR2XumfphTuGf1
         fV9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oda3TiJot8GzyiQyyZi/bcSgiTf9qdeFuVfY8gcsi40=;
        b=DHVmVW61A9UP1KXz2M+xokJ0VkijwzseqaiOSCiOoOMfaXh348qBB+vOpHn+c6pa3/
         9KX5wI7V3W78ka2PiY4EHEIIKZgm4fgoX5SrkwELE9UNeUJD0E9CAOFFfX/Ndr6lwN7U
         hsiAK34yvE9qrw17UkDMfZmaq0rUs1KKNSHdHKsfznKDdCcHl/rjefgxcCn61c3qkErc
         Sp8uaRyVEmMFsbGQpG/g278GMIG5pxjgH8RBq0SoDBvQHmtTvngObyUK4kfLxMKBF4ce
         0FuYHmKwva+72bixAJzWfhZaXyd+Oj8xQXvSsTskudM7UnnRQDx31rH401hhNqbZlYil
         zn4Q==
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
Subject: [PATCH 4.4 179/190] bonding: process the err returned by dev_set_allmulti properly in bond_enslave
Date: Wed, 11 Apr 2018 20:37:05 +0200
Message-Id: <20180411183603.826001016@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476354379097090?=
X-GMAIL-MSGID: =?utf-8?q?1597476964073943584?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1660,8 +1660,11 @@ int bond_enslave(struct net_device *bond
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
