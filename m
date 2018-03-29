Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49aGJqOmrHj1WQt+yir9CC4+NPv2xJZQRrM6ofrnT9fgaVnu8Jki1ub5yy6/AYA0hEb5bhY
ARC-Seal: i=1; a=rsa-sha256; t=1522346760; cv=none;
        d=google.com; s=arc-20160816;
        b=AU1YqELMJyCSpK0K1Engt7BdEpJaPFb9Qt3TkGFpDdOv/jBOXt1IeDtc7OLpipIW53
         qnx2kJgbqW/CSTgd1k8YXDP4OW8h+WOGOx+wTjsLC2aRP5hkS+j6Usb123gOZN+6mnkS
         iFrEAqjezgmpjakTGqdfwWat8KzLQZAiaaZpTqUmaT/4UguKiaisu05I2JymvP27jTgs
         S1MGwjWH+LKwh1uIfcbUnTq0g+XeCrYrkQDra+nwXLUJMEOJogBdP/jBwwYRFU0g5Ay4
         q4hA/DiV6Brc9R3vb0tmRKi/ts+vqiLbBASs95bOIksp6vVOLuf4TP0BGfbj8ADuM+nk
         u17Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Vs8LHyNiqh3xycY2xteJF+9olaZjlLfkOdkNpRh8FrU=;
        b=hxjXWcxYNyDrZOvIvJQJ+pMWYlX97Sm9corNmVvZcavddiJhqzgCxmHCXYLa/CJLc2
         qdgrY7XPQ3pSIBHDPH/AK+5peP/3cXrOlWw+BEJKtxbRua0Oa9PZLMzQjBmV7J4LaNVS
         r1z1wemf7Qb86zPOU5ERoMj9xVSkXo+6XfsTJ6WfOAJK5hhHSt2BU6zRlHnker8TWcJ9
         CdYtuqT6uPNnEi1pQxGbkr2DdgoS2BJpJqkXkJg7K2yTFxQons391IISZTiYgh0Ba2Ay
         c+DA9FIsg7iPBk59wRdTWeWqCFe6mMDCyAguQyLDfNBSZVdTOFYN7HGXn7srY+28enLf
         E8mg==
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
Subject: [PATCH 4.14 27/43] net: fec: Fix unbalanced PM runtime calls
Date: Thu, 29 Mar 2018 20:00:22 +0200
Message-Id: <20180329175732.994286342@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296106771354924?=
X-GMAIL-MSGID: =?utf-8?q?1596296277125171270?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3565,6 +3565,8 @@ fec_drv_remove(struct platform_device *p
 	fec_enet_mii_remove(fep);
 	if (fep->reg_phy)
 		regulator_disable(fep->reg_phy);
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	if (of_phy_is_fixed_link(np))
 		of_phy_deregister_fixed_link(np);
 	of_node_put(fep->phy_node);
