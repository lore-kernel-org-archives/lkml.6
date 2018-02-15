Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226m5BU0is2sb/5jDe7zIj9Wo5qMq0csMXd4mXOFhT/qCcdBnqWJfF4Jsn8n2mFL/7HD+K0K
ARC-Seal: i=1; a=rsa-sha256; t=1518709026; cv=none;
        d=google.com; s=arc-20160816;
        b=b1Y1FUz6/F+YacSmFKpzTj2/sKEKmBDLHSihzszJMypQ/+e8e5nlN8nsd7ptWgVBrP
         KB1Z8AOAR4MdUr5FnG27tg0fROr6VjGEkwsFCEjsodpWK77VxM/H/ZYuPXM42KS10Qz0
         s5Cbnizt3REBAfpQzU4fQVEhmatVLQ/DUnf1PJ+MRo3JqfyTYdl2sXtKQeGRj3xYiwl/
         SEP+bCz+rR8D5WoO4s5dfpKGLEFRNpIkyWwqPvsXxEr0QfbNJ5CrPCI69yaVH5M+MpkZ
         qsmtJA+ABEahniEOCb0h/NoGsHmpDRm8meEZhquxXygbd8a+DH/MWBKmk9TRMdybo96R
         I/7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6eynA7+GW07pPge6WmETiOxLqGXzmwJjMw6Ycd/naFU=;
        b=B8oOaHUB7bPeLbWyYOEZrfu1eczWwyFujeF7k0hGzgrOyULCyWjehIh9MLd43yhomG
         U/BUP1HUnTuRIinj6iOzYFS7Esk81/oJxPyujrjNF3R9p5qtQ5RIf9edCx0lCLOZWQhH
         emfphMPXv1aMnY4Yl4V/nd6AblgzfikaywxCRd6TjBAANVzrEmCjv2BSvGqhVZkKlgKZ
         jsD3genyBSVpk1lcDyjwMIBlX5TqMujnrhnPc8h85d6Ia5ianuUvC/GEvkbpfMV62Boe
         c4dLlZqmPmZdHC7BQyuI5NxzAzpWky+7gnmD9VAoeWIC80O4dDffdg986/a0eWE9XIMg
         pg0w==
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
Subject: [PATCH 4.14 130/195] media: v4l2-compat-ioctl32.c: dont copy back the result for certain errors
Date: Thu, 15 Feb 2018 16:17:01 +0100
Message-Id: <20180215151712.249453715@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481025461471591?=
X-GMAIL-MSGID: =?utf-8?q?1592481835498589676?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hans.verkuil@cisco.com>

commit d83a8243aaefe62ace433e4384a4f077bed86acb upstream.

Some ioctls need to copy back the result even if the ioctl returned
an error. However, don't do this for the error code -ENOTTY.
It makes no sense in that cases.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -968,6 +968,9 @@ static long do_video_ioctl(struct file *
 		set_fs(old_fs);
 	}
 
+	if (err == -ENOTTY)
+		return err;
+
 	/* Special case: even after an error we need to put the
 	   results back for these ioctls since the error_idx will
 	   contain information on which control failed. */
