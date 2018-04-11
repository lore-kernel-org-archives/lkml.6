Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+PndiUHg7lgdUIRMXpI1QG9KMA4fprWVIqaLvaCOSy22a/Gnfhqgt4fZUcE6YNDKVLW/st
ARC-Seal: i=1; a=rsa-sha256; t=1523473381; cv=none;
        d=google.com; s=arc-20160816;
        b=v8YRLW85q1KjU763JUde7h/89qc5+F/JV4ypypB5F3V9gnwsQYFsXwHYmixhMiEtbk
         6WUW+BF7x3XX74vil859qK+yGYwo9Vim1JfxdFRbyezYD8plnYlMMZK53Mfe9cj0/fhp
         LRf/sNCV14cTwTmbnpfSwXumQGhantVNX0lO7WjZs48skw9U4EfAuuW0hw63oYJR3gQW
         ljhLzHuyVhyZYeJc55ao9aRJZ/wlEXFHP2KyrmKQGcu5dGxb9aQL/ZcqLXCXr+k1j3XR
         jimomOZSc+Gy7eED6duG5rVsr64QI4+x1SWtQd8Tme97t/9MFkNuhGuDwPkXN+JxNZ+t
         axqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Wi/SYo+HPqJGnqOvtoOytbTEIuNzp9gEU/61M0c+brY=;
        b=QL97BAKhSJ40aZMPUzbeFJiIZwYAlMH7nBN4iQ3QovkYpDgLvxDTdI+P4dUdJMF5fH
         ly9yhCmQV1KjoJqkN3JLMXxaXBj6vQHQLrjp0ObJJ3+krVo7TS1yYb/mL6AuuNsdigpE
         Guc4DO/IuHx6FMpeWCmzEvR8XdOnTgM5aG8Ae80iloKqa/rDqOwBCMXTNGdiFvWe/9FJ
         aByu0WzPMm5ClSDCrCNUbIL2d2Ujvc8dER4dO0a1ZjMm+sjcreQdnrzAFsBEDHnvY/Gf
         XpThDYfvRrCBA8PYSXcfT7fJ1WZV50Tl8bHehMpK4IOPN4QSntrd8nflQROfzvA69IYn
         0nlA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	David Howells <dhowells@redhat.com>,
	James Morris <james.l.morris@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 228/310] X.509: Fix error code in x509_cert_parse()
Date: Wed, 11 Apr 2018 20:36:07 +0200
Message-Id: <20180411183632.320878729@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477624441340215?=
X-GMAIL-MSGID: =?utf-8?q?1597477624441340215?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit 4e880168e9ffb1cdbdb72b3b48ab0324b30c2d62 ]

We forgot to set the error code on this path so it could result in
returning NULL which leads to a NULL dereference.

Fixes: db6c43bd2132 ("crypto: KEYS: convert public key and digsig asym to the akcipher api")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: James Morris <james.l.morris@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 crypto/asymmetric_keys/x509_cert_parser.c |    1 +
 1 file changed, 1 insertion(+)

--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -102,6 +102,7 @@ struct x509_certificate *x509_cert_parse
 		}
 	}
 
+	ret = -ENOMEM;
 	cert->pub->key = kmemdup(ctx->key, ctx->key_size, GFP_KERNEL);
 	if (!cert->pub->key)
 		goto error_decode;
