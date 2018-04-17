Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49xlxvksn1/qrtmz/mIglfXhzzcTtWtAefzc/V/lcTbNZ79caxsIRF0NaH200ca+c/aQJvq
ARC-Seal: i=1; a=rsa-sha256; t=1523981442; cv=none;
        d=google.com; s=arc-20160816;
        b=l0AiI2+8fBRR0msA4RIt75ccxMeKPVEHCMS0uxSU70tDBqL91Gc3tKfkWiffA9TRPC
         dK10IqF1HQkkyxJk9/ICtc4KOa4wI/oYO6Vdvoj6EUiEXgQZuESfhN2UToelS85cIOpg
         ViuR42qIJ2r+F0+a04OaD58Vd8WgknYo8G1njCj/HIPcvkqaNYko/7iPCgsTY1nyOgY2
         QbupUfArRO5EVvNBm82bj3F5hepoOp31rUDSKU2EjVJmUHP/zFrOlrUnXhacvKKxv9Ou
         NeZgB3Y7b5ROwhGcLXCsWbST0jisM3B4368CafS3iXMrgzdQR8pRc38vWR3mi3V9vZQN
         TNsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dQDePi0qLpJ0rEk6zS1pdX9eXpLmsQloDCLyTLWWh38=;
        b=w1SB9euri0SsRlg5CYCM5Xi7OR6OUL0HZolPNwGa+09gM6Ssp6byi/8khz4GKD4RnG
         xizdu8lx0ls7XiWP+I/4zjGF0Oe94RbErrNT99/rrD6pQRO2kUztFhcMAEYpLVqpf12/
         n1yVwVMnMNzPM8zMUp98rT0BVODvzWDquN6qe0tTYs2+Fx/RFahrvAgcpm06q0lKy2VN
         1fXpKw1ZZWlxP2q0MVvPjfzo3P0P98yBv7BHu/g30SQ2n6Ymbbbb1RUKvbIPJ3di86SP
         pStLT2kzM06aGt7OZ+9KboQqs8xBhF7WybtDvYOO0PDdreUAzieIXGmXcJy5A7IGkCnr
         WnFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
	Santosh Shilimkar <santosh.shilimkar@oracle.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 63/66] rds: MP-RDS may use an invalid c_path
Date: Tue, 17 Apr 2018 17:59:36 +0200
Message-Id: <20180417155648.597585073@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009722009378488?=
X-GMAIL-MSGID: =?utf-8?q?1598010365209419114?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ka-Cheong Poon <ka-cheong.poon@oracle.com>


[ Upstream commit a43cced9a348901f9015f4730b70b69e7c41a9c9 ]

rds_sendmsg() calls rds_send_mprds_hash() to find a c_path to use to
send a message.  Suppose the RDS connection is not yet up.  In
rds_send_mprds_hash(), it does

	if (conn->c_npaths == 0)
		wait_event_interruptible(conn->c_hs_waitq,
					 (conn->c_npaths != 0));

If it is interrupted before the connection is set up,
rds_send_mprds_hash() will return a non-zero hash value.  Hence
rds_sendmsg() will use a non-zero c_path to send the message.  But if
the RDS connection ends up to be non-MP capable, the message will be
lost as only the zero c_path can be used.

Signed-off-by: Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rds/send.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2006 Oracle.  All rights reserved.
+ * Copyright (c) 2006, 2018 Oracle and/or its affiliates. All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -983,10 +983,15 @@ static int rds_send_mprds_hash(struct rd
 	if (conn->c_npaths == 0 && hash != 0) {
 		rds_send_ping(conn);
 
-		if (conn->c_npaths == 0) {
-			wait_event_interruptible(conn->c_hs_waitq,
-						 (conn->c_npaths != 0));
-		}
+		/* The underlying connection is not up yet.  Need to wait
+		 * until it is up to be sure that the non-zero c_path can be
+		 * used.  But if we are interrupted, we have to use the zero
+		 * c_path in case the connection ends up being non-MP capable.
+		 */
+		if (conn->c_npaths == 0)
+			if (wait_event_interruptible(conn->c_hs_waitq,
+						     conn->c_npaths != 0))
+				hash = 0;
 		if (conn->c_npaths == 1)
 			hash = 0;
 	}
