Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqafOdiZA+iSQhoJVVFD0ebQcT6COPnexQdth2EqaacaR6OcAA+Pzf4CdRnsVY8A41Gu7yx
ARC-Seal: i=1; a=rsa-sha256; t=1527156302; cv=none;
        d=google.com; s=arc-20160816;
        b=UmvCnx/a6RoE/dkxQ+244RF34QZGGGzMhKQZQqyh4wtFL7F1dIfXdAIg5I58dbk95X
         65NC1/yvqjbhd/vBmJG2Xu0KvakoT/WGU3xeJmM4RmLAgjRiHbc3HB+AqpdAKxDceFNR
         TD9fwRoxkw3VSBUvv2XmPJurdNRLuf1AqMOnG30f5gKDtPLtOYn8bcCZJmdEnulw+SPQ
         Hzixvbl96HPo7BdWTWoJWBJf7LbN6in74XlN5vaEp7Y95usH6J/euS1SGSSBSy9iKuF6
         V/jwuxR9o2yF52EoelCUEppcoAZgH6gUkkUQSnZpUB6J78y9MoVTJTPA65mkj+HkbSWT
         2WkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Oj/vzqPygBKGjCk0fSus5JuUhUwpsA3x5l8JIbdXdgE=;
        b=Iu48uZK8ww4Y8og5fq5aS8waumB1garEmv5TIwDMw+0ASkPnzVi8zvyk2fyxA83BQ6
         qqrRnoZNx31EL7WOzhek97+uKjQIRwUmy/HbUBiBn1Nb7ww0CodupaMcodJFjbn286j9
         eH2/ZTyrOwcPu0+Q454n5Xg3l4ub/ALC/Kz+yaid2fkf05zZjrsHp7R/K8Pv5HUht806
         X3Z7shki4St45ZeODbafX76P5VVtmMgi8MoSEqdbS7mcl4vWpMfxgHK0hssmU6wmp5Lz
         kfR3PwCtk2njJYHRIMcHqDoNex+Wk7dPyp8iBM9A81HqX8OOoFWF2AxNbmPTwq1fyrwD
         8LpA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=TIvl71n7;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=TIvl71n7;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Antoine Tenart <antoine.tenart@bootlin.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 102/161] crypto: inside-secure - fix the cache_len computation
Date: Thu, 24 May 2018 11:38:47 +0200
Message-Id: <20180524093030.641944064@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338843355309259?=
X-GMAIL-MSGID: =?utf-8?q?1601339447577230612?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoine Tenart <antoine.tenart@bootlin.com>

[ Upstream commit 666a9c70b04fccabde5cea5e680ae1ae92460a62 ]

This patch fixes the cache length computation as cache_len could end up
being a negative value. The check between the queued size and the
block size is updated to reflect the caching mechanism which can cache
up to a full block size (included!).

Fixes: 809778e02cd4 ("crypto: inside-secure - fix hash when length is a multiple of a block")
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/inside-secure/safexcel_hash.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/crypto/inside-secure/safexcel_hash.c
+++ b/drivers/crypto/inside-secure/safexcel_hash.c
@@ -187,7 +187,7 @@ static int safexcel_ahash_send_req(struc
 	int i, queued, len, cache_len, extra, n_cdesc = 0, ret = 0;
 
 	queued = len = req->len - req->processed;
-	if (queued < crypto_ahash_blocksize(ahash))
+	if (queued <= crypto_ahash_blocksize(ahash))
 		cache_len = queued;
 	else
 		cache_len = queued - areq->nbytes;
