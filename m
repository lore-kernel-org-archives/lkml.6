Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+m87g3/Y84Yph01NRwP09KtoFt0hWA8oCbFBy5mpFG1/OJyYDp9ozJwYYrT6rPkDdN17RO
ARC-Seal: i=1; a=rsa-sha256; t=1523981077; cv=none;
        d=google.com; s=arc-20160816;
        b=ntPUEBPAiiOO5vmDfeKKDDd81i4BB1RGIZstRa4dhYT/dblUOCOSeA2uV8ZfwinxNO
         e4jfrhdrPAoXfU2T8lP2X4ImHhdDklLX+krRrCJB4IkB3VVyOzmjaA1jN6Z1egGJ2d0B
         jiakdYMNV3EJn3uL9e0dx9O3GrKTKmWWLuU7upnVtCPT6ZCDn6ChWL3zi/jU+dSlIUm3
         ZZKbsr4IaBDlh3qpEC9LN7+lHAtuBwdryyMInF0RUCa22AXih+/DI8Ttg5dwFMk2cYTL
         HLeRWC12ApuvJuFTaItOoK4GIbYRDmeTPXCSRougszwqLOTs++wAkTHWytA2ef/12DOk
         SAfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=e2+Xvwf2XKWOYjqSRPZPH7tULDV19/IvU9pCPelrKZ8=;
        b=nWC1Zfmuc60w0YNqGQVfpSXHLCfQC1kXQsRotdih5dCRIGFdzQLxbP9iBQH1KS2ldr
         bD2/iNeLIDoeO0cVDFHETHTD7495ne0ct8Yt00Lr5VJ0SihLawLSny8jzU91OXPVFIYR
         aHBYTFXK9MxZHkKTfeXI5X9eU3VhhvZAvZ8IGKyJR+8Muj2h1tTkDYB4A27x9Fa6DZe1
         XYkEUCa7nLjSTeySTOTsxwzWfrE5KIS7pOpnK+Q+pC8qMOdm3FEmY0cNWXWh5VN54MgO
         Y/MZjDzTj+8Tuy+DI8mhIzSSGKQqfrPstciugo1GiApkm5VAcODZ8Ewf/59qmRpjw0yh
         8zXA==
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
Subject: [PATCH 4.15 34/53] xen: xenbus_dev_frontend: Fix XS_TRANSACTION_END handling
Date: Tue, 17 Apr 2018 17:58:59 +0200
Message-Id: <20180417155724.802239811@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009807855187650?=
X-GMAIL-MSGID: =?utf-8?q?1598009982329680189?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
