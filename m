Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225HI2w8rMGE5aLqrR2iTWDnrx/t6eJqn1hYAAPy/mjQAE8TPWvAUHTNgT5srtEBSsa2P6tu
ARC-Seal: i=1; a=rsa-sha256; t=1517590791; cv=none;
        d=google.com; s=arc-20160816;
        b=kvWOvZ2RRqpisfXGCPsPMVVFrS4dJdIz6HpikcvUQ8kIg/a2rsGtcWP18d3KYoL68i
         1aNDNkjT0QPZmvampKtn5IctxxvitoHCdPu/3mAxUqrSVeHflwVv6A07uaw0BFSBosKb
         WfoRaGKvTs7Y1RNmAA/S68RN6//SemIjbASJ95ilG8WvemyA+7P98L6JIhZAKfl7A3S9
         MsIuYD1cUV8HgJesnyT/nVaAMos5a1SsYKh8kl6gw6aQulMTiS3db6enYqSeqrCIC1QT
         QSxY600bS6smdLlC3jgZyF3PFJsGvg+mm+R9EBUjzVjPb5TrZVWbC/Q/nfmEly/iui6W
         eTQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=O4vCgIjKcBRLeSlVWwbOTnKHA+v6SXzRYqUQ3DO9S0g=;
        b=NbX9IQNex3sCQo7MyQrL2+JnAWLldzaGLG9xY2V92qWU4vy90fccbfVqQxewuWG/iP
         fWyKg4NeiwSpod/oct7E68YEZHXZBkoei7Wpg7Hoc2qtCS2NXUkQYyg4wMrOqxHuohp9
         DxU3DXReeoioDe5Ec3yCshV0SJWoQCmcfKDUrtb8zttioBP/JYVV7qiStxO847sX7z0E
         uHxPXJ9oeBlvkeUn9irUos6ALwmKpvhcSN1VhnqUVTKm8xpNEcX0sT/ZNj7d3GDsHTln
         3t2oUQXmbWjzX5m1bKJMoIjUt6pmmUCt8Tlhl1bPEPTiyNMBC512VWx/O5dkebb4tCai
         u9hw==
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
Subject: [PATCH 4.4 15/67] crypto: af_alg - whitelist mask and type
Date: Fri,  2 Feb 2018 17:57:44 +0100
Message-Id: <20180202140816.984119391@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309282150108123?=
X-GMAIL-MSGID: =?utf-8?q?1591309282150108123?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
