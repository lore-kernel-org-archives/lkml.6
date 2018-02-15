Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226LaM4RGchfaZL0gg1nZpP9wUV/1GqumMhRak7Ef8A7DxxZMCoF/jkZdVEZeCmLUYhL7vHu
ARC-Seal: i=1; a=rsa-sha256; t=1518708441; cv=none;
        d=google.com; s=arc-20160816;
        b=NEmngml0RUrW7gMlH/SpN1UklWD8x/f17Ziaou4vuD7BdiiwsspE0Zy1hCbRU6aSRC
         ehDMXbRuR+WLliq/0mJ7qHEHQ0/tB8ddPdDRmjCKENw2iaftSz/GhGIU+TU0/U+QnjRt
         3qmWQPZPtZHzOIpJQRhm//X9j+6xyAQtlqVUqz7Wy+hc+S/yXWNZe6SsDrK3OMMONrMB
         PEEQFShsX2CzZDsWfO+N04Gm68h9p8urYLuwAokktFwAo859GhmIITYBr2/R5SQC5ZRD
         5UzijOigM2F+38foCQhcTLtX9mvacdCZo1a1sZGtr4LIpPI7s0wF2tXDFunhHEI5t/9y
         lWlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0HHNFo26CAWe2nXCLnjrxdpdBWiCAljOuKFLYaYnh50=;
        b=HqsZf+3bfZrzABJq/Slr8d4stnwY0I4WKEUDnrCXEG8WveDH38YPp2mHqPd7yiAIky
         h57V7MsHm7YaqRtKaKDzyfNw/hSDOvMraqCXT7XxvRB0cZeg/zm/mTZnIg2w4ESuNzVF
         z43yG/zoWXE0GEF1ZnCjqHVZWLBxNPpL9AjvXMwOdDnYu6j6QneK8N5OL9A+UVSGrcHP
         l2aOui2F4NI0cRjv4YLK5IzR3qhVSM/IXxIZ3P9IlT2kLFTA5RzlOYOTeamZF67SoWyI
         VrX3LuF7/rqKpVJvWcHy43W9H5Mys54hnPSDSkXxMYBl6T5AbvAjVBVQoYnHgzn5IjrT
         8xPQ==
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
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.9 43/88] media: v4l2-compat-ioctl32.c: make ctrl_is_pointer work for subdevs
Date: Thu, 15 Feb 2018 16:17:10 +0100
Message-Id: <20180215151228.632424300@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481014708077345?=
X-GMAIL-MSGID: =?utf-8?q?1592481222402203045?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hansverk@cisco.com>

commit 273caa260035c03d89ad63d72d8cd3d9e5c5e3f1 upstream.

If the device is of type VFL_TYPE_SUBDEV then vdev->ioctl_ops
is NULL so the 'if (!ops->vidioc_query_ext_ctrl)' check would crash.
Add a test for !ops to the condition.

All sub-devices that have controls will use the control framework,
so they do not have an equivalent to ops->vidioc_query_ext_ctrl.
Returning false if ops is NULL is the correct thing to do here.

Fixes: b8c601e8af ("v4l2-compat-ioctl32.c: fix ctrl_is_pointer")

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -612,7 +612,7 @@ static inline bool ctrl_is_pointer(struc
 		return ctrl && ctrl->is_ptr;
 	}
 
-	if (!ops->vidioc_query_ext_ctrl)
+	if (!ops || !ops->vidioc_query_ext_ctrl)
 		return false;
 
 	return !ops->vidioc_query_ext_ctrl(file, fh, &qec) &&
