Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49U9Q8TOee9ujIv5rRo4xv7ts1ltl6Un/GMS9rFVZf0CoetIZaBnPEoLOj9hlaZ903Z2N2r
ARC-Seal: i=1; a=rsa-sha256; t=1523399082; cv=none;
        d=google.com; s=arc-20160816;
        b=zL9ASueK7WA87fYkaKrBs1XW6xSqPlvujP1+D2RJmFRiwxvnZS1bt+/w+scXlfD3dB
         0BA1jkzaS3tgV00QXtwg4XFZxfHTKNU0rO/YHmwtsSyJ14+FjEmXHAa/Pffb1Dd6qvjm
         AntpA7XD1MuBE0Ri6meM64wsWIpBtPqn0m/DWu3rBdrp40+DQ4bdsHFt92IXKxzwGrdz
         WNdZqXIx6p8U746vV1xC/EJrH4ReqlDzwXQgemP63iOGq0mX9Twa8z/ljjQ1q6OHNiXg
         XHYJjdHqP1M6oM6hDQLqqJD5yjC0+IEEhb2PTPeJdqhoP4xTqrRuj5cOot9jHvpdlXhw
         3nhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=eJ1esvG7L/feK4r2lwtoCvvvEZV5P08nyXKwMyAYp90=;
        b=rmtsWl3f250G+TWJVVS/47LxTx+jvyw5JBZnUD1NN6/IOsTjXvF+CfI38HmT+IAZRo
         98jj4Ltj9uVbCMu+w9uR7ysJux2nuoqft5HYK5bdf8N0RG3SRWa3dJh87PIVgPCgSIYk
         GuewUCYFw/CT0CUwZ3yMlE9jfR4jUezKs8gSVEx3/xPbFi9S13b9GcjpIIpS+DJGhH5f
         xs1QYOzTKR2BfTyG0Pqa2Yebb5Td3HKZsk9BsiVCHeXeEw2b0w9eGKhpwDQDWaoFXf+Z
         yXw7sJE8lP2QqhRR70gtEgNfQ5b34sXHpMebv+vBpSxOev2NT6do2nNrJN0lFtq68B2a
         oruQ==
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
Subject: [PATCH 4.16 10/18] vlan: also check phy_driver ts_info for vlans real device
Date: Wed, 11 Apr 2018 00:23:45 +0200
Message-Id: <20180410212759.123735460@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212758.564682823@linuxfoundation.org>
References: <20180410212758.564682823@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399716023236832?=
X-GMAIL-MSGID: =?utf-8?q?1597399716023236832?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
 #include <net/switchdev.h>
 
@@ -665,8 +666,11 @@ static int vlan_ethtool_get_ts_info(stru
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
