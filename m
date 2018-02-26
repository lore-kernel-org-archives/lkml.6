Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuGvElZhE+e7DeED4OUHsEJsOvs5AMvqhSP3c3y0URNuibhMdU4vf3yRuWqCK49UZDSYfkM
ARC-Seal: i=1; a=rsa-sha256; t=1519676532; cv=none;
        d=google.com; s=arc-20160816;
        b=nB6nSAb2/IbAXvdReXruHlEyDr6ukSLNzu4jlFaWIypzZxtvN4YBZstDy1JzgZg/G1
         kZ5WQip9WikCB/3vObpxxh2EMjBOnx3cBT1uuW+xtCianBpCsOaBfNIbrwh3TmUTMS0S
         arMKMpiSYYpLny5jFtdabPRBQ/P52BwfG0Tk8xdZ1EiwTj9Zqvlf+8WLZRMcXmv6lO+F
         Wseb/w5kZ8I0WtELt64I45QIi8gZL32PbclVcye2L3DtWMtTlwB8WjhxDclIgmqmokWJ
         7CC/mLfoHWTMfE6TzfQI8rPHekO1xfIALEe5lOOFy18KGlqYVF0/QUfYrRSanz8EkgOw
         YKkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GaY7ZRfSvpKsVDibuWMp4JbtIPsXmo8E3zlBWRLJKVQ=;
        b=SsBzuJ1Jey8Fjvfir3xt2bfB921WOGGBoXIytQOTXL1sXvyKzJFPwjQZ9IKlCN5e1S
         d21vwH36Iea88yiM/hLYBjedeQv2/TeRCZiV0FaOBVp3O/VJbNeiOCbUo36lE0PXm//Q
         8qa1htC7BIYEKagVc1pGXl7eu3fN9m+LV0HcygHKvHLHMS+AQraJHU42AsAeaq9CTeAi
         +LoVRs16LeHT4OjKBFfi8yODQA5+aoBAunA+MRdJD5RHIyPqRCdC5W+wvsWgJqC025Oy
         OBbQ39R0I7PyGCytB15rY7O049oYYw90rEqL+mUdqK/NbYib37SAWzTgWuL8xJ8O2Swk
         gDCw==
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
Subject: [PATCH 4.9 28/39] X.509: fix NULL dereference when restricting key with unsupported_sig
Date: Mon, 26 Feb 2018 21:20:49 +0100
Message-Id: <20180226201644.906209281@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
References: <20180226201643.660109883@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496339342709279?=
X-GMAIL-MSGID: =?utf-8?q?1593496339342709279?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 crypto/asymmetric_keys/restrict.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/crypto/asymmetric_keys/restrict.c
+++ b/crypto/asymmetric_keys/restrict.c
@@ -66,8 +66,9 @@ __setup("ca_keys=", ca_keys_setup);
  *
  * Returns 0 if the new certificate was accepted, -ENOKEY if we couldn't find a
  * matching parent certificate in the trusted list, -EKEYREJECTED if the
- * signature check fails or the key is blacklisted and some other error if
- * there is a matching certificate but the signature check cannot be performed.
+ * signature check fails or the key is blacklisted, -ENOPKG if the signature
+ * uses unsupported crypto, or some other error if there is a matching
+ * certificate but the signature check cannot be performed.
  */
 int restrict_link_by_signature(struct key *trust_keyring,
 			       const struct key_type *type,
@@ -86,6 +87,8 @@ int restrict_link_by_signature(struct ke
 		return -EOPNOTSUPP;
 
 	sig = payload->data[asym_auth];
+	if (!sig)
+		return -ENOPKG;
 	if (!sig->auth_ids[0] && !sig->auth_ids[1])
 		return -ENOKEY;
 
