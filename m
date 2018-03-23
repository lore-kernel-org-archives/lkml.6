Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvGhqq05o9Ykqnj3V2cm5lG3wrOGBbmVnoaqpWZYYOeFNJXcYUPBZevdHrQHQrqvUyOx6jG
ARC-Seal: i=1; a=rsa-sha256; t=1521800345; cv=none;
        d=google.com; s=arc-20160816;
        b=kBB3lrsa4pe9XRC23W40wBpmm/UQxOvMw1pCpw+3PacdtJ6I0SWPzGS/iCHk6j7RTc
         U35fRpNrQqVJ2rliMfh3eAU0CxaA0JG6FbSofrwdWwSMXnX3Rqz0sow+rSzanb75DJuY
         nJLxs7MtSFbYc9mfryT8e9AWXKBQRzAWc1M5QmesFto7OraMteYWA6bGZ5CpRICt7Dn2
         PK832Q1mID+0t6qzTyjhII/Rr8zVnwCAMwFkeTDwR/tWFWvmpT1Vh4Te3BZJOGQMfcpE
         v5no7elo9H7+C0PaeOT3m8/K4HLH+NrcA09Wn23zbL99kNyvWb9cm60Txxvgf+rxkn1X
         jFmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=s5N9QDEAwpmt0VLfACHsMx5uIgK72O0z6HyEllZXOtw=;
        b=qPD4pg3Vd3MCl9mipZTgwRvWm+yZoVlaoCepZHFegYKDIvauTcdMaXLdfPMdmTUvLr
         vi88Rz0L5ZSUmRAJUqxv0UYuTeZKZ+3RWynxWRu4EbYbd4DKXwYqHcfApeeQhUhIaMBz
         y8E2mF+PpuR38PMemVFeVhshg93pDL84z//b9k9J5JWRe5DxAxoBUrKUqduMd7QJKBBM
         nXLqMPE9VrMXGscVxUp8TubPoxJSsQIfDwC98kXYsN5JW+nVU4jgWYYwtfta25YOE5cz
         l1rQBwJ9CcAd4TjIfj3SdWFSYZ7pBmA445+Wugp2bugruYzJ02N83BnV4I8hZ+pREyha
         lFSg==
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
Subject: [PATCH 3.18 20/47] mmc: host: omap_hsmmc: checking for NULL instead of IS_ERR()
Date: Fri, 23 Mar 2018 10:55:11 +0100
Message-Id: <20180323094248.990377219@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722586597308053?=
X-GMAIL-MSGID: =?utf-8?q?1595723318532732832?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1757,8 +1757,8 @@ static int omap_hsmmc_configure_wake_irq
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
