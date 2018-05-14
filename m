Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqCe2U5KWyCMAMat9ZKOKdYWlkKL41wKTDdSrD+uBXUkcqgW6QR38/kPee1/VhgIOqkuXMu
ARC-Seal: i=1; a=rsa-sha256; t=1526280788; cv=none;
        d=google.com; s=arc-20160816;
        b=xtMWb8jkPgh3bIO6pX2ELUY30jg7ljWHD2Z2qjlrrHVMDgR2U1P24hu/KcN28qtB5P
         QMTDDr6LhVSt3jIMdBda3/J863JlIwXxaUKIBvdmt98Q4DizjwHVeCfQNuXn/Yi/wyOc
         UDTJvdJzbuH329Ti/oOfg7Cabfahe/ceFvoUeMHyARSsIWBwHylVbSktAhKncAniUqHU
         XYwfRUU3cZ88voMj9Fj3UwY5cysmM8yCrxctg2klhS59s2fFMghZzPJmdKzK5NAYK/HH
         Vz+jSepxOP7w+vJIMXgVtN2CD3XeDYivreNzFyVLI9zSlGcUOh00ZP7N7gQNiQistyKg
         eW0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=sa5qeEenmySElejHQ0FnLwiUDahcfiIBSGluFwBB2ls=;
        b=UeupPtIXMwrReZSIe/LYmgQ7TFHRhyFNOJQMF18XWX4Km9DBsIkxX3VnS+aA+5/uHN
         LZl7QuD7vAArePoms1RrNKAAUfOXMOdNhiEVgQaRW8EZpIrP6zjZaAXlTBINPerI6HFv
         Sr4c06Bd4qyPH/RmzjfhH/LMAfbnhs2PLe372jlG0Y4BqCmRO5mWDQ2fuUHzZiAQtjQl
         zBggBJH8a6ycGR479nMYusW1B0RQZZC30X8ePfNZfAHcIgC3AS8IJjjXU+88BSG3lP/a
         hg2CZ+lVxw3S2wbQT0rNNYTcCkGlBQjHwGsL3/9YovtGWCmA3FLWdm+g4IbtIrShc6Uf
         XYkw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=sB/sSlPf;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=sB/sSlPf;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	Stephan Mueller <smueller@chronox.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 32/56] crypto: af_alg - fix possible uninit-value in alg_bind()
Date: Mon, 14 May 2018 08:48:37 +0200
Message-Id: <20180514064757.938462632@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421404075424649?=
X-GMAIL-MSGID: =?utf-8?q?1600421404075424649?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit a466856e0b7ab269cdf9461886d007e88ff575b0 upstream.

syzbot reported :

BUG: KMSAN: uninit-value in alg_bind+0xe3/0xd90 crypto/af_alg.c:162

We need to check addr_len before dereferencing sa (or uaddr)

Fixes: bb30b8848c85 ("crypto: af_alg - whitelist mask and type")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Stephan Mueller <smueller@chronox.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/af_alg.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -157,16 +157,16 @@ static int alg_bind(struct socket *sock,
 	void *private;
 	int err;
 
-	/* If caller uses non-allowed flag, return error. */
-	if ((sa->salg_feat & ~allowed) || (sa->salg_mask & ~allowed))
-		return -EINVAL;
-
 	if (sock->state == SS_CONNECTED)
 		return -EINVAL;
 
 	if (addr_len != sizeof(*sa))
 		return -EINVAL;
 
+	/* If caller uses non-allowed flag, return error. */
+	if ((sa->salg_feat & ~allowed) || (sa->salg_mask & ~allowed))
+		return -EINVAL;
+
 	sa->salg_type[sizeof(sa->salg_type) - 1] = 0;
 	sa->salg_name[sizeof(sa->salg_name) - 1] = 0;
 
