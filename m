Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv9J6Hq+oDjNB+ebWz0BdLk+td8oUeEmrTzXxQJIeQya1XUulIYuGIsJoz+j1C51YvckqjI
ARC-Seal: i=1; a=rsa-sha256; t=1521483944; cv=none;
        d=google.com; s=arc-20160816;
        b=x3r4NgI4seNIA26sp/94DLZAmeAdc29COUqsInfklO1OiBnhFs8lzxe75M0RlwyBzv
         HwtYHkl9+wgRWyWVARJ2n4a3xr73/wKTdBYhQHftmtqQmVwLLjRD/Wu6VOtImGDJ6iyh
         Qktxv0HCvf1SNu+84TlP2NvrjUNg8VPmBPGBbDuzTzLSx4T0AhGsWsTtc17w6sVJYrCf
         2BfQPjJ+BpQqpI9SrypRU2pfBGDhjwwkWlIPUC2pwjc06xjsOEnLgMjKySzNZsaDib1X
         Ngd8Gp6nwLzyZk/bb+eQkh7hJne+rSWAP3i1jpBGCIe1bSz0QUGcpXjE755eDrl4jWSQ
         0FIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xlUYFG/y/dEX4vQ8+l8BQrmIhiEBkVmQuJ3zbaSF4jk=;
        b=Y+pOTrC3q18+sqKa0lqjiEjQS0+MSPejRPUkRcsTaa/F8pADebCKtL6/c5rFab09QA
         fyivhODtcRJYkANexxFVJPYSSd66dN/4xKx5mHQFc8X8g4qsILHqW3qnwp8nO+YiOdpK
         llbM34tIIK8E61MWZOSbTDd21hxG+IgycxuF8V+V0DByFzCPhNPxAv/7byzFsIDSIpuB
         7syYl1XwpmR/Ci9IFzACXOGGgtUucjFmJ9uxsQfBRSa46RiE8XwLVsrHQklMf/TuK5Mq
         GpXDHV93A5Jce9PZ8Z4lwaBKrxnKarBSPgMurjtYImRx0jLptAzLFEbjrGMJBoqLZM7B
         GG+w==
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
Subject: [PATCH 4.9 173/241] net: ieee802154: adf7242: Fix bug if defined DEBUG
Date: Mon, 19 Mar 2018 19:07:18 +0100
Message-Id: <20180319180758.317636013@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391548381946292?=
X-GMAIL-MSGID: =?utf-8?q?1595391548381946292?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -888,7 +888,7 @@ static struct ieee802154_ops adf7242_ops
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
 
