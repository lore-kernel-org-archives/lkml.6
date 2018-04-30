Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpJwPkFypLOa7ZIMH4Ve7iiMUZHtPRrb5HZ6irGyUXktylYlLJv8H41qJFiriDkAcWF6oUz
ARC-Seal: i=1; a=rsa-sha256; t=1525116445; cv=none;
        d=google.com; s=arc-20160816;
        b=iJd6uXNQDoc28bP0ItW/ExhD/+yw8HftVYXsQsDCnp+bC9xhUFnBXSfpC7wea3kHvq
         lVA5ajABcaJwmbvh1MahQuOFniXhKjWZSRUPlCu3B4tfctS5OzSqQSxuspLhgsXLDvk2
         TVA88XswWLg5CJUzpnu2zy1kz4S1x1JpAcxJxSSNmuWQXbQZB8EMtyogzdkFkoGRNKbZ
         5d1HEzOE9ElH/zojsqNipHuZw1f7jMnOu31sd5IdfDEGymA1vlI3y7YWCv0/3D3PM+Gk
         eQd4E/duS/iRmVQqN46xe6sBB0kDaeepb5OuIMib5+9V2pkYnM8Jl4HizHn8gJxbDwOu
         gERw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=XER83H+ptP6lW8rK2aGVUJgpFesRNp4rVRLC973Ioqw=;
        b=Hv2w0CRKeGPfB/jd69P0DqnAlJbdKKShapdPzv4+zgIcrHE3jrchnB4x87KpkwyClV
         6zHR2RKd1C4jrL1TeTGjI+Mz2eYQyMcVxY2294hqfCe0AcI1gWVq/RmK0WKLFj8N7SID
         YTAGk44L9vTW4NzExzaLXk5FNmngacP4QWGkpnd3UAtiO+/Akxg1JqFN1EVGeZY1zUFV
         UVQF6OvOSzK2eQVaQIFoTuD30mT8vd+87p4jt9u3xq6VRJBkTFgVV1pSmvpIhbUHRWK1
         X8ZBkfGeEiaq70vsakB+fcAd20GNghiIlwOhX509Le+Hpd1vZTyE4B+1KtGWLVbcSdOt
         S0Lg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA9722DC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>,
	syzbot+209c0f67f99fec8eb14b@syzkaller.appspotmail.com,
	syzbot+7fb6d9525a4528104e05@syzkaller.appspotmail.com,
	syzbot+2e63711063e2d8f9ea27@syzkaller.appspotmail.com,
	syzbot+de73361ee4971b6e6f75@syzkaller.appspotmail.com
Subject: [PATCH 4.14 55/91] kobject: dont use WARN for registration failures
Date: Mon, 30 Apr 2018 12:24:37 -0700
Message-Id: <20180430184007.053623683@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200285796531709?=
X-GMAIL-MSGID: =?utf-8?q?1599200501268606343?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Vyukov <dvyukov@google.com>

commit 3e14c6abbfb5c94506edda9d8e2c145d79375798 upstream.

This WARNING proved to be noisy. The function still returns an error
and callers should handle it. That's how most of kernel code works.
Downgrade the WARNING to pr_err() and leave WARNINGs for kernel bugs.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Reported-by: syzbot+209c0f67f99fec8eb14b@syzkaller.appspotmail.com
Reported-by: syzbot+7fb6d9525a4528104e05@syzkaller.appspotmail.com
Reported-by: syzbot+2e63711063e2d8f9ea27@syzkaller.appspotmail.com
Reported-by: syzbot+de73361ee4971b6e6f75@syzkaller.appspotmail.com
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/kobject.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -234,14 +234,12 @@ static int kobject_add_internal(struct k
 
 		/* be noisy on error issues */
 		if (error == -EEXIST)
-			WARN(1, "%s failed for %s with "
-			     "-EEXIST, don't try to register things with "
-			     "the same name in the same directory.\n",
-			     __func__, kobject_name(kobj));
+			pr_err("%s failed for %s with -EEXIST, don't try to register things with the same name in the same directory.\n",
+			       __func__, kobject_name(kobj));
 		else
-			WARN(1, "%s failed for %s (error: %d parent: %s)\n",
-			     __func__, kobject_name(kobj), error,
-			     parent ? kobject_name(parent) : "'none'");
+			pr_err("%s failed for %s (error: %d parent: %s)\n",
+			       __func__, kobject_name(kobj), error,
+			       parent ? kobject_name(parent) : "'none'");
 	} else
 		kobj->state_in_sysfs = 1;
 
