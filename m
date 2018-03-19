Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsaVYtIhvQwDI3pk6r/CEUo1CF4exXBHDoAZ0GwVwojVdnysgdfXFCkYrSCjt689UXx3I51
ARC-Seal: i=1; a=rsa-sha256; t=1521484006; cv=none;
        d=google.com; s=arc-20160816;
        b=PZWPOD/nwwVx/ygstYDhAocGhLdvIg7aclNKBBrQECOTpwlhpKAUF67mUC4KXFJD0w
         EDUKdQnzRjKSTgVX6EjHy+rXpXpn4tUzgtbYmkrdro+kDtCms9xz00e54gRSBBH6iF50
         K//3Ix5i8slEvyUPHKsy5nwsjuee4AoEw13JOKZi0/gkZ1mdzQe8dCRSuQ/+3fNImX/7
         PnZqQisW2GiCm5Yu2HqkZrpkJ7Ug/y5MfWZTQLSwh4k+n8mDl5aWuNgS3E0wUSBUmVeQ
         5J3kpWyfr6gqO9NGYCuerSHBnM1ULdeF7OQrM96U7S+ESbwspfcWXEQpV/dWlMbcpxzd
         V0WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KieoKMRiuYZpUA1GyeO0a9LLOxyNhm7DlCFHFNLJ8kY=;
        b=WwzrG88syS883M2LRoJfcPkNHl2TkA0vVryDSEisJr89DY5puyPlOicCvZKT3ZcPcT
         GOtFdKvZGr5U8PKZa5BqBXZDMOgpNpV/SNUSR25zJ4wXGYHJzpfiYoqAXFQvuKNStYTA
         tIz3NsQQBQUYChthx7VDMAufYNsORw7AmUrm+Ysx4+oXd9Yu8SKHQKmvoy0IyKo33xIf
         E1mSepQOFfWoK3wiVryJKAGKIr0wCdI6Wc1eUydR4tKgRnRkGEtAoEW79vBeHsF681QM
         lF0ifOX/iKRXRQ3vhJu1PlxJ5KbQVFeXr0Kw8DDfp4jhMdbC4nU++XauOutSm0Ul1vBZ
         L1Ew==
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
Subject: [PATCH 4.9 197/241] media: vsp1: Prevent suspending and resuming DRM pipelines
Date: Mon, 19 Mar 2018 19:07:42 +0100
Message-Id: <20180319180759.347810101@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391613778820847?=
X-GMAIL-MSGID: =?utf-8?q?1595391613778820847?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -509,7 +509,13 @@ static int __maybe_unused vsp1_pm_suspen
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
@@ -520,7 +526,13 @@ static int __maybe_unused vsp1_pm_resume
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
