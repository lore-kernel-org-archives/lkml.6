Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2245V2BjczXKOaxF8FcYPDTSFbdhSAynm0iJy6HYwxscA/oDxD/pJ5weXxNhH+Zffb0TbRfb
ARC-Seal: i=1; a=rsa-sha256; t=1518708447; cv=none;
        d=google.com; s=arc-20160816;
        b=wWV8WRbkcu+hOMotK8RkBcM+qvxlT8GZ7StmA/mF/TXw2uvTODsbp2Is4qVgRWBuy+
         7k9CXL1blMn5wzx+sltyUCiusM9onHlPYFEos1Qi+kH+1DWtXLySDIsXECyPEfRpCFpb
         8yN+wI41pgC9ocYxqzyiA6OJWq8iuYtz5qUL5pnlDsyRkpgtg90TN4n1y+VpG46+VXPq
         xrjpgYW28cys4r/YZqV/HtwWRd3DjDLfZ3+himlWICOKrOuE05yJNZVTopyAHzusU7zl
         OYFOUlcG8n8xbE4vxvzFqEWbiTyAW3nHysBQB+6b/boU7RW/dFOc7W3HiO1LArq7EC4l
         9XSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4emsvIZ2LVSqtDh3vB0TU0VLqoub3VroqaGioososHU=;
        b=pfEpz7OHPfBXVwPwwbWz6Cq3HjY/DZdr9m9k7m+fAS4aER9HW7FsbxSFmZ2/FzEz0s
         3o1SMo/ZjJc2Qn5+GXTB7kM6/jMLTJGPW63b/w9JU7hqwtNB0jnG16vlDf4480Qa2k6w
         /HCq81SQydWj6G0ydtox9A1kQzYNOcrW8lIArVjBVH4s0piRgKkqtUJpvUoeT8oEqHNe
         faJVaJ8bk7Pq1XUyLHcapfdHYbzk2FKsWGlKA8oYHVM8jCON8TIymBj+kDwN9HR6BE/O
         HSoXmL3r5d4l0dPdoN0W3HUy9l+BBkAKfnJeUauxDJJZJiKVpQehDO/q/Z41/ZjqO4JN
         r3uQ==
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
Subject: [PATCH 4.9 45/88] media: v4l2-compat-ioctl32.c: copy clip list in put_v4l2_window32
Date: Thu, 15 Feb 2018 16:17:12 +0100
Message-Id: <20180215151228.913241826@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481020362499482?=
X-GMAIL-MSGID: =?utf-8?q?1592481229195711347?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hans.verkuil@cisco.com>

commit a751be5b142ef6bcbbb96d9899516f4d9c8d0ef4 upstream.

put_v4l2_window32() didn't copy back the clip list to userspace.
Drivers can update the clip rectangles, so this should be done.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |   59 +++++++++++++++++---------
 1 file changed, 40 insertions(+), 19 deletions(-)

--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -50,6 +50,11 @@ struct v4l2_window32 {
 
 static int get_v4l2_window32(struct v4l2_window *kp, struct v4l2_window32 __user *up)
 {
+	struct v4l2_clip32 __user *uclips;
+	struct v4l2_clip __user *kclips;
+	compat_caddr_t p;
+	u32 n;
+
 	if (!access_ok(VERIFY_READ, up, sizeof(*up)) ||
 	    copy_from_user(&kp->w, &up->w, sizeof(up->w)) ||
 	    get_user(kp->field, &up->field) ||
@@ -59,38 +64,54 @@ static int get_v4l2_window32(struct v4l2
 		return -EFAULT;
 	if (kp->clipcount > 2048)
 		return -EINVAL;
-	if (kp->clipcount) {
-		struct v4l2_clip32 __user *uclips;
-		struct v4l2_clip __user *kclips;
-		int n = kp->clipcount;
-		compat_caddr_t p;
+	if (!kp->clipcount) {
+		kp->clips = NULL;
+		return 0;
+	}
 
-		if (get_user(p, &up->clips))
+	n = kp->clipcount;
+	if (get_user(p, &up->clips))
+		return -EFAULT;
+	uclips = compat_ptr(p);
+	kclips = compat_alloc_user_space(n * sizeof(*kclips));
+	kp->clips = kclips;
+	while (n--) {
+		if (copy_in_user(&kclips->c, &uclips->c, sizeof(uclips->c)))
 			return -EFAULT;
-		uclips = compat_ptr(p);
-		kclips = compat_alloc_user_space(n * sizeof(*kclips));
-		kp->clips = kclips;
-		while (--n >= 0) {
-			if (copy_in_user(&kclips->c, &uclips->c, sizeof(uclips->c)))
-				return -EFAULT;
-			if (put_user(n ? kclips + 1 : NULL, &kclips->next))
-				return -EFAULT;
-			uclips += 1;
-			kclips += 1;
-		}
-	} else
-		kp->clips = NULL;
+		if (put_user(n ? kclips + 1 : NULL, &kclips->next))
+			return -EFAULT;
+		uclips++;
+		kclips++;
+	}
 	return 0;
 }
 
 static int put_v4l2_window32(struct v4l2_window *kp, struct v4l2_window32 __user *up)
 {
+	struct v4l2_clip __user *kclips = kp->clips;
+	struct v4l2_clip32 __user *uclips;
+	u32 n = kp->clipcount;
+	compat_caddr_t p;
+
 	if (copy_to_user(&up->w, &kp->w, sizeof(kp->w)) ||
 	    put_user(kp->field, &up->field) ||
 	    put_user(kp->chromakey, &up->chromakey) ||
 	    put_user(kp->clipcount, &up->clipcount) ||
 	    put_user(kp->global_alpha, &up->global_alpha))
 		return -EFAULT;
+
+	if (!kp->clipcount)
+		return 0;
+
+	if (get_user(p, &up->clips))
+		return -EFAULT;
+	uclips = compat_ptr(p);
+	while (n--) {
+		if (copy_in_user(&uclips->c, &kclips->c, sizeof(uclips->c)))
+			return -EFAULT;
+		uclips++;
+		kclips++;
+	}
 	return 0;
 }
 
