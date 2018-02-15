Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227lfbJmJ7sSHv/Xfj2mb7HsvA7TzfoPJ4zpmtn6tysitojD7P7C5L2Ch7h4CI6gA3s7h6eT
ARC-Seal: i=1; a=rsa-sha256; t=1518708444; cv=none;
        d=google.com; s=arc-20160816;
        b=qJTj7pZT2p19mToeosnom2jUxXSR8UKsv+X2g5I4ReZIA/1vG6DkALvUorL6ywMN6r
         8/i2LRLJEf4l0KJyTiNXJylKb2MCYmmcxYBWCqSKDYB3Qfmq0keayEEY40CPQ5D6T63C
         6jCnAD6hT/zVkk7KroEd5iEZB3dtifAhNs1+nt6LkcfGgQLaGXYx5Lb2bD1cf80Je9jy
         pa2JighffGI5KpNCqnfn4e9Z06Sa4SWpdUZYcu2di0tSTKmFLydsuBTQgq2L7rfCDoUT
         y13P0AqSSp1oCnjTbhRnPO3tMU4VN703WCt+LS7lVTq5XRErvytxnhw+DNwBZFoqLtB4
         thFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=j2kcIO/ClQFAkOnE38IFpHcHgFwh+VgiNWCaxAUlKsA=;
        b=szcBJpYC8QHlesQh7pEXEqxM948DQZSrWSlqpay+OnFZUxoOVhhjkHsj3biPqI59sn
         tjrr0DQrJnkZObgolgk5joGAFZNoN5Wy5ExhfE+uFuH/tgzyTp/E1WkGPV9vmEANbwSI
         kcK6DTfisdRkMrpA+/b8bHAU9fNMTDEgVHG61iGsBCGaL02EIJ76x1QO79gZy7FEmK+L
         P5Q4hZHk5yXFb8qizFXZP2OdFyoHqR7nRMwYIkPLn3szkEYBQ9syReMSN7kIdRz5zN06
         4WApbdAr1slZbafyJZQVjVuHx4Hj2IvSxVQ+QIJS1hzYNb1xrHVbkVdf1H2lvzic4gPo
         ewnw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Mentz <danielmentz@google.com>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.9 44/88] media: v4l2-compat-ioctl32: Copy v4l2_window->global_alpha
Date: Thu, 15 Feb 2018 16:17:11 +0100
Message-Id: <20180215151228.772097938@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481017399458749?=
X-GMAIL-MSGID: =?utf-8?q?1592481225611705596?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Mentz <danielmentz@google.com>

commit 025a26fa14f8fd55d50ab284a30c016a5be953d0 upstream.

Commit b2787845fb91 ("V4L/DVB (5289): Add support for video output
overlays.") added the field global_alpha to struct v4l2_window but did
not update the compat layer accordingly. This change adds global_alpha
to struct v4l2_window32 and copies the value for global_alpha back and
forth.

Signed-off-by: Daniel Mentz <danielmentz@google.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -45,6 +45,7 @@ struct v4l2_window32 {
 	compat_caddr_t		clips; /* actually struct v4l2_clip32 * */
 	__u32			clipcount;
 	compat_caddr_t		bitmap;
+	__u8                    global_alpha;
 };
 
 static int get_v4l2_window32(struct v4l2_window *kp, struct v4l2_window32 __user *up)
@@ -53,7 +54,8 @@ static int get_v4l2_window32(struct v4l2
 	    copy_from_user(&kp->w, &up->w, sizeof(up->w)) ||
 	    get_user(kp->field, &up->field) ||
 	    get_user(kp->chromakey, &up->chromakey) ||
-	    get_user(kp->clipcount, &up->clipcount))
+	    get_user(kp->clipcount, &up->clipcount) ||
+	    get_user(kp->global_alpha, &up->global_alpha))
 		return -EFAULT;
 	if (kp->clipcount > 2048)
 		return -EINVAL;
@@ -86,7 +88,8 @@ static int put_v4l2_window32(struct v4l2
 	if (copy_to_user(&up->w, &kp->w, sizeof(kp->w)) ||
 	    put_user(kp->field, &up->field) ||
 	    put_user(kp->chromakey, &up->chromakey) ||
-	    put_user(kp->clipcount, &up->clipcount))
+	    put_user(kp->clipcount, &up->clipcount) ||
+	    put_user(kp->global_alpha, &up->global_alpha))
 		return -EFAULT;
 	return 0;
 }
