Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs6ZPByt1Cw3cZdTtrbog0mAE3LzUQMCEBulRdH4wiG0HU9afVq82VjApS1M8QHIWjULK3V
ARC-Seal: i=1; a=rsa-sha256; t=1519981529; cv=none;
        d=google.com; s=arc-20160816;
        b=riU1qk3tMICdAi5OIm9nqEuZ5D8ZzQg8p2O25nGAtqoJaBsze9tAmjRUecAzCACwFt
         d5gyWfMJ4SHaya1cxB3fvwSqLx/1xI3vTjORd3ovMKr3As6pUgzh/ONuNXmav1r0fOaK
         +FbUD3UT2bPZbfoSHQL6jfhdtyrOadbkVdUps92X174kodXvsNHFX+wLQEbztYmaHTZn
         4IKkBpRppVEdRn3YftKmx9zzNhWgsdPE6P//BXHDKwujp8xRV0P1QRywa9O2xMGp4zBk
         ZTYV+XEzRPAroaucpMOV8P2YCbp9UuwBSoxOQZzTRgA3DeaQh7JY0nqDSwQj18RvEkJ+
         Ersg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SLTQvscNY1VcSCpWHLBaYMYbrzG6smUeSVFsvrjXXBY=;
        b=gwAnZ6xoZ9TgOl2edsfAVHm8vADCCW/iYxYsVFXnXVJ5YKX+e1NAloj0YwHxvwQbWc
         upG7KtB/BvpP3o72f183B+qzMhkYZwCIe5piI3srH9PW0bWaBJtQnoCmMIM/dTOiNBus
         OxKjFrWc+h9LlKf51Eo5fqK87jn+cpJXhklPP0/J6cDOrEhXOoQl5/eCZ+9maeXhmoIl
         7eK0aCwQl1KCnK+rpPAogIYh/+FlS1Tbq6qCafevkLW6kpMj+ZAQkMsVbZ0QOI8rxBZj
         wo07hzVEBvgTpdHZjxOdKsdOjcOgUMfz5TFEuOB5Sgp0Usey8kIt1Hw5BkjE2ehQKN/n
         5+sg==
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
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 103/115] sctp: make use of pre-calculated len
Date: Fri,  2 Mar 2018 09:51:46 +0100
Message-Id: <20180302084508.012827424@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815405591850190?=
X-GMAIL-MSGID: =?utf-8?q?1593816152515796195?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/socket.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -4957,7 +4957,7 @@ static int sctp_getsockopt_autoclose(str
 	len = sizeof(int);
 	if (put_user(len, optlen))
 		return -EFAULT;
-	if (copy_to_user(optval, &sctp_sk(sk)->autoclose, sizeof(int)))
+	if (copy_to_user(optval, &sctp_sk(sk)->autoclose, len))
 		return -EFAULT;
 	return 0;
 }
@@ -5588,6 +5588,9 @@ copy_getaddrs:
 		err = -EFAULT;
 		goto out;
 	}
+	/* XXX: We should have accounted for sizeof(struct sctp_getaddrs) too,
+	 * but we can't change it anymore.
+	 */
 	if (put_user(bytes_copied, optlen))
 		err = -EFAULT;
 out:
@@ -6024,7 +6027,7 @@ static int sctp_getsockopt_maxseg(struct
 		params.assoc_id = 0;
 	} else if (len >= sizeof(struct sctp_assoc_value)) {
 		len = sizeof(struct sctp_assoc_value);
-		if (copy_from_user(&params, optval, sizeof(params)))
+		if (copy_from_user(&params, optval, len))
 			return -EFAULT;
 	} else
 		return -EINVAL;
@@ -6194,7 +6197,9 @@ static int sctp_getsockopt_active_key(st
 
 	if (len < sizeof(struct sctp_authkeyid))
 		return -EINVAL;
-	if (copy_from_user(&val, optval, sizeof(struct sctp_authkeyid)))
+
+	len = sizeof(struct sctp_authkeyid);
+	if (copy_from_user(&val, optval, len))
 		return -EFAULT;
 
 	asoc = sctp_id2assoc(sk, val.scact_assoc_id);
@@ -6206,7 +6211,6 @@ static int sctp_getsockopt_active_key(st
 	else
 		val.scact_keynumber = ep->active_key_id;
 
-	len = sizeof(struct sctp_authkeyid);
 	if (put_user(len, optlen))
 		return -EFAULT;
 	if (copy_to_user(optval, &val, len))
@@ -6232,7 +6236,7 @@ static int sctp_getsockopt_peer_auth_chu
 	if (len < sizeof(struct sctp_authchunks))
 		return -EINVAL;
 
-	if (copy_from_user(&val, optval, sizeof(struct sctp_authchunks)))
+	if (copy_from_user(&val, optval, sizeof(val)))
 		return -EFAULT;
 
 	to = p->gauth_chunks;
@@ -6277,7 +6281,7 @@ static int sctp_getsockopt_local_auth_ch
 	if (len < sizeof(struct sctp_authchunks))
 		return -EINVAL;
 
-	if (copy_from_user(&val, optval, sizeof(struct sctp_authchunks)))
+	if (copy_from_user(&val, optval, sizeof(val)))
 		return -EFAULT;
 
 	to = p->gauth_chunks;
