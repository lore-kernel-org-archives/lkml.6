Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqUebyEyV2tl3/BcKUgigC7bzgN0kQHOzm7eOwVkNNmT5tEn+kHsy4NzmNam6sOwejauFwU
ARC-Seal: i=1; a=rsa-sha256; t=1524837633; cv=none;
        d=google.com; s=arc-20160816;
        b=Nq8kBlSYo/B+jLGx4yxgjF/A0Ks47R4aI5TrQ+xfy+lLXiYu66mNom5sCod2yD7qgS
         YzCop8FSI/Ttkf7W+b9mXFzacUbgqHF0BbxFXELUHXticUBy8pBoUW9mkkGebHFSQo8e
         8WfeKUWdy+Q0+7gI6HNuhkd3y3rrtuJNtubIg8Yq8UhKbK+spwdECNPousZr0k40SidQ
         BClaZ1NxIvYfHj+5eIvhURxHqkbc1jo8SKkNPz11Aezvdr7u53uT/g4vvGss2OzeBI99
         bMvJkxiW58hzDNsJCRN/V2r0FqAWmWAJ2ap+fvTs483v+YptE4rnHW3OaKIFZdxoxMN2
         8iLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=N7EcJaIoawjTGGC3sTASGstoI/ksNQeCa1Ful2gXHFQ=;
        b=j54JXpQA8AqrDhFlEqojD2b6Gxz52DCTBBdI3NElJ71qcHpVR35vA75bgLS+VJ4T/P
         G58vrv0FqQgSJdHYOv+/wU1cuoUsmaKU8v62Vs6jhCIlkmMf7QyERuAOYrgFU+Y/qC9c
         K1WzKgquIky/DX/L3o1KzPaS5QicWI6BPgQXLJZR68OctBYfg+v+G41qZlHsCfrfU4UA
         UmMm86CBqAuVaCK7Oap8McR71S6gKEz4OBTQLKOXcjYxE8XWnYhWX/ViRanjDsTgxwIK
         29lcJGFJ6PxQATJp2JXlm+rFW9zYkVespMyuIbdP0s/XRURS77upV5TI6bxBL4huLhV9
         F8Cg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78CC521897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 09/24] bonding: do not set slave_dev npinfo before slave_enable_netpoll in bond_enslave
Date: Fri, 27 Apr 2018 15:57:44 +0200
Message-Id: <20180427135631.968715007@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135631.584839868@linuxfoundation.org>
References: <20180427135631.584839868@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908146234977294?=
X-GMAIL-MSGID: =?utf-8?q?1598908146234977294?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>


[ Upstream commit ddea788c63094f7c483783265563dd5b50052e28 ]

After Commit 8a8efa22f51b ("bonding: sync netpoll code with bridge"), it
would set slave_dev npinfo in slave_enable_netpoll when enslaving a dev
if bond->dev->npinfo was set.

However now slave_dev npinfo is set with bond->dev->npinfo before calling
slave_enable_netpoll. With slave_dev npinfo set, __netpoll_setup called
in slave_enable_netpoll will not call slave dev's .ndo_netpoll_setup().
It causes that the lower dev of this slave dev can't set its npinfo.

One way to reproduce it:

  # modprobe bonding
  # brctl addbr br0
  # brctl addif br0 eth1
  # ifconfig bond0 192.168.122.1/24 up
  # ifenslave bond0 eth2
  # systemctl restart netconsole
  # ifenslave bond0 br0
  # ifconfig eth2 down
  # systemctl restart netconsole

The netpoll won't really work.

This patch is to remove that slave_dev npinfo setting in bond_enslave().

Fixes: 8a8efa22f51b ("bonding: sync netpoll code with bridge")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_main.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1505,8 +1505,7 @@ int bond_enslave(struct net_device *bond
 	} /* switch(bond_mode) */
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
-	slave_dev->npinfo = bond->dev->npinfo;
-	if (slave_dev->npinfo) {
+	if (bond->dev->npinfo) {
 		if (slave_enable_netpoll(new_slave)) {
 			netdev_info(bond_dev, "master_dev is using netpoll, but new slave device does not support netpoll\n");
 			res = -EBUSY;
