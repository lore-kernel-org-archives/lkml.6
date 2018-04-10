Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+qvNrymOopopo01M6mQn3yLLZbU0DWdkDjpI8sfCZUkUy4SrlzaIyyi+eCC+LDghZEtvPh
ARC-Seal: i=1; a=rsa-sha256; t=1523399572; cv=none;
        d=google.com; s=arc-20160816;
        b=RKuVO+1SpX3Z8u31ELUIY350VRorCFpw+1QRJ/UtgPVf4/W3GFX28/eINCGeMds3eV
         lfhenUTKu3kc9TN6GRYge2xE6j36VRftN93mDJxxUedVsH+8iEy0rZnwu0OH/Pf2tGjV
         ODZsNILilQ8HOYkjW1fjtS4ZPJaMH3X/r6mQR1+zlx0m323xsNSvx9TC9r2Cm8QbO3pg
         yo8ZC4aJYqtzY/W0q5fBW6u3Oeh9CJ1yV/F35C8K5ZQADwnIB7N7NGFPdMPGjj8sMXs7
         qLckgNGPFQ65ak+wSgr46w9KkKiDJBjDnG6qroipZlfIUwJXQ6cGu610lZrq6XCY6tDd
         gMbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nLZ2D21g4inWILg+i4yM8jbcrF/FKRXsC1shrgggLQA=;
        b=FKBGE/+Io0r8HXlJmSE3V9DPzfDKlXUvaL1LiUl2r+7VBJE247Aglk8v9/Rv73ChWI
         ca2wifF6zxmG0i52Dxh/aI1xAjIwhE3cp+Cns90PwpQzLcqT+g1Q6ZlrTuru7FYKpEaX
         JNtfJPEGRY9jbhd1vVcfCyBhJFAy9DDe7+SpwGSvWdrGxdTrwfRRyhny+3LzrtXfkqk5
         YNlnuTRZ/sAjTP1ol/qvNRCq2XC+mg0FZYvepz/SUaA7vTskM1SivPNhubThytKPK+yy
         PeAetdpyWwce6mSWJVfozoP5cUTRMVa+gpO/pckj8J8+bNTwHIrb5t9ISpRqxrCgHTzz
         Soiw==
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
Subject: [PATCH 4.15 138/168] vlan: also check phy_driver ts_info for vlans real device
Date: Wed, 11 Apr 2018 00:24:40 +0200
Message-Id: <20180410212806.946793178@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399716023236832?=
X-GMAIL-MSGID: =?utf-8?q?1597400229578230063?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
