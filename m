Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226+d74YvTqPWqJiwdvitxVCwaXUtRMW7OEvE8yhFCUWSMNzoiVdTQwbVZ1rrGUxq0UVjWTt
ARC-Seal: i=1; a=rsa-sha256; t=1518708436; cv=none;
        d=google.com; s=arc-20160816;
        b=YhIZNfOHlGsiU+cATNMSLF8A1G4w0GFf0pHUC9UvOT/dCZm8FCPR81r63Gpn4f76D4
         zm27q6tx5bKf/1lJqlM2pDallPH/iemFMk665ca2cLV6kICJl8N+mbYe7LD+aYWzIO8Q
         3u3mOQ0/1V5rAVb3oz2hfNQz7jWDeaTWjlgR8qlPKLmaC4fq8ijYtt+zJznB64uZ8OeO
         mKM9lKxp+jKTMI2zv4XIDgOCYbGblQOi0a3lmmzq6WCnVbz0jfmZVkzwrg9N+xN70gij
         q0jeXiUcyMLquAInnV1j8aj6MyPbKgWxmbrscuUj4RP90hP05dl+dz06frqjsXSm5mMc
         i+Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QfJNVU3aH9jNu01d4sajTJKz5JTAGHVFnT2dKuvlcx4=;
        b=uSq85f4fLd2dVsCaY2BUHQt2SQGxEEJdVXtzZS0quvGEhr6iaBTRBGRJaRmQAYYOzB
         kvrCmHTmaem/oL02Sgfem/pdf2WH0mZD91EpytIVC44TXVTTe1qV0bvmkOhHjvkOqCCx
         rrTCOTMV+PEBeZiHOPWWHpAMF7ZM/OG7Hia8y4ytGaLIIphCWsqFBjJQWd2LfNAkgHRP
         XNxz3gLjC3kmUNR1MF+cWnbEM8dAYNVgHjwOKSs2Oyp43PMuB0AG44w9xr3Zmu+9KyXO
         zSAuyqYVu5wDPj9+Rv75YdROSxDV0C6Z3GTKAUo3RB5QuvTUOuNwatQYhX86puIDodnF
         eeUg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.9 41/88] media: v4l2-compat-ioctl32.c: copy m.userptr in put_v4l2_plane32
Date: Thu, 15 Feb 2018 16:17:08 +0100
Message-Id: <20180215151228.360767410@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481006379737208?=
X-GMAIL-MSGID: =?utf-8?q?1592481217290072444?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hans.verkuil@cisco.com>

commit 8ed5a59dcb47a6f76034ee760b36e089f3e82529 upstream.

The struct v4l2_plane32 should set m.userptr as well. The same
happens in v4l2_buffer32 and v4l2-compliance tests for this.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |   47 +++++++++++++++-----------
 1 file changed, 28 insertions(+), 19 deletions(-)

--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -299,19 +299,24 @@ static int get_v4l2_plane32(struct v4l2_
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
@@ -320,22 +325,32 @@ static int get_v4l2_plane32(struct v4l2_
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
@@ -395,6 +410,7 @@ static int get_v4l2_buffer32(struct v4l2
 	} else {
 		switch (kp->memory) {
 		case V4L2_MEMORY_MMAP:
+		case V4L2_MEMORY_OVERLAY:
 			if (get_user(kp->m.offset, &up->m.offset))
 				return -EFAULT;
 			break;
@@ -408,10 +424,6 @@ static int get_v4l2_buffer32(struct v4l2
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
@@ -468,6 +480,7 @@ static int put_v4l2_buffer32(struct v4l2
 	} else {
 		switch (kp->memory) {
 		case V4L2_MEMORY_MMAP:
+		case V4L2_MEMORY_OVERLAY:
 			if (put_user(kp->m.offset, &up->m.offset))
 				return -EFAULT;
 			break;
@@ -475,10 +488,6 @@ static int put_v4l2_buffer32(struct v4l2
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
