Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225x/sQPKIbeHnALRn1WkHGZbDZR8xhTOl6xJCIFOJGRFLKaEyKYZwzoECh+d1FWd4SqbV8v
ARC-Seal: i=1; a=rsa-sha256; t=1518708932; cv=none;
        d=google.com; s=arc-20160816;
        b=sTbB5uSRxwsUINA48JYdG5kGjx4dtraiQRuRQdOhVslWvkCEoKTTOfn7Alh8s02Kh3
         4zs/CiGjVTin8C+7jmE0zqdcUmTBuC54QXTQ3MDrpZcGbaRPD0M3kKSjStn0+80MlCCX
         WFs2S27kh4KubxniWylDPBIJe5bb5QW2Auddk8g11e/NrLCfQg8Y39+7d5/LKevJyuWh
         R6u370q0UGD9B+6HeMAEB4mP+y8GEV2H5WZt3he0DxvPOuOdBXYcEt5+yv/axMdqJioP
         JV/ePgLvcgdSUPq0rs5CwSR5C7PXwhnwDQqGbLMob9vF+vwyHBo2EURORNvZ007CodTA
         asvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yiM4eXOvSTkDAA9YC7x4dO3wNeI0MYDu1qCWpLtBfUI=;
        b=LA/h7KUXETD0hDwOcUuqUvYC5oAmL46iJ2viJAwYFAIQS2KsCbfP6Nor0qiHcjWACp
         ENibGMQk06PY0wSFH8KdQSsmiDaK39q9/1a6EmEqBnXzRkCUFAQ8eVx/7VHgekqOsfkt
         D96SdQbRAxwbTnRCtM2f8syhuMO3psNxCLEAD+zGn9yon+Q1brfhLkqHhU2M4xhMaMFV
         hVIkyDSmFv7bJxoOYj3kQwyzIzH4UnClXIFldsTJgJB/gklKWSjsYWFjV9wJp7a12R5N
         AAPHlB01/7pqRu08nG9bhD8yUgu+lc47VEY2/Qam0hbZDF0jDcTzHlTH3jA6iVpDJsRY
         EbBQ==
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
Subject: [PATCH 4.14 132/195] media: v4l2-compat-ioctl32.c: make ctrl_is_pointer work for subdevs
Date: Thu, 15 Feb 2018 16:17:03 +0100
Message-Id: <20180215151712.365601797@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481014708077345?=
X-GMAIL-MSGID: =?utf-8?q?1592481737357236780?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -770,7 +770,7 @@ static inline bool ctrl_is_pointer(struc
 		return ctrl && ctrl->is_ptr;
 	}
 
-	if (!ops->vidioc_query_ext_ctrl)
+	if (!ops || !ops->vidioc_query_ext_ctrl)
 		return false;
 
 	return !ops->vidioc_query_ext_ctrl(file, fh, &qec) &&
