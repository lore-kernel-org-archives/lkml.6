Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+FzCVmkaPt3b2+aBrG7j0uM2SUEpGlTSAui+/5Aj0vAhvTv6G8C7wVenUCCgRAZPyJTNPc
ARC-Seal: i=1; a=rsa-sha256; t=1523980911; cv=none;
        d=google.com; s=arc-20160816;
        b=YuVMUeOOcII1mw0OFFinBa5V1DGmYPz4t77bkGK3YTGw9beHK1XW+u9OiufLvGx6/Y
         LMVV4wOUsxbdiXSMqGGZCzxaxIq/tBqrru09cH1jLaylpVV4DV+Od3mEeBrMiWohz4Y7
         7yOgwsiwux95nNCo/WFa/+L9rluGhrIv4zWeIMMmZdbxkzlhQ8aoca3JjZyMF7N54mIW
         WHGX8h2HD73/sLl5QNUxpe0PLhkC2IwWJb99H3/PWMrTxBRY0vCHbI1DN9zhF7UB5dYz
         pj8p4TGlAjE9zzIfhW8GuxdCyKbgHq46GZNJvihYHWPKqQ5Rfd2xyEqVgkyb4bvJ7BQU
         k6AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7E/3KsSd2O9ZIsq4ArtphsX39tPs42f76FzvjMV9zVY=;
        b=qD6RXpRp6vQfCmlSsDwptWiOla5BZaRTHtlm9i5rSpoQI6+brTLNS0vHIKlmLBK00A
         ukX5Uq63DGWfoYg6H3RF5VoFlbRqGJJ6RqtoyYQuiGtU4K20H5wtF2S6KtEpAu/c0tXO
         o5I7tU/PXGjXmzNvmItFuzuspX1bu3uoeSCcDmm10toDqvEBr05b5amCCVmpqoHyubDN
         g0z9LgHYa6189mYVBS/Hb/kmED/vpHoTNq09IIBsfRAVkydhwhpiJB8RBQKxnvhYi54B
         2ccxwl/A4SHqzD2N3+coEztEM1b4lFFTD/5u0bjAVEGk5U06dO7Kod4MG+1ufGw+mUoM
         zVbw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Simon Gaiser <simon@invisiblethingslab.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH 4.16 48/68] xen: xenbus_dev_frontend: Fix XS_TRANSACTION_END handling
Date: Tue, 17 Apr 2018 17:58:01 +0200
Message-Id: <20180417155751.300069139@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009807855187650?=
X-GMAIL-MSGID: =?utf-8?q?1598009807855187650?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Simon Gaiser <simon@invisiblethingslab.com>

commit 2a22ee6c3ab1d761bc9c04f1e4117edd55b82f09 upstream.

Commit fd8aa9095a95 ("xen: optimize xenbus driver for multiple
concurrent xenstore accesses") made a subtle change to the semantic of
xenbus_dev_request_and_reply() and xenbus_transaction_end().

Before on an error response to XS_TRANSACTION_END
xenbus_dev_request_and_reply() would not decrement the active
transaction counter. But xenbus_transaction_end() has always counted the
transaction as finished regardless of the response.

The new behavior is that xenbus_dev_request_and_reply() and
xenbus_transaction_end() will always count the transaction as finished
regardless the response code (handled in xs_request_exit()).

But xenbus_dev_frontend tries to end a transaction on closing of the
device if the XS_TRANSACTION_END failed before. Trying to close the
transaction twice corrupts the reference count. So fix this by also
considering a transaction closed if we have sent XS_TRANSACTION_END once
regardless of the return code.

Cc: <stable@vger.kernel.org> # 4.11
Fixes: fd8aa9095a95 ("xen: optimize xenbus driver for multiple concurrent xenstore accesses")
Signed-off-by: Simon Gaiser <simon@invisiblethingslab.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/xen/xenbus/xenbus_dev_frontend.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/xen/xenbus/xenbus_dev_frontend.c
+++ b/drivers/xen/xenbus/xenbus_dev_frontend.c
@@ -365,7 +365,7 @@ void xenbus_dev_queue_reply(struct xb_re
 			if (WARN_ON(rc))
 				goto out;
 		}
-	} else if (req->msg.type == XS_TRANSACTION_END) {
+	} else if (req->type == XS_TRANSACTION_END) {
 		trans = xenbus_get_transaction(u, req->msg.tx_id);
 		if (WARN_ON(!trans))
 			goto out;
