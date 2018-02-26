Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227he7F08ANlV/f4k1DARehm7XqSWhEMH2Jo57L20SWsmk6thQp5EEpktWsuR/J93nhiFUdt
ARC-Seal: i=1; a=rsa-sha256; t=1519676604; cv=none;
        d=google.com; s=arc-20160816;
        b=zhbuzeQ63Zq/0mMkpYRVlu/Norae2fBM0JyXRKVQjolmnfiBO3Sx9voelsQd95wzQ7
         8d2dIs5DdhukFRIrLvrIKSOWzwgb+9ckJK4mZGdWzxPz2sfMJjbapRvNmqDyQ9VbwuvG
         8WhFxgucUoDSoAnjJ06HjN9LFqDO5EheA6boi3faJhfU5kjZX+8yB/8+7yp9AGnPYKM3
         RAZh7424J4XNb79EIAODFrJ0UvM1nqa7eJ9gktyd3hmrc9vIIFy+dOEgl85cbhP3J53o
         ewHLuaj7aJLp9wKIDBDfkFM86bL55yROZlbfFZ1GPzr1WqhXmktXVSJcseJ/BPsJhNaY
         RO4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AIo+u6BJn8BhCNoAlVdWi3t+4Lzow1AF3SxaaeAY4NQ=;
        b=oRAY0GPNUvuYUrB9AaYsf2/2YPG8DWnCrJicNdWzlA5hyCrUwlgqewyaKlCWF8o/uD
         CcKKjZUbboEmVskgnJ1+5NJSGFlNnsLdX+awjgCjB/xKHZWb+odZrMJT+FPGn8n7Uvv5
         YadCtg3qiPMFmP3wm/zxZCL9NyaPl/9CX+jsFgY84Jlj8kJplbni4BoKPrqtKdQNdcwN
         PcchgJ7JYlsEMXSp4ftQv50q+ZmQ7oPqq8lj6b0qOdyyTM3p/6HiMvRoJT5bns9+8sNf
         nZMcGrCmrdsCH39J/gM37cJc3y83p5QfKFqocq2vO9zzoyRoad50W+Tzr9CEIbZ6vygz
         LYIA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Biggers <ebiggers@google.com>,
	David Howells <dhowells@redhat.com>
Subject: [PATCH 4.14 12/54] X.509: fix NULL dereference when restricting key with unsupported_sig
Date: Mon, 26 Feb 2018 21:21:49 +0100
Message-Id: <20180226202144.975088910@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496339342709279?=
X-GMAIL-MSGID: =?utf-8?q?1593496415660287161?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 4b34968e77ad09628cfb3c4a7daf2adc2cefc6e8 upstream.

The asymmetric key type allows an X.509 certificate to be added even if
its signature's hash algorithm is not available in the crypto API.  In
that case 'payload.data[asym_auth]' will be NULL.  But the key
restriction code failed to check for this case before trying to use the
signature, resulting in a NULL pointer dereference in
key_or_keyring_common() or in restrict_link_by_signature().

Fix this by returning -ENOPKG when the signature is unsupported.

Reproducer when all the CONFIG_CRYPTO_SHA512* options are disabled and
keyctl has support for the 'restrict_keyring' command:

    keyctl new_session
    keyctl restrict_keyring @s asymmetric builtin_trusted
    openssl req -new -sha512 -x509 -batch -nodes -outform der \
        | keyctl padd asymmetric desc @s

Fixes: a511e1af8b12 ("KEYS: Move the point of trust determination to __key_link()")
Cc: <stable@vger.kernel.org> # v4.7+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/asymmetric_keys/restrict.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

--- a/crypto/asymmetric_keys/restrict.c
+++ b/crypto/asymmetric_keys/restrict.c
@@ -67,8 +67,9 @@ __setup("ca_keys=", ca_keys_setup);
  *
  * Returns 0 if the new certificate was accepted, -ENOKEY if we couldn't find a
  * matching parent certificate in the trusted list, -EKEYREJECTED if the
- * signature check fails or the key is blacklisted and some other error if
- * there is a matching certificate but the signature check cannot be performed.
+ * signature check fails or the key is blacklisted, -ENOPKG if the signature
+ * uses unsupported crypto, or some other error if there is a matching
+ * certificate but the signature check cannot be performed.
  */
 int restrict_link_by_signature(struct key *dest_keyring,
 			       const struct key_type *type,
@@ -88,6 +89,8 @@ int restrict_link_by_signature(struct ke
 		return -EOPNOTSUPP;
 
 	sig = payload->data[asym_auth];
+	if (!sig)
+		return -ENOPKG;
 	if (!sig->auth_ids[0] && !sig->auth_ids[1])
 		return -ENOKEY;
 
@@ -139,6 +142,8 @@ static int key_or_keyring_common(struct
 		return -EOPNOTSUPP;
 
 	sig = payload->data[asym_auth];
+	if (!sig)
+		return -ENOPKG;
 	if (!sig->auth_ids[0] && !sig->auth_ids[1])
 		return -ENOKEY;
 
@@ -222,9 +227,9 @@ static int key_or_keyring_common(struct
  *
  * Returns 0 if the new certificate was accepted, -ENOKEY if we
  * couldn't find a matching parent certificate in the trusted list,
- * -EKEYREJECTED if the signature check fails, and some other error if
- * there is a matching certificate but the signature check cannot be
- * performed.
+ * -EKEYREJECTED if the signature check fails, -ENOPKG if the signature uses
+ * unsupported crypto, or some other error if there is a matching certificate
+ * but the signature check cannot be performed.
  */
 int restrict_link_by_key_or_keyring(struct key *dest_keyring,
 				    const struct key_type *type,
@@ -249,9 +254,9 @@ int restrict_link_by_key_or_keyring(stru
  *
  * Returns 0 if the new certificate was accepted, -ENOKEY if we
  * couldn't find a matching parent certificate in the trusted list,
- * -EKEYREJECTED if the signature check fails, and some other error if
- * there is a matching certificate but the signature check cannot be
- * performed.
+ * -EKEYREJECTED if the signature check fails, -ENOPKG if the signature uses
+ * unsupported crypto, or some other error if there is a matching certificate
+ * but the signature check cannot be performed.
  */
 int restrict_link_by_key_or_keyring_chain(struct key *dest_keyring,
 					  const struct key_type *type,
