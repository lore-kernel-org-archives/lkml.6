Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuGaNcZLPL5FQnQfnMfUhh+lr8qPByUkAjnkH7AsK3XB0Flux5+XTgtMsUV/04G797JSqpE
ARC-Seal: i=1; a=rsa-sha256; t=1521483077; cv=none;
        d=google.com; s=arc-20160816;
        b=eCFhdjEasS5wBuxIWsJDmNLITw+QkUAbz9Yj6mXC3NVz1X8IF8OZr69jXNCygTMHW4
         cSFvqkVpeJsBY6RpNvwIaphiY+lQwWKA23t7YHHvpkxPsVca6XK8RL8ksK8wz4yO624x
         MgtbkTjhiCze3I7U2wQrfdkormlj7llF1hH2DSjDrzPFGwhR1Lz1uWZAAC7cG5z+SXet
         kxpIc3u/e9vKTqyDh2yh4OwaSoRY0VQsEiEshbfh4eOJqhedqidwlkt3nOsFlql49D8Z
         gRO6ZEQRuydudmqmpsdisseWmeD59UVVvxB+9JMHLZfYvC7/YNizCCxfY3C6+kOjm+d1
         Nc2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=39zwaiBkKUdOhc7Dyt/co8/tCxJI5OJJDbT3gvVqiZo=;
        b=j0vzVQv16xb4Cl1g2gPRqwE1OAM0lnZdXycYg8BIItquvFocy5fv5caLrCi651EBxy
         NUhQDL2od4aaGFbFoDJVCSS35uYMuakb0lf5O5s8VsclMMBNXq5RQ/5tLDat906jo/Vg
         EFkKXixx+GF1ykktjiB56hzWqMn9+wcxJen/JAEy7uTxoQGgHh+c9knL8jrcjp2KCc6D
         wuKeofJahuNw7Caa+RG8zNtfL0Ovcvvq9Dao5nh0nqK9kOHdgue1vtXIZzGABJ8fX88H
         hthJ7XHK2doClh8yyNGIpAtJWWB8ndQFNTybwfR9BJux1PX0Mys2aak8TIdtBciYpttH
         2Nog==
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
Subject: [PATCH 3.18 59/68] ima: relax requiring a file signature for new files with zero length
Date: Mon, 19 Mar 2018 19:06:37 +0100
Message-Id: <20180319171836.133063513@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390639959423215?=
X-GMAIL-MSGID: =?utf-8?q?1595390639959423215?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -206,7 +206,8 @@ int ima_appraise_measurement(int func, s
 		if (opened & FILE_CREATED)
 			iint->flags |= IMA_NEW_FILE;
 		if ((iint->flags & IMA_NEW_FILE) &&
-		    !(iint->flags & IMA_DIGSIG_REQUIRED))
+		    (!(iint->flags & IMA_DIGSIG_REQUIRED) ||
+		     (inode->i_size == 0)))
 			status = INTEGRITY_PASS;
 		goto out;
 	}
