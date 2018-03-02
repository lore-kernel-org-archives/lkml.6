Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtoiGjDwMVZwRtzajVyN5nNq+B4abxEHo2Quufi8b5Rd1dZ/Rcaf7gYbKdV4dZoXdqBcuIx
ARC-Seal: i=1; a=rsa-sha256; t=1519981355; cv=none;
        d=google.com; s=arc-20160816;
        b=dltLPzouO7rAXXnYH/WFNbzhwlzYs526rTz3Sn7E5RgEXdRIpAT6KDtF1zWdJj8afk
         DTwv8JY6f/j01Lp02kSRuehLH+mF2DTzmgOh5TVS/vcaGDq2xX4OtOSVJxzBo08pstXA
         HiAxcuR7EiE40YXU31qHgLw178brUzlQvBsRfbQSM0mvCDyhpigpZX95nVzVd1wxPs4I
         uRWrVbrvusinAl7EYLllKyQIkSctF1aBJGgRqgthJAMmMQer6ibxxpfsxD7alfQBpHCC
         85V1XDAWDqKxkDI29yVx037U7hP5JZ9T7GXfdThUS711ZI7QGTetp78IKTCgpzdDxcBb
         whxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rGxL0pUe1LJThEUtKAuh/XjIv0VptTMULAZJnXU/zSU=;
        b=VDLRK8V4L7GHB8E6M3EjuaHDvZ160LCHqVDODB+/i6A7fTlgRqyJG+SkB2WgHxy6e7
         q3XQUseGzPEfVZcTElPD2yvv9UUf6c/25AVzXyP+ePCcPUAI8DYUTVOczY+miSy7CtBk
         mxVwNbIeE6iidciHqFtWNLlFwAMndOssCnj+hIGFmrO6jP1ZnpSM8eJNg6IyB/I7vHhl
         wGvCrRQ/ly6ujvMAmcI6i/2y/G34vPpdyD7M7UsGs1M12B13cq7zsJD8pKHlyIqt5Fku
         oOvPWjs5Um2blyW1mJVyOo0f/nACwz1OQphrWqW484uJD23i+I4pyaWUKfcBzJwDJPtF
         jRIg==
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
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 020/115] net: phy: xgene: disable clk on error paths
Date: Fri,  2 Mar 2018 09:50:23 +0100
Message-Id: <20180302084504.685994318@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815671358161748?=
X-GMAIL-MSGID: =?utf-8?q?1593815969915583503?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Khoroshilov <khoroshilov@ispras.ru>


[ Upstream commit ab14436065c8066c265540312742390d6d07ddd2 ]

There are several error paths in xgene_mdio_probe(),
where clk is left undisabled. The patch fixes them.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/mdio-xgene.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

--- a/drivers/net/phy/mdio-xgene.c
+++ b/drivers/net/phy/mdio-xgene.c
@@ -194,8 +194,11 @@ static int xgene_mdio_reset(struct xgene
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
@@ -388,8 +391,10 @@ static int xgene_mdio_probe(struct platf
 		return ret;
 
 	mdio_bus = mdiobus_alloc();
-	if (!mdio_bus)
-		return -ENOMEM;
+	if (!mdio_bus) {
+		ret = -ENOMEM;
+		goto out_clk;
+	}
 
 	mdio_bus->name = "APM X-Gene MDIO bus";
 
@@ -418,7 +423,7 @@ static int xgene_mdio_probe(struct platf
 		mdio_bus->phy_mask = ~0;
 		ret = mdiobus_register(mdio_bus);
 		if (ret)
-			goto out;
+			goto out_mdiobus;
 
 		acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_HANDLE(dev), 1,
 				    acpi_register_phy, NULL, mdio_bus, NULL);
@@ -426,16 +431,20 @@ static int xgene_mdio_probe(struct platf
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
 
