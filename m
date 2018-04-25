Return-Path: <kernel-hardening-return-13134-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZqilqbf13gXzLZRGoiJv0o8qzaGvsV2WnOEBoEvBIif8VyfuTycJll3HCrwVECScMkxBTx9
ARC-Seal: i=1; a=rsa-sha256; t=1524652620; cv=none;
        d=google.com; s=arc-20160816;
        b=IJMkeTusSZMgkUfLM/9189Q8vu7zR9v+PR+IrFCTSdlzBQAZFVcQXUF7MNRcoW4Hr7
         WTkEXmY8eQtEnDI1ua/exYByI23i+m/xfF61k/aAPDSce0mG1wXGiwLfG7Hx7RTMVI+M
         +afkInoWM5luf/UyZxbSjl4cVFdRHnERRE+guKCTqk5mIe1A3Uc+nDY9NdoJizhJPkYk
         wdjc9HHVwWNcSstfUwd+LftO2IzLekuDzbzSIm1MxnQfL+G0OY68A1eh53elbVtPvncT
         SCMf5RFnnHxViXnD7JHL6XMMkNf48tXP8EXTefZO2oJ1SJqVrFmnp+lLfHVG4/c2/XL1
         RlQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:date:message-id:in-reply-to:references:from:subject:cc
         :to:delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=Irz8iZqHvnQaXtKF4iqB1Ide9Lpf/ot8oKjATGCyRKo=;
        b=gBDY+gMQAgM3BfEbyB8U/uXqzuNjIKlWD51odaIuufIuRU9tqtLzUaclZhOM8HJyFE
         Ci/DzKrHKH+w1BSeYavAFh1dtYSpCRZyKUp5gtiAu4iz+iPS0zN0/u5+UwZ+fdHpXYqd
         qIlxPx2jdiaoaNks3khrhzb1Ms+JE3QOAjeq+uSnJ70OKZBKjGsdg28fL8xOIyl4/j/z
         dwA+s7eV/RMQdTXsvxjzzUaq1A6UuCB1tz93rqV9kuVsramE6VSXyuKEoPxbcqqo+ONL
         RnRmF6N1Elg5XxXQW/dy7wuXDdeJJ6WJ7dFKDAziTlKTuEdf1pl99oIqhLVgnARCnUt/
         nDGw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13134-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13134-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13134-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13134-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
To: keescook@chromium.org, serge@hallyn.com
Cc: tycho@tycho.ws, ebiggers3@gmail.com, dhowells@redhat.com,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        jmorris@namei.org, Jason@zx2c4.com
Subject: Re: [PATCH 1/3] big key: get rid of stack array allocation
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20180424143539.GB3125@cisco>
	<201804242346.FHI69745.SQMHFVOOFLFOJt@I-love.SAKURA.ne.jp>
	<20180424145104.GC3125@cisco>
	<20180424195845.GB23575@mail.hallyn.com>
	<CAGXu5j+SXCJpm9xnX1UaY0Qz2+E0qNETc+s8kwrH6hE9LLjgpw@mail.gmail.com>
