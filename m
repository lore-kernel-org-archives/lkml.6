Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs2kdzQ8pUtpHvQvTJKrIjbYXBL924/WOhuE6MTTfIgozuMw4NwIe9C8dddeBPQsukObPPd
ARC-Seal: i=1; a=rsa-sha256; t=1521214743; cv=none;
        d=google.com; s=arc-20160816;
        b=MsHU8NkZENSxC6dAWOIgCe6pz1BHaSJ+wt4Oo9pQqSgoMSLz+PJeOUxOc25rnDRm1S
         zgDY7aP/9IyaZyL8kYKNyPU+9nX0EOsD+zgOKKDSLwBcJpX2GdydufQ903HsBPNnIoHp
         njaNnzCa21pKO6Mcp+FjqjR6VCJG7EQ9avvD7/0zgzqUE0DtJhSQVQ4NwmWG33S3Cp9W
         5hesOw+pNHJDkJnN/taXG7I5A3ZIz5rJwQiUNdYz3nsmCJ6YnKu+q5/COsskPiygGdah
         6AblUwM6EIq3Tdv4bvQGexsGe0Uj6ZX+02KQodL3MjCxCaL67l9MBoLukt9FXTdMam/I
         9xzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qXvf3SO8Ouc+UJeFb94Dfyh8mD4wC4WZxRb6ERRgI5M=;
        b=GfpvM9JC4MmsfgSthieN5pS/beidZjoDUGPDzRJ66KTB5TE2BfSY9IyW5hY6dkTB0R
         jUN8WAbHl22xfKrnDkLJT8rExJstDtdkICxvplIueULaU2ffB7DX15VJq6vphIfZYTzM
         LAkV08vAhbyoeSpoTmr3El04jPbrQS7HxjcNT4oE+6fQSxqgeS/1wTbat4vSFUpU6cfb
         g2qvSZY0P2Iy69bjYX3ybhTjXJB2ECLQLJ+QCqZH3qiTZk03diY9Gh4AdE5LU6JtiDpi
         ux46vyWnYG+F7gAaDJihcToAMvUhX4G7uDqYZpPpbzjoQ05kdr8zhAO39kkR1TKZrCur
         1bQQ==
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
Subject: [PATCH 4.14 106/109] ima: relax requiring a file signature for new files with zero length
Date: Fri, 16 Mar 2018 16:24:15 +0100
Message-Id: <20180316152335.598768675@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109271252967331?=
X-GMAIL-MSGID: =?utf-8?q?1595109271252967331?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
