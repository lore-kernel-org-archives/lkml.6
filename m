Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/qI9tKWKkFSE86a6iwZ8UcaJAnD0mKXnOyFEZCzI6tSd7qeyUzQQ+u8bdIBtPiGKHhNAqM
ARC-Seal: i=1; a=rsa-sha256; t=1523473403; cv=none;
        d=google.com; s=arc-20160816;
        b=qXaqlNOFG+Ych6OZ6Go54oKXlC8iErjLhY5NJAQh3V0ZiwCgLpKEOjJ9rC9vk3stv0
         hsqZB7lBeKAYNxMGtm/1Gg7aEfKJw59rWCRYtug8fRTdlAkthCk7ckkhe0P3kxs64WC/
         kPAYe8ca4ZVpDeCbdKb/cE4DpOR1wFwQiEoS06rlUiWvQiOSF4QKA4jZ5+g5q68p6Ure
         JGzsjq1mLzglW6jW/IW0LDqGTAnbKuvejfNJW73Ce4TKsfgq7kl+R0lFnPTgOHKTiZLX
         V00O6oG+NI29D4wNpUfHFDLlSFrxuzyqi3tVNcZvVr/CXOj0AxneU+jhf37sgH7/0dL0
         Wcsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QPOvpls5cnOjvzt/HdfCu9agdJ+yExXeq5LVRsnhqYE=;
        b=CcRguWBGCwLkalycqryNzyl5TyLjfzDdxwP+WT4u4tIklxZ3ra+WY/FD9Nt/D0gYhP
         Qpn4DEYGQTdMmNbQTCTrv+Td/GcH8EZtPcnRiVCKD4NKSL8EYXVhdJJPiLhUenoPbK84
         mi/0+qeko0P/OBmAqqu/9DfAW8jyZCEoS4aJMUYy0nd7LYlTGQHtYkcwwUT4OLvsaVwE
         KruYot1naJUE70dszXSty2djOEfKu9CQ7qgUbBWqmV83h100tloWxbm8HtNe29r3eKkW
         z4Fje6/77xH49MSP6K4mf6aN6iFXp1omGx3D5ZMza3PlEszPFRDV5qQK1Zi10ArbZX/B
         l7qg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tero Kristo <t-kristo@ti.com>,
	Aparna Balasubramanian <aparnab@ti.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 235/310] crypto: omap-sham - fix closing of hash with separate finalize call
Date: Wed, 11 Apr 2018 20:36:14 +0200
Message-Id: <20180411183632.611968069@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477648303283018?=
X-GMAIL-MSGID: =?utf-8?q?1597477648303283018?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tero Kristo <t-kristo@ti.com>


[ Upstream commit 898d86a565925f09de3d0b30cf3b47ec2e409680 ]

Currently there is an interesting corner case failure with omap-sham
driver, if the finalize call is done separately with no data, but
all previous data has already been processed. In this case, it is not
possible to close the hash with the hardware without providing any data,
so we get incorrect results. Fix this by adjusting the size of data
sent to the hardware crypto engine in case the non-final data size falls
on the block size boundary, by reducing the amount of data sent by one
full block. This makes it sure that we always have some data available
for the finalize call and we can close the hash properly.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Reported-by: Aparna Balasubramanian <aparnab@ti.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/omap-sham.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -750,7 +750,10 @@ static int omap_sham_align_sgs(struct sc
 	if (final)
 		new_len = DIV_ROUND_UP(new_len, bs) * bs;
 	else
-		new_len = new_len / bs * bs;
+		new_len = (new_len - 1) / bs * bs;
+
+	if (nbytes != new_len)
+		list_ok = false;
 
 	while (nbytes > 0 && sg_tmp) {
 		n++;
@@ -846,6 +849,8 @@ static int omap_sham_prepare_request(str
 			xmit_len = DIV_ROUND_UP(xmit_len, bs) * bs;
 		else
 			xmit_len = xmit_len / bs * bs;
+	} else if (!final) {
+		xmit_len -= bs;
 	}
 
 	hash_later = rctx->total - xmit_len;
@@ -1137,7 +1142,7 @@ retry:
 	ctx = ahash_request_ctx(req);
 
 	err = omap_sham_prepare_request(req, ctx->op == OP_UPDATE);
-	if (err)
+	if (err || !ctx->total)
 		goto err1;
 
 	dev_dbg(dd->dev, "handling new req, op: %lu, nbytes: %d\n",
