Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoaeuWvk7zVp2iC6B2Hf2FbZ6uU8zafAdXcaLgIP71okV2OA/Bs2jUE6fhs+6Wh+dFPciW5
ARC-Seal: i=1; a=rsa-sha256; t=1526280848; cv=none;
        d=google.com; s=arc-20160816;
        b=W6/B2yCfoCHHXB6Oec5bRk8L1awOTXjlnYt+O1zl+ESKX9hTiVLwAvjNpYLCP88vlY
         Ogu0D0FYW9VR6vP+R2vbJs+tpyWyIV8n+TJfy8S2momLO3vk0xiFi+pOuPTWBajx1w6m
         F8TUuxL3hVHgQnVwAbpTM39plmtuHX0OtzbMv7xw0BpgtiCrJCAsprRP4ay2cfHwAzOC
         SGDBJn34nnVZlAbiPUHWo8nzfe8QSzONZ2dwv/PgeLxb35b48iAo+7zqycJnBZuoMGT3
         KW1M3goEmUdxbd9cK63MOuOOF80Us5Pm+NBBCq63wIo8uWKdY6Ug2SAMATs8Li8gToyL
         Jrdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=r71g7VfTtXyhcInCOVt/5eYfowhMh+iQy9DUC6jYKuY=;
        b=krddKG6bHeOA0r6busaMqm0YyBuOBsoTTKu+F40lif5qiQy6cINZnST/ALtClngeXn
         A61k2W68UQT4FKvNTqkMio+9xTVnTmZD3XHNITblh8zFGITX8DYK/CbuZ7cT6ijaVc7m
         70WX45PnTFr2vnK/hO4rjV1NZbE5stS8Rbgd6hYYiWD1jMMvdKAWYfOuGRk5wfewuPxn
         EebMgoF+8NCS/M0LrjjEpIBZIFvjQnYTNKztzl4PSB8DbYlpQEzBeVnM3wsdTfeVLWxk
         63XLuoBQs5CCrkMOM0242yJP1oHEQ5HYeIkeLfmiPeiolA8Yl36dsT63/dZ4LVoRFSGK
         Le5g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=oirdZXiV;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=oirdZXiV;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jimmy Assarsson <extja@kvaser.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.9 23/36] can: kvaser_usb: Increase correct stats counter in kvaser_usb_rx_can_msg()
Date: Mon, 14 May 2018 08:48:57 +0200
Message-Id: <20180514064806.063336229@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064804.252823817@linuxfoundation.org>
References: <20180514064804.252823817@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421236759746459?=
X-GMAIL-MSGID: =?utf-8?q?1600421466995633291?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jimmy Assarsson <extja@kvaser.com>

commit 6ee00865ffe4e8c8ba4a68d26db53c7ec09bbb89 upstream.

Increase rx_dropped, if alloc_can_skb() fails, not tx_dropped.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/usb/kvaser_usb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -1179,7 +1179,7 @@ static void kvaser_usb_rx_can_msg(const
 
 	skb = alloc_can_skb(priv->netdev, &cf);
 	if (!skb) {
-		stats->tx_dropped++;
+		stats->rx_dropped++;
 		return;
 	}
 
