Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49O/VlHhvlfneXlvNN44gY5RA3L6odGX/wNWTNobm3KBkiLkml7jhtTvKHFztcV53m0mVcS
ARC-Seal: i=1; a=rsa-sha256; t=1523021278; cv=none;
        d=google.com; s=arc-20160816;
        b=O747htjEes1UpXIOgz7ExwsNo8gIlQZHCNUzHsnnEasLX+WG6RoIRRhTJrLKN5KhHP
         6olGv0kfLov6LPu+7dJRMTiDPWRbZyifStD9cZIKqif4an7e3epoInwJTLEx3i1vCaIo
         3JbkJXZM/oTUvHnXsABDUuobbltQJZ7uSG2CcF1E1cmrV5QtZ9NAVrK6nu2CIY9hKu0X
         UyytV1ytgGVZ0lWA4nMSn8osp+7tvrI3urGbhzHO9nCpBCv4Dp8a9huAy6D7W69w5vSv
         uOrpRVP3d3H/YxT5bd3f15puEsPsfglwc8+S2ZlUbVYA0vWW6j4Hm/1p4I+dgVSDeUxW
         wHpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Z90ApyRSTwN/XNGGP7bPpBpAUKbw0pHEfy0wP/PBIQ0=;
        b=o3y8oGX9fIBX/cmXlg5lfVLeKpJHxjS3f4Cl36xvMkE54hpdbz/zv3pB0XPhBkSmB2
         pn21DwuQCwlsDdumm4xMzl3ApiBTjtu7d6AAr8HJgjiXi2XWWNadWgykQJgiuvbLoUgi
         NtXNdk2MSYf007mWzfzXgTSbEo4vPe1qyfaVFJoEcWRkuhHSYCTnVUM4exCIIp+gd5HI
         VK/zsQFNpxyap2/3YElpAbFS5Xbew8ma6HmQePGQVcttoTjFtunLQZ9UWPbBRnJuniwX
         EYAxkyAZCsIFxsbcNjLNtDNQCqvZTtsUGtXaqgjHrZnd62w/yV3e3/E2TbRfk3aZWbXc
         TfwA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 3.18 72/93] media: media/v4l2-ctrls: volatiles should not generate CH_VALUE
Date: Fri,  6 Apr 2018 15:23:41 +0200
Message-Id: <20180406084228.210045845@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003560634497713?=
X-GMAIL-MSGID: =?utf-8?q?1597003560634497713?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ricardo Ribalda <ricardo.ribalda@gmail.com>

Volatile controls should not generate CH_VALUE events.

Set has_changed to false to prevent this happening.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-ctrls.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -1619,6 +1619,15 @@ static int cluster_changed(struct v4l2_c
 
 		if (ctrl == NULL)
 			continue;
+		/*
+		 * Set has_changed to false to avoid generating
+		 * the event V4L2_EVENT_CTRL_CH_VALUE
+		 */
+		if (ctrl->flags & V4L2_CTRL_FLAG_VOLATILE) {
+			ctrl->has_changed = false;
+			continue;
+		}
+
 		for (idx = 0; !ctrl_changed && idx < ctrl->elems; idx++)
 			ctrl_changed = !ctrl->type_ops->equal(ctrl, idx,
 				ctrl->p_cur, ctrl->p_new);
