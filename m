Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224R4DKBbcdpi0KMIE/4yFxPLy7+cVEbwVOYzYs9d7JFDcvkYpl19ugn5SB/eTNUM09vm3wB
ARC-Seal: i=1; a=rsa-sha256; t=1519412147; cv=none;
        d=google.com; s=arc-20160816;
        b=RGk+OCIcfcIF1q9qSavqHS37i8qxoJLWvVvlBTlrsSo7szkElZ6qGs1ZkeFGdyoGYJ
         8x5qbQRVH9BnrSIf3EDgtxMegUiWgu6yz2XtQjeGw/r05Vl332b29H6V92W3In4IgXy6
         SCw5M67J0XnE6+wHP6d/T6p2yMQcR2JsSPbhZ4b+fJx4IdPfG5xxWohFRCpq975mYpGS
         d+BNTAou/Z2F7DkSyecTjtLwHs2A2XJeRJw8qOx33MMJwGR7WDdvksIa/QtO662+f+DX
         +5LJSEtREKlJVYr0wkXgROisiSA1n0gKtixO3SammEf1AGbpu8aONb2XWWeLKL2k0o7R
         sYlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xAmQZFeNclo3z1pbtokjrHq67BGiqZQSVVqVZkNBm8Q=;
        b=v7QoSuEGDWfm1Ja8wNVF0BnH9H6DDTO4XXHM1iEZ6f3buSmgqHUW6x7FtGptesfaLp
         /hmWkcKNT0u8Ti8OP4SKBcFvt7+n7jkehsOHsWk+92joZu+QT5VaeOq6oENwmOt+qhiO
         iBnMDioS2WIMue5esI74OqGsPSMe+a2FU/GiS+nz9sPgn3777DYf9644sSVJnDxVPtPz
         5E9Hd50uDC/T+xkfrKPw0IO4/Hzv9bUQbOCFk9ZR4B15U9BJVSARu0s9107UYTKXNnZe
         kps2J/1iAc1tzqNZqnNlVKKqIg3vTgc3DtOnTQ9nPyzwOjNkFnrzK5QftMogYseycHdc
         Ou/g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 141/159] drm/armada: fix leak of crtc structure
Date: Fri, 23 Feb 2018 19:27:29 +0100
Message-Id: <20180223170800.090983929@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217818345500659?=
X-GMAIL-MSGID: =?utf-8?q?1593219112098533395?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King <rmk+kernel@armlinux.org.uk>


[ Upstream commit 33cd3c07a976e11c3c4cc6b0b3db6760ad1590c5 ]

Fix the leak of the CRTC structure in the failure paths of
armada_drm_crtc_create().

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/armada/armada_crtc.c |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

--- a/drivers/gpu/drm/armada/armada_crtc.c
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -1225,17 +1225,13 @@ static int armada_drm_crtc_create(struct
 
 	ret = devm_request_irq(dev, irq, armada_drm_irq, 0, "armada_drm_crtc",
 			       dcrtc);
-	if (ret < 0) {
-		kfree(dcrtc);
-		return ret;
-	}
+	if (ret < 0)
+		goto err_crtc;
 
 	if (dcrtc->variant->init) {
 		ret = dcrtc->variant->init(dcrtc, dev);
-		if (ret) {
-			kfree(dcrtc);
-			return ret;
-		}
+		if (ret)
+			goto err_crtc;
 	}
 
 	/* Ensure AXI pipeline is enabled */
@@ -1246,13 +1242,15 @@ static int armada_drm_crtc_create(struct
 	dcrtc->crtc.port = port;
 
 	primary = kzalloc(sizeof(*primary), GFP_KERNEL);
-	if (!primary)
-		return -ENOMEM;
+	if (!primary) {
+		ret = -ENOMEM;
+		goto err_crtc;
+	}
 
 	ret = armada_drm_plane_init(primary);
 	if (ret) {
 		kfree(primary);
-		return ret;
+		goto err_crtc;
 	}
 
 	ret = drm_universal_plane_init(drm, &primary->base, 0,
@@ -1263,7 +1261,7 @@ static int armada_drm_crtc_create(struct
 				       DRM_PLANE_TYPE_PRIMARY, NULL);
 	if (ret) {
 		kfree(primary);
-		return ret;
+		goto err_crtc;
 	}
 
 	ret = drm_crtc_init_with_planes(drm, &dcrtc->crtc, &primary->base, NULL,
@@ -1282,6 +1280,9 @@ static int armada_drm_crtc_create(struct
 
 err_crtc_init:
 	primary->base.funcs->destroy(&primary->base);
+err_crtc:
+	kfree(dcrtc);
+
 	return ret;
 }
 
