Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt/g+iv+OTxVwRlIiX7XyGk5LT5HfbuvbPWrsap1/lTqSnTsvZx4cCTSEZzfvJ/cTG9s0hC
ARC-Seal: i=1; a=rsa-sha256; t=1521214545; cv=none;
        d=google.com; s=arc-20160816;
        b=IQrku2foqtO6jgN1D98b+jvu1ac+hvDGiEX21lXs5lB/zbufgwXktYHSF/FlPJY/yp
         EpX36IApBtnh+xRve+8toEREbcnD3pGPVMqBOt3L+eU8gf6zn2WadtDpfYGV7BeED0kv
         RWPhZnHmodVpJs38nz5LaqNTkFfHGFZ2utz2ehwNOQYI5rmkPlAVEkCHEG5wYqKghxix
         saZoUbqmIZvgv68MEMxH0trDoklG/OItG1wWA4w1TNY0Z7F0sIH85dKGRGjE8Y9QmLUG
         MEhAJv0h+jH1srRQ7qEWz0JFENUZWbmH4xB9CEnf9lNcwF36jL4KACPr+WhGd8NZhLwO
         7AYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=N1j3JR5U8aPHiQu4mYNDoFNSKJ6bJWLssAh1CvfgyC0=;
        b=G5LNr+AghpGQ6ZdIqFEVdAhqFE02Ize2qwYqaq7rpudfQdDgRLOPf6gK3CPKT1yA63
         P5lNpXjWcgUerd+pQsbGwiCnLJo2Ko719OLr7pJ5cDMJTScgswW8/Hw2/RodTtXLjFe7
         oZOpPg/Ju12BDN5pA7TmULxfwsrwnpP6MbA+zYh+tD0nlj6Sgbx7zo2XCF2LoS8U3DxD
         6XMuBcD5FUtddYkwk4Zcou8ePtdzZcfbW8OrIRm6GCLZS9PXjrYJafcFiHk+9KY0ri2Z
         dqqkWhFymWS21eu6F2612i9jC+1gal6l3DusD99uJycM8mRfC8NXQ9aMQm9mIMax0goI
         XgjQ==
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
Subject: [PATCH 4.14 045/109] net: ieee802154: adf7242: Fix bug if defined DEBUG
Date: Fri, 16 Mar 2018 16:23:14 +0100
Message-Id: <20180316152332.425198988@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109062996502048?=
X-GMAIL-MSGID: =?utf-8?q?1595109062996502048?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
