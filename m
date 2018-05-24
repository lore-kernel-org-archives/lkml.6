Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZodASkbMd2uYgf46mmeshfTA8pYlUQoG9e7CAO1cgdpJWgBUHdXSRiLMrEtuJJrDBEi8JCa
ARC-Seal: i=1; a=rsa-sha256; t=1527156215; cv=none;
        d=google.com; s=arc-20160816;
        b=LAcuJlnGIfUqueUbmYzDmsXUbsiCciY5Wa8WnSL0BYABDd39CXceEHdfa0ecfJnFl/
         hckhdE6rWAPW1h6WAqvTMhT6OIyhqf4RvOtQWIy5fgJYqf5RQzWzC1rh1NRWvkURYVhe
         2j6v40vW/HcDJ83wHxsCs3egD0nuy6S3bnkywfB+yUqkdlyWgPtmpAqammyOxAf37jgz
         GK1uM+EMUhmbl8KblwR0keUPyOR8Ssla+18mSmy7Z+df2hhSMsGSCjvMesixdijWefDM
         ZsLKfbb6b5Fu5s0eMXRxej5+PD/9dgn92G1x/WLywCFlIf5Otz+deLsgUBOuOttcvA6W
         VtlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=LGFpVT2dXtvWt4R8FXz7mC4nnENvPXT/lS8Lpszo6qo=;
        b=ch6oA95Acqq4haYPJT0SH0U69VxeWslVlUxTSZZgrjU9U/W2SWjjlCZMiQgPXqkuPd
         kg02G37rrf6jw3gSlbE8lx7TWhlIDI1wGzl47E4YER0wMqWVi14hCW6LHLqASVkWJD7o
         fNrMe8WtKvkIq7Y52wcMJ2gGEdz66MOUbACPrW9wsmsaJATpV30l8VsCvRQ24slQg4Vx
         TbpyMkifBIF2doB+fiaVnBLB4daUsDtYDDo6E86/df7QLl+jV66SDcqBJ4potrpt+kI0
         FE7XLgABcQfQW8JYOmE8jzTzC+RzMMMBipNhnawr41F1qdEiBmTuG6g5z3LvaiLEWI3S
         nRXA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Q5Oln3H2;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Q5Oln3H2;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Antoine Tenart <antoine.tenart@bootlin.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 106/161] crypto: inside-secure - fix the invalidation step during cra_exit
Date: Thu, 24 May 2018 11:38:51 +0200
Message-Id: <20180524093031.098530213@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338854833570204?=
X-GMAIL-MSGID: =?utf-8?q?1601339355657469969?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoine Tenart <antoine.tenart@bootlin.com>

[ Upstream commit b7007dbccd92f7b8c00e590020bee542a48c6a2c ]

When exiting a transformation, the cra_exit() helper is called in each
driver providing one. The Inside Secure SafeXcel driver has one, which
is responsible of freeing some areas and of sending one invalidation
request to the crypto engine, to invalidate the context that was used
during the transformation.

We could see in some setups (when lots of transformations were being
used with a short lifetime, and hence lots of cra_exit() calls) NULL
pointer dereferences and other weird issues. All these issues were
coming from accessing the tfm context.

The issue is the invalidation request completion is checked using a
wait_for_completion_interruptible() call in both the cipher and hash
cra_exit() helpers. In some cases this was interrupted while the
invalidation request wasn't processed yet. And then cra_exit() returned,
and its caller was freeing the tfm instance. Only then the request was
being handled by the SafeXcel driver, which lead to the said issues.

This patch fixes this by using wait_for_completion() calls in these
specific cases.

Fixes: 1b44c5a60c13 ("crypto: inside-secure - add SafeXcel EIP197 crypto engine driver")
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/inside-secure/safexcel_cipher.c |    2 +-
 drivers/crypto/inside-secure/safexcel_hash.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/crypto/inside-secure/safexcel_cipher.c
+++ b/drivers/crypto/inside-secure/safexcel_cipher.c
@@ -456,7 +456,7 @@ static int safexcel_cipher_exit_inv(stru
 	queue_work(priv->ring[ring].workqueue,
 		   &priv->ring[ring].work_data.work);
 
-	wait_for_completion_interruptible(&result.completion);
+	wait_for_completion(&result.completion);
 
 	if (result.error) {
 		dev_warn(priv->dev,
--- a/drivers/crypto/inside-secure/safexcel_hash.c
+++ b/drivers/crypto/inside-secure/safexcel_hash.c
@@ -496,7 +496,7 @@ static int safexcel_ahash_exit_inv(struc
 	queue_work(priv->ring[ring].workqueue,
 		   &priv->ring[ring].work_data.work);
 
-	wait_for_completion_interruptible(&result.completion);
+	wait_for_completion(&result.completion);
 
 	if (result.error) {
 		dev_warn(priv->dev, "hash: completion error (%d)\n",
