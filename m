Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtyb/qYQWKc+xJ3S8iKtES0gglRiAziS/RiqKQAdP3MWBNCInlJPXg2MJCrzEU5E1pCINeD
ARC-Seal: i=1; a=rsa-sha256; t=1521483807; cv=none;
        d=google.com; s=arc-20160816;
        b=hiKHqrX4AYYI0llmOuk+7nJ4s8kHtgE4nEaoa0KdRmLlUX+f3ORbSbjqBCZJFIpzEe
         AQGGQW1TzMyMu57VgMuIEyygl1T5jJP4dPxT1MQ0EfvkwQeAFVQ6J5ug8jNHRWH5H8im
         QsptRFM06u8Q/Hy9LSiHLRCVSgSbQKIAgIV3dm09AIIQxN9GJSaMDAIYpOMbChFXC3Op
         ksxiGhzHNqpv87I3xRTsDvAhtETzQV59QRVVS82TyopVa/FIqW2+1u0G6biRFtvZfYbM
         F9mJCB++kazt1mAD3JRvsxLM8j7csIy2IR3geGirn4JJFoFSRSJqAh4O7/jdjGWQ2Xfl
         MH0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=q4EVk2RoOBOKo0/V7Jv1sofeI83J1BGVe2ANd6LIzFQ=;
        b=s08j059r/2j/twzsoJ8+VrAYLbjIjFt2YegHg1AppkuHni2eQhifeAPK2aJ5KOdGqu
         gWp5VSjDuhGK72ifEuk0wWzaJ2xWiPrATdWxsCsus132AT5QRa3tYxI4GxbLRMHFMCEi
         RP96D+o5n3rCn9v4YBLicN5/HyxgJ5lqE1GtlR8L7+LhUbzvbgcx6QUgFEE1i1Bon45T
         /79XmJw/9O/zhM1QIpvyxBOr75o6AP/U1zYYSv3nHWg+rPkSPCrILUlxoOsvwMNRNzEu
         FW/ORx0cUtctGm67tAueIZVbxNYD/F6cjYBkTxXXia8rCYHgisIdxDVVQSNgBRAjuKmt
         TfDA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mitch Williams <mitch.a.williams@intel.com>,
	Stefan Assmann <sassmann@kpanic.de>,
	Andrew Bowers <andrewx.bowers@intel.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 124/241] i40e: only register client on iWarp-capable devices
Date: Mon, 19 Mar 2018 19:06:29 +0100
Message-Id: <20180319180756.334934447@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391405470733489?=
X-GMAIL-MSGID: =?utf-8?q?1595391405470733489?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mitch Williams <mitch.a.williams@intel.com>


[ Upstream commit 004eb614c4d2fcc12a98714fd887a860582f203a ]

The client interface is only intended for use on devices that support
iWarp. Only register with the client if this is the case.

This fixes a panic when loading i40iw on X710 devices.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Reported-by: Stefan Assmann <sassmann@kpanic.de>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11142,10 +11142,12 @@ static int i40e_probe(struct pci_dev *pd
 		  round_jiffies(jiffies + pf->service_timer_period));
 
 	/* add this PF to client device list and launch a client service task */
-	err = i40e_lan_add_device(pf);
-	if (err)
-		dev_info(&pdev->dev, "Failed to add PF to client API service list: %d\n",
-			 err);
+	if (pf->flags & I40E_FLAG_IWARP_ENABLED) {
+		err = i40e_lan_add_device(pf);
+		if (err)
+			dev_info(&pdev->dev, "Failed to add PF to client API service list: %d\n",
+				 err);
+	}
 
 #ifdef I40E_FCOE
 	/* create FCoE interface */
@@ -11323,10 +11325,11 @@ static void i40e_remove(struct pci_dev *
 		i40e_vsi_release(pf->vsi[pf->lan_vsi]);
 
 	/* remove attached clients */
-	ret_code = i40e_lan_del_device(pf);
-	if (ret_code) {
-		dev_warn(&pdev->dev, "Failed to delete client device: %d\n",
-			 ret_code);
+	if (pf->flags & I40E_FLAG_IWARP_ENABLED) {
+		ret_code = i40e_lan_del_device(pf);
+		if (ret_code)
+			dev_warn(&pdev->dev, "Failed to delete client device: %d\n",
+				 ret_code);
 	}
 
 	/* shutdown and destroy the HMC */