In-Reply-To: <CAGXu5j+SXCJpm9xnX1UaY0Qz2+E0qNETc+s8kwrH6hE9LLjgpw@mail.gmail.com>
Message-Id: <201804251936.GAG73463.HOJtFFOQSLFOVM@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Wed, 25 Apr 2018 19:36:21 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598589451187807410?=
X-GMAIL-MSGID: =?utf-8?q?1598714145698734768?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Kees Cook wrote:
> On Tue, Apr 24, 2018 at 12:58 PM, Serge E. Hallyn <serge@hallyn.com> wrote:
> > Quoting Tycho Andersen (tycho@tycho.ws):
> >> On Tue, Apr 24, 2018 at 11:46:38PM +0900, Tetsuo Handa wrote:
> >> > Tycho Andersen wrote:
> >> > > > > +     if (unlikely(crypto_aead_ivsize(big_key_aead) != GCM_AES_IV_SIZE)) {
> >> > > > > +             WARN(1, "big key algorithm changed?");
> >> >
> >> > Please avoid using WARN() WARN_ON() etc.
> >> > syzbot would catch it and panic() due to panic_on_warn == 1.
> >>
> >> But it is really a programming bug in this case (and it seems better
> >> than BUG()...). Isn't this exactly the sort of case we want to catch?
> >>
> >> Tycho
> >
> > Right - is there a url to some discussion about this?  Because not
> > using WARN when WARN should be used, because it troubles a bot, seems
> > the wrong solution.  If this *is* what's been agreed upon, then
> > what is the new recommended thing to do here?
> 
> BUG() is basically supposed to never be used, as decreed by Linus.
> WARN() here is entirely correct: if we encounter a case where
> crypto_aead_ivsize(big_key_aead) != GCM_AES_IV_SIZE is not true, we
> run the risk of stack memory corruption. If this is an EXPECTED
> failure case, then okay, drop the WARN() but we have to keep the
> -EINVAL.

big_key_init() is __init function of built-in module which will be called
only once upon boot, isn't it? Then, there is no point to continue after
WARN(); BUG() is better here.



Moreover, if this is meant for sanity check in case something went wrong
(e.g. memory corruption), it is better to check at run time like

diff --git a/security/keys/big_key.c b/security/keys/big_key.c
index 9336237..bca04f2 100644
--- a/security/keys/big_key.c
+++ b/security/keys/big_key.c
@@ -22,6 +22,7 @@
 #include <keys/user-type.h>
 #include <keys/big_key-type.h>
 #include <crypto/aead.h>
+#include <crypto/gcm.h>
 
 struct big_key_buf {
 	unsigned int		nr_pages;
@@ -109,7 +110,12 @@ static int big_key_crypt(enum big_key_op op, struct big_key_buf *buf, size_t dat
 	 * an .update function, so there's no chance we'll wind up reusing the
 	 * key to encrypt updated data. Simply put: one key, one encryption.
 	 */
-	u8 zero_nonce[crypto_aead_ivsize(big_key_aead)];
+	u8 zero_nonce[GCM_AES_IV_SIZE];
+
+	if (crypto_aead_ivsize(big_key_aead) != sizeof(zero_nonce)) {
+		pr_err("big key algorithm changed?");
+		return -EINVAL;
+	}
 
 	aead_req = aead_request_alloc(big_key_aead, GFP_KERNEL);
 	if (!aead_req)

because crypto_aead_ivsize(big_key_aead) == GCM_AES_IV_SIZE is true
unless something goes wrong at run time, isn't it?



Moreover, zero_nonce[] can be "static" if all actions after memory allocation
are guarded by global big_key_aead_lock mutex?

diff --git a/security/keys/big_key.c b/security/keys/big_key.c
index 9336237..1e7d2d1 100644
--- a/security/keys/big_key.c
+++ b/security/keys/big_key.c
@@ -22,6 +22,7 @@
 #include <keys/user-type.h>
 #include <keys/big_key-type.h>
 #include <crypto/aead.h>
+#include <crypto/gcm.h>
 
 struct big_key_buf {
 	unsigned int		nr_pages;
@@ -109,27 +110,28 @@ static int big_key_crypt(enum big_key_op op, struct big_key_buf *buf, size_t dat
 	 * an .update function, so there's no chance we'll wind up reusing the
 	 * key to encrypt updated data. Simply put: one key, one encryption.
 	 */
-	u8 zero_nonce[crypto_aead_ivsize(big_key_aead)];
+	static u8 zero_nonce[GCM_AES_IV_SIZE];
+
+	if (crypto_aead_ivsize(big_key_aead) != sizeof(zero_nonce)) {
+		pr_err("big key algorithm changed?");
+		return -EINVAL;
+	}
 
 	aead_req = aead_request_alloc(big_key_aead, GFP_KERNEL);
 	if (!aead_req)
 		return -ENOMEM;
 
+	mutex_lock(&big_key_aead_lock);
 	memset(zero_nonce, 0, sizeof(zero_nonce));
 	aead_request_set_crypt(aead_req, buf->sg, buf->sg, datalen, zero_nonce);
 	aead_request_set_callback(aead_req, CRYPTO_TFM_REQ_MAY_SLEEP, NULL, NULL);
 	aead_request_set_ad(aead_req, 0);
-
-	mutex_lock(&big_key_aead_lock);
-	if (crypto_aead_setkey(big_key_aead, key, ENC_KEY_SIZE)) {
+	if (crypto_aead_setkey(big_key_aead, key, ENC_KEY_SIZE))
 		ret = -EAGAIN;
-		goto error;
-	}
-	if (op == BIG_KEY_ENC)
+	else if (op == BIG_KEY_ENC)
 		ret = crypto_aead_encrypt(aead_req);
 	else
 		ret = crypto_aead_decrypt(aead_req);
-error:
 	mutex_unlock(&big_key_aead_lock);
 	aead_request_free(aead_req);
 	return ret;
