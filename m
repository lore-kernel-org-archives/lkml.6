Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/9zjJ/FhcNjkadS36HqKUyAcDTu21W+DTwspt3ZF3bNjePRmUQRdStd1Q497E/SMWBYDHy
ARC-Seal: i=1; a=rsa-sha256; t=1522346789; cv=none;
        d=google.com; s=arc-20160816;
        b=zhF6aJBM5pFRSyc5VxTeWjJEwceI4GAwx/iKOOzxc/pnHT6WTLX9Ki6968AZhymjd8
         sz0eEB/jBLrA/nwKPn9Navd4/Ld7Hf6uvQQcH/mVC0lbTO4wlTuascd8WTuXh4VmZL1b
         TOkP7wKXaWS3fumC7eJuqFndejibvOvjXCc/EUBbymTIpeqKF2LArnpdx2oZ+oNng47q
         M/EBYlCMqBD/dQOFr+1g8PXqNWt0ajKDOe7ww2ERvzU0iFVRhWL0PQzlwOKkEVIJx/nP
         5l5LWQeR1NaZvBQkGj5CZUQdPm8I/01QQAGDgvPc+L5s9HxQvzRMUWplSBUCYkgFfOsd
         7RaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=u2uG8zsvHkQyA1uyXSohsufvHlwku8+jl215itgLLTw=;
        b=MaRVxgZb7x/FJ5tOvraAbwM45oqnRomPCAaggTLLhGShPet52WH5wBA8xgBvdU0txL
         xUGHvewMopCaGEEwfn6En0gq5pPWss8hoNxmmdgB4JTo0BCSCExWy7cFUC5xSBOTyj9l
         zzgzKuVmufo8SjLG2MvOv/E0Z57e83uIUMeTdYK9zvyuLkfjW4bmtFppdLyk6M39enQt
         ZXpR235PAZAn79oOBUmHx4eIr2so9/W3FLKs/z4r9FB7nyevE+9u5YR81aCbyvfn416c
         kbp54idYQXAdOFxIQMQa/YWTHlWURXcoVZLNIhYTVtTOMzQoRdJhbU+uLpDFcNYD1Tyr
         Qkgw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 15/28] net: fec: Fix unbalanced PM runtime calls
Date: Thu, 29 Mar 2018 20:00:34 +0200
Message-Id: <20180329175735.225362309@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175733.447823703@linuxfoundation.org>
References: <20180329175733.447823703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296106771354924?=
X-GMAIL-MSGID: =?utf-8?q?1596296307518219377?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <f.fainelli@gmail.com>


[ Upstream commit a069215cf5985f3aa1bba550264907d6bd05c5f7 ]

When unbinding/removing the driver, we will run into the following warnings:

[  259.655198] fec 400d1000.ethernet: 400d1000.ethernet supply phy not found, using dummy regulator
[  259.665065] fec 400d1000.ethernet: Unbalanced pm_runtime_enable!
[  259.672770] fec 400d1000.ethernet (unnamed net_device) (uninitialized): Invalid MAC address: 00:00:00:00:00:00
[  259.683062] fec 400d1000.ethernet (unnamed net_device) (uninitialized): Using random MAC address: f2:3e:93:b7:29:c1
[  259.696239] libphy: fec_enet_mii_bus: probed

Avoid these warnings by balancing the runtime PM calls during fec_drv_remove().

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/fec_main.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3533,6 +3533,8 @@ fec_drv_remove(struct platform_device *p
 	fec_enet_mii_remove(fep);
 	if (fep->reg_phy)
 		regulator_disable(fep->reg_phy);
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	if (of_phy_is_fixed_link(np))
 		of_phy_deregister_fixed_link(np);
 	of_node_put(fep->phy_node);
