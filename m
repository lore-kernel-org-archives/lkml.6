Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoH98sVhPXnnuX3dDdzSkosa9tV2r+7clONawzl6IjIuSGb/jb6FkL0hS13bgRS3woUgEsY
ARC-Seal: i=1; a=rsa-sha256; t=1527156308; cv=none;
        d=google.com; s=arc-20160816;
        b=q24SDIJQuD0UNu1Xh+S9iuXfk+qTjNc5aqjHuTrrCeHamGxPOUwTjnWCGTTSKyzOGC
         mTLF9Sn5Sn+melyvW3wnNd54eCLZqRuEuOlPNDhTRPSaPjPWSHNAwAArhLzFD7oFbw2D
         HqIOkJHt3rPuxhnsOG9MzKA7Jg7RDXkRovH3tF36w2OfPm8USMqHSbw2vV/nJgf9cega
         XzooIizsCKGgNVl+8pKxeOGDW1XrFiI3KECGNjXmS98rPKiJrhphe5gwMYvECdk17I3n
         7C9tqg1XyCdnCZMUFLrDgrNj4Mz0iPPkBqwoIfxJAPQ6hvj+2Br7INwIRVuu8FcH549L
         rrrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=cA0IPStflY6mubUBCgFsyhHxtVner11SAW0ZAjGbPqw=;
        b=vLGFEsk+r5naevnoaZJArxBSlr5AYIDMiEwQAoeske6Lxb/udOSWVHb18Cy6669HYx
         OMMx6zPH+qFRCMKS7vZEBKrKr/TGUDh8pb8Zk0xTM//KItVEjPwcRrgu3mM2s4OSY5vw
         ro4tAj7kknfIMxMWtb4IYO9aoDHobG0a6yxY2CDyz2FwNgw9C4QB24Pm3YXnQQDFOlcD
         4oQRRpqedxpLMyZ99aOZP03vPW4cKMbOu7+5TFmLLYm66PLKwoz6Cg69P4uXl50FLrbL
         pHHbkXqNhGPmXjOyakBfR4HJQEbajCgO82AbErAE4RtL+YL7tqNp00Bx5ZePr6kSjCru
         SRgw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Xh0wUiYa;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Xh0wUiYa;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ofer Heifetz <oferh@marvell.com>,
	Antoine Tenart <antoine.tenart@bootlin.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 104/161] crypto: inside-secure - do not overwrite the threshold value
Date: Thu, 24 May 2018 11:38:49 +0200
Message-Id: <20180524093030.885344589@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601339452878698343?=
X-GMAIL-MSGID: =?utf-8?q?1601339452878698343?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoine Tenart <antoine.tenart@bootlin.com>

[ Upstream commit e1d24c0bb76648cdf789b168defb6e31adb0b1b1 ]

This patch fixes the Inside Secure SafeXcel driver not to overwrite the
interrupt threshold value. In certain cases the value of this register,
which controls when to fire an interrupt, was overwritten. This lead to
packet not being processed or acked as the driver never was aware of
their completion.

This patch fixes this behaviour by not setting the threshold when
requests are being processed by the engine.

Fixes: dc7e28a3286e ("crypto: inside-secure - dequeue all requests at once")
Suggested-by: Ofer Heifetz <oferh@marvell.com>
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/inside-secure/safexcel.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -523,8 +523,7 @@ finalize:
 
 	if (!priv->ring[ring].busy) {
 		nreq -= safexcel_try_push_requests(priv, ring, nreq);
-		if (nreq)
-			priv->ring[ring].busy = true;
+		priv->ring[ring].busy = true;
 	}
 
 	priv->ring[ring].requests_left += nreq;
