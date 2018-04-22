Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/VzEThBsT0USs6gfpguZX/X7cZzdz3Va7i36oNODs/6EiLiuNnEDM5LrjbA9rv2dVOMWiD
ARC-Seal: i=1; a=rsa-sha256; t=1524406324; cv=none;
        d=google.com; s=arc-20160816;
        b=RFUKJUud/VE08UUoJ8ay8HlsmhHmGRDiJmphJ4gXRhLHaBboDEO5c9WjwhVzSHcegC
         gIzxxlTaUI/3XgR5MSPkzxpvrhihObQPq8NrmEZ015dexDSCGrEZ6BPK6HyIhw2XZmeE
         2IS/OWWoB0y7YqSv1fayCOrRHLH7YhA2YjAS8nE6hIbeYLRa0H9+Ee7o4KOgR3ZFEqPi
         TBO5yu1t00E8pgNAlBzgNzLGaWURXMfcIb0JWA5xSu+9xmMdKsCIEvExUiure+xIVuli
         xxVWLMEycD0k6pu/Lt2zavdcURMBjNtQiVb44tZbVQ2MgtvpTIixyyciNObk0uooGJ22
         6U7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6vY+OUyRLl03VdkKhGg2gxoHu5FM1Ftzbz3eyDMF7as=;
        b=q7dOb9J6ub+aFqm8Tcd2YBcK+CuLMk0geJeUZJTE5dnETRN0EALols2zIYjd4aevs+
         +so7xm5g0b3SCOqSad57SDkaEd5FrgFVyhye+w5KN6UaiQTMap/niIgtzSAUkGRbpsyq
         PXW9NtbQXMmo3gJ7sRFUbn22YmXyNlrHmQJSY4Y4gGNNgnEwErWvM9dzOPbn1qcFZZyP
         GKq2P4aGUq6GPZ/cu29fyPU97fplS3o2hRwTz1EkggGMjvHs71Wu2VcyoOueoo0SUeql
         SNuZjaKXP2+BkwWrM/mx4ZLhKnh3vOyUFc9FBoCpBpW6k7ETZOnKEGf4hLuLPA+4Lmez
         Kk7g==
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
Subject: [PATCH 4.9 22/95] usb: dwc3: pci: Properly cleanup resource
Date: Sun, 22 Apr 2018 15:52:51 +0200
Message-Id: <20180422135211.349345810@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454910876862386?=
X-GMAIL-MSGID: =?utf-8?q?1598455886743095619?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -173,7 +173,7 @@ static int dwc3_pci_probe(struct pci_dev
 	ret = platform_device_add_resources(dwc3, res, ARRAY_SIZE(res));
 	if (ret) {
 		dev_err(dev, "couldn't add resources to dwc3 device\n");
-		return ret;
+		goto err;
 	}
 
 	dwc3->dev.parent = dev;
