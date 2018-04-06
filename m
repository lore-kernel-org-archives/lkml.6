Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49oAxVmj4nYpLQAweB8iOCKhiSe22rN2UIlUNnozUSh/kTLVeb6pPMFujSybhSUb4W3l5n2
ARC-Seal: i=1; a=rsa-sha256; t=1523021257; cv=none;
        d=google.com; s=arc-20160816;
        b=vBqqkzD39T8fP9OhHeDCpoi495WZXHjCVGB4VlXWW3LsT4eICuRVC45T5ngekHKztw
         K1ziK8RTD9POzHLyJD3WoXVrsLjtSDLPguTCCIWZN/I4rld1Zk/D3cQ8mWbZtORzIhL/
         Wue6Y2/Qy+OWno+e2AizagnwOBjHVg8FQh14tpKxKWGJ1XvqiuH0A6I6izVYQwNc2FAc
         VTQroY4foh9oIHSgXAMWFzUr+M4jLvg6v+tEFLZ5R6bMrRf6uoxyYXbea5WGV8AliNB1
         Kmok0jgauLpN8/3hfuQ+b3sP2tu0drXuxBg7xwajlALGj7/Ntpgvu02aalhRhGpmgbvP
         mCAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/bc0Fn6bYuHi05LFfQ7cxvOOi4nsl2mVT5uQbHFJxac=;
        b=vPZpulkW8aBgwvcTatb/yMhseryr3CjMBQo3/J0EqOpOPKE6lhixQY3cCwRdhyU/Ia
         ExC0IpCJoUl2nDtvRSHlzKFgkkPVWJEn7EqNvDD6XgwXhzOQfMMxFvHnNR46+Q4rWR7U
         +0VTYK7oIkblf6nUyhzIHYStZnUczIer7AAuoUAdY2fOGXH04BrvPPs6albCBFdgck9A
         YBMYT9tdToJqAwxFIaS763ubuOuX/pP7aZlovONdhlQMoSsJio+hdm3Dz33rH5ezByq4
         3GxrZq1PvMo0UTdVL8cuJ+MovuYrXkONlgmLQxttCJrFkx4TU6FAIWY43TzmocnGS2UQ
         hvCQ==
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
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 65/93] media: v4l2-compat-ioctl32.c: make ctrl_is_pointer work for subdevs
Date: Fri,  6 Apr 2018 15:23:34 +0200
Message-Id: <20180406084227.802612553@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003538323948294?=
X-GMAIL-MSGID: =?utf-8?q?1597003538323948294?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -600,7 +600,7 @@ static inline bool ctrl_is_pointer(struc
 		return ctrl && ctrl->is_ptr;
 	}
 
-	if (!ops->vidioc_query_ext_ctrl)
+	if (!ops || !ops->vidioc_query_ext_ctrl)
 		return false;
 
 	return !ops->vidioc_query_ext_ctrl(file, fh, &qec) &&
