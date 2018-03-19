Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs7sUlxM26/OwJ/wpkYmm/rGsLa8wqo54vcbApomJV+5Zl6ISzQ2l8Nf2ZghBUsfFzkI0Ui
ARC-Seal: i=1; a=rsa-sha256; t=1521483158; cv=none;
        d=google.com; s=arc-20160816;
        b=hpgle7xGxghOeBfwKU9dxbgpe3MhJg9fIGu7WgYJkopm9wFQl3iwnqYmSH+QXEhDft
         auSHKtjlxgYcTVa1TLpogYWHIQXcPqzEVSMofnk1A6iOSrDV++TS0XcmHXAGi7u3VYtT
         dRapX+Jn/CpW/M6oqExTGGRQtRm1jDnFuWiIjvLJq8PcaHWXaHELZJjHJGZRqyyxLS/C
         3PLaEfF0/ZlyV9Z2yokLSzW4qc0PbVKAWH/h6cy5FCc9KTtjRyau7gOO7tLTHowbQbfy
         HKMerX44Ogsd/UCYpjZZ43Ru/ts3BRwvVKi5VUsiFvZi7UKdALds3I6isvDAsaqLW/Cn
         Vl2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vc7V/v2ipCpfTTB812+v0l1sU+dUoLCCJOHrFaUnHtA=;
        b=pPILhCcd2Pl72YsqP8fgu6opHDlnC/BHhPpIO0Q0wofqBSTCEdki62Mo0QJYhM+gsT
         uNtc1ovEMJPicmAKETEWuH9jMRy9YLQizAA2mbiP9Cxny3Ux8pfGe+Z91zSlJF4dwlZR
         xb673+CUghEknq3Nh0nI5+JOWnUBOdBqJVL75su/BGeFHK7WmHTJ1hKEeMAH3EwvbdMJ
         YEttqA/rUQKOwa8/J9vZYls+FWpUywWWxDkoqHeunCyA4AZiWf37epgbDgpl0tNsqjqS
         Ns6iGpoWaPdD2grd9Jy4R3DI1Ng576mX3NofYGHBOu6EPwuUnlgtmaB+otk8O8v8gfsh
         oHBw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexey Kuznetsov <kuznet@virtuozzo.com>,
	Patrick McHardy <kaber@trash.net>,
	"David S. Miller" <davem@davemloft.net>,
	Andrei Vagin <avagin@openvz.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 020/134] net/8021q: create device with all possible features in wanted_features
Date: Mon, 19 Mar 2018 19:05:03 +0100
Message-Id: <20180319171852.070705529@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390724374058886?=
X-GMAIL-MSGID: =?utf-8?q?1595390724374058886?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Vagin <avagin@openvz.org>


[ Upstream commit 88997e4208aea117627898e5f6f9801cf3cd42d2 ]

wanted_features is a set of features which have to be enabled if a
hardware allows that.

Currently when a vlan device is created, its wanted_features is set to
current features of its base device.

The problem is that the base device can get new features and they are
not propagated to vlan-s of this device.

If we look at bonding devices, they doesn't have this problem and this
patch suggests to fix this issue by the same way how it works for bonding
devices.

We meet this problem, when we try to create a vlan device over a bonding
device. When a system are booting, real devices require time to be
initialized, so bonding devices created without slaves, then vlan
devices are created and only then ethernet devices are added to the
bonding device. As a result we have vlan devices with disabled
scatter-gather.

* create a bonding device
  $ ip link add bond0 type bond
  $ ethtool -k bond0 | grep scatter
  scatter-gather: off
	tx-scatter-gather: off [requested on]
	tx-scatter-gather-fraglist: off [requested on]

* create a vlan device
  $ ip link add link bond0 name bond0.10 type vlan id 10
  $ ethtool -k bond0.10 | grep scatter
  scatter-gather: off
	tx-scatter-gather: off
	tx-scatter-gather-fraglist: off

* Add a slave device to bond0
  $ ip link set dev eth0 master bond0

And now we can see that the bond0 device has got the scatter-gather
feature, but the bond0.10 hasn't got it.
[root@laptop linux-task-diag]# ethtool -k bond0 | grep scatter
scatter-gather: on
	tx-scatter-gather: on
	tx-scatter-gather-fraglist: on
[root@laptop linux-task-diag]# ethtool -k bond0.10 | grep scatter
scatter-gather: off
	tx-scatter-gather: off
	tx-scatter-gather-fraglist: off

With this patch the vlan device will get all new features from the
bonding device.

Here is a call trace how features which are set in this patch reach
dev->wanted_features.

register_netdevice
   vlan_dev_init
	...
	dev->hw_features = NETIF_F_HW_CSUM | NETIF_F_SG |
		       NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE |
		       NETIF_F_HIGHDMA | NETIF_F_SCTP_CRC |
		       NETIF_F_ALL_FCOE;

	dev->features |= dev->hw_features;
	...
    dev->wanted_features = dev->features & dev->hw_features;
    __netdev_update_features(dev);
        vlan_dev_fix_features
	   ...

Cc: Alexey Kuznetsov <kuznet@virtuozzo.com>
Cc: Patrick McHardy <kaber@trash.net>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/8021q/vlan_dev.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -559,8 +559,7 @@ static int vlan_dev_init(struct net_devi
 			   NETIF_F_HIGHDMA | NETIF_F_SCTP_CSUM |
 			   NETIF_F_ALL_FCOE;
 
-	dev->features |= real_dev->vlan_features | NETIF_F_LLTX |
-			 NETIF_F_GSO_SOFTWARE;
+	dev->features |= dev->hw_features | NETIF_F_LLTX;
 	dev->gso_max_size = real_dev->gso_max_size;
 	if (dev->features & NETIF_F_VLAN_FEATURES)
 		netdev_warn(real_dev, "VLAN features are set incorrectly.  Q-in-Q configurations may not work correctly.\n");
