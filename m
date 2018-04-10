Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4863mLU6XrLZfajzcViUgcynBJguWbLwPHi5DFmRknowMagdT7+HOWk3lZe+ChuTQzTyJc0
ARC-Seal: i=1; a=rsa-sha256; t=1523399596; cv=none;
        d=google.com; s=arc-20160816;
        b=Y/ov/BKDMRuTH10NalnKGFS9brq8PCyocd4Gv6P0XDLdrpG6coIzLNMOPcjSy3+Sui
         jrUBt0oAtyQpvkZ2tEWVSiHWUpbnAQPyw1i6X1ifxt52QWmfFvV/cIAl8BygZvMq0w62
         sqbaTy+3nSi/UqYmXU1SqJHNZj172mIfSGwTbCBmCFCI5CHqD6CNBYNqNeXZN4MSZ7fA
         YUu2EQFXowwinTyEg2wBUvSIxPGhLltehaP+Fn/rbsNMei/iSvbRpu0bzDegdVjgUeyA
         nwcQ0SSi+0eLlU13ldmeHHAmRzhtrPJqXxvJZA0Rv9SsfUQ7QJgQolqd1CawvxPGJ5fX
         puhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6fsfoEBK+8UHLmmrFZfx7pm1e7ACfAnxxUh95UjD3oc=;
        b=jj2MyiqB6KwTmXy6kc5a/xCim5e/Bjdgpq9S5IHVGdBJrDDby5owjoH/qFl1SeHnoa
         z8iZtejLbsax+SyYGt1udwaks6sJLVrgSM/DGSNEOpAyF4JpjJYKrfDrfVXtEzxbLtvi
         qJOWir8Mp9ZcLr6nviZohO+jiyKZwGMlLQ9s4tnCHSPDoBA8QddPagfEYF4j1GxEyXAG
         PGaUOMJzchnKLRQ3vtUVHnUULSxC1MuoBAcrV6tO8zV5dtJXdT4oJbDFEY2hMGMj0enP
         HfHK3mj4yd4h8GNhs8lFVu40EHpXy2aEN7Fx6gHyhFG1+OC1E6Jr/UvUICfkn1XUrQCe
         0I7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xin Long <lucien.xin@gmail.com>,
	Jiri Pirko <jiri@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 166/168] team: move dev_mc_sync after master_upper_dev_link in team_port_add
Date: Wed, 11 Apr 2018 00:25:08 +0200
Message-Id: <20180410212808.289995216@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400255758993490?=
X-GMAIL-MSGID: =?utf-8?q?1597400255758993490?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>


[ Upstream commit 982cf3b3999d39a2eaca0a65542df33c19b5d814 ]

The same fix as in 'bonding: move dev_mc_sync after master_upper_dev_link
in bond_enslave' is needed for team driver.

The panic can be reproduced easily:

  ip link add team1 type team
  ip link set team1 up
  ip link add link team1 vlan1 type vlan id 80
  ip link set vlan1 master team1

Fixes: cb41c997d444 ("team: team should sync the port's uc/mc addrs when add a port")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/team/team.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -1197,11 +1197,6 @@ static int team_port_add(struct team *te
 		goto err_dev_open;
 	}
 
-	netif_addr_lock_bh(dev);
-	dev_uc_sync_multiple(port_dev, dev);
-	dev_mc_sync_multiple(port_dev, dev);
-	netif_addr_unlock_bh(dev);
-
 	err = vlan_vids_add_by_dev(port_dev, dev);
 	if (err) {
 		netdev_err(dev, "Failed to add vlan ids to device %s\n",
@@ -1241,6 +1236,11 @@ static int team_port_add(struct team *te
 		goto err_option_port_add;
 	}
 
+	netif_addr_lock_bh(dev);
+	dev_uc_sync_multiple(port_dev, dev);
+	dev_mc_sync_multiple(port_dev, dev);
+	netif_addr_unlock_bh(dev);
+
 	port->index = -1;
 	list_add_tail_rcu(&port->list, &team->port_list);
 	team_port_enable(team, port);
@@ -1265,8 +1265,6 @@ err_enable_netpoll:
 	vlan_vids_del_by_dev(port_dev, dev);
 
 err_vids_add:
-	dev_uc_unsync(port_dev, dev);
-	dev_mc_unsync(port_dev, dev);
 	dev_close(port_dev);
 
 err_dev_open:
