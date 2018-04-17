Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/7hcDFPWYqKtOD/uF7XUtU3W+EUeiMHI0je4PEZwGb26QtNhEemLmN9gbBvREJJeMm3pqu
ARC-Seal: i=1; a=rsa-sha256; t=1523981191; cv=none;
        d=google.com; s=arc-20160816;
        b=N3dwqEfrixfW1JCoTzdC3NbBDq6vusK9+NVKdhcnb0D/gHfQRJWKVKIUoo38CfQv5+
         iE9OBO+ShcTVC6PaD5t6YtIV08PRaXk+94/pFTP3U3cKxQVUgIHeZwQOPYkJbCQ1w/P4
         /vImJSZDpSHS2kld90NYYfbC6AZ3Mf3EOo7WwDU+Wqk1QBldufkur3hSvpaUJh3J2Vsp
         HY3Q1H7TVsOWhcafroocvrna+Hy7BcVH6iAPQlXOQLle18lgzGuYmlWF30eAQJ6j2cQ9
         aVC/vNcLtNdz/R7HlO4cQ9OfUDlEx+ssf6rGowpwmV3qIxTnD7cIRG/WOf3az0jG+5r6
         3moQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5r7Vc9UhtVpRnQ2jrnh9Xv1+TTjz0HEPmskczH/649o=;
        b=yJFEcxaNR8vhPs9Dd8JrbWq+P5fv3DwZcPV/xGNb8o+d/IZXXucszRYBWiqjECZaRt
         OYVgDgEfd4QatZWdldxUJs9X0BszmHhLuOd04L5Zx/TOCGSBRNxoz85xXnfiutoEoY35
         rAokRwORZWee0XwnbcZP9dQp2SaQQAGtxkQEQd72YAPWbCheKus70xiYfMjHkGT3Ne1x
         95vFea06AJiM3/bV7VLWiTYj44l3nx3Y+OgJtoeKdmWtUty7nEmYngjpDE1ybyq6Cueb
         a3zQfAJDqFz+08AyT/b6/4rGHjFqeGCFoMtfp+9NwdIH9sYxxWQZ+hsXY61MvCr+MSlF
         yjHA==
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
Subject: [PATCH 4.14 03/49] rds: MP-RDS may use an invalid c_path
Date: Tue, 17 Apr 2018 17:58:42 +0200
Message-Id: <20180417155715.190382158@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155715.032245882@linuxfoundation.org>
References: <20180417155715.032245882@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009722009378488?=
X-GMAIL-MSGID: =?utf-8?q?1598010102431270835?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -986,10 +986,15 @@ static int rds_send_mprds_hash(struct rd
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
