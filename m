Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+FltQQqZXA8S9tovQq+Mtja+2SaXNGzNLcsY5M+udvYqCSLxRGDgJjfHtG0GJxe+7jOmGK
ARC-Seal: i=1; a=rsa-sha256; t=1523980829; cv=none;
        d=google.com; s=arc-20160816;
        b=mmQeg4qLiAGe4Bdw8iRFdVL1RCE39PPOPK0+QejFG31shca2MPLcU5mQn/92Eh+yMe
         wtqHgKGwobfd34TfMCbmSW58veKS/zTLiyBGRpRPF8ln0V0xzdc7s1ypKB3y8P2/oXZL
         yZxszl5d+f4WUNfO+HK5xq1D63b5QAHfc9hUgiwXbWjEnNtathZYnyQJjKtI4l6Ofpes
         h4ipg3roQ2CfZtwpN5Ux68OEGy36zxQ7g0CdQiSEFMlPG96spWKxaddnqx5jCBW/MtPz
         MxbL3YDltJDidrTJlQtsz+6ObCg9C0aT/ONcAVYRMkbGgeUJZ2A3kt+yN/wPhQn3Xsfw
         dy7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8AxUsSMyU94SiTjxTZuWUGVSsFVyglyi3S3YiQLjo24=;
        b=PnaDgNHT3QwgGuKIYPxpkwtbD/p02u7W/c1kIkM3KIBhNG7Mx4sfMY0syWWe2ZB1hG
         AzBRLsqAYovStuNq0F5Vy+HD6PZH3P9Zzp6g25qyd+n6jy/CwzYlFLX0gDBxVzbhUxs6
         V3GPAijp01pThMGPCA+X/HfcHz7qDOUHSluL7wzAH97wgQOV+FRSx9TcVwIpGG8rmHyf
         V1pbLOgfxpkcEKlummhWdWZuhWNicaa1wqXwD3kG/G26yxFbzjHcwXolmOyiPqOBpjJT
         YFZSs0uuIUZZO7pcUrPYMjJSIGnimPSUBdRddNGOOOayIKBSZF+f9Sd4Ucw/nyHiPYjO
         TMPQ==
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
Subject: [PATCH 4.16 02/68] rds: MP-RDS may use an invalid c_path
Date: Tue, 17 Apr 2018 17:57:15 +0200
Message-Id: <20180417155749.441731719@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009722009378488?=
X-GMAIL-MSGID: =?utf-8?q?1598009722009378488?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -997,10 +997,15 @@ static int rds_send_mprds_hash(struct rd
 	if (conn->c_npaths == 0 && hash != 0) {
 		rds_send_ping(conn, 0);
 
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
