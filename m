Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+Sy6wRxPu5EmQN4x72568diJ3xqFvDRcPRpUvhEJb0FXOTzvasSWpHn1Pxs3xXkalVR9w8
ARC-Seal: i=1; a=rsa-sha256; t=1523399577; cv=none;
        d=google.com; s=arc-20160816;
        b=tPG2dLDb3Uz4LIT7Vksj6hkuRZC/Z8AKiHBBLqSf+RLNrC3mvUMKvxzUS3MPriPXo8
         D7YAD9KuCbpygeEXE7p5j1JbrMrWtIZMi/34GDyMJArBqahv03kTuNy+MMEBoFjqmnxT
         +upj7vGImTRrziTgcR1SW6hMdkh8k0BpYoThQJHh1NRn1HONb4L5PdNVYavvaiw5eTuP
         GXBUD+TFfjPHnoguakYrC00veGmLLZrty5sblrjtaRDj3LTiNhHDo+Pa3PL0or1zXYb3
         M8IkhXVWKAnckYdiSvYAmIM4nMtm4yPPBiVIiS1PQFt3Z7kh5TCUEeNVGdR9u64Ms6py
         4dgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FnyKyu5V51PbqGPyV34n3ybo6CIt8s01siVtJ3FNHE0=;
        b=Rp1TpoYGFrdksanfEDaGH5cLagcpaV4su7X4tpAm8xfBNBzMyz7qZ1EmhtNpJkK2tY
         aNyhiLE11Df1dHDGHP4CbEY4Fhc+BToZzfYr1NFEyPIz2z+YPcvTrgj8iI46ONwHul1O
         x2OMqbsXXxfY1LNYRHNPQg7zTSBY7onKC0gn9asD0FENINtsCvvMigpZakh6Saq0axjR
         TgZdmGJFeV5U1Vq0JqxyBWPAI/6FmvXbYEp/EE/h2kZOBnNRSr+CoVO1sD2JV8w/aXE7
         BXNK2l3ZWFGGTU2eB64Wcp3UZNn6o+fAu37p/YnVbRo6aY4KgbZcI1iO/kVr5C5tjkQ+
         8gjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xin Long <lucien.xin@gmail.com>,
	Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 140/168] bonding: fix the err path for dev hwaddr sync in bond_enslave
Date: Wed, 11 Apr 2018 00:24:42 +0200
Message-Id: <20180410212807.037974125@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400235959751975?=
X-GMAIL-MSGID: =?utf-8?q?1597400235959751975?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>


[ Upstream commit 5c78f6bfae2b10ff70e21d343e64584ea6280c26 ]

vlan_vids_add_by_dev is called right after dev hwaddr sync, so on
the err path it should unsync dev hwaddr. Otherwise, the slave
dev's hwaddr will never be unsync when this err happens.

Fixes: 1ff412ad7714 ("bonding: change the bond's vlan syncing functions with the standard ones")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Acked-by: Andy Gospodarek <andy@greyhouse.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_main.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1565,7 +1565,7 @@ int bond_enslave(struct net_device *bond
 	if (res) {
 		netdev_err(bond_dev, "Couldn't add bond vlan ids to %s\n",
 			   slave_dev->name);
-		goto err_close;
+		goto err_hwaddr_unsync;
 	}
 
 	prev_slave = bond_last_slave(bond);
@@ -1755,9 +1755,6 @@ err_unregister:
 	netdev_rx_handler_unregister(slave_dev);
 
 err_detach:
-	if (!bond_uses_primary(bond))
-		bond_hw_addr_flush(bond_dev, slave_dev);
-
 	vlan_vids_del_by_dev(slave_dev, bond_dev);
 	if (rcu_access_pointer(bond->primary_slave) == new_slave)
 		RCU_INIT_POINTER(bond->primary_slave, NULL);
@@ -1771,6 +1768,10 @@ err_detach:
 	synchronize_rcu();
 	slave_disable_netpoll(new_slave);
 
+err_hwaddr_unsync:
+	if (!bond_uses_primary(bond))
+		bond_hw_addr_flush(bond_dev, slave_dev);
+
 err_close:
 	slave_dev->priv_flags &= ~IFF_BONDING;
 	dev_close(slave_dev);
