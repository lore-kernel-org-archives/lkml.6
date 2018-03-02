Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsWAI6mP1+PPwW6gA8oRM/qzeelzIPSgZIb6mM2ypi+x/oH3pfP/h8sritISsInJzwqNT/+
ARC-Seal: i=1; a=rsa-sha256; t=1519980950; cv=none;
        d=google.com; s=arc-20160816;
        b=pYebJhDxc75l1aDU8B0OFFObrFfI8zvRCoX3hgJCrx/Zjaour9+gOUzdzwzl+9pAmT
         W0tz3O6qarbjLH3DPQ1l/oWIwjTakfvkSHtpJg/yLhzNECH6fXKqatZikrnveNa6Brdc
         7QFB2s9TZxP2vLTUcM3A3RFeeIb3Wodo0EWUFghUrkAjpAm/tu/FlererIwGGcUf4S+V
         eI5FtMZmPPVkt/XXYe8+MBSETXqVA7WAwAMREIa7bDydoPWQ56eElF1wpjVVdLAPMtSP
         qeyJEtF/OKopi6WWc4dtLpYdvCZMIZI09EjDKPQGlGlhJ+crfWm7j/QOJACo+bFFa5eW
         FEUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3TZNfBglOvH2O8Z5MqDP18trgnZxVMG5ZoxcaFO0Iv0=;
        b=fnbenci8W4pnGAzxTV+l6rCnZtLyQaXYZ9NPVDB19DIKzGEQ3NcZsWfv9f7IFhWRY0
         trc6q+nrh/0yPnH/Lu8A1F34eFj813cH6Ck0tTq13K+9kYTuxtirQSrV3ZTmP5GINPY7
         qqeNJj8AoYijKVbggQctngcL4J2S28yMeV/R4rUCNpEs3RUnL0KiNlAMf8o85qXs4gRP
         W5h/Oy7Vk/AunCO2CsWagE/l/EwaPLYBe+p4SmK7ZOgG47HddkVxptAaJ7+CFMTHLArH
         CZrtXKWkEOaBy+8mlaQ3Dd1/mZQa2iMFXxTPCwDgpdvh2+h2DCS+6/RlEasVBYDS0wuk
         0dqQ==
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
Subject: [PATCH 4.4 32/34] sctp: make use of pre-calculated len
Date: Fri,  2 Mar 2018 09:51:28 +0100
Message-Id: <20180302084438.054235528@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084435.842679610@linuxfoundation.org>
References: <20180302084435.842679610@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815405591850190?=
X-GMAIL-MSGID: =?utf-8?q?1593815545590814557?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4445,7 +4445,7 @@ static int sctp_getsockopt_autoclose(str
 	len = sizeof(int);
 	if (put_user(len, optlen))
 		return -EFAULT;
-	if (copy_to_user(optval, &sctp_sk(sk)->autoclose, sizeof(int)))
+	if (copy_to_user(optval, &sctp_sk(sk)->autoclose, len))
 		return -EFAULT;
 	return 0;
 }
@@ -5022,6 +5022,9 @@ copy_getaddrs:
 		err = -EFAULT;
 		goto out;
 	}
+	/* XXX: We should have accounted for sizeof(struct sctp_getaddrs) too,
+	 * but we can't change it anymore.
+	 */
 	if (put_user(bytes_copied, optlen))
 		err = -EFAULT;
 out:
@@ -5458,7 +5461,7 @@ static int sctp_getsockopt_maxseg(struct
 		params.assoc_id = 0;
 	} else if (len >= sizeof(struct sctp_assoc_value)) {
 		len = sizeof(struct sctp_assoc_value);
-		if (copy_from_user(&params, optval, sizeof(params)))
+		if (copy_from_user(&params, optval, len))
 			return -EFAULT;
 	} else
 		return -EINVAL;
@@ -5627,7 +5630,9 @@ static int sctp_getsockopt_active_key(st
 
 	if (len < sizeof(struct sctp_authkeyid))
 		return -EINVAL;
-	if (copy_from_user(&val, optval, sizeof(struct sctp_authkeyid)))
+
+	len = sizeof(struct sctp_authkeyid);
+	if (copy_from_user(&val, optval, len))
 		return -EFAULT;
 
 	asoc = sctp_id2assoc(sk, val.scact_assoc_id);
@@ -5639,7 +5644,6 @@ static int sctp_getsockopt_active_key(st
 	else
 		val.scact_keynumber = ep->active_key_id;
 
-	len = sizeof(struct sctp_authkeyid);
 	if (put_user(len, optlen))
 		return -EFAULT;
 	if (copy_to_user(optval, &val, len))
@@ -5665,7 +5669,7 @@ static int sctp_getsockopt_peer_auth_chu
 	if (len < sizeof(struct sctp_authchunks))
 		return -EINVAL;
 
-	if (copy_from_user(&val, optval, sizeof(struct sctp_authchunks)))
+	if (copy_from_user(&val, optval, sizeof(val)))
 		return -EFAULT;
 
 	to = p->gauth_chunks;
@@ -5710,7 +5714,7 @@ static int sctp_getsockopt_local_auth_ch
 	if (len < sizeof(struct sctp_authchunks))
 		return -EINVAL;
 
-	if (copy_from_user(&val, optval, sizeof(struct sctp_authchunks)))
+	if (copy_from_user(&val, optval, sizeof(val)))
 		return -EFAULT;
 
 	to = p->gauth_chunks;
