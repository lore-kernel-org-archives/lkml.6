Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48pRipAqTLKPQ7GSH9y0l6FlWwCYgePwbbJCFTz0M4tHp29nYekTuBav9prTsmQxFW0MGt4
ARC-Seal: i=1; a=rsa-sha256; t=1523021181; cv=none;
        d=google.com; s=arc-20160816;
        b=K2Cha50wj1RrnJTud51jOCVMlLkDEGVfXOUw4RxOjeZyGYtXK6g76dUIsN5Kp+ac4B
         6bNp5rMRY3qhwVe+qGGkSJzqzBOX0K97OizTatKqI6SAJ/0YW9etFk15bqfGE4k+Hhpf
         Sz+Pa47V5Z9AhQMBfbOk0CuGSPnVI28OEohNQ2mFnB+nxI0hx6x4Ucabb68Rlr/YaGfU
         xprIFLV7i64WUNE6F793AumUN0gf1f86HK+HFnnHCqdrks3+htvyMLJ40SGeqForuDny
         CrWPFqrF6qheUcSxf5UYgTNNle9F4KrbGQYpv9aOKuPxF3kG9mGqjEEFi/eTYvUhKnNF
         X6NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IVeglYodaj86bBeRcCqdzCJZZUbN5ZoXiEkHYUsJSq8=;
        b=S0QLvcKqcxe+62vJuZ6+IW+Nr7Ie+mAs35Dd2FaW4w98YPtZbNxEPrEWOvRJQM6jnh
         Jw2Z88tRrVA+yQrEuiZ/UVrhrBCcLCu6PI3RmBUz98VW4T6fx/rts3XMf4pVSfxzGiOd
         uOtBm699oEbA5++0TBX4D5m3hKlPEMLTRGGzRBf4WPyzUdbUAuEna3f0GIfY1WP+0tFK
         enHzIVtReKWVsjr7WKjZY3WBnSegGoj5QJl9myqcxPV0h+Rfvr4tRIlA/ca4LCG0mfgA
         MK7QF8C7269jSYnFl37/S5aLrmJXPUtoxuN7Ne8YxOICxVfA9aepO6EFVjGSiGyOzRji
         ZMXw==
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
Subject: [PATCH 3.18 36/93] net: fec: Fix unbalanced PM runtime calls
Date: Fri,  6 Apr 2018 15:23:05 +0200
Message-Id: <20180406084226.531266983@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003458247497313?=
X-GMAIL-MSGID: =?utf-8?q?1597003458247497313?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3339,6 +3339,8 @@ fec_drv_remove(struct platform_device *p
 	if (fep->reg_phy)
 		regulator_disable(fep->reg_phy);
 	fec_enet_clk_enable(ndev, false);
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	of_node_put(fep->phy_node);
 	free_netdev(ndev);
 
