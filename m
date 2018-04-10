Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48pO3L9TAhB9Q9IKiPvl+E/9URMlgE5kTpE5tM/yryP9nxhTCwG8lAmlkZEdKsCRNppRvP2
ARC-Seal: i=1; a=rsa-sha256; t=1523399934; cv=none;
        d=google.com; s=arc-20160816;
        b=0X1q47oiXX/lD76iKy0w+ZAfNK9vQ3oXP54s5pey1CfiDnmYrpDoBgGlrgns9ayV7v
         19gLVJXCDWMjzUP9ednUvi4O7ngo8n6cf10ODk9xVbkYeOaExLWE/LQAEaAQ4GopW080
         0L+wI7gvxZ0hxJvD1/jrVx18zl6II9veLGJ4kTkuOCo4xn3LTzfZRG5qSMloXUkXR5zM
         TUzAXOdvXISOKtSj/emXZMjsqbnD7358nnIKwFxCDLs1EuSs58qjk6/mrDWHVm7KjaV8
         dRzjsIKs2XNAghUSCVj8zu8GVUZHbEJ5O9Uk0RGstxjKPM4aWZabFUYPDJk77rxvak30
         FfDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lILDBbfDVBrjKdhXMw2q6l2RKpdYvxXO4+fjO8+A3eM=;
        b=VE31SDOojaVqOFf+tifZ5+0u9/7pZP39h7ABBBR8WznpFS+aBcdBymVVnkI3R1jea4
         j2V7PLtrD0n59JOmGtYzc0E0vey7KFDyN18XxqoD1ja7b83OdWXpRBEOTyqEXHo3P49o
         dL16oa0KzAkVV028YE8Y9Sv2ulxS4R55P0nH/mV8XQkEdPgfDwInnrOZ+SmWndqyGVRo
         PEZOFaYQc7xd4c1hSgiVsls/kyVc3mMb4dgcqZeJxxanzRXArA9HWLdI+KnEmIWI8Iw/
         Wa8shUatfOFsyaL1DdQxoyx/dbxxd+yL6UoeYxIC4Jmi25otovmyDaulRfI+Z2g5UPBa
         AVfw==
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
Subject: [PATCH 4.14 116/138] bonding: process the err returned by dev_set_allmulti properly in bond_enslave
Date: Wed, 11 Apr 2018 00:25:06 +0200
Message-Id: <20180410212915.642286449@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400241445808107?=
X-GMAIL-MSGID: =?utf-8?q?1597400609151909919?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1702,8 +1702,11 @@ int bond_enslave(struct net_device *bond
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
