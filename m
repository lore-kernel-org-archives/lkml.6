Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtvp3DPBRMZZrcOOHxNCAZMQsVbaNZtsKsEgsdxRTpMIQpdT5bZyILa9Pn6HTorgXHd697Z
ARC-Seal: i=1; a=rsa-sha256; t=1521214675; cv=none;
        d=google.com; s=arc-20160816;
        b=gyKODyCjcBXIRK51DsX3Q56N56Nz1dkxY6enBUS7eQJlOIjno1i8Rkpcuv/irA+cg/
         VsaQzJMPNX7/5cg4CTMWu8a8PmOUb/XpbnxN9DrO/zwQ3Jn1zM6l0LF5wEi4bk+022yA
         qKkawpF5y2Tk/aZesNIc9GsvGClz5cAhhAN6+0b/j+Z+Z9He1HNsj24e0qhha2iEieSt
         rrJOyVr9P9JHq2t4/NwQtgPmyzJvsXWRvSYWl3udR+d1CKILd24RL4KOgSzsrwCnRaeO
         gNYMDLkxk4AwbRJ9j6kaWqY4tqSMuyjFKMoQQeSEUYv+sw79vkKYP8kY8L5FigxL4Cfd
         mN4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rVCbdaT7mJwc4D6klXp95MFaCtuw3BsZgzlbbYGC6eo=;
        b=ZrXZ/YWql52Y2UZIiBJ5f8abT/2ARNqoYDB0EJe8HynWob6oDgCaWkBfkkinkD+GFN
         /y0tagyHXvXmy1STYsqGXcUrurJKAlBGrgu2u8Oq4zN5VZtwZX+OPLwRPSHGqpSNJ9TN
         6wlL7oONRuwHjxlzrkJjpxkWrV6SGYTh+eWpANCG/FyPQFVdRqZDy6C4J4U2OtItwNu1
         0bdlmPa3SM3c80sbY9q/sdjOG30NxvU838rjjoCsgJeDwijX3nZVU/THtSWhVGfjBM0+
         HxRKGL/qm6gs7pPz/AnLSLE4c8b4h7/W/yn6tMrbhSMQ3hE1hJzWKUTGUCLW3IWlQz1v
         yKhg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 085/109] media: vsp1: Prevent suspending and resuming DRM pipelines
Date: Fri, 16 Mar 2018 16:23:54 +0100
Message-Id: <20180316152334.555684549@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109199606669126?=
X-GMAIL-MSGID: =?utf-8?q?1595109199606669126?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>


[ Upstream commit a17d2d6cd9985ca09a9e384f1bc71d710f7e5203 ]

When used as part of a display pipeline, the VSP is stopped and
restarted explicitly by the DU from its suspend and resume handlers.
There is thus no need to stop or restart pipelines in the VSP suspend
and resume handlers, and doing so would cause the hardware to be
left in a misconfigured state.

Ensure that the VSP suspend and resume handlers do not affect DRM-based
pipelines.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/vsp1/vsp1_drv.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/drivers/media/platform/vsp1/vsp1_drv.c
+++ b/drivers/media/platform/vsp1/vsp1_drv.c
@@ -571,7 +571,13 @@ static int __maybe_unused vsp1_pm_suspen
 {
 	struct vsp1_device *vsp1 = dev_get_drvdata(dev);
 
-	vsp1_pipelines_suspend(vsp1);
+	/*
+	 * When used as part of a display pipeline, the VSP is stopped and
+	 * restarted explicitly by the DU.
+	 */
+	if (!vsp1->drm)
+		vsp1_pipelines_suspend(vsp1);
+
 	pm_runtime_force_suspend(vsp1->dev);
 
 	return 0;
@@ -582,7 +588,13 @@ static int __maybe_unused vsp1_pm_resume
 	struct vsp1_device *vsp1 = dev_get_drvdata(dev);
 
 	pm_runtime_force_resume(vsp1->dev);
-	vsp1_pipelines_resume(vsp1);
+
+	/*
+	 * When used as part of a display pipeline, the VSP is stopped and
+	 * restarted explicitly by the DU.
+	 */
+	if (!vsp1->drm)
+		vsp1_pipelines_resume(vsp1);
 
 	return 0;
 }
