Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49T3Zu6+40WgLIWoiH+xgwDN04N4qZbZOqAsI3dPZfMbQE7KiKJPkvqA2kXOXOUCAXtIJnQ
ARC-Seal: i=1; a=rsa-sha256; t=1523021235; cv=none;
        d=google.com; s=arc-20160816;
        b=kqnKidSbqizpfmRT5XOLCTstvcYmZp3JAWwrkAer9mCFln6+YH/qv2+zk6YNO6m3sn
         ApMU6N/iAwFZLUoon1g/04pZl3vd4jPbR0rflmT3sJBQ9uIcg55ExUIw97Ta65bTx3zr
         RMOtBhsaBQUXEItl/qXhJFx9tfbtElcDu9kliItnRyg3k29FC+EUGWhF4f1rU8LRCSu9
         Mao2OziKIsg9onEW6RKubaqRpxKsTDkv1pbUbLdIKqfuIk3TzRvuEblXEFTWxn/xH7Uy
         eyKntxfNnoO4hhQQdteyRiKKtKIGQDia7OEf9G0WN4enCaKoR8FyMmPlUeS0pIqJbG6o
         /HhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=D8ikRJ1lubtn/xHV90esGX8bCRmB1ooxLSzK3Qk2TPI=;
        b=TWb8HIxbD3cdtotb6g66XjZxHdOR9IEZE6SbG1DQRimIZnG6THLectfBmkDRZuIlUy
         5BPAl57WntrX5lveoANCvaf9eP5nWDskBlN+S6jqoSmmUt5vKBD3wYLOKg5jd8c3tAFd
         9TZnvC0Huh6A2qrB27pePymzgQrMxlcDxYCtzs9Em3Fq/mYSP9NSK1fAsn+lD6IoEv0W
         Q9GfamA7tu8QmJtHURJcXgobHpw1Ov2Ye2Zm4BXyN49a6bBgyN7OxvJ8XYHPr4DTkHCH
         g4mI6Mo9AMD+BDFcakaMIw6RBAiOERMfyKDV1STTinDbcFHg3sDjmkL51qkicvL1iTu5
         RfNg==
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
Subject: [PATCH 3.18 57/93] media: v4l2-ioctl.c: dont copy back the result for -ENOTTY
Date: Fri,  6 Apr 2018 15:23:26 +0200
Message-Id: <20180406084227.391689297@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003515036096994?=
X-GMAIL-MSGID: =?utf-8?q?1597003515036096994?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hans.verkuil@cisco.com>

commit 181a4a2d5a0a7b43cab08a70710d727e7764ccdd upstream.

If the ioctl returned -ENOTTY, then don't bother copying
back the result as there is no point.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: <stable@vger.kernel.org>      # for v4.15 and up
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/v4l2-core/v4l2-ioctl.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -2539,8 +2539,11 @@ video_usercopy(struct file *file, unsign
 
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
