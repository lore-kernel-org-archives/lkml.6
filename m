Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2271HZ4BVgBigiDOhJcHc2oWtAGQtcOJHGfiusFnXeQ3xK2/ZLKr20Y9A73OYPSYdqvsYCxx
ARC-Seal: i=1; a=rsa-sha256; t=1518708455; cv=none;
        d=google.com; s=arc-20160816;
        b=iQlZDL/6ORfo7cvlwdpGPe3USK6wPGOz3pzF6mEOrx/wAi+1Arc687BPcCX7QHGIvk
         J4kwzHwRW7pE9xUy94d20EFYtxPt99Sz2M1O/yOzeOPOwk2wRR4OXB2r+ga1b7A+v/CV
         2J3qh/oy7IWHrocZqISX4/3noJpWBC5cfZtWvi+b9Qe5QnAXIJ1/l4eklKxYqy55EpKW
         Mh+TAPMAwjPIUaWksFNGW18G8AbzNqk0ADAKeYQj6k0Gz/qM/bDRyXSoEmD0wzCEO/eK
         uKkFWHF7Xphc+3jVSoBSWmUSa2HUMC0AWmcf/rg+YV5VGtKoYL1AAEkuEJPMhqkAHBol
         NU4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FyqJSUz19M74BW6xSC1wvCTdbB4eW0nYjiX9CSnCKzo=;
        b=TgmocOQerX2DZpLP7zY1yKdHxCCWSFsHw/KDoBrFKSCPOkT9SufBLUzm8+Vj6PJYuG
         nPJX7MjFTniQYBDV/WpnxzV2dJTZyhcsU8qqF9YHOgeulaSc12cyed+newDWd7gSM+SA
         1d1zlPoyScmn9NeZqNPT9PT90l7Dc/KUV5XtA2ESh2cbqZ6vwTWFsEhw/5gexHnCcsI1
         5nirbHRPRz6Ta6JierY0exCp8uUbLXa6EI+2zmX2rdwfuEIhEDdL/+L7fS0fXfgnqCyy
         JEx8OR8MdnNp44oam+Nj3qjRMrEtmjqC+0OiyI0O4ZNlTAE6yWWJ88A157iuELS/ZyoR
         1rQg==
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
Subject: [PATCH 4.9 47/88] media: v4l2-compat-ioctl32.c: dont copy back the result for certain errors
Date: Thu, 15 Feb 2018 16:17:14 +0100
Message-Id: <20180215151229.215925423@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481025461471591?=
X-GMAIL-MSGID: =?utf-8?q?1592481236860003693?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -956,6 +956,9 @@ static long do_video_ioctl(struct file *
 		set_fs(old_fs);
 	}
 
+	if (err == -ENOTTY)
+		return err;
+
 	/* Special case: even after an error we need to put the
 	   results back for these ioctls since the error_idx will
 	   contain information on which control failed. */
