Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvpDZpHQKeuZot9QvY1Kf7MwQy41qC0UyfPsJlhP5sgyblyq2uUMebhyK1/8NfbWXalUd3h
ARC-Seal: i=1; a=rsa-sha256; t=1519981137; cv=none;
        d=google.com; s=arc-20160816;
        b=HcV735lIRBxKcMWJvqlDDbO7MGhmse+zthxNoM43BGeX9DxLeeXaI8VpJFd7kY8N3h
         PKrgooc9XRnfASrIVNtDh/YoRKtN6lhmvNG/lEmxJqeDHpHhkCm2ysqU5inEGQmkii68
         EAL3lWLAzGi6oCdFryM+p39V5jLybh6JKrqQflFzFxIh1JQ22kqngYp/5d7tyITIC1Ro
         0ROTIy8AQKqT3CFb+h0XCwnuHPgZRBiH7aUJvIhasg+hhcHigzc3o9op5FkRe+bosTBc
         W+/up5Jjtest5pDLuWKSEN4vOcO6db/QNhA7P3n2QnksHuhw7hqxuKsx+hzioeWPMD2I
         5jPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YrDSHq8Lyy7WGU4S4NiHng4Z+1XnDDe8L+zYQWt1jqU=;
        b=NuZgCSPv6fuc35f812oBRLuiAMc7/77RuDwnUZy7XYLp8PhKMj4t97JH6euzOHamx1
         JGb+7ahCHdycG4z+0goE484OGlnqrCOXYzbYdfkfzZ6YntodSiS7ycx/pexhdrZJHIFH
         qa4x+T00JFGQUyFgblLrVIwAJTiNj+tu8dBfTdeBv/834d6Qa9Y+m50Z1P+f3VpZGWpg
         rMl5aOb8g5kmRXKvKzPO0kFaX94iDS89b5iV2Sy7Gy8amwI9RhHbQaoWZ1sq1EvRMDT1
         xHBi6zPbufXHu3WtFnx9Qr+kHe0cBYQwzGubEcwJp+MtEvT4dC7S6ysO9Uv11dnu6dI7
         KOug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 53/56] sctp: make use of pre-calculated len
Date: Fri,  2 Mar 2018 09:51:39 +0100
Message-Id: <20180302084452.215587772@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815405591850190?=
X-GMAIL-MSGID: =?utf-8?q?1593815740761086987?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


[ Upstream commit c76f97c99ae6d26d14c7f0e50e074382bfbc9f98 ]

Some sockopt handling functions were calculating the length of the
buffer to be written to userspace and then calculating it again when
actually writing the buffer, which could lead to some write not using
an up-to-date length.

This patch updates such places to just make use of the len variable.

Also, replace some sizeof(type) to sizeof(var).

Signed-off-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/socket.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -4765,7 +4765,7 @@ static int sctp_getsockopt_autoclose(str
 	len = sizeof(int);
 	if (put_user(len, optlen))
 		return -EFAULT;
-	if (copy_to_user(optval, &sctp_sk(sk)->autoclose, sizeof(int)))
+	if (copy_to_user(optval, &sctp_sk(sk)->autoclose, len))
 		return -EFAULT;
 	return 0;
 }
@@ -5342,6 +5342,9 @@ copy_getaddrs:
 		err = -EFAULT;
 		goto out;
 	}
+	/* XXX: We should have accounted for sizeof(struct sctp_getaddrs) too,
+	 * but we can't change it anymore.
+	 */
 	if (put_user(bytes_copied, optlen))
 		err = -EFAULT;
 out:
@@ -5778,7 +5781,7 @@ static int sctp_getsockopt_maxseg(struct
 		params.assoc_id = 0;
 	} else if (len >= sizeof(struct sctp_assoc_value)) {
 		len = sizeof(struct sctp_assoc_value);
-		if (copy_from_user(&params, optval, sizeof(params)))
+		if (copy_from_user(&params, optval, len))
 			return -EFAULT;
 	} else
 		return -EINVAL;
@@ -5947,7 +5950,9 @@ static int sctp_getsockopt_active_key(st
 
 	if (len < sizeof(struct sctp_authkeyid))
 		return -EINVAL;
-	if (copy_from_user(&val, optval, sizeof(struct sctp_authkeyid)))
+
+	len = sizeof(struct sctp_authkeyid);
+	if (copy_from_user(&val, optval, len))
 		return -EFAULT;
 
 	asoc = sctp_id2assoc(sk, val.scact_assoc_id);
@@ -5959,7 +5964,6 @@ static int sctp_getsockopt_active_key(st
 	else
 		val.scact_keynumber = ep->active_key_id;
 
-	len = sizeof(struct sctp_authkeyid);
 	if (put_user(len, optlen))
 		return -EFAULT;
 	if (copy_to_user(optval, &val, len))
@@ -5985,7 +5989,7 @@ static int sctp_getsockopt_peer_auth_chu
 	if (len < sizeof(struct sctp_authchunks))
 		return -EINVAL;
 
-	if (copy_from_user(&val, optval, sizeof(struct sctp_authchunks)))
+	if (copy_from_user(&val, optval, sizeof(val)))
 		return -EFAULT;
 
 	to = p->gauth_chunks;
@@ -6030,7 +6034,7 @@ static int sctp_getsockopt_local_auth_ch
 	if (len < sizeof(struct sctp_authchunks))
 		return -EINVAL;
 
-	if (copy_from_user(&val, optval, sizeof(struct sctp_authchunks)))
+	if (copy_from_user(&val, optval, sizeof(val)))
 		return -EFAULT;
 
 	to = p->gauth_chunks;
