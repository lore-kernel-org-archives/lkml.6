Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49XGYN2/siJBEwyEoXLcOLJRjgQJSyyYBg3jQ85lh7mjgyL05QQnwf/CoybCVwA9J7O0Jwh
ARC-Seal: i=1; a=rsa-sha256; t=1523472948; cv=none;
        d=google.com; s=arc-20160816;
        b=r66B9T2ETH85h8by0xRGjNJ4oiXEKkW2uyDnmO+wYN7oVt/poy8AzXmjdyeZOxaKt3
         bgqufTCqM9yQrEVJY49tJKOy5co8kKGP9luDYuMUWXzkfOHfbr8H7Ce8hLHJPvLZkvsd
         rDoC4tocFPisuURvNALWHHE/5GyhQVX8uxiN6HxIuNzr+cnGwymePw03SA3U+UIbgW+Y
         mLCeWETYIGO4GVCg8eACRNQc/Xw2BbR/iWp/rNvE00TfYjogK3AOQS2yZJsgBAwR5Gnm
         EmsVmKdQfueNgWcey+qcrMYg7bYNIriB+VdGgtWt1bofujOFFUGRStkZbgIJv827z0wj
         0z1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cyNJnJkCiwTF04MQC6ywAfcy9BlQmhPTDJfR0UIGdLc=;
        b=x851VVFB1qb1HADyoroF5YVOAcKC/vUw1+WRm98Hm4JkvTQoSvCXWTnrRSoPLPCtFq
         F11va531piFnOXM/kOgoNO8XOaPAMH5EVdj2u9Fih9GEm1iNKrLiyy8M94PBORMsUs87
         iS9dT/e/XlJBGLOj5hPTLft5tY54xiJr84/HXoskABz/0W0lB1rd5tNJ++SmYXA9ecoJ
         LRdti/+aurMqGNVH+GZnFpQ7L1Ouyn8Quu1bjgSQqAch8TtAjFHE1K9D0qTSL5LJtQAX
         0SEqgBFuJXvG4hgFalNnAGcQkfs9uZE/CYiCmsC9pCScZERuJYP5Ec/+6CQFfAJdZVK8
         buvA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 075/310] sh_eth: Use platform device for printing before register_netdev()
Date: Wed, 11 Apr 2018 20:33:34 +0200
Message-Id: <20180411183625.541619486@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476116406131279?=
X-GMAIL-MSGID: =?utf-8?q?1597477170927100272?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>


[ Upstream commit 5f5c5449acad0cd3322e53e1ac68c044483b0aa5 ]

The MDIO initialization failure message is printed using the network
device, before it has been registered, leading to:

     (null): failed to initialise MDIO

Use the platform device instead to fix this:

    sh-eth ee700000.ethernet: failed to initialise MDIO

Fixes: daacf03f0bbfefee ("sh_eth: Register MDIO bus before registering the network device")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/renesas/sh_eth.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -3133,7 +3133,7 @@ static int sh_eth_drv_probe(struct platf
 	/* MDIO bus init */
 	ret = sh_mdio_init(mdp, pd);
 	if (ret) {
-		dev_err(&ndev->dev, "failed to initialise MDIO\n");
+		dev_err(&pdev->dev, "failed to initialise MDIO\n");
 		goto out_release;
 	}
 
