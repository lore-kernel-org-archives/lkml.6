Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49QFWg5xrpOII3Myre078+H7wOLD7R4G6CSfbPGjbGOhzGrdU7PsR1SeJ8LIAYeHuJXAhhv
ARC-Seal: i=1; a=rsa-sha256; t=1524405394; cv=none;
        d=google.com; s=arc-20160816;
        b=nUrnc4sqn8fBtiyjDBuKywCC+GJaiEnj6Pq9GhQugzlA0jnSIRHta/xYPRsERBqHiN
         pCFpPHyaBhhzvx/n9ieT82k1beddT1LPQrzaI5HR+7E9MhOXuw3jW3btsO+VeW9uYm/6
         Y4TifsbCD2ht7ZnlScjgGyk1MYPzf/8vegMaZtQP59gkwmDa2YV9sirNeg1jjtlwoaAI
         HDhm9Q7tsww1Ob21kUHt2mECSPFBE53QAdoj1eAWZ1lFqg2cQ6bZeBIjjijR6Pj0PlxU
         VnRX4EM+itCxRrpilQHv6lZnXaEW8jiRuW4UTecdo+ZG/gvXZuVEuCCW8rn8/+sqhpI3
         dx8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5dSA6AYvuDv1sp8X6AkdyDn1FVRWJtyY1npYD/hPrRI=;
        b=taFTkiMZCiL2MLky5nX2FWhIS5QKnjeq8TrkPGS4EDSkbjB5qpM+sL/87Vh0Yew/wU
         /J76x0Pjh8WgFBVDbMljpX98STPfMq8Q6n1gaF28U0pZJLQDcw9m5O1Y5qtgjgakoBU5
         50fJy9kLcLy7ZBxELpG7d7bRFeqcaHApBFFS0T9CwBAAam7NsehTAOnnmujfkZuDn/lK
         KTbh70VSQqAeV0rR9tWS5IEeA4kawevSjEIBIKYUM8u1vMguXyW6Apj9XF74c73qvLl/
         TP/4SKE54CQ7+hg6JfqrDlaxMXgMYZML7HpMMAZD+gP8ruuoieCWYI6hy7Pqe+yZPMHa
         f9zw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thinh Nguyen <thinhn@synopsys.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.16 043/196] usb: dwc3: pci: Properly cleanup resource
Date: Sun, 22 Apr 2018 15:51:03 +0200
Message-Id: <20180422135106.302095614@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454910876862386?=
X-GMAIL-MSGID: =?utf-8?q?1598454910876862386?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

commit cabdf83dadfb3d83eec31e0f0638a92dbd716435 upstream.

Platform device is allocated before adding resources. Make sure to
properly cleanup on error case.

Cc: <stable@vger.kernel.org>
Fixes: f1c7e7108109 ("usb: dwc3: convert to pcim_enable_device()")
Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/dwc3-pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -222,7 +222,7 @@ static int dwc3_pci_probe(struct pci_dev
 	ret = platform_device_add_resources(dwc->dwc3, res, ARRAY_SIZE(res));
 	if (ret) {
 		dev_err(dev, "couldn't add resources to dwc3 device\n");
-		return ret;
+		goto err;
 	}
 
 	dwc->pci = pci;
