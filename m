Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48XTdRZq4syZEdlJhf4THRwXpScDFHnhD1heDktJju4rJn5XXtZas3fz/6/8bHZDxgVl3S7
ARC-Seal: i=1; a=rsa-sha256; t=1523021252; cv=none;
        d=google.com; s=arc-20160816;
        b=EKXSCWaGQ+AjYKepsbZxl45oRpuSDr7JKdekfQOgKLIQeRHXhtijHQf08JDvz3KSFu
         io5kSkSh2AaB2fYh7MLgTDm1hE4gYIHURdlT97gK63BCpBOHjKaBDFMcCugzKHNtxDgX
         zJp2N85UndTHxxyDcFK2fdFzb28aQf8JADYWPINak/9ANHJSwg74S5QYuj4C3zNkET3q
         qGIn9PlLdZ2F0zSoXMoxo7F1VcBG+1t5Lv3t3zqvDL2u0VsI8LDmMli8w66vN9M5KjgZ
         9QJHrcOFLP6vd0PMPSCByCta+FIJFMHLeKWEScSaDI3GxmmJOMoGkeXSbUvm7ctxea3Q
         DHhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=03Nq9UcJTbphqTQAistVhGb39he+KC6nKt2NJokdfoo=;
        b=qdPPXtynAtRGb2yBIUzIeQdJ/Z4NEVF7Lvl8BDmrcg5+BE4RCldWrsTkb5is/bOfl6
         hOoevdubHKslVdMH1JQsAoHWVV9vbtfcW+VJoX42WMsqJOyi/M35NzKwin6eD8p0Wev4
         69+ImJZGFP7W7E5DjF91r9Lyumt2VKg9jP1KiXyC2bW5fblFXMlVT9tOLJiNx1bRtrnl
         /Sr5RDD63AttMsEAJA+IhY3V6Pxy8TnVEHboX3WOU7oLLvs1qwfCtH7RwQV8F46HYoNB
         ipeMwSKGc75eONr7SWXbgfrawlZzDJXqyVq1nCd42+Eb5F2KrIE0TyQ7n6+N639RVvwT
         7hmw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 63/93] media: v4l2-compat-ioctl32.c: copy m.userptr in put_v4l2_plane32
Date: Fri,  6 Apr 2018 15:23:32 +0200
Message-Id: <20180406084227.687803957@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003532008046130?=
X-GMAIL-MSGID: =?utf-8?q?1597003532008046130?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hans.verkuil@cisco.com>

commit 8ed5a59dcb47a6f76034ee760b36e089f3e82529 upstream.

The struct v4l2_plane32 should set m.userptr as well. The same
happens in v4l2_buffer32 and v4l2-compliance tests for this.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |   47 +++++++++++++++-----------
 1 file changed, 28 insertions(+), 19 deletions(-)

--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -287,19 +287,24 @@ static int get_v4l2_plane32(struct v4l2_
 			 sizeof(up->data_offset)))
 		return -EFAULT;
 
-	if (memory == V4L2_MEMORY_USERPTR) {
+	switch (memory) {
+	case V4L2_MEMORY_MMAP:
+	case V4L2_MEMORY_OVERLAY:
+		if (copy_in_user(&up->m.mem_offset, &up32->m.mem_offset,
+				 sizeof(up32->m.mem_offset)))
+			return -EFAULT;
+		break;
+	case V4L2_MEMORY_USERPTR:
 		if (get_user(p, &up32->m.userptr))
 			return -EFAULT;
 		up_pln = compat_ptr(p);
 		if (put_user((unsigned long)up_pln, &up->m.userptr))
 			return -EFAULT;
-	} else if (memory == V4L2_MEMORY_DMABUF) {
+		break;
+	case V4L2_MEMORY_DMABUF:
 		if (copy_in_user(&up->m.fd, &up32->m.fd, sizeof(up32->m.fd)))
 			return -EFAULT;
-	} else {
-		if (copy_in_user(&up->m.mem_offset, &up32->m.mem_offset,
-				 sizeof(up32->m.mem_offset)))
-			return -EFAULT;
+		break;
 	}
 
 	return 0;
@@ -308,22 +313,32 @@ static int get_v4l2_plane32(struct v4l2_
 static int put_v4l2_plane32(struct v4l2_plane __user *up, struct v4l2_plane32 __user *up32,
 			    enum v4l2_memory memory)
 {
+	unsigned long p;
+
 	if (copy_in_user(up32, up, 2 * sizeof(__u32)) ||
 	    copy_in_user(&up32->data_offset, &up->data_offset,
 			 sizeof(up->data_offset)))
 		return -EFAULT;
 
-	/* For MMAP, driver might've set up the offset, so copy it back.
-	 * USERPTR stays the same (was userspace-provided), so no copying. */
-	if (memory == V4L2_MEMORY_MMAP)
+	switch (memory) {
+	case V4L2_MEMORY_MMAP:
+	case V4L2_MEMORY_OVERLAY:
 		if (copy_in_user(&up32->m.mem_offset, &up->m.mem_offset,
 				 sizeof(up->m.mem_offset)))
 			return -EFAULT;
-	/* For DMABUF, driver might've set up the fd, so copy it back. */
-	if (memory == V4L2_MEMORY_DMABUF)
+		break;
+	case V4L2_MEMORY_USERPTR:
+		if (get_user(p, &up->m.userptr) ||
+		    put_user((compat_ulong_t)ptr_to_compat((__force void *)p),
+			     &up32->m.userptr))
+			return -EFAULT;
+		break;
+	case V4L2_MEMORY_DMABUF:
 		if (copy_in_user(&up32->m.fd, &up->m.fd,
 				 sizeof(up->m.fd)))
 			return -EFAULT;
+		break;
+	}
 
 	return 0;
 }
@@ -383,6 +398,7 @@ static int get_v4l2_buffer32(struct v4l2
 	} else {
 		switch (kp->memory) {
 		case V4L2_MEMORY_MMAP:
+		case V4L2_MEMORY_OVERLAY:
 			if (get_user(kp->m.offset, &up->m.offset))
 				return -EFAULT;
 			break;
@@ -396,10 +412,6 @@ static int get_v4l2_buffer32(struct v4l2
 				kp->m.userptr = (unsigned long)compat_ptr(tmp);
 			}
 			break;
-		case V4L2_MEMORY_OVERLAY:
-			if (get_user(kp->m.offset, &up->m.offset))
-				return -EFAULT;
-			break;
 		case V4L2_MEMORY_DMABUF:
 			if (get_user(kp->m.fd, &up->m.fd))
 				return -EFAULT;
@@ -456,6 +468,7 @@ static int put_v4l2_buffer32(struct v4l2
 	} else {
 		switch (kp->memory) {
 		case V4L2_MEMORY_MMAP:
+		case V4L2_MEMORY_OVERLAY:
 			if (put_user(kp->m.offset, &up->m.offset))
 				return -EFAULT;
 			break;
@@ -463,10 +476,6 @@ static int put_v4l2_buffer32(struct v4l2
 			if (put_user(kp->m.userptr, &up->m.userptr))
 				return -EFAULT;
 			break;
-		case V4L2_MEMORY_OVERLAY:
-			if (put_user(kp->m.offset, &up->m.offset))
-				return -EFAULT;
-			break;
 		case V4L2_MEMORY_DMABUF:
 			if (put_user(kp->m.fd, &up->m.fd))
 				return -EFAULT;
