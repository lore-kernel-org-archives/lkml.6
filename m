Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/VwR5xdkPwPAGeOLuz4JPc6CdSjfFCynIIj8mN4emEU6hSozEUPfnznhaLcO+J7KHAPaFz
ARC-Seal: i=1; a=rsa-sha256; t=1524406922; cv=none;
        d=google.com; s=arc-20160816;
        b=QKULIDCxgZK9EsE+s7udzB7FKI8DbctofA84x1wxj0KyyL14xjZolqFDxNZC5RyIlY
         sx3QNwSL3TPErXzw6pj1sY+wkE4ZiQlHnXFVexZ0cvsU8F61rdNABqNTHGFYTOkOs683
         q/uTnz1YCkkdxE7+CENzHE+oCiHLyAPij/BvK3RdUAT5jRX3ZWH0mBkq1tSQ2LviOrlF
         3mG+X3VC7A82blkw48E06oK3jC+Qk8IP2SMw3uUwBkOJWTDGztFk6GZ6IdaMyFIMXEzH
         dkoq1XTqwnk3n5vEGwnuoVCB0DPQOyQf0c0h6VxMTvYSkRNrUnbYvUNsJVN9HHWhZ96p
         DmGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GKLbf7CsfiNtXrXbXXo3u+4T+jlrdo4RQWiFxPWf7qw=;
        b=OPePNuiBHpiEVWZT0sgca7f+6vx4F315ZhnxUbP5gYcgPVOm7dUOBksL7TjEBtezux
         Qy431T5hX6c4Cw6EJj37Xf0byOBVEF00G0FzR8mk540VAnldgUOBp3HqOHlFAgC9FfFF
         latyKoOEiBLFUrv/E7jNwqIHc99tqCG5X3JAMyeMzGghiA+1b48nO9rgjBF4X4WhyW0T
         oEUWanaTCrW/+mVmkfMSDNtlOfgo/ES5Y5ILaEmAj4g9FE/1hXMzCcHsAinLi4sSmE4z
         pfAmdMaxBijadcfc3qat8cekkTJOpbPtO9R/hoWIvekOuprFyWzrZ4lA7hUlHDnXk/2O
         7PmQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 3.18 52/52] fanotify: fix logic of events on child
Date: Sun, 22 Apr 2018 15:54:25 +0200
Message-Id: <20180422135317.721399577@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455284731037282?=
X-GMAIL-MSGID: =?utf-8?q?1598456512546188948?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

commit 54a307ba8d3cd00a3902337ffaae28f436eeb1a4 upstream.

When event on child inodes are sent to the parent inode mark and
parent inode mark was not marked with FAN_EVENT_ON_CHILD, the event
will not be delivered to the listener process. However, if the same
process also has a mount mark, the event to the parent inode will be
delivered regadless of the mount mark mask.

This behavior is incorrect in the case where the mount mark mask does
not contain the specific event type. For example, the process adds
a mark on a directory with mask FAN_MODIFY (without FAN_EVENT_ON_CHILD)
and a mount mark with mask FAN_CLOSE_NOWRITE (without FAN_ONDIR).

A modify event on a file inside that directory (and inside that mount)
should not create a FAN_MODIFY event, because neither of the marks
requested to get that event on the file.

Fixes: 1968f5eed54c ("fanotify: use both marks when possible")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
[natechancellor: Fix small conflict due to lack of 3cd5eca8d7a2f]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/notify/fanotify/fanotify.c |   34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -92,7 +92,7 @@ static bool fanotify_should_send_event(s
 				       u32 event_mask,
 				       void *data, int data_type)
 {
-	__u32 marks_mask, marks_ignored_mask;
+	__u32 marks_mask = 0, marks_ignored_mask = 0;
 	struct path *path = data;
 
 	pr_debug("%s: inode_mark=%p vfsmnt_mark=%p mask=%x data=%p"
@@ -108,24 +108,20 @@ static bool fanotify_should_send_event(s
 	    !S_ISDIR(path->dentry->d_inode->i_mode))
 		return false;
 
-	if (inode_mark && vfsmnt_mark) {
-		marks_mask = (vfsmnt_mark->mask | inode_mark->mask);
-		marks_ignored_mask = (vfsmnt_mark->ignored_mask | inode_mark->ignored_mask);
-	} else if (inode_mark) {
-		/*
-		 * if the event is for a child and this inode doesn't care about
-		 * events on the child, don't send it!
-		 */
-		if ((event_mask & FS_EVENT_ON_CHILD) &&
-		    !(inode_mark->mask & FS_EVENT_ON_CHILD))
-			return false;
-		marks_mask = inode_mark->mask;
-		marks_ignored_mask = inode_mark->ignored_mask;
-	} else if (vfsmnt_mark) {
-		marks_mask = vfsmnt_mark->mask;
-		marks_ignored_mask = vfsmnt_mark->ignored_mask;
-	} else {
-		BUG();
+	/*
+	 * if the event is for a child and this inode doesn't care about
+	 * events on the child, don't send it!
+	 */
+	if (inode_mark &&
+	    (!(event_mask & FS_EVENT_ON_CHILD) ||
+	     (inode_mark->mask & FS_EVENT_ON_CHILD))) {
+		marks_mask |= inode_mark->mask;
+		marks_ignored_mask |= inode_mark->ignored_mask;
+	}
+
+	if (vfsmnt_mark) {
+		marks_mask |= vfsmnt_mark->mask;
+		marks_ignored_mask |= vfsmnt_mark->ignored_mask;
 	}
 
 	if (S_ISDIR(path->dentry->d_inode->i_mode) &&
