Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226BMkmCbq3RtsjrElDo0+QWxLMeXJwKK/h6ZHH+CYuJ352vmzRBSSIQKwWQVWBU7oEeDgCu
ARC-Seal: i=1; a=rsa-sha256; t=1519217975; cv=none;
        d=google.com; s=arc-20160816;
        b=SM9nRLEciH1Q0Xq9KDPxTkMpaa9XZU4egxDA/YEFFIRi2l7/2y7z1Y5yMbObj6l0sK
         Ju4PrQ8Z57NwQtR50f1VTDMQNOAVuq3ARn2g49zYdeZwdh4eXy9eNFDhnS0I2uKQHS7N
         3QMEllCCfzopQZcHvEalmuiDpJ93JlJ3ngzEeLW03XegDJdxVcvS+6kuBiqEm+2JGQYo
         bjtU9tAI6A1ybXbkluRC069vECVpUjWB1LHzAoyqqDS95Qkk6Jh6eehSO+smt2zb8anM
         +WUjIUC3ieKUkjDkKaz/TIavfo5npim6Q8Dl9Kn7e9Rw8lpJIQxYaU/DvFVffI+8bveo
         ijqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/x/AGJCJ91/sjv3+MA2WyAvrRx9JvhV6UwGPF1ORQ3k=;
        b=bQVAIvcAGHVVpAJtnv/eD7tMl3QHsSQirvnGIDy3X6DRcB5mUSKMviw+pvnrrhxEbJ
         XKh3IATzluVeX3U9qeVJ5mmSS9BV+b3yCQ/T9OQBqsiB2/JSX1cy7cMb2skT/IKUurGJ
         X3wEKot7dcaT8F1vNDh9725uccisHDE+3t6ClQvnIjL+G52gxadIXCO4ocaXBCHbZNvK
         8niXnQ5su5aYTbJwQDjleiVR9JLsVvTHTXkG7Nhw0Q4rEucSGI8w3v/iJWtBlyXsqCfF
         CeROFGDuv2a2BBpZx9wmncJyAY0CFLJHcTTu+BAcC9+Td+PtN+yNnGhs+9Hpo+qN8w4p
         82mg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Artem Savkov <artem.savkov@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 045/167] crypto: sun4i_ss_prng - convert lock to _bh in sun4i_ss_prng_generate
Date: Wed, 21 Feb 2018 13:47:36 +0100
Message-Id: <20180221124527.039187962@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015507939746969?=
X-GMAIL-MSGID: =?utf-8?q?1593015507939746969?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Artem Savkov <artem.savkov@gmail.com>

commit 2e7d1d61ea6c0f1c4da5eb82cafac750d55637a7 upstream.

Lockdep detects a possible deadlock in sun4i_ss_prng_generate() and
throws an "inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage" warning.
Disabling softirqs to fix this.

Fixes: b8ae5c7387ad ("crypto: sun4i-ss - support the Security System PRNG")
Signed-off-by: Artem Savkov <artem.savkov@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/sunxi-ss/sun4i-ss-prng.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/crypto/sunxi-ss/sun4i-ss-prng.c
+++ b/drivers/crypto/sunxi-ss/sun4i-ss-prng.c
@@ -28,7 +28,7 @@ int sun4i_ss_prng_generate(struct crypto
 	algt = container_of(alg, struct sun4i_ss_alg_template, alg.rng);
 	ss = algt->ss;
 
-	spin_lock(&ss->slock);
+	spin_lock_bh(&ss->slock);
 
 	writel(mode, ss->base + SS_CTL);
 
@@ -51,6 +51,6 @@ int sun4i_ss_prng_generate(struct crypto
 	}
 
 	writel(0, ss->base + SS_CTL);
-	spin_unlock(&ss->slock);
+	spin_unlock_bh(&ss->slock);
 	return 0;
 }
