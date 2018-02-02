Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226vrGlngia7iw5+oL4FcwosYXbvrOFDNckDBBoiO2i1i7TlROqYytOPWkfPGo+hPhoSGE5U
ARC-Seal: i=1; a=rsa-sha256; t=1517591294; cv=none;
        d=google.com; s=arc-20160816;
        b=dDXdqMsCMh3mqVcV0LccVNi0evco5sDvG2YYMdCM3R0QE8QPEAM8SoQaeYzgnxP0Lc
         f+jCl0Yuz5VIzsqrXZ9WCZYYKENkHKzHOW7EH5tCcnLVXpHTBcYAoRGOod53vVG65Jsx
         c7pOTQ6uF+x9DPlIhdGmInPNIyCeWQk1F3kz0aZFxIRkkbuQli7SOhl4A7sA6u2JJPgV
         tgodAM3s9m8Zp5Ke/T6i9xR4/re4QTY/pYzB6IoT0OWd+v+KIw9zhe2pGQA8Ref6Eo9d
         2r+KRYfU7MGzhgyOs6wpcTMeYi9oB2GgdO9fxJm+8g3hZ39jUIAqxoVjrtyVrHvZWQdW
         t+xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jorPukhazpQ0I94G+7IFVanKe2/C60KdS+vY12kN344=;
        b=IrzwzQlDmfmEcW3KJY5ZTxZqDtM+8MF0ViXYj3HatPZ6YWKVKObuNqanBwux2f9Wqk
         AMx+1iArjhpcxG9M5NdojIaHsE0JvE2Y3gYDxU3xmB3XZw6/1KJK38cThhc4dErJU2ay
         dxm58VD14Kh3aYnS5gZleHuQCZk8EyPDnz6zsujfmtOgnCO4LP+j9gnq1R1jMFUD94CU
         9ilpEBCSk2Wb4DGfPkFcVW3BiKW742o/8JjLOzTinBAatqn8cEkhPY80iPu2lmZRPBTJ
         BFbQPMniHKkBblu5Sxqx87lnr9TDQS/K8KpbnAlBKkav3H0Q1mSolI5FRttMyB8qEEHk
         gz5A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Douglas Miller <dougmill@linux.vnet.ibm.com>,
	"Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
	Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 029/156] scsi: aacraid: Fix hang in kdump
Date: Fri,  2 Feb 2018 17:56:50 +0100
Message-Id: <20180202140841.652865378@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309808970580972?=
X-GMAIL-MSGID: =?utf-8?q?1591309808970580972?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>

commit c5313ae8e4e037bfaf5e56cb8d6efdb8e92ce437 upstream.

Driver attempts to perform a device scan and device add after coming out
of reset. At times when the kdump kernel loads and it tries to perform
eh recovery, the device scan hangs since its commands are blocked because
of the eh recovery. This should have shown up in normal eh recovery path
(Should have been obvious)

Remove the code that performs scanning.I can live without the rescanning
support in the stable kernels but a hanging kdump/eh recovery needs to be
fixed.

Fixes: a2d0321dd532901e (scsi: aacraid: Reload offlined drives after controller reset)
Reported-by: Douglas Miller <dougmill@linux.vnet.ibm.com>
Tested-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
Fixes: a2d0321dd532901e (scsi: aacraid: Reload offlined drives after controller reset)
Signed-off-by: Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/aacraid/aachba.c  |    1 -
 drivers/scsi/aacraid/commsup.c |    9 +--------
 2 files changed, 1 insertion(+), 9 deletions(-)

--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -918,7 +918,6 @@ static void setinqstr(struct aac_dev *de
 		char *cname = kmemdup(sup_adap_info->adapter_type_text,
 				sizeof(sup_adap_info->adapter_type_text),
 								GFP_ATOMIC);
-
 		if (!cname)
 			return;
 
--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -1672,14 +1672,7 @@ static int _aac_reset_adapter(struct aac
 out:
 	aac->in_reset = 0;
 	scsi_unblock_requests(host);
-	/*
-	 * Issue bus rescan to catch any configuration that might have
-	 * occurred
-	 */
-	if (!retval) {
-		dev_info(&aac->pdev->dev, "Issuing bus rescan\n");
-		scsi_scan_host(host);
-	}
+
 	if (jafo) {
 		spin_lock_irq(host->host_lock);
 	}
