Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224yjLzcAAxo+LTtrREDjNtbVsaHUXCTc2/uZoBTVhzbpui41Sw3WPqH2x2JoSjTIyxcOBG5
ARC-Seal: i=1; a=rsa-sha256; t=1519218455; cv=none;
        d=google.com; s=arc-20160816;
        b=In1UH21BLs/3L9csviGhx39RHBw5zLEnUjKR3+a09TmyPcEjwZTkppix2Elpzj/lOU
         BeNSXQiChQybgNdYLdPP6B4SJja5PgPr/hr75tveXXtx/2xizymd6dwBu6QANqZze/Eq
         3JI8JoTgwApWGH4ZFlktdU/O8T67y5Dgbv8uog6k8Glmluv2zetMdy+rzWGrwLXe/oso
         DMHgVkB+gaTPAv4QZaYZvtjSUp1JrzRpRSaAQUHWnl3rdsjFa0f3k3bbF1E21W1uq1aJ
         926Atve0DxQbciy4FCrro+plC67RkdQVzznM7m0Ep1jCm3CnZ0OQ5UpdDOl90Z4d9eal
         gmSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zTT57gAReJU3Tho7ytFz2xLMMiPbhHc4x4XGM4Vpupc=;
        b=aUgcdIM9VsszoMGtmqw1l75W/Gr0cXavVsxCXZTizW82aI0Lpr1u3/wdcz1fkxZgCt
         Z2IPWT8nMeL/wiajmu5JXbWcERKeu624UHAtPvYyfFuhNcxNZVsZzVxbH3/lTMa6aG9b
         yLYB2bI/wtkfSl9dUptfwm8o+4YvCBEuyMTUE4v+O8EMnSk3hQOhU+3mA51dWVhWpTQ0
         K0/VYbdoZqDxquhyrCYpZwIgxkSHW/O3QkbvVFvetfw3mU/G74S0P7lpoXY+Rw+YkCc5
         EWKoX7ROvA3boOsxe7b97POPSjBjGu7m5/geUOflX6qdc97xrf40sf2Qbnk/gQ0h02fZ
         kvlw==
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
Subject: [PATCH 4.15 045/163] crypto: sun4i_ss_prng - convert lock to _bh in sun4i_ss_prng_generate
Date: Wed, 21 Feb 2018 13:47:54 +0100
Message-Id: <20180221124532.874587428@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015507939746969?=
X-GMAIL-MSGID: =?utf-8?q?1593016011333554892?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
