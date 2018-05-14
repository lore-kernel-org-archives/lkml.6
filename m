Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZovA7SPO1jqoR7eLxDqnNvvu8Mj1KqAkxwzYdfoZZNFQGYDrmF39ZHA1uOOTUiJW4RvY/+7
ARC-Seal: i=1; a=rsa-sha256; t=1526281148; cv=none;
        d=google.com; s=arc-20160816;
        b=MX1IfvqB4Zbvww5oSZTqi6bP3RcTNQEUuICKQ31xReACeGd23euDdmPRq13h2KjwlF
         HV/PM+w+Q7RxtfZeuid9kERM7CbatBakTWTOmxr3BJLPRQXSQzOmddY5FJgttUErbdjU
         WuF2hOcJi80u2J6AEn7Eg+lngoQeXOq5iVO1XvI7ekRVPjmXZEUBNAvRlQgWh9QB+JP8
         QZsiCK1ZBQgtkDBCMeF6d2H93VyfckRfMRUbIkVzSLjkTe0K3vwfQLqKPnweiXpLG/Hc
         JkhUQZ8CJV0Dqd1Ga3NVTktS3DV5eF3S5Mph2b6TlPz8FXJwW1nUux9mOxbRvvhlcbA3
         maQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=zd0nVnluajNAUmILgJAK/I9AGpQQnJFR522z68tFG3o=;
        b=V38cT48n9yeCHmdfiXA8CJtZza+tLHFzuKqIk3p5fSSV1LG4EXIVNntCIz2CifqOF4
         ovclweL2ZiyE+gmxRcl0nD4bqLZrT7SnOA3bKzCHg/KKz5hT8rG3AcP9ozG0dBJ6kW5N
         rjmB6AwcxJFcAvHamVD1OypaNkT+vMrWzJn9Ej9p20cjZjYjs5a5oaoj4A/ONC2lJsww
         58Y50HbDKYru+sSJKejlLtwaHaFskuupJViTfU/yJEHPzrRREfoKD570myU6PkITeISY
         OJREBqapdW3TIPqhuCz8xrxwl39ABGrtCqVw7PRTPcY7eTOvqHa6hKtKhnROlYkurb/a
         N7ZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=q0bd96Ha;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=q0bd96Ha;
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
Subject: [PATCH 4.16 06/72] crypto: af_alg - fix possible uninit-value in alg_bind()
Date: Mon, 14 May 2018 08:48:23 +0200
Message-Id: <20180514064823.314950811@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421404075424649?=
X-GMAIL-MSGID: =?utf-8?q?1600421781243095311?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
 
