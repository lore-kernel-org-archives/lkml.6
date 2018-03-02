Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt3HfFFsfQNaOyTg/o8IKbfWCufob30xKlQDssrwSmvNRWFM89GWlB07dbMX2PE+eDlcc3B
ARC-Seal: i=1; a=rsa-sha256; t=1519980909; cv=none;
        d=google.com; s=arc-20160816;
        b=yWCFiUEd36ce33RDPLclMA5cSOv0U3bCxhT/Z3Av3IAi+NTgZKFwIDhWT55AjxzdUy
         btik9KO6F4Jiyf3+bovyLkl18Ns1jR8yBQh++hA2+85YIVNQtOYpBWGZiebTzIgA6kGV
         kW9YR73R56umFQnEDxZAFIdxs6KZvL9w/l6aDWdwg/3xR9I1WCgo83RnqxWYzQ+ziVpU
         ApAR7F8i5bot3vULYVSgxE7i2ZmIIW4ouOGeWOGSzT1dgTs7Wa/trsfGAGkoP2QaicuO
         ruRpMRF7dR8o2O+CiI0ZmI5hq65cwCOH9joHNWfA96ghasuAokVrdsxsRf2mLAIMUOTL
         QYZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fny+T23kWrBWIUV2RVYeO8H7mGx5LJBymKWCGY9tjQQ=;
        b=PAGS0SV+firlgaE7oVLh4V18AziNZzxwJKfdM+6mp3iSjnNBDueR/k/XaPmJHGocHm
         lejsHXSyaqBvMjCIOEzDEhdS/e0utEGlblA0xIJBs5FUmXLXkHFmxFDNzig5W/OezPfY
         QVzmbP17KKTLWYtxNrdXkQez20m454Ic0VC/yFNi1P+MENCTAnPsLQJ5RVZXHoR+17Jo
         zbKBNTT5pBIu5MqmjiSeWzmt1oTLhw0rjMIdF6N9qpwTcA/sZTRcDTLzazekRhyQb92t
         DX4j8mGLGn/deENIh99TSMSbV92+o7D6EdLhsWqYZ/jX1Nx/Ofl209q/TZNk7VWu8N2r
         gEQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 28/34] mdio-sun4i: Fix a memory leak
Date: Fri,  2 Mar 2018 09:51:24 +0100
Message-Id: <20180302084437.813692671@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084435.842679610@linuxfoundation.org>
References: <20180302084435.842679610@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815310363107750?=
X-GMAIL-MSGID: =?utf-8?q?1593815501884490113?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


[ Upstream commit 56c0290202ab94a2f2780c449395d4ae8495fab4 ]

If the probing of the regulator is deferred, the memory allocated by
'mdiobus_alloc_size()' will be leaking.
It should be freed before the next call to 'sun4i_mdio_probe()' which will
reallocate it.

Fixes: 4bdcb1dd9feb ("net: Add MDIO bus driver for the Allwinner EMAC")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/mdio-sun4i.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/phy/mdio-sun4i.c
+++ b/drivers/net/phy/mdio-sun4i.c
@@ -128,8 +128,10 @@ static int sun4i_mdio_probe(struct platf
 
 	data->regulator = devm_regulator_get(&pdev->dev, "phy");
 	if (IS_ERR(data->regulator)) {
-		if (PTR_ERR(data->regulator) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
+		if (PTR_ERR(data->regulator) == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			goto err_out_free_mdiobus;
+		}
 
 		dev_info(&pdev->dev, "no regulator found\n");
 	} else {
