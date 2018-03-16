Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu5jf1nuM3zgG3HG/Dj2+tx4BDi38ymacyuj3YzezVv9LtpdrJk07Pp+O03POn4/75t2XdX
ARC-Seal: i=1; a=rsa-sha256; t=1521215090; cv=none;
        d=google.com; s=arc-20160816;
        b=A7WQOiBlsZsQl9LvAVzXird+YWRFUBXYhyCHkpS4dnvjmJknB6+5RtFiqlymcc8vjN
         oo/JjIEY4aZz1aDU+68o6oWS0xUf6shCOEcyLYQ5nauG8fXdTXYlKnZxL+gQYIvUdLDk
         7EEOeEjk9F6mZSxc87rGIuYmmWXnm7a7rxdSql28aYYiuEPBbWWaXHcxSAc67s6cJ+Gp
         FXbkZjfmrOFD/eJzT63vBanGmJ8+US5FJmv6mIl0SdbT31CUCNwK0aXSmJATaJPshfn6
         A8ZSIvDj1okf1wIzraMgcgNf7gYfM+UTdGhWtQc29kCVJvmNIb6E0C8CP4kTmIPhqepT
         w4vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Y1KrCxjOhUkPSC/pPXwOlsX5/xWZiULxui3WHIZC2HA=;
        b=UUArmOEDLClo7MwVyTVa1o5Ti385HG96Jk6Ws6FNYohjFBPlGw2WNxwhOrCrmGQlzf
         1U31tlR+9p1IeQL923v4ak1+9v7Ok9O6r7o07UNUULce0XHROc2lyOBJCAF7bgi4MGZx
         CvDVT1qaUZOPciRSQxVDp/niBYRnVVAWykLOM8nN6fBh1eBYtJJZ8vDDNT0CbnVcJCzY
         KNzhDVXYs+xiDQuHVNkbKgnWntN5EXZlFESmk71eouDfpG4VdNChoa37hpJj7ksW3Qzt
         uSta6x2sqR3NnFjmvnRb8VjMWtF4tlSOtm5gGwfN/0YyFwGsj9gI3SDt8bpEwpFoyp0z
         +PbA==
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
Subject: [PATCH 4.15 125/128] ima: relax requiring a file signature for new files with zero length
Date: Fri, 16 Mar 2018 16:24:26 +0100
Message-Id: <20180316152342.663901260@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109271252967331?=
X-GMAIL-MSGID: =?utf-8?q?1595109635061872236?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -223,7 +223,8 @@ int ima_appraise_measurement(enum ima_ho
 		if (opened & FILE_CREATED)
 			iint->flags |= IMA_NEW_FILE;
 		if ((iint->flags & IMA_NEW_FILE) &&
-		    !(iint->flags & IMA_DIGSIG_REQUIRED))
+		    (!(iint->flags & IMA_DIGSIG_REQUIRED) ||
+		     (inode->i_size == 0)))
 			status = INTEGRITY_PASS;
 		goto out;
 	}
