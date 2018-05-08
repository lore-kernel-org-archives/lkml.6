Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpGKwsbwFBVvUSpGaJX+O4NDoRjR3Nbw34HRRPcuDe5zpINy7Tb1aX8lkEQ1Mc7iZweDzpF
ARC-Seal: i=1; a=rsa-sha256; t=1525767136; cv=none;
        d=google.com; s=arc-20160816;
        b=eryGaUiCtWPaJLPd43XlM78AGw7pg7EAcQvoTNlSY2OEMjBR93h7M8YIYeQLQLR6DN
         SseHDjCCm2n/aZMTdmW7cUbldkzSreRnosKx+ICRWuUg1EZ1Idzxc2dE/8LsZWNMVGpp
         D62/vTxvsUvgsp7zdiRPv1zqfDdrJDzzNdvf5cOVBQDY8gQszbNQugAkREw2Qnm11RWL
         oP4YIqnASyyxDPGhdrKms6COQgXYFnDZMwiHoGt3fqlXwCynDkwj1lMD9daZYSgVBRP4
         kQaIRjYxd/QW3lctEzhZ6UWReXAxEGvJIVgGFhtqhoqvdxUkmstcl+roLE9GD/jb7ubl
         lxiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=eBwkeKMwWn+dfrAwVBEfJzzhdZO9AAzT+OlN4wDwQo0=;
        b=fQKImkoD5JQK+EItGDL3+stA6M2S2i5669anJzdPdIoBI1+tmHQzvfmQ8OzRyivq4w
         PEC1qLAYhyJRSFUpw2SqhkW464h1romNnCfzO9whrFPdd5XTb8kvAyxj8V8/Cdy3mN5a
         nByvhX/qujEHoaI8Oc4aPtGT2OR+CNL5zh0ASTFoueS1FxS484Pz3h74GCQBEsGb3fUr
         0kVJFBbZnrvPXt4Do1N20jZSYEMmngl6Em27MFDekMISuKRVe9L0yDHqX/eU4A9d889q
         MWKHgFa7SEExQUQ7wPs/fgcjwTJ1N8PrzHKXoGTtbkv7VSOJxJStil4FmpIjN/5WwRJX
         vohA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=wwg9Q8ZO;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=wwg9Q8ZO;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Matthew Wilcox <mawilcox@microsoft.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jeff Layton <jlayton@redhat.com>
Subject: [PATCH 4.16 09/52] errseq: Always report a writeback error once
Date: Tue,  8 May 2018 10:10:07 +0200
Message-Id: <20180508073929.223263280@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882801198490431?=
X-GMAIL-MSGID: =?utf-8?q?1599882801198490431?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
 lib/errseq.c |   23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

--- a/lib/errseq.c
+++ b/lib/errseq.c
@@ -111,27 +111,22 @@ EXPORT_SYMBOL(errseq_set);
  * errseq_sample() - Grab current errseq_t value.
  * @eseq: Pointer to errseq_t to be sampled.
  *
- * This function allows callers to sample an errseq_t value, marking it as
- * "seen" if required.
+ * This function allows callers to initialise their errseq_t variable.
+ * If the error has been "seen", new callers will not see an old error.
+ * If there is an unseen error in @eseq, the caller of this function will
+ * see it the next time it checks for an error.
  *
+ * Context: Any context.
  * Return: The current errseq value.
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
 
