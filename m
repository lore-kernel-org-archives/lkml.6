Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48daWZGzV4xAECNGCqnZEg+zRpqYy0Sgn7HUYELDfqbqDR9wXmWKJI1bAeU3jlWE7ilBO3W
ARC-Seal: i=1; a=rsa-sha256; t=1523980818; cv=none;
        d=google.com; s=arc-20160816;
        b=Rx1pUmkwOu0FBxu2phpX8W2ZNA0Vnp8cbA4nPPfO5iQ1MwdAX8LxBz+cZlc2mq6/vf
         R5VwSifU+tcTgI4nBFjTxyjXYGYsf1t1bPVmWSO12jHtzpyNkQwvlKLwgv7VC9+oOFeJ
         +mXP8l6cpA1oux4/zjZ9+vm0/fRJ5tEcKQLu7QTYUe+vbZr5I40pImWzAEnk4uVal/eU
         6KdHaeFJyvGaopuAUhloctvbvlBcQU8jWCyFyqmd2o9BbyDGkkhNJRYXokzkcroFa9CO
         /9+vKSAV5m5B+UNqzAKbgQx1oKPLZhQHKMv4bQSWvuM+7xhmK1kIqGxHx7zAAw5RqBPl
         nZ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6+rU9AIL2K8+rMFPasm0L62BtbwHsxp6YkDMk9gjuVM=;
        b=a+9qCNlCi0zTXlbJzF0Dpt7qT1MLq5etqdJ+gIUril11G27bYUhcDTIYMIEGnG+wrL
         99gCxLHfyJ5zH1+xNPgSYpw9au1/Y6mtyohg7h9iJO9Tq7UPl6fXl9xxrmGWo4GvTOZs
         zwSCLtWHWOETMHcAmM4Po6yqMWtLTHNkl8F/ThQPLde6FSvwbbL4TH1cKdyQTLyRze2/
         Vgi1GFHVCfF9eS9c54QA3H6QyYXoJMPd1iIRPIxUvLkWy+ePqdWJADFFy0H2umq+TS+G
         P0+6EP9a0VMsg1dbs3SCjgQ1E6zJtpeF+skTjPby1m6dUo3+S3+8wHh2KjvwBqFBO5Cz
         n4Zg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 4.16 16/68] parisc: Fix HPMC handler by increasing size to multiple of 16 bytes
Date: Tue, 17 Apr 2018 17:57:29 +0200
Message-Id: <20180417155749.993691531@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009710354383751?=
X-GMAIL-MSGID: =?utf-8?q?1598009710354383751?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

commit d5654e156bc4d68a87bbaa6d7e020baceddf6e68 upstream.

Make sure that the HPMC (High Priority Machine Check) handler is 16-byte
aligned and that it's length in the IVT is a multiple of 16 bytes.
Otherwise PDC may decide not to call the HPMC crash handler.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/parisc/kernel/hpmc.S |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/arch/parisc/kernel/hpmc.S
+++ b/arch/parisc/kernel/hpmc.S
@@ -84,6 +84,7 @@ END(hpmc_pim_data)
 	.text
 
 	.import intr_save, code
+	.align 16
 ENTRY_CFI(os_hpmc)
 .os_hpmc:
 
@@ -300,12 +301,15 @@ os_hpmc_6:
 
 	b .
 	nop
+	.align 16	/* make function length multiple of 16 bytes */
 ENDPROC_CFI(os_hpmc)
 .os_hpmc_end:
 
 
 	__INITRODATA
+.globl os_hpmc_size
 	.align 4
-	.export os_hpmc_size
+	.type   os_hpmc_size, @object
+	.size   os_hpmc_size, 4
 os_hpmc_size:
 	.word .os_hpmc_end-.os_hpmc
