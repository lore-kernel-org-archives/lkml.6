Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49jBWjvny3/iO68dWWIjvQRcH/ZRXYdQ/mnRDQrPjM+p+nHQkcHSvemjozKPaTI4It/PlD4
ARC-Seal: i=1; a=rsa-sha256; t=1523472164; cv=none;
        d=google.com; s=arc-20160816;
        b=MojevHrVEKdffwanoOUc98Fsj8uCbDsb9GU7n1wjDN4cYlXOUICs+jt2EBWMeT16HT
         Q4YtiB6HlCY+STXd5NYtKs2Hqs+scAN3CJZm0PVyW43yrIn+4KODDY7dICRk83Lin7/c
         8efe2Pr8LZPUnlKcS7m+CSPmNeIRk/3QvqMJ6FvywC2ubftI+a0dXj9tYxF1hwtM13uS
         fIYpOzyKSk7VKJcrHZTrWvAGsFBB8rkOr+6k2bKYLAuDkBTtcjaCa1wtoOlzesC1gIG+
         DMT8rJ9WgOki9Wk9T6T10tMkH7M7jldg3Ud49n4uYxGZmzAaA2Y9yX6frQhC4DArTckg
         vJgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nCe/ffSXOTqgi5M/0VLMpfkH6x3klbbLedCsrGhV1R0=;
        b=fSfcgXpqC2Jt+r3DldQsW2AewBltAxTubVslU+XlVQrUTdDKfuK40/h2w5dgtx7l7F
         vTPvPqc+8wjXbqFio0RkjonQgFf3aAAI/hwfcfgX2pzsI9Ye80skIKJ4EapAA22JZ/nC
         roYriZq+fYYl5VqqobtlUpiGWSFpSyzuEDcwLKjoDKq7E5izmJoappG1vzCUTtZpl+VM
         +pz3pN7QfKl5U06bz4WbaqWr11c/VdNRbHWePXbyi7SP91oFNC76Z01A0QN5GEfbuYz+
         0oGD6xj+pKFFizrMDPWlQLaw4B1YN6TCSjYAB/tTEuOLNkXEzKSJYV++uXXYcjlwUeDP
         KQiw==
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
Subject: [PATCH 3.18 110/121] bonding: fix the err path for dev hwaddr sync in bond_enslave
Date: Wed, 11 Apr 2018 20:36:53 +0200
Message-Id: <20180411183503.603121371@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476349058540941?=
X-GMAIL-MSGID: =?utf-8?q?1597476349058540941?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1421,7 +1421,7 @@ int bond_enslave(struct net_device *bond
 	if (res) {
 		netdev_err(bond_dev, "Couldn't add bond vlan ids to %s\n",
 			   slave_dev->name);
-		goto err_close;
+		goto err_hwaddr_unsync;
 	}
 
 	prev_slave = bond_last_slave(bond);
@@ -1596,9 +1596,6 @@ err_unregister:
 	netdev_rx_handler_unregister(slave_dev);
 
 err_detach:
-	if (!bond_uses_primary(bond))
-		bond_hw_addr_flush(bond_dev, slave_dev);
-
 	vlan_vids_del_by_dev(slave_dev, bond_dev);
 	if (rcu_access_pointer(bond->primary_slave) == new_slave)
 		RCU_INIT_POINTER(bond->primary_slave, NULL);
@@ -1612,6 +1609,10 @@ err_detach:
 	synchronize_rcu();
 	slave_disable_netpoll(new_slave);
 
+err_hwaddr_unsync:
+	if (!bond_uses_primary(bond))
+		bond_hw_addr_flush(bond_dev, slave_dev);
+
 err_close:
 	slave_dev->priv_flags &= ~IFF_BONDING;
 	dev_close(slave_dev);
