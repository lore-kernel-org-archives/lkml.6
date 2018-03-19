Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsTqgm7mhi8lxedAAspgx6lhyOyJTZUk8R6fwE/oRlMTmRYD5EQdl/IDMyYLDMNkWMKoka6
ARC-Seal: i=1; a=rsa-sha256; t=1521483576; cv=none;
        d=google.com; s=arc-20160816;
        b=vqETo5AZ2I3Wj4hUJ7Uye4KIWCsNwR2smnmSLRAmSVJWZ0DusjRHNnHu66MsWMKYFz
         ys5VOp9hf+Bkfy/9CtmgjwA7W0PDSjFy2V2crwC5VGfSWL+2WZ00iWJB+zC7JxdIKcl/
         PMqYv8GoBbQi9Ffs35RQtIjVnMDHC/BBSBuO2nkEnh30PFDUVRfEnKZtaYWMgELWsSGk
         wDdfEPv5wppFsRXxBDsdmIcr39DwrVCHhPj0GeUVfH9GmyYhGVZBLIKaUbiA8OGykTm9
         8gPZI07voKHOjcY2xFtNWiZhj9mweMLauA9q/VnalFTuWm2eYA9TIMm0czrdnAQW3sWJ
         5jFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CvttG7Z8QqJ/CHEiwfpa5cK3vZld6mTXtIocDzQZXQA=;
        b=aFrWrTe84IiFaXqGD74WmqJQ1hYyUUkXvfHF9Pqx+eKYDiziHkgCtTMyguzM0xnLC8
         Rz6JzIC6ycrEQpXe1DEO9uyBLiribUKIJpsPaDxo7u92G9/tS1lw0PdUsqvpEqjm1HLi
         Ji0C7MgN2EIjv2NJJFrK8eHIWUGE2Q0Cmk5JE8SiSz640W7rExWid3VYJvItGf006C2Y
         4miBmld9rPIT3sIb9T1V/inTc+ngkjyfFbWrNXGU4AMCSEjSqHE6mIrqJ6e9dvXKZR2P
         07KaLksKTcGjIIwxvqO45B0GnZhncZSGioGSsPNRSvAHwyWYSF12u1TPlf3uRFuApcG1
         1YsA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arvind Yadav <arvind.yadav.cs@gmail.com>,
	tomi.valkeinen@ti.com,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 040/241] omapfb: dss: Handle return errors in dss_init_ports()
Date: Mon, 19 Mar 2018 19:05:05 +0100
Message-Id: <20180319180752.861721795@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391162244534313?=
X-GMAIL-MSGID: =?utf-8?q?1595391162244534313?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arvind Yadav <arvind.yadav.cs@gmail.com>


[ Upstream commit 0348aaa34412e24ebe622a2b1b013e68d6ae5412 ]

dss_init_ports() is not handling return errors from dpi_init_port() and
sdi_init_port(). It is also always returning 0 currently which results in
part of error handling code in dss_bind() being unused.

Fix dss_init_ports() to handle return errors from dpi_init_port() and
sdi_init_port().

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: tomi.valkeinen@ti.com
[b.zolnierkie: fail early on errors, minor fixups]
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/omap2/omapfb/dss/dss.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

--- a/drivers/video/fbdev/omap2/omapfb/dss/dss.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
@@ -941,11 +941,13 @@ static int dss_init_features(struct plat
 	return 0;
 }
 
+static void dss_uninit_ports(struct platform_device *pdev);
+
 static int dss_init_ports(struct platform_device *pdev)
 {
 	struct device_node *parent = pdev->dev.of_node;
 	struct device_node *port;
-	int r;
+	int r, ret = 0;
 
 	if (parent == NULL)
 		return 0;
@@ -972,17 +974,21 @@ static int dss_init_ports(struct platfor
 
 		switch (port_type) {
 		case OMAP_DISPLAY_TYPE_DPI:
-			dpi_init_port(pdev, port);
+			ret = dpi_init_port(pdev, port);
 			break;
 		case OMAP_DISPLAY_TYPE_SDI:
-			sdi_init_port(pdev, port);
+			ret = sdi_init_port(pdev, port);
 			break;
 		default:
 			break;
 		}
-	} while ((port = omapdss_of_get_next_port(parent, port)) != NULL);
+	} while (!ret &&
+		 (port = omapdss_of_get_next_port(parent, port)) != NULL);
 
-	return 0;
+	if (ret)
+		dss_uninit_ports(pdev);
+
+	return ret;
 }
 
 static void dss_uninit_ports(struct platform_device *pdev)
