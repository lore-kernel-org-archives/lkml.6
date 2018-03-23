Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv1DsHVGV0BBhx+jxhVRcujLfs7HI9wDn5HZMkIdpDPPYJjz9rrDoVGdYREkfAqqymPBs3h
ARC-Seal: i=1; a=rsa-sha256; t=1521800118; cv=none;
        d=google.com; s=arc-20160816;
        b=TQXIE+dGHsGJEAEhiZg1LoR8CVyXKSZkjr0jBqKNAEupL3SrRQsHZI9SMx2GgUcbpD
         3VJyusjcLQhIw0AbWbCs20pRKMjOSQtgUOP2Ur/EdRIS4TVRvdWOqOBrKAR9mEWeBeCF
         n2/R/BiFQtQiX3GTRZo70eZ3PNlv4BSnIBjbV77PmOQY2ovgWSLbrv1T/SGt0y4QcQcA
         V/xH1ToR7Cq3XuMRZS3SXmw7wewnTpJpCc0MXZPB+u1NMewV4/M5q6T0gEIqYl9LtzRb
         gAupF06ovJGxktN8bhO+zmY6l5l83bGcWnZ+rLVYzbBRQRc1x8M1mHujaahf62TW7WUE
         emcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TIs+M6jsumjZY+x2PBaL7fgZDua/8Za7dNm+p2EAZM0=;
        b=ApeIPOG6d+laD73PzWGcnoZyDEG6rrR1EGLmKy0HyNIrCjbtSCTxIJqUeqKH4zwrjK
         f3JFDWYCYMo2oV1/sdBD6SAlGaNYDeDzyQwemBDCfra7KeeIa09+S4ELFqHQY0MxlQbJ
         2qXeiaC22ZRTNoz0VwyPOOt/vu9tKtJI/Ab5wI1GdrQO3vfo2XAq+SFlrYqtSUPDzEUp
         KgQxmlhhFPTVa9fCrZ6SrzKzUphT7o5QJgmGmcM9StUub0GZHxDHibc2OpTNSZYmle/i
         lgBye6auhuJY9kBgaDFI1zEP0KyUi9uL/KRmn8ICcbY2mukhiYcq8s3KWwX1fjR+EJP/
         aH4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 40/97] mmc: host: omap_hsmmc: checking for NULL instead of IS_ERR()
Date: Fri, 23 Mar 2018 10:54:27 +0100
Message-Id: <20180323094159.899305130@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722586597308053?=
X-GMAIL-MSGID: =?utf-8?q?1595723081343135573?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit ec5ab8933772c87f24ad62a4a602fe8949f423c2 ]

devm_pinctrl_get() returns error pointers, it never returns NULL.

Fixes: 455e5cd6f736 ("mmc: omap_hsmmc: Pin remux workaround to support SDIO interrupt on AM335x")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/omap_hsmmc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1776,8 +1776,8 @@ static int omap_hsmmc_configure_wake_irq
 	 */
 	if (host->pdata->controller_flags & OMAP_HSMMC_SWAKEUP_MISSING) {
 		struct pinctrl *p = devm_pinctrl_get(host->dev);
-		if (!p) {
-			ret = -ENODEV;
+		if (IS_ERR(p)) {
+			ret = PTR_ERR(p);
 			goto err_free_irq;
 		}
 		if (IS_ERR(pinctrl_lookup_state(p, PINCTRL_STATE_DEFAULT))) {
