Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo+pA2Ec12rgxOZ+rG+3TWQAxvVBDB0FGZ7hDw+Ra3UZFIQYqEH/loDkkE+c1F/IdDWmHGu
ARC-Seal: i=1; a=rsa-sha256; t=1524837892; cv=none;
        d=google.com; s=arc-20160816;
        b=ggCai0Sn6m/XEuG4wEAXatvy6WMSnJSXR+0xvzebCoNXIV/dqpU97Q7S7j7qGFWR2R
         6J+StUfj8qiJyRHZgSfjsr5S7bhN8eox7D8p/F37C/5o+WkYD9215XbCd1VrOoZ/nC3o
         CyBg3LIg5sLu8oArXnC780q2iL69YW3l249kGLlTncrgqNyC8cMc7cuHvo06+65JBht2
         ndjI982d5KECz2htYRsKBON20uZkH9nZqSt9MVjV8XhNKDhwRNProBrcw/MrOygjAHjg
         ZmGNZ9GdSn1hkGZjTN1fiEcAoA0xVgn7C3O8kerlo2zcPculA+H3m7cbzd/BheE7xpeZ
         PTWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=c5gqnVEjyPX8LcGx5pmNxkxElc/BvxtC1andBLMKLHA=;
        b=uminhR1Z3f+HN68My2tb4O2jyPqovRuzi0DDt0j0OUr33+ghUYPTe7Auyy8jIU98nU
         v/xVzYhaeKKw1BbQ620APUF3N8EDxQP5ffFdOnhw610JtCTa8pBaDyW9WxJWDge1lb/y
         70X8yTDZ7knW1WHGuJazkf0Rb8sswNAo6q+kypHD5X4AFSBURBwFdXGYcjyyIuKGSrnB
         XCE4IIQ3LPCZhs0dV2aHqvcsq1gyykXWZd7fcAOhyTAGfPUwiTuNSCXDzj2DGn/K3glZ
         P4Cb5z95mLkKzrLl58YwDVqaTEV4to19DGzpC4y/kBLHyXkT9bvIFQiEcmNiLYxB1nm3
         52pQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E08218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Murphy <dmurphy@ti.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.9 12/74] Input: drv260x - fix initializing overdrive voltage
Date: Fri, 27 Apr 2018 15:58:02 +0200
Message-Id: <20180427135710.404946572@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908262562310694?=
X-GMAIL-MSGID: =?utf-8?q?1598908417716823029?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit 74c82dae6c474933f2be401976e1530b5f623221 upstream.

We were accidentally initializing haptics->rated_voltage twice, and did not
initialize overdrive voltage.

Acked-by: Dan Murphy <dmurphy@ti.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/misc/drv260x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -521,7 +521,7 @@ static int drv260x_probe(struct i2c_clie
 	if (!haptics)
 		return -ENOMEM;
 
-	haptics->rated_voltage = DRV260X_DEF_OD_CLAMP_VOLT;
+	haptics->overdrive_voltage = DRV260X_DEF_OD_CLAMP_VOLT;
 	haptics->rated_voltage = DRV260X_DEF_RATED_VOLT;
 
 	if (pdata) {
