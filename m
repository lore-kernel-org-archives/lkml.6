Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuISdrgxub1ySABvVgaBATqMMvVcmegAodZchViTfGLN9A58xPxWt5qenTJcL7Hc7jveHHQ
ARC-Seal: i=1; a=rsa-sha256; t=1521214888; cv=none;
        d=google.com; s=arc-20160816;
        b=HN71evt2RkagXgOn+4dxe6G8gPI1/82EVPCdbWGna8+9zE1S8pHWSDejp9zG7iXgiY
         dDPkjTa73Am1NmEKMQfD5i5sQx+3WdkDrYV0+/8btWeoohUDxRXkqdopJ5qs2vY9R0Em
         W2Wjp5ljxDLGaY6utZgAO5mrI0IwpkF0stnW85K3p3C02fc5wOWt4GRztDCqWZK9Dj1F
         JEAaHaF29LxyLjwmICKeJmsekDTntrPsiT7p9NsCsiirr2+Al6YP3eD1jBToe+oFpo4q
         NnVcpbZaaxKt1LrGdqDqHdw70uwPGWw4nKldVnYOQ6JCwAuLnx+301w8p7WWUHmXDNAu
         x2SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=O09WsFbrnjHonwTDNTViQgyOb69b5H10dF+cjrNh7gU=;
        b=OGRfZASIO6ZYKTMvp7OoN0Ba65SGARBnvLBsLYbtZSRGnf3wMNwRmKpYRMT6A+PdZ5
         9rXABsBznD9WVLYs2xo9SSmurXjp3RzjuFyZa1PYg5Jx3ZU7K9zMLXqjH9WIgMGl17F7
         wMwHuWUvO7JHAubRzK6Blvcc+nmpMtcogCE7Y3ntHolBGUIiBv5isPR62QwvXPI08Qut
         SJ9s90svEZt9uNqgxRcB2kXbw+gRzX2hvRv+64DlorC0pi9kZpGauKBClhoRQa8Sr9Ty
         jUSw2i7pnsfmXpEme1I5UkJJIwdwNmWOQDSQSkBtCim9L0nZxs37TeNmbeXTuynyCiDM
         hq8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	Stefan Schmidt <stefan@osg.samsung.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 054/128] net: ieee802154: adf7242: Fix bug if defined DEBUG
Date: Fri, 16 Mar 2018 16:23:15 +0100
Message-Id: <20180316152339.542391941@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109062996502048?=
X-GMAIL-MSGID: =?utf-8?q?1595109422861011169?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Hennerich <michael.hennerich@analog.com>


[ Upstream commit 388b3b2b03701f3b3c10975c272892d7f78080df ]

This fixes undefined reference to struct adf7242_local *lp in
case DEBUG is defined.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ieee802154/adf7242.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -888,7 +888,7 @@ static const struct ieee802154_ops adf72
 	.set_cca_ed_level = adf7242_set_cca_ed_level,
 };
 
-static void adf7242_debug(u8 irq1)
+static void adf7242_debug(struct adf7242_local *lp, u8 irq1)
 {
 #ifdef DEBUG
 	u8 stat;
@@ -932,7 +932,7 @@ static irqreturn_t adf7242_isr(int irq,
 		dev_err(&lp->spi->dev, "%s :ERROR IRQ1 = 0x%X\n",
 			__func__, irq1);
 
-	adf7242_debug(irq1);
+	adf7242_debug(lp, irq1);
 
 	xmit = test_bit(FLAG_XMIT, &lp->flags);
 
