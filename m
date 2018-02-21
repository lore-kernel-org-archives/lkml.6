Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227OAafk3wuMKYbtwRBSGRE9ZMtlRX1zgDV6+lTFxdEugfP6i+a0FcxrdxbVqWjiZOXVcdIQ
ARC-Seal: i=1; a=rsa-sha256; t=1519217681; cv=none;
        d=google.com; s=arc-20160816;
        b=wJ4aq1rWDn1BjmTxx7HsPxgQuBgWroJJtWL3y63bbtz7EW0FvfOs0qSNoFGaQ/mL3I
         AcKMaFwb2yOBoTpVloi6RJYMEhaY32oAwxbUttYno0NduPn7AKh2/9Jdljgv1fA1A7fI
         tqQGwZHYfciTRD2y5GnKMlcsz1moTQ6lujDsYb6GK+F44r1h90ryJskDPsGvS8X9xFQV
         pyFoXATAM9iloOtmIOTRxqJJxrsGowIN3mlFZu5ZUy6tD76UG69nHxuUqYhyJWf3fZJr
         OZcYVFY2Z8O6xt1OHGyNVbi6aZcq4AmCqBvOGseVfdKP127um+2QQZfMNcByhdQasu77
         Gb/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=OHv0djUL33R2Vj9DcSrVOLmdt/QgOn1U1tOPZyUp4zw=;
        b=MB5XrxaucKMYkJhToBxjKAJht0bxkrkM8lUUjsTpvYIdvw881xEiJhXipRvuNuf+JN
         Xr098Zap0yduxLhM8pPYRR7Sx7k6fcxdgacnVxg3lbvm6mIj4TrGnxvWXD9iS4UW29vQ
         BtMHDZY40Gk7azUJxjIJcboA3mMEsZQpNN61VzcUGWlF7uPNmBcJoPIeqRxuSWVEZr3X
         l83A6NUCFJjrbxpzEcLbF9yct6LyDQl5Y9NG8RnFFqzOD9yf4UkKSnfFg7OcYZ1MMl9O
         pvErx6r27ZtDyFNtW6mBHspCIRCXRUfTNM5M78kNEjdcfVLsXTlec6v/dE6QV6Jq5Qu2
         Z6fA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Markus Elfring <elfring@users.sourceforge.net>,
	David Disseldorp <ddiss@suse.de>,
	Nicholas Bellinger <nab@linux-iscsi.org>
Subject: [PATCH 4.9 17/77] target/iscsi: avoid NULL dereference in CHAP auth error path
Date: Wed, 21 Feb 2018 13:48:26 +0100
Message-Id: <20180221124432.904654100@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015199328743705?=
X-GMAIL-MSGID: =?utf-8?q?1593015199328743705?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Disseldorp <ddiss@suse.de>

commit ce512d79d0466a604793addb6b769d12ee326822 upstream.

If chap_server_compute_md5() fails early, e.g. via CHAP_N mismatch, then
crypto_free_shash() is called with a NULL pointer which gets
dereferenced in crypto_shash_tfm().

Fixes: 69110e3cedbb ("iscsi-target: Use shash and ahash")
Suggested-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: David Disseldorp <ddiss@suse.de>
Cc: stable@vger.kernel.org # 4.6+
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/target/iscsi/iscsi_target_auth.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/target/iscsi/iscsi_target_auth.c
+++ b/drivers/target/iscsi/iscsi_target_auth.c
@@ -413,7 +413,8 @@ static int chap_server_compute_md5(
 	auth_ret = 0;
 out:
 	kzfree(desc);
-	crypto_free_shash(tfm);
+	if (tfm)
+		crypto_free_shash(tfm);
 	kfree(challenge);
 	kfree(challenge_binhex);
 	return auth_ret;
