Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtL9mCtPjCddgR1ebPbpZOzIrdJCOny01Rhwxtq1SMmlZYS30UbDq6PY7z2Btc5irEkOFS9
ARC-Seal: i=1; a=rsa-sha256; t=1519981070; cv=none;
        d=google.com; s=arc-20160816;
        b=AryA1obrSow+ddczt9y4Da8AZveeKzfzvFqLK474KN8iz32RFHH3/zWHdZzY05MMRZ
         q5Jd3v96s1imkib82Zx0YpTvn9R+lNO1ohoq8z4q5O6xkpe4Ey4Vm1eP7FRJaGbO4yPv
         YjabIgOYamx/vWTRQUZYFhlLt8FoEkpXrc3Y5Hy/UT5/iGT50XiaudLjIS5hL073WvpQ
         /BX/SFwLZcbzGlI2FZ9AIlIfTuGrJPyyRNUCZZFPf6V7P5steEtuQnORDJPYvJA2egi1
         jH+v0VUAq9urqSwM24L5Hhbz9a9SH4+mj0/rY8Jx9lAZHtCpHUGegByEzEk4AgsohRg9
         8Zxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4+Rb7dRZiXtAQVJQEGjfhiX39WL4bkUMgxNt06+XmsE=;
        b=cRvs92KmpOAQN43xmJe64cZ745u++teLc6EuR2BTyA6+apfc5LRPTwfoaek1Mn1bZJ
         XONsCVXp8G76Mi5AEm0qoNS3lxF/Wne+AJ7C/5U6tEOEl0I2n2okZtBYoCp4VZtEkX6i
         W1cjFlqSaoGwNAe1W82R/68ICQLKGdGMadTuzrtJFXix9aJweNTmpBvu4zAbo3g/nW+K
         +4IfH4Mj/A72Zx5xMOWNSy7GZJHKmtzf5CcURHt1Bjq4QswBb0NZCPtoH1iHcrt9JnTr
         Nn84MwmKHipKnx4f86BtgI4vP8g1rjfzHNVrrW2usgZq2CBd0LBHn1my2rVXClFGb2lZ
         Zjvw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 13/56] net: phy: xgene: disable clk on error paths
Date: Fri,  2 Mar 2018 09:50:59 +0100
Message-Id: <20180302084450.300845854@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815671358161748?=
X-GMAIL-MSGID: =?utf-8?q?1593815671358161748?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Khoroshilov <khoroshilov@ispras.ru>


[ Upstream commit ab14436065c8066c265540312742390d6d07ddd2 ]

There are several error paths in xgene_mdio_probe(),
where clk is left undisabled. The patch fixes them.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/mdio-xgene.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

--- a/drivers/net/phy/mdio-xgene.c
+++ b/drivers/net/phy/mdio-xgene.c
@@ -197,8 +197,11 @@ static int xgene_mdio_reset(struct xgene
 	}
 
 	ret = xgene_enet_ecc_init(pdata);
-	if (ret)
+	if (ret) {
+		if (pdata->dev->of_node)
+			clk_disable_unprepare(pdata->clk);
 		return ret;
+	}
 	xgene_gmac_reset(pdata);
 
 	return 0;
@@ -364,8 +367,10 @@ static int xgene_mdio_probe(struct platf
 		return ret;
 
 	mdio_bus = mdiobus_alloc();
-	if (!mdio_bus)
-		return -ENOMEM;
+	if (!mdio_bus) {
+		ret = -ENOMEM;
+		goto out_clk;
+	}
 
 	mdio_bus->name = "APM X-Gene MDIO bus";
 
@@ -394,7 +399,7 @@ static int xgene_mdio_probe(struct platf
 		mdio_bus->phy_mask = ~0;
 		ret = mdiobus_register(mdio_bus);
 		if (ret)
-			goto out;
+			goto out_mdiobus;
 
 		acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_HANDLE(dev), 1,
 				    acpi_register_phy, NULL, mdio_bus, NULL);
@@ -402,16 +407,20 @@ static int xgene_mdio_probe(struct platf
 	}
 
 	if (ret)
-		goto out;
+		goto out_mdiobus;
 
 	pdata->mdio_bus = mdio_bus;
 	xgene_mdio_status = true;
 
 	return 0;
 
-out:
+out_mdiobus:
 	mdiobus_free(mdio_bus);
 
+out_clk:
+	if (dev->of_node)
+		clk_disable_unprepare(pdata->clk);
+
 	return ret;
 }
 
