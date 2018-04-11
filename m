Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49IaAx2BkvRnQd8hS470V3diYJP2aeUVgZ/fG+cTV7yKehZXWlYAfXUYsv44AyKLYRm/Eew
ARC-Seal: i=1; a=rsa-sha256; t=1523472588; cv=none;
        d=google.com; s=arc-20160816;
        b=xCWTiTKIg/E1ctSky/4sjlVKje9Vsm8KUw+RaB+cRP7yB30urX2NLG8ZpzZgo2bZgC
         11FiC7rILkxrjEBWYHNmPL8NEDNvG4aDbszva93C2uIwTafIhS+BzKSRSXrB+CKFgXJ5
         Zkn6Q3VHLkdEmdnPy5S74HuWwb8tnaOQKYwqS8ucKSrOQu9h+2p/NnY+VP3LjDk/11ww
         9X1wVrxV90ZsbIzz1pY9NJcVuzrmbOTXFRtkRxR1SHuSxyrXK7w9HFFcihKhGbRABT5B
         tLyMCZvVIWiSh/BRAse8J05dx6FLzBzN2j0Tl1TIcGYczcHoeDYk6riowZOxg7roknMU
         bf+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=844I6eU+6AT8u0YvtIVcq+SjZ+sAKJxITQkwYsRrb14=;
        b=pS8CuVBWSVGiGwOMMNN/PbJSBYff1Udw1FStTWs6FGvZuhGYdQpl6qInvQihA9QFeF
         fcn8m0krLVxVYz/M+2DFgCns2XIulzrj0Ujf54OhfQHQDjlrY84m4nmqj6A9f9BS7v8b
         gG+YlxspruzFgz/VDCSpCuVnUgZqB+6atUV+b6c7JXQMUocHhW3839DOfNDaLkyuXXG9
         FcYZ5corjLhIY2nkSdZqi85K0sBNjQVjD2+MJX/LefjQYWbBvTiNiQVl8HpuFJMxob+D
         kW0BzeBvb5iIi2enveEiaNgh/scnOIS1z3zGRo4/EhJHbZMCOtGs0RVLMf9YXWZ13i6r
         OZ+g==
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
Subject: [PATCH 4.4 105/190] net: freescale: fix potential null pointer dereference
Date: Wed, 11 Apr 2018 20:35:51 +0200
Message-Id: <20180411183556.747142708@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476191043922793?=
X-GMAIL-MSGID: =?utf-8?q?1597476792675718021?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -382,7 +382,7 @@ static int fsl_pq_mdio_probe(struct plat
 {
 	const struct of_device_id *id =
 		of_match_device(fsl_pq_mdio_match, &pdev->dev);
-	const struct fsl_pq_mdio_data *data = id->data;
+	const struct fsl_pq_mdio_data *data;
 	struct device_node *np = pdev->dev.of_node;
 	struct resource res;
 	struct device_node *tbi;
@@ -390,6 +390,13 @@ static int fsl_pq_mdio_probe(struct plat
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
