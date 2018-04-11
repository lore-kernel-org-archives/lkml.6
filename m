Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48aPHn0uBgqB6/9MSRxktg9KGOKKxv6bDkSammxuGWJgXQqNOz86ZbXUWEtmZqM10/L7dX4
ARC-Seal: i=1; a=rsa-sha256; t=1523472170; cv=none;
        d=google.com; s=arc-20160816;
        b=g7WlyPQUF35aummC24edpR73sJfWLZAyyd8yhJ5rOW2Gs+tTWLX8vT8kRcCoMaU52e
         PKdqmLTk9QxSI95OxGlRSehWNCxI88yNG5iiIrQrFu77dkMKTWYpAudH+tsRD1+GKjVF
         lU6M1yvgcLZkV5ooWsAyozW9dnNOXidnwMhwtVL5ZBy7uByjYRKtZg7W0l3k6vc1vzox
         7fdotPIAiCydvbT2deeZ5yhwOqw6oJsiDQmibEZ6sVFP6JodepT+08rL+nBbU9yBb/Ow
         SSTbym7y3OxazfK8Jyx38Do2FWgBcrMk2BHYB2UtFtGCdWO9u51161LsGef1oDlcslUW
         ikMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=F14Xvuyt5RLBPpsQHeXQcsDkN1dsq5zdx27GdIhEI9A=;
        b=aNbTeBN9Y/iBuNc6PLMgwZqB88gXelGCgtZF9lwl5X6GritAnNuu3fVJ2icZURVmEU
         Q5aBU1f6F8p95qm1KROyuaOFhvBxKEVvHZXfgp3X8WhPozLuM2Ikl3umUXYvx6VEA1NJ
         19yBXU7FzJcOjvJ7PYEzI41NugdXxZnPw09UCeXL0x7jH7PRelJJmur/+N6hRrcS4Gpd
         0E9fpFhiQE8nDmtFwQQpucc+8zUybt3uQS15p33ZH6449cqomRp0WI6DYx/Hi7NwsBlK
         4/z05FCgd6wQ7la0FaJcbA7NnIaj/NK+dRwX/L6MybZRoS11n4o1/1DmNO8cjzW+LFFD
         LoTA==
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
Subject: [PATCH 3.18 112/121] bonding: process the err returned by dev_set_allmulti properly in bond_enslave
Date: Wed, 11 Apr 2018 20:36:55 +0200
Message-Id: <20180411183503.729507784@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476354379097090?=
X-GMAIL-MSGID: =?utf-8?q?1597476354379097090?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1548,8 +1548,11 @@ int bond_enslave(struct net_device *bond
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
