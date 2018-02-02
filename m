Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227xmIXgP3C1EIQ9o/hjqgT9XmHZL0UDQzpvH+gd6ETE/RwhKjqivSMyXj2iCqf3LTUfSj2K
ARC-Seal: i=1; a=rsa-sha256; t=1517590974; cv=none;
        d=google.com; s=arc-20160816;
        b=BaXDpdshqCNksBqocOLmFq2r/KSSfcs6hMb75h7Npn+5kslsU0qHL0QSodVn/70coQ
         lwbs28NXoa7eMGUG1di9PevlLZKnZXUdd8bj4iRR4UN3zEvVj1g74DK1gMcNJHiVZdwb
         MtpOflds914plWFo6K2qMTDvjIOmpa9S3U1Ckm4UFEwmtG7AES9lFqqaFLEfIg64cRX8
         H1hAkG0jOWcW2OlF783wGekZ+BwuZ89A2oDQOarbfpLPlJXdlx8jMZyJm+RdclNLxHYv
         8m4XSFZQOlrofHtHpJSnkh03uFrNCR6a9ZWi592RAYJICu9uxouJQyQbkpK8yzDgeb2k
         ssXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1Wina20onWvuN1btJkZGpIa/1VJlx/7o7o3pg+McnRI=;
        b=CnQDkMe4SY9ODSbwFR/z16pq15LzeciddF+QIKhfeuVZJqx7oGCx/zSQxqgWP/wwUL
         Gf9my4t7P79Hur/C0ihV7NrYTrta9jYWeQsTOklRrWIEHUwRfEddUD2PpRY+J0NCBW5R
         i+Yov0YqVrIiN7mnDNhuo4GCAcSd550W1zI7MP9BRimCXAAUapowILqjHieYoBBS8xi2
         Kjo/Q1ZHkIGJxTWZWjVmdHXd0Q1TpDKO6amCilrMDkj8C0zkelji+U2EnKuASMKeo5Cn
         yYcpkWwQ9s+3Gzm5NzqUecqsqoTvoZbx2h201ts1hOz40RQpe2Gt4PJj9eyuRHieIRYV
         7vJw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot <syzkaller@googlegroups.com>,
	Stephan Mueller <smueller@chronox.de>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.9 10/86] crypto: af_alg - whitelist mask and type
Date: Fri,  2 Feb 2018 17:57:30 +0100
Message-Id: <20180202140823.788833552@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309282150108123?=
X-GMAIL-MSGID: =?utf-8?q?1591309473298566168?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephan Mueller <smueller@chronox.de>

commit bb30b8848c85e18ca7e371d0a869e94b3e383bdf upstream.

The user space interface allows specifying the type and mask field used
to allocate the cipher. Only a subset of the possible flags are intended
for user space. Therefore, white-list the allowed flags.

In case the user space caller uses at least one non-allowed flag, EINVAL
is returned.

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Stephan Mueller <smueller@chronox.de>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/af_alg.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -149,7 +149,7 @@ EXPORT_SYMBOL_GPL(af_alg_release_parent)
 
 static int alg_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 {
-	const u32 forbidden = CRYPTO_ALG_INTERNAL;
+	const u32 allowed = CRYPTO_ALG_KERN_DRIVER_ONLY;
 	struct sock *sk = sock->sk;
 	struct alg_sock *ask = alg_sk(sk);
 	struct sockaddr_alg *sa = (void *)uaddr;
@@ -157,6 +157,10 @@ static int alg_bind(struct socket *sock,
 	void *private;
 	int err;
 
+	/* If caller uses non-allowed flag, return error. */
+	if ((sa->salg_feat & ~allowed) || (sa->salg_mask & ~allowed))
+		return -EINVAL;
+
 	if (sock->state == SS_CONNECTED)
 		return -EINVAL;
 
@@ -175,9 +179,7 @@ static int alg_bind(struct socket *sock,
 	if (IS_ERR(type))
 		return PTR_ERR(type);
 
-	private = type->bind(sa->salg_name,
-			     sa->salg_feat & ~forbidden,
-			     sa->salg_mask & ~forbidden);
+	private = type->bind(sa->salg_name, sa->salg_feat, sa->salg_mask);
 	if (IS_ERR(private)) {
 		module_put(type->owner);
 		return PTR_ERR(private);
