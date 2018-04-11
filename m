Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/CWpUEgbDo9pC51kZr7DjPvv1pY+lwmLqjQXRFV9zwuxCIkQtbQYSAZq6VXCU7ZhCAPCFr
ARC-Seal: i=1; a=rsa-sha256; t=1523473212; cv=none;
        d=google.com; s=arc-20160816;
        b=sdc7ZKAAn4DcaCCu62vQebz/JGMrOpIM0NxaSJb81ib2/+EiZa1d6dIHan5t7V23U5
         Ex8dIpW628y6y12BKoGUf0X23oE/p6yqQvC5gSyyoXymyHB6r9TLenKb05fgZn0CHd8y
         HSNw+7poF6KFglTdaxQ5DSwOaqmUKZ+JpVzdcmIOJwm26uKl41Y09z7/RUI2OEVkX6EZ
         zC5NRynq7MBBUR+SlPH1Yg3BIBJeYzTKS01tf1fA+oSya3UmLXJUNx2spTY5wAmKFoPs
         KyRJtl+vWHTY6sL3AdVEJWSl0cyvrhtOIYT0ZQXkKihWFen04srbkAabyNrlai8RJvtz
         /uUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Cvq68MY8qomHJH3S/+hq08GWyk1k/1e0uRTOvwcJMao=;
        b=RZk9KM/Krmdx4QJjQXZqVGt7jN4AibTJv3IfRpmM+7cqfko+H1GlIRkf6qxsZ8yHyO
         AftcXi7GTFNJpq8TjCmqpJ1GrMNIyzZPYQeQSjMRG3PBOY4Rha9z8M0Af8jBSOpiGiCY
         wMWATu64TchNHutUWIS7v2xxOwGKo2j/EK6TZvJRyhxMd/lmLQOJPSt/X2ppGWnaYQ7J
         6UBq8VO3Zy5PiZR9meWRh3a9nU+cUt5/8PDA6cl6lFw4zZCLADRUXM/yi7pUBO+wTC57
         AjILHwF4ZoIPIrk9OgrKHQStj4CMhiAWPoPLSsPFBXJ2oDX26KzYuCtfs1RZBEnczs80
         zqcQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 165/310] net: freescale: fix potential null pointer dereference
Date: Wed, 11 Apr 2018 20:35:04 +0200
Message-Id: <20180411183629.478310658@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476191043922793?=
X-GMAIL-MSGID: =?utf-8?q?1597477447275491649?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>


[ Upstream commit 06d2d6431bc8d41ef5ffd8bd4b52cea9f72aed22 ]

Add NULL check before dereferencing pointer _id_ in order to avoid
a potential NULL pointer dereference.

Addresses-Coverity-ID: 1397995
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/fsl_pq_mdio.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
+++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
@@ -381,7 +381,7 @@ static int fsl_pq_mdio_probe(struct plat
 {
 	const struct of_device_id *id =
 		of_match_device(fsl_pq_mdio_match, &pdev->dev);
-	const struct fsl_pq_mdio_data *data = id->data;
+	const struct fsl_pq_mdio_data *data;
 	struct device_node *np = pdev->dev.of_node;
 	struct resource res;
 	struct device_node *tbi;
@@ -389,6 +389,13 @@ static int fsl_pq_mdio_probe(struct plat
 	struct mii_bus *new_bus;
 	int err;
 
+	if (!id) {
+		dev_err(&pdev->dev, "Failed to match device\n");
+		return -ENODEV;
+	}
+
+	data = id->data;
+
 	dev_dbg(&pdev->dev, "found %s compatible node\n", id->compatible);
 
 	new_bus = mdiobus_alloc_size(sizeof(*priv));
