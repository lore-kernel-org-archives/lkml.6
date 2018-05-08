Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZph3vRtb7oWl6UEcYLt+RbxVAgk2iXMn4IQZw3xfjXnto/WXmva0FfdpagSEpfgQOwcDf6k
ARC-Seal: i=1; a=rsa-sha256; t=1525767378; cv=none;
        d=google.com; s=arc-20160816;
        b=s2H66PVzh50d7CJ243IV6bYW6v0TDcAp7rHIHPUWJYg3B7UbFVK2hgLjTkW2PG3ZbS
         kmsMkQAxJw1SUcnG9ODcjXil2BqbXn6OIN5aDe4320oI/xT3TCXXd79xmHz7jCKrorkv
         Qpu/5wGfDpJqGU+AGV0nFHsm/wLijqfjaO8w+gQh+9OoxA/7q8mWndbr0oOzeBGF/4p8
         fC3AXdOYiS2fF2PFybh7cmczWDgZh5w0/OnxJKsif8KEUvJ3t94Tq/GLN7y82NK9mtzS
         axbQ7CI2paKeJk73GBAQtMGyBynEizzS444supM/ggqzM1ZKAQyrwgP0eggG8aN+fFli
         rhZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=wGwtsouH/Asa/XynJR8xdqnrBiXazbhhQ4m4kBfPaEI=;
        b=YnsTifLjfbT8zyMk6Ccw9OJayXl7hZYT9fC630BW3qUUI70y6uuJfi3JsLueta3jg+
         GD9sARO3KBXyqRwya2i5TBNAjdTrrj+OmrsWKJQVdUHd7PLsuIFav5rgz1BJWU2VW17l
         CggXveDBO5VW8CGXPJndeOvyj79IDYX6PeTiKcwXgg4vzxm7Fu/JQcvJlntpY2raa63g
         HGilsTYgFjnP9iTVPy9RpYhVf/ssmOxRCqasAdmnAYGjLsHV3WB3hUkxaivKRhXvIjKn
         Q2ImkzSh4Wm7IEo2MAnoGp8jLA9BW5QRzVL2IH3jZ/QaOa+Pa/FukpuX1RYW1A3ms7+x
         M+Bw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Zz35M6Cw;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Zz35M6Cw;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Matthew Wilcox <mawilcox@microsoft.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jeff Layton <jlayton@redhat.com>
Subject: [PATCH 4.14 33/43] errseq: Always report a writeback error once
Date: Tue,  8 May 2018 10:10:52 +0200
Message-Id: <20180508074009.104216516@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882801198490431?=
X-GMAIL-MSGID: =?utf-8?q?1599883054553724628?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Wilcox <willy@infradead.org>

commit b4678df184b314a2bd47d2329feca2c2534aa12b upstream.

The errseq_t infrastructure assumes that errors which occurred before
the file descriptor was opened are of no interest to the application.
This turns out to be a regression for some applications, notably Postgres.

Before errseq_t, a writeback error would be reported exactly once (as
long as the inode remained in memory), so Postgres could open a file,
call fsync() and find out whether there had been a writeback error on
that file from another process.

This patch changes the errseq infrastructure to report errors to all
file descriptors which are opened after the error occurred, but before
it was reported to any file descriptor.  This restores the user-visible
behaviour.

Cc: stable@vger.kernel.org
Fixes: 5660e13d2fd6 ("fs: new infrastructure for writeback error handling and reporting")
Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Jeff Layton <jlayton@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/errseq.c |   25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

--- a/lib/errseq.c
+++ b/lib/errseq.c
@@ -111,25 +111,22 @@ EXPORT_SYMBOL(errseq_set);
  * errseq_sample - grab current errseq_t value
  * @eseq: pointer to errseq_t to be sampled
  *
- * This function allows callers to sample an errseq_t value, marking it as
- * "seen" if required.
+ * This function allows callers to initialise their errseq_t variable.
+ * If the error has been "seen", new callers will not see an old error.
+ * If there is an unseen error in @eseq, the caller of this function will
+ * see it the next time it checks for an error.
+ *
+ * Context: Any context.
+ * Return: The current errseq value.
  */
 errseq_t errseq_sample(errseq_t *eseq)
 {
 	errseq_t old = READ_ONCE(*eseq);
-	errseq_t new = old;
 
-	/*
-	 * For the common case of no errors ever having been set, we can skip
-	 * marking the SEEN bit. Once an error has been set, the value will
-	 * never go back to zero.
-	 */
-	if (old != 0) {
-		new |= ERRSEQ_SEEN;
-		if (old != new)
-			cmpxchg(eseq, old, new);
-	}
-	return new;
+	/* If nobody has seen this error yet, then we can be the first. */
+	if (!(old & ERRSEQ_SEEN))
+		old = 0;
+	return old;
 }
 EXPORT_SYMBOL(errseq_sample);
 
