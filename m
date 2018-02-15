Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226FyG9HrMrq1qhF9Y8YWHHLCVcDzRBucT7bXCEqUle544+bj7kon3qun77z7PvfZicJe7F/
ARC-Seal: i=1; a=rsa-sha256; t=1518707974; cv=none;
        d=google.com; s=arc-20160816;
        b=v8NqTuTk0HedTEDgoiuB7q+4i1DZBPyhZRnHiaUPeSBYSPw5kjLmyBkPOg93IOrq1q
         JWSkn/vfAkVAQjwoWYllaZHaZ+A6cLBim1UVSvZt410N9w6LAMVpoL1lZ6s1aQlYOt0D
         7qdsctBQ4U5V7pV6IhdkczoRDXEl7QiuL+nrvgkI9bGZFot2bgHZxJtxCCcjhlJHoBjz
         rnGUT8H3Qhl53YyMMrY2dCLSJj+nxIRYQdF5o5vSR3jMsuzY80qbWBs024Ln+3xrWcsQ
         L/tYMptVMRpe94ZZ8ZEnpcYiJqZt/msPJZyd+GqzlQc6Ho9bWh/Eb1VIUY5Fo/r25cAh
         tGFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BVMuVj7cDK9Z0uSQIWnix7Wp/58INNq/i+n109fwcrI=;
        b=wpqo2oCijVxRU9992rh27iQ1LlPKwN8NaSYmz+514Hddas4mJMZBBxw7uoyd7YdXU0
         jhMg9/y2nsIMB9EJPvw0wvu5bU/mUY1FVawQg/ZYfJtTyLQFMHWjkxylTnv+I+3UftIb
         yIkU+tHL31r7ImEHarAfsWTtM+yItCMqqDNGCr9gZDJQXxgnWtLXbA7P4pjv0PX+a7ed
         9lZeHaNMSZ6EXyXErW1DuuINaM3cAqQdRyiMuT/CKG/92EcV6rW6STshjQJ+DvBqJQ3x
         sVrQGumrt8xS2Wk9e9AtsavShk9wWuMNAMrWgefEgOF3XjBdvWDil/f7E44ejQytcowy
         4eew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Ivan Vecera <ivecera@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 3.18 30/45] kernfs: fix regression in kernfs_fop_write caused by wrong type
Date: Thu, 15 Feb 2018 16:17:21 +0100
Message-Id: <20180215144122.358790493@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480732716912474?=
X-GMAIL-MSGID: =?utf-8?q?1592480732716912474?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Vecera <ivecera@redhat.com>

commit ba87977a49913129962af8ac35b0e13e0fa4382d upstream.

Commit b7ce40cff0b9 ("kernfs: cache atomic_write_len in
kernfs_open_file") changes type of local variable 'len' from ssize_t
to size_t. This change caused that the *ppos value is updated also
when the previous write callback failed.

Mentioned snippet:
...
len = ops->write(...); <- return value can be negative
...
if (len > 0)           <- true here in this case
        *ppos += len;
...

Fixes: b7ce40cff0b9 ("kernfs: cache atomic_write_len in kernfs_open_file")
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/kernfs/file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -267,7 +267,7 @@ static ssize_t kernfs_fop_write(struct f
 {
 	struct kernfs_open_file *of = kernfs_of(file);
 	const struct kernfs_ops *ops;
-	size_t len;
+	ssize_t len;
 	char *buf;
 
 	if (of->atomic_write_len) {
