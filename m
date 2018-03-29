Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49hqWapyDiiapeZ/bqgVsBuSMQkvzaHAy3EoOPYIhBAFkKUowSVvfSF4bwX8u9p3QEe2z2A
ARC-Seal: i=1; a=rsa-sha256; t=1522346598; cv=none;
        d=google.com; s=arc-20160816;
        b=YCtK6pS3I+GW3yAbg2lmLuTZwnAcQTNQVijznxi/CgNqEFi6Zei1tYw8wMsR7SskI6
         34kb7T3p+ywmjhURIazAI6SP71y8cs1Oomkmtw2kVIRLmkXoZCrdz/FCkIJj8W/9WZu6
         qphDKxSD5OXMA0UrWxGPr64Qulf2rWd874swCU12ZwS1EwFT88YDM6iuvMFaww30sn7J
         +7FJZMc6Wrb4eUC1eyU9uJ25WYtinPFlfHNMcF3vJ69GACLd29wSCGKKk42cOFy91Hcu
         t6AB8nPstWPvdhA8CoL9ewvASiYp/VUyeYZcdC+1ooArX5BjK41h1UYcRc68gukonqZ0
         0PGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5hJ0k6ZI7pinBtrtwuIvTYoS7p5XKFwaM/5GFqIm6ro=;
        b=HqW91xjMSQfTCNjC1C/GWlFJnZsSSlcvnv08EB69pVbIWTKEvH8eyR3vJdczka1YLE
         ZQb3PgAEoUy2vnDap4kpzGtoJQol6meHrhzCKo6A0asOESDawPz3t0wvNZXwrz44YiWs
         NX+ZndycorJ8RjoQsfDZ+J4Fmf1ZEizY5LWQ2ejayl45NZa/bBkbUxsALXyg0BJeFrVC
         bcPlicbOLTSXx2rFn1U6GMTRN/xCtcBd32CBgKY+jmQBmuOXDakIeq08KgWmc8kuetuj
         /k981PEqobQx6y9ncaS2zo1WLrhyLLHOO19jC+u6XH6591Xive4kyDjEDcqrNkmFERJ5
         f3Yw==
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
Subject: [PATCH 4.15 40/47] net: fec: Fix unbalanced PM runtime calls
Date: Thu, 29 Mar 2018 20:00:21 +0200
Message-Id: <20180329175732.840556965@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296106771354924?=
X-GMAIL-MSGID: =?utf-8?q?1596296106771354924?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3578,6 +3578,8 @@ fec_drv_remove(struct platform_device *p
 	fec_enet_mii_remove(fep);
 	if (fep->reg_phy)
 		regulator_disable(fep->reg_phy);
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	if (of_phy_is_fixed_link(np))
 		of_phy_deregister_fixed_link(np);
 	of_node_put(fep->phy_node);
