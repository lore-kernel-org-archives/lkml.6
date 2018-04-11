Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49gHM9Cyw8xKqKrGx+fM4RusO7m2IL1gogrNvyHGg+ovYkBlqGe99okCEaTXieDZC2Yj6xz
ARC-Seal: i=1; a=rsa-sha256; t=1523472743; cv=none;
        d=google.com; s=arc-20160816;
        b=fpug43Isu/LODEtZAzftEy5FwZzBznUs0lRwQFbgfiSFQpGl6d1H8gb+wde9lZNAix
         vikce29rdsgTe52wCAUNlGSm6PQ6QpqeOU1PRgNZ1ZZKr3FzeLSLvdzKBCUzFLYZplJ1
         ggZ6yfhpJBfU83huqdkT/rsa1Gtbk8MXEjpB2L6qGrU4AXmXo7gOHOZFfNfsV9Zi3kHR
         l2OSnSkaFe9FH8mC50/SvmZ/kkiydih0FWreAQrMuGzG3dswLoF3CiAsXsoMmj8u3GE8
         d0w5cH4IOPVZIoWJLnrjHtd4t9dEhAaGHupOr11bUe2+6zxgYY1tPC+ZL1JGtXjuVfQZ
         ITkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8XC8+r8+kiS7mlPZdTDhi2c2vDyMKB/0cBMlvJplwC8=;
        b=KP1rCU0WwHPvFc4uBY+yhy831vCqQVDwZOEdk4Iq8YSob5Clz0S8Y+5Y87jAFpL5Hz
         RORfrFiRftuSIJcXEX1C8M9ofNWcu0Fd4CI6uQTPYvS5LEevHusMwjTgoKmrsJD3zvA7
         yi0cdnxpd2E/YtWunI6QdAt1/ArmDmUNZBYxODklLwle/lQc+b6gxT3wrpma+7r4dgnY
         hubbf7Tdi5oHkjOrVMby6sYVIlUOHCuBrn4To7zQuaBTp4x21pxvNHjdi/LgNgen4RcR
         /g16yTmnkVnbs9cv7fwhJm/PNyT+ROY9MZgPjG9ZK4/jUtYrB9JTUkzABUh6vESyVYjB
         WPQw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 176/190] vlan: also check phy_driver ts_info for vlans real device
Date: Wed, 11 Apr 2018 20:37:02 +0200
Message-Id: <20180411183603.295915333@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476955489488888?=
X-GMAIL-MSGID: =?utf-8?q?1597476955489488888?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangbin Liu <liuhangbin@gmail.com>


[ Upstream commit ec1d8ccb07deaf30fd0508af6755364ac47dc08d ]

Just like function ethtool_get_ts_info(), we should also consider the
phy_driver ts_info call back. For example, driver dp83640.

Fixes: 37dd9255b2f6 ("vlan: Pass ethtool get_ts_info queries to real device.")
Acked-by: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/8021q/vlan_dev.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -29,6 +29,7 @@
 #include <linux/net_tstamp.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
+#include <linux/phy.h>
 #include <net/arp.h>
 
 #include "vlan.h"
@@ -654,8 +655,11 @@ static int vlan_ethtool_get_ts_info(stru
 {
 	const struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
 	const struct ethtool_ops *ops = vlan->real_dev->ethtool_ops;
+	struct phy_device *phydev = vlan->real_dev->phydev;
 
-	if (ops->get_ts_info) {
+	if (phydev && phydev->drv && phydev->drv->ts_info) {
+		 return phydev->drv->ts_info(phydev, info);
+	} else if (ops->get_ts_info) {
 		return ops->get_ts_info(vlan->real_dev, info);
 	} else {
 		info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
