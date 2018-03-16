Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsg3Y7EJTL/LkP+cE/YA2DxjeHgzetJDTyRGO+44R/dF6rP3ENdZpe6V3rj6g6LNtHc+8z5
ARC-Seal: i=1; a=rsa-sha256; t=1521215034; cv=none;
        d=google.com; s=arc-20160816;
        b=sEY4VCceRPorSBszI9juyv8w81RpoA0zECupyusyMbU+a/EeoyVfCGF7QoyDK2i5Kk
         gxrMkvkZ47CfZSCWgGookTh144Qit1YsJ4+XEYra+ELrAAwW9nvU3YZUNyE7CsdxFAr/
         NEq5xC8zwhFVa/xlYcM4xgaklo7IlimaG1cdkTv+ZfiuUveGW3m9EWWNda61rq8oppfL
         eZ2uTgN7oBAj4LIZrxVBAsklx2HSenOlB/Gq3VxAOK8QZaNf2BQ+dqwVXhfxEAnlate8
         o5en5bZbwr4s1DNm/5MnlcG5HWer/JXSDke+HMJKEKzoaPS2bteANrWiUKLDDmBty+5/
         nkkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Lm1ug2R0m/eyylzn0aGpA7oRW6d5UeOxqWKdc7lyJvo=;
        b=Y3RjScgld0kggMVQ6Npao87sq4m5kfwoOY2klhtVNC6cXXZU/6F83U/VdjOdj++6wC
         q8CIDVaHlTFlD9SS20B86gywlEdXaHEGTfGDa2x7Rylm5dIQNRI7DEPEitpS7vGy7do+
         6HssHy6lsjGuOjblDd4i7y3bMmXSHuh3ccF2Z7EIcWWlkCGm2a5aKD8BWv2Z/UrnW3CX
         n773QF4two4QZM2CZmb+ADwf174+sMIcF97nXkAlWvkx8QO0unVVt6c8pe6T/lMEQB46
         PvH5HwlHGtBO2ESZyPdf1xerW/RngeVhqTsBKUdCc/HZ0Xz5onqMyCxA3Pljp0iQmJuB
         n9tg==
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
Subject: [PATCH 4.15 104/128] media: vsp1: Prevent suspending and resuming DRM pipelines
Date: Fri, 16 Mar 2018 16:24:05 +0100
Message-Id: <20180316152341.730235720@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109199606669126?=
X-GMAIL-MSGID: =?utf-8?q?1595109575831213419?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
