Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225hjerqrsoYvVVMrMkmz7C9wXtPlzQureoxykaugXVuHmfL8NEEyntgzwfFMQBRujHr9/jj
ARC-Seal: i=1; a=rsa-sha256; t=1518708418; cv=none;
        d=google.com; s=arc-20160816;
        b=Zdz8sxT4Hq/NcKO76TEe3A1SKqcghcKcgMRlEWlRInlKA/FYxQ3oLlY1qDt4//Xa/5
         zF88O64QfDAmT892e9kQKSUawRGROFWcauDGjdKvE/2MfpEr0fIA+amCjmNygS1V1Iby
         5dhQkGk38XqxBO4Df+kanDsAylgeznSJw/b20fw8Q3HD7am/3od3fFEQIqPlLnbfQt4c
         cL8QCM0lQd9cWG6RLyK+wVCMzcvWoqzubn6dvBAMcl7X71/49T5aC7p4uO42TqC8SkiQ
         9la3ikkqwp1RH8QNJE41Nvkawo4jUyqJ4usbttwHZvwVyrEtRYVO7+gv+6wulTXeisr0
         ngjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2kxJ5i9/lILeAI3l5Qn7fndk92einA4kQAfWKy4Uqiw=;
        b=pqZp9wb3ELLNRPoM8GAhcIT+re5MyMDTANs/8SiVXMZ6Gs028MBC1aaNFWREnWnjvO
         OIG9g4f+Bc5DfevG0Y1Vhv1naUYiiZZWRl6j4p+e0eNDBdc2kkJW9ZKiSiYgY+SmYVaq
         SwjJL5XQrqR+zq7Eyz1OJ+8MtIlWyvdi4k+J+nO8takq/A2wcofBgVy0WA4/7oh4uN3A
         w/mlcNPWcGFmQRd7/TqpsO9LAZDA96ZcQRSNXhC/cz0OFBfEJwrN26Mx70N4ZbLn6l/x
         f6XR451Dj/fnoFBObXZ3pgE9r5B747bKvAhA1skZbzh8RJYm1PAePi3QlbAhNp65bDEQ
         QXWw==
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
Subject: [PATCH 4.9 36/88] media: v4l2-ioctl.c: dont copy back the result for -ENOTTY
Date: Thu, 15 Feb 2018 16:17:03 +0100
Message-Id: <20180215151227.636335678@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480999261182610?=
X-GMAIL-MSGID: =?utf-8?q?1592481198504630943?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2862,8 +2862,11 @@ video_usercopy(struct file *file, unsign
 
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
