Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225Wryx49M11DqbW6QhBEUxopkdXqtC7nDV5WsN0otIgIMqsIEZdDaEeip0VPr/dDDfLkOLt
ARC-Seal: i=1; a=rsa-sha256; t=1518709435; cv=none;
        d=google.com; s=arc-20160816;
        b=rhQLWZGngjEIQyuk0pGPFa9Bwq0gSyMxwlY+m3KyWGjUJ1nyc1iI6ACqiDE3uLvmV+
         36KsFNS8qJwfvFJSMbYt1m8Gkzb4MGf/Os4Xtge0q3siFD+2avKAz1SKS8M/AVDe5JFA
         eBN91dzWap8ugHjJkYqMPYKMSUQ3CfyAH/CBwQ4L4ude5jEeyQvvWXM1ZhWuEwT2+D46
         AzIegrfixwXl+LwmBeWzZz23AK95lUG2ImssMGHrWOY90lVPbJal+XMRyXA67TygbN/W
         cmGBh8CIVOVbAv2lpeWtpa1IIK6UR6yVdnl7/iK8ZojIjRAYNu18jdbQr8S1Bf3C6Q3U
         I0eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mLuk1jLHYk9R6RDG7CJzUgtuA2Vy6VNVwgMrYPc0BoA=;
        b=ofxPc9E7xq9UlROJtfOiTJAr96jt2kHOt9+ok2kmBlSh7ADIgTbwIEpj+K7li89i5c
         9TwcG7X1WeL2NwaLeRU5U9070py2dgCXgWZCr5Eon14PEEv7nOUPMPEzXhIbfgFjOZxP
         OIKGg6ljjSCwJThgg+ZODepqtGcl6z7JNSTxxgP+4YgE9/w3HvoW4SX/dDm778T7by4G
         7retmURHkf+RW6wcd56r29InAJlsS5a7iNYIQLgrtF9HNal219AnT+xxnhMJxvts4/M9
         KSTqV3lWMY1kvt6VKOSdOOHvaTUXZdJe3/fAkojYBfgYj8+fZU6FEf/DGD005g8kga4p
         9dYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.15 115/202] media: v4l2-ioctl.c: dont copy back the result for -ENOTTY
Date: Thu, 15 Feb 2018 16:16:55 +0100
Message-Id: <20180215151719.260712503@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480999261182610?=
X-GMAIL-MSGID: =?utf-8?q?1592482264413263593?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hans.verkuil@cisco.com>

commit 181a4a2d5a0a7b43cab08a70710d727e7764ccdd upstream.

If the ioctl returned -ENOTTY, then don't bother copying
back the result as there is no point.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/v4l2-core/v4l2-ioctl.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -2895,8 +2895,11 @@ video_usercopy(struct file *file, unsign
 
 	/* Handles IOCTL */
 	err = func(file, cmd, parg);
-	if (err == -ENOIOCTLCMD)
+	if (err == -ENOTTY || err == -ENOIOCTLCMD) {
 		err = -ENOTTY;
+		goto out;
+	}
+
 	if (err == 0) {
 		if (cmd == VIDIOC_DQBUF)
 			trace_v4l2_dqbuf(video_devdata(file)->minor, parg);
