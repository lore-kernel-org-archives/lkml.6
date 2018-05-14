Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo1awIrn3XuNeSZ6S/qs+jZR20Gg9j5esnuXI4MXFiW2qCfyiaLSW8+FEtfQvk3pkJ1VE3U
ARC-Seal: i=1; a=rsa-sha256; t=1526280960; cv=none;
        d=google.com; s=arc-20160816;
        b=kd0oCjJDqFQFAnwwmIy1fxa/hrYBNvK9cGJQ7cVtIg58OtOSZiO3BYLCUcs/gBB7pD
         +/XMWCUFyCM5qTRUJcqWqkiZJ89BILcV+Mo3I/GmgTiGYjmO7Cgw04GH4urQVE70agei
         qeCZxcL93ChAvuNPtjiW/eDwbXdLpn5JCq+VjJ6c5Di+RMEI/8Qn6/qJ3LQGtjgj+hp6
         fgDfj1eO2gHXbn86OoBeKttxwADtNnJtbBiYCZMkjOFK7Y97nz2JKEX5TdYla3ojqntB
         ZwbNHUqimHuQoed/qwKucpqnB6h5o9VfLz5LMolk/lycG/jkSilR2bzx/xnXplSyJ2Z5
         E3fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=K5uI7pfmIry/j0YIX7pQZ4FKNV9pPJwPYcISBq8WOm4=;
        b=VBy34w/EIK/e/jauJVOtVQw1fOWzCocvPkU1dg7YXSELNouRjyurmByrMYCGovYXoZ
         KkQioG85PX6pqyYm6BLjt+xgWJ35cCX/S2yCCGStPrfP0/MqzYJQSkRFN0Ynb4AKIVSM
         TkJQuSTbB7I6vbSaXj6784tFBCZTKzuDbYEoUMRQTNeiS1HGoCJ89SJwOTYVM7rZ+NdK
         gprAXMlna/lpV/PUlcp2ku01IgBHBoZ5rqSy/8Btn0Mx09e4K+SMPxQ9y6iIjaRP93p9
         S62ZZg9GBcNKztj5yQnY+0be42iplaed03ugV18z/nAPv2067rACim5zo5wL5m2K6vWc
         6CRQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=pumHYSnN;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=pumHYSnN;
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
Subject: [PATCH 4.14 04/62] crypto: af_alg - fix possible uninit-value in alg_bind()
Date: Mon, 14 May 2018 08:48:20 +0200
Message-Id: <20180514064816.694010271@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421404075424649?=
X-GMAIL-MSGID: =?utf-8?q?1600421584105980968?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -158,16 +158,16 @@ static int alg_bind(struct socket *sock,
 	void *private;
 	int err;
 
-	/* If caller uses non-allowed flag, return error. */
-	if ((sa->salg_feat & ~allowed) || (sa->salg_mask & ~allowed))
-		return -EINVAL;
-
 	if (sock->state == SS_CONNECTED)
 		return -EINVAL;
 
 	if (addr_len < sizeof(*sa))
 		return -EINVAL;
 
+	/* If caller uses non-allowed flag, return error. */
+	if ((sa->salg_feat & ~allowed) || (sa->salg_mask & ~allowed))
+		return -EINVAL;
+
 	sa->salg_type[sizeof(sa->salg_type) - 1] = 0;
 	sa->salg_name[sizeof(sa->salg_name) + addr_len - sizeof(*sa) - 1] = 0;
 
