Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs0+Aen91L4VKNpHqTPqrYRTdPAn7GumzPmA9U5a9QZQE0ZDMUaEbp9WUhPZZJyhM5ig3Bz
ARC-Seal: i=1; a=rsa-sha256; t=1521484042; cv=none;
        d=google.com; s=arc-20160816;
        b=bIbr9mvQ3yt7nnHpmT5dvIP2E1fCV+vNtgyhzMJBpz6WWcsDmnR7m869HHLGhFRqqz
         sdeHSxv3pYEf895YILE0r8Dp/19as39irwEq5tsFh2sDbnxcC13DLpTGSkcMIkb/hp8I
         ZsKEgDMdGVFRUYAZq7mobxcjQuSeSWOkD6msaaL63TI9OkCAcMEgpe8PCi767q6zDyy3
         e710do4UYgO+3qLsLNd+Uaq8BKpgKHbPLOy4f2bpsv75xFJvLh2aEl9/WTMeYyJFESqw
         ycIZg+/y9bQDv1BXd+egMtsIkjsyDxLuoC1DjnPqwPfPWnI+NIIXhtGxBoesvTdNxdTp
         2kkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=238e+pUBZLi+e0KcfunEatJxo2lB0Ka5ELmp00TUWLw=;
        b=ETfGH2cP4d0/JWMetLA+Wr/KDs8XTjuwZhJiaL/YdjyJIcPbP1Q1YutPS/TVIuviuh
         qE0aoNXK7mwwmC9gFDGumKNZgqRY+2jpVw9e2K++OMpJRmiyG4J4aeo23ZUHuOxBaTHA
         fEX5noZdfQma5UEV5iUSDqPXaOHWDbTedGCgnIjjBFpKb4GUTzrMjM/3FH4E6Ybucsga
         YjY771YsXZOcWuzIN9zqVOiA6/4Icqf9mSjkXW/DfLqKGNsPVakoJMq7dcb3h1Q5r8LJ
         DF2CxgPAqqowFz3KjfdHf3HYo7CMJoNFJ/O4sv0znOeMfObxbNHd95AwGyZruhwJsQln
         2aKA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mimi Zohar <zohar@linux.vnet.ibm.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 209/241] ima: relax requiring a file signature for new files with zero length
Date: Mon, 19 Mar 2018 19:07:54 +0100
Message-Id: <20180319180759.828692103@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390639959423215?=
X-GMAIL-MSGID: =?utf-8?q?1595391650986138502?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mimi Zohar <zohar@linux.vnet.ibm.com>


[ Upstream commit b7e27bc1d42e8e0cc58b602b529c25cd0071b336 ]

Custom policies can require file signatures based on LSM labels.  These
files are normally created and only afterwards labeled, requiring them
to be signed.

Instead of requiring file signatures based on LSM labels, entire
filesystems could require file signatures.  In this case, we need the
ability of writing new files without requiring file signatures.

The definition of a "new" file was originally defined as any file with
a length of zero.  Subsequent patches redefined a "new" file to be based
on the FILE_CREATE open flag.  By combining the open flag with a file
size of zero, this patch relaxes the file signature requirement.

Fixes: 1ac202e978e1 ima: accept previously set IMA_NEW_FILE
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/integrity/ima/ima_appraise.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -207,7 +207,8 @@ int ima_appraise_measurement(enum ima_ho
 		if (opened & FILE_CREATED)
 			iint->flags |= IMA_NEW_FILE;
 		if ((iint->flags & IMA_NEW_FILE) &&
-		    !(iint->flags & IMA_DIGSIG_REQUIRED))
+		    (!(iint->flags & IMA_DIGSIG_REQUIRED) ||
+		     (inode->i_size == 0)))
 			status = INTEGRITY_PASS;
 		goto out;
 	}
