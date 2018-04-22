Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48alRzNjd4ENoYljy4zhN8g4dHHbDQu2QYKXq11q2fFKef+OPh+NUPCCBNg/N2WGYD0ZM8O
ARC-Seal: i=1; a=rsa-sha256; t=1524405751; cv=none;
        d=google.com; s=arc-20160816;
        b=msgEJNy+TSlenJVuVRtEVRCGDLkwvdFvASBTqoYPm9bXQUXH2BSniaPZDRkT4wyVm1
         1It17so32UeYojXcyeQiSmQcRB2kXajIM8EiFGn4pxS3O/HXhOa1TnE2qVwuCwNj//Xf
         hIX3/39AVGvMx2BfwMwZpeoBTNndACftr/ixGnZnX5afGVQ4d37zaqt0y7/n6T/gcvtr
         Wd6xuMz6smTUeRhUXzdP0jnk/y+04VoLHq6IxjJ+/ytlTXzieo15yICiEpDIo8iUdd7x
         hjbLYEslKojcbqiDy8oyNsS4uMGfIKFZuf/JjSqJlgVVKK0AYMvXGjq1cUCDTAJpAafK
         DxBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9z0Fb46gAYhk4lq7HLnCyIT1qGAEILVQP2frDk/noIg=;
        b=hoeIcqxWo6g5CTa4BBfyT4PYs+USM+q6zjdSfnmV5I1iFKEFg0MUuA2Fosja0qFIgN
         wtZNPcpCEXIXx2QFHnLH5WSDFytIq4HeoEQ2WEMu2s+sZqpd3WP0cUeEmCsYcCbp34pm
         RPoW214GPnrspIqkohQa1j/vwz8vHRqy8o4MdDNV3qBSgCK18LtnDV863m0ckxQvl/FI
         I4HIEXvVl7w3rfpMBICgbVdqUh/Lt8e5ZEd+IuPSEBaIyUoInx9Fuu+uFy80JlqKTkc8
         N6kIpLdNoGvljQWgfoMglUaRXFHgxCLGdYTm2fnylyjh6ncLAh3RFdmliysf2CouQMc+
         t4Ng==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 4.16 181/196] fanotify: fix logic of events on child
Date: Sun, 22 Apr 2018 15:53:21 +0200
Message-Id: <20180422135113.619785651@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455284731037282?=
X-GMAIL-MSGID: =?utf-8?q?1598455284731037282?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/notify/fanotify/fanotify.c |   34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -92,7 +92,7 @@ static bool fanotify_should_send_event(s
 				       u32 event_mask,
 				       const void *data, int data_type)
 {
-	__u32 marks_mask, marks_ignored_mask;
+	__u32 marks_mask = 0, marks_ignored_mask = 0;
 	const struct path *path = data;
 
 	pr_debug("%s: inode_mark=%p vfsmnt_mark=%p mask=%x data=%p"
@@ -108,24 +108,20 @@ static bool fanotify_should_send_event(s
 	    !d_can_lookup(path->dentry))
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
 
 	if (d_is_dir(path->dentry) &&
