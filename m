Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZodhaB5gbZiLLx5Z7vT1Tp1Pf3qS3eB6AzlBpCQavt3k9xc6EOdWNiAh2N0ubaZx3/gdsrR
ARC-Seal: i=1; a=rsa-sha256; t=1526280822; cv=none;
        d=google.com; s=arc-20160816;
        b=fhviyzi7Z+32NlI5bZm5sOil1z3bj6h68/5N5sVBoMp1pACyJs6nDssKLplBEPm0mE
         IWjT5LN600wqi48NKiYJnZxTp3ia9CNcAlH9EtatAC3kXClSLbAcvNnghp0SAQ5gGlt3
         p3eK4pp/B9tqiWtCkaGBfL2U13n/1cy/wVLReZs50omznZavkPg2/Tms+zQRKIbOOS2A
         shEdmO6JGHFd1nh+HzNGVEkpOKdgE0hon6mCK/dfGx+3OVo+dn/fjgsmgCnFD3G92ZVN
         p/K2l+wwOPYjvLa4wrr+jF+okZuFlxfVIoINJTZxf8yh26YufXOa5LVuTfipOGqBG1dz
         YGyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ae9IQqcgKlcSwYptJU32XZ8/Xkzea+ZK1azfsOVF/Hk=;
        b=mP8+dELpgfnipDiqTpYXRw0fx6ndaR37/Nham1d6bEifIzSjE7aC8Qnzp5Iq56I/eo
         mYq5ml/IFN4rzHEuizbei297IaJgcLqyy53qkBVxNyxrSLAlPXCe7qtJ7a8Dbeq2no70
         RAwn5pOLOZrlm4v4/QDD/SBUsYpzP8a2wb3dP8ZCcz9U+PjNV4vfCSuKQVQcKzChx/t9
         PvHHI/u8BLUj/72AtVk32QKLPZEOiYUYN5SjzNSHA7gUipODOMQacXLhUki7n1UzzSjC
         ZgrQj3UECa2XthjUmbtU+Bna5Rn3BMdF9QcicyO4n3nywPbskg+Vqa60pxXFyE1kkt3j
         aSIg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=m6WtJShe;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=m6WtJShe;
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
Subject: [PATCH 4.9 04/36] crypto: af_alg - fix possible uninit-value in alg_bind()
Date: Mon, 14 May 2018 08:48:38 +0200
Message-Id: <20180514064804.606574246@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064804.252823817@linuxfoundation.org>
References: <20180514064804.252823817@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421404075424649?=
X-GMAIL-MSGID: =?utf-8?q?1600421439659278265?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 
