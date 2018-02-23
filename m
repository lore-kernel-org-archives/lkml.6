Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227OKX92BHSY3gljM1y0EFg0D8y664q8tTXiOWuj7ptoq0W6anQAJfH2hliU1e2O0dTEBOpc
ARC-Seal: i=1; a=rsa-sha256; t=1519410914; cv=none;
        d=google.com; s=arc-20160816;
        b=DDTBidD3qvQ+vq3XTAah9lsnIAveRoyE0os3PBk4EOpxzNZgIhNeVWRxbwXcImSeYZ
         Jvf2VV7Dm0ovH2fRYv/o4i4FoVwzXesbLM5zHzAFUjLO/p9KlcmLupz63LBNx1+PsqRG
         V2bcbCbvxJ+mzfuR3+EJ8URmB/kHNrEXHCxja3BzfI3CXd6ZhmRcfKDb1tVZi+ZtJ7ZS
         XVJzyQvkyQ0vytNdZPYPJ8Op5daQddl3tfrEgMt6zK4mGzlIUSA/cIAnEombAVLoCZab
         W0JJ5zHAqOvSTPaNeKupxJmfhwVrtDbCWxUNEdwxgb4UKJFZ7LvXN7v8D+gTT17bZAe8
         AdgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KGZV8gR9jGpasnwv81KDIxil6/49UlOmVIBZ9P5853o=;
        b=ow2RXYpi0vfJngwlgFa4csG4+O2YqIBE8Q7J07PLcbKsdDW3ggxFddI8wfEtjVBi8v
         Iia4O2gAsPDvoRezRqkpHatAJZBzydY2f67C6qWLX3Zw+abd4CdAL4ANxUMAkbvUspDQ
         YxmqZLsJuKGLRjV5qqMIstAMe4+y5BhKgOaggLB72aWP0o/yogavjSu4s7Mtwz1wKA4k
         03dOyHaabswSAKbiGkBaBZuDehndbRAVkQcD+KBPSDp5/uGrtjzSLWMS7lcG245tYFcy
         Ymuosz8vMZDofnC4YQebO3865Qhdua7Pek6mm8VBf+CxRB+j2KBvV09oNadqasWJbwJX
         Jb/A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 056/193] drm/armada: fix leak of crtc structure
Date: Fri, 23 Feb 2018 19:24:49 +0100
Message-Id: <20180223170334.767274930@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217818345500659?=
X-GMAIL-MSGID: =?utf-8?q?1593217818345500659?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King <rmk+kernel@armlinux.org.uk>


[ Upstream commit 33cd3c07a976e11c3c4cc6b0b3db6760ad1590c5 ]

Fix the leak of the CRTC structure in the failure paths of
armada_drm_crtc_create().

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/armada/armada_crtc.c |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

--- a/drivers/gpu/drm/armada/armada_crtc.c
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -1182,17 +1182,13 @@ static int armada_drm_crtc_create(struct
 
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
@@ -1203,13 +1199,15 @@ static int armada_drm_crtc_create(struct
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
@@ -1219,7 +1217,7 @@ static int armada_drm_crtc_create(struct
 				       DRM_PLANE_TYPE_PRIMARY);
 	if (ret) {
 		kfree(primary);
-		return ret;
+		goto err_crtc;
 	}
 
 	ret = drm_crtc_init_with_planes(drm, &dcrtc->crtc, &primary->base, NULL,
@@ -1238,6 +1236,9 @@ static int armada_drm_crtc_create(struct
 
 err_crtc_init:
 	primary->base.funcs->destroy(&primary->base);
+err_crtc:
+	kfree(dcrtc);
+
 	return ret;
 }
 
