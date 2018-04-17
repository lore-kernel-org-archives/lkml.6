Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/8ALAU0sHzJIQYMtUtidja8rs84fUXzWiPgzU7HwFRhjVKZft+VtZ72EwKx/AX342Lchrd
ARC-Seal: i=1; a=rsa-sha256; t=1523981253; cv=none;
        d=google.com; s=arc-20160816;
        b=ttENl8KPw0gySFKatNiwuB2LjqCXcFle+Z5JZzUKWY5/ky2Wzi4eUtGDMWgWiquyg4
         Y185hJfoPGK5tQ5qhPO2UR1rAICYL+l3HGl8Nul2RwMUNwreO5YGIuVnNwI1PkVwaMbT
         izMCY6hzvea2FKgDl50gapcd2/Ce5YUW1GGEhdCl8q//ZFOHbhI7PZpHsPzf/nnheJ52
         D/AMzJPL+jByyXQefi/vjJGbKgktEWZzL8XabBsHV+ItJc0mHW9KsmoaoXN9hgl9ingb
         yi+kq/FcAw5poJt8tv9AwBfdvrdR+w4435Y/snOj1M+8fgk+gp2+qdSU0jQBPh+3CI3I
         qNAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aH2OHPCa+ZSnYZbyuF4zE2oGXEFec8IvBbo8hNMvqUs=;
        b=T+AQvzqklQBIia3PbPLQQdW7t9tNne6J9Ky7aDH0gE/Y1VekjSEvQPSObsKxKspURk
         UivUSS77uVrMS490j38o6Cuj+Mi86iqpCORZh9lkMi2uKr4tMLMcS3sY3fsuA6W46Cil
         tQ1TnBwsVFoGathGnKpqbEkJVp9BguYf8lUwdJtxJKC6xBVBiG/hNWtM8Ki5azqLldMT
         5JwZbljaiUgQL81neIAS9pa3ClhCKFThOEE2S3wOMNefcBTBuFTgmgKUu7uBOK+W7/Ll
         KKp481UipNf6EDDwyQ3aCgP/a2iUmdMU+XSPoNiUMYbscRz29Cg6VudNjeggHX1PmuHh
         fAzQ==
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
Subject: [PATCH 4.14 47/49] xen: xenbus_dev_frontend: Fix XS_TRANSACTION_END handling
Date: Tue, 17 Apr 2018 17:59:26 +0200
Message-Id: <20180417155717.278117685@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155715.032245882@linuxfoundation.org>
References: <20180417155715.032245882@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009807855187650?=
X-GMAIL-MSGID: =?utf-8?q?1598010166790176932?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
