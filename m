Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1414047-1519989496-2-1738436827171769233
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519989495; b=Vpb5IOIl1QtukezDxKxx/K090YJFm+pnkR3Lq0yMyMKZ9Y1
    iz5qbm7RVZZpv11fZGcmZS2psXqZ+/5FDFbUVrgJtqZJyvfAyKnuHfd5PwW5PljC
    kd2giPflAH3Qm4rJVQm5IPap7SsuPBBA7bAz4bXnSMrDRxXuQtJ4nYtOpxtigjjB
    0n973vRIjf4dhd6cI4fg480gmiaA56nilDAy1Cb20b2anT5G9n/4XXKVaYOLXN8y
    ZRBHZztieVIsdAaG1jf+XJ/aElJnxmM3tf96QPZaxz7gzRmSxlm14tXVtCJxhkjW
    1n57UnzKRObmL8WYArvdvU3Ph8cHMZfJn+4ISEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519989495; bh=CS4CuE3oFG+eEEvWUuT42NULjs
    woehUzPu4GtN6M8W8=; b=I6cSaCONSxi4jvUFa7mb/4E9PBFg1MnZewRv0NDiTw
    KFmX1OCQqtJvMAQZWpn0nI8zNT6a3czCxZBR0EW8gzhL0forPWE0Zov0h/C5pew/
    6cGTE+PMNzn5UxUDToJ1BUEUsYLAEB2Wpykxba32DNmV/rNRQM9oLrOFb5ux6yiK
    KwFejbK+sZnW6YuaVsuJZcZevX7SFyUs9AzuEYkseYzX9d6wjC/71sbNgICBs6pr
    kYVG2ECvciN8Y4KmWVTRtNDMiVtMa250X/LPWhdmAO7EyLLhaSFiiUYwVP8CwHWV
    7Pr3CR+PUNtDtS9dx+wZkGqV3ytGvR5nJVhfzYI3vyrg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423411AbeCBLR5 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 06:17:57 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50120 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423335AbeCBIxg (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 03:53:36 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 23/24] sctp: make use of pre-calculated len
Date: Fri,  2 Mar 2018 09:51:20 +0100
Message-Id: <20180302084240.266696799@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084239.157503766@linuxfoundation.org>
References: <20180302084239.157503766@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4458,7 +4458,7 @@ static int sctp_getsockopt_autoclose(str
 	len = sizeof(int);
 	if (put_user(len, optlen))
 		return -EFAULT;
-	if (copy_to_user(optval, &sctp_sk(sk)->autoclose, sizeof(int)))
+	if (copy_to_user(optval, &sctp_sk(sk)->autoclose, len))
 		return -EFAULT;
 	return 0;
 }
@@ -5035,6 +5035,9 @@ copy_getaddrs:
 		err = -EFAULT;
 		goto out;
 	}
+	/* XXX: We should have accounted for sizeof(struct sctp_getaddrs) too,
+	 * but we can't change it anymore.
+	 */
 	if (put_user(bytes_copied, optlen))
 		err = -EFAULT;
 out:
@@ -5471,7 +5474,7 @@ static int sctp_getsockopt_maxseg(struct
 		params.assoc_id = 0;
 	} else if (len >= sizeof(struct sctp_assoc_value)) {
 		len = sizeof(struct sctp_assoc_value);
-		if (copy_from_user(&params, optval, sizeof(params)))
+		if (copy_from_user(&params, optval, len))
 			return -EFAULT;
 	} else
 		return -EINVAL;
@@ -5635,7 +5638,9 @@ static int sctp_getsockopt_active_key(st
 
 	if (len < sizeof(struct sctp_authkeyid))
 		return -EINVAL;
-	if (copy_from_user(&val, optval, sizeof(struct sctp_authkeyid)))
+
+	len = sizeof(struct sctp_authkeyid);
+	if (copy_from_user(&val, optval, len))
 		return -EFAULT;
 
 	asoc = sctp_id2assoc(sk, val.scact_assoc_id);
@@ -5647,7 +5652,6 @@ static int sctp_getsockopt_active_key(st
 	else
 		val.scact_keynumber = ep->active_key_id;
 
-	len = sizeof(struct sctp_authkeyid);
 	if (put_user(len, optlen))
 		return -EFAULT;
 	if (copy_to_user(optval, &val, len))
@@ -5673,7 +5677,7 @@ static int sctp_getsockopt_peer_auth_chu
 	if (len < sizeof(struct sctp_authchunks))
 		return -EINVAL;
 
-	if (copy_from_user(&val, optval, sizeof(struct sctp_authchunks)))
+	if (copy_from_user(&val, optval, sizeof(val)))
 		return -EFAULT;
 
 	to = p->gauth_chunks;
@@ -5718,7 +5722,7 @@ static int sctp_getsockopt_local_auth_ch
 	if (len < sizeof(struct sctp_authchunks))
 		return -EINVAL;
 
-	if (copy_from_user(&val, optval, sizeof(struct sctp_authchunks)))
+	if (copy_from_user(&val, optval, sizeof(val)))
 		return -EFAULT;
 
 	to = p->gauth_chunks;
