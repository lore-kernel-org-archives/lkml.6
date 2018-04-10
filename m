Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx494rmdOakFIeqZ5jKcMCZl8/yqgivgG0ZgBcW3M3SLCRD9IsGnPH9kukFYTMjZRSYZ55E1V
ARC-Seal: i=1; a=rsa-sha256; t=1523399297; cv=none;
        d=google.com; s=arc-20160816;
        b=CyEPbOj3hTb4i+PfCd37yUpddqGNzBfsfeqBoiGP9Y2l5U/I6zRL/tAHRUO3QJmdWW
         nCD2XZ4a3TYAkoReCch/sTR7vOcuSA5zrvokQmgZPpoP9daCYUApW8NdEXHhJanHBK3i
         GFc1DkvBSgKB7nPyXrlsxS3uPKViz99zzyMYaAfj0DOlFE7zEK5FQwjbTTXvnHaudY/Q
         JooW44ofrCZkMkxqQsD+zkj43WsA3BtWgebDuj6TK+iaZPDzMJYB3qn9qWcl63I+cbaE
         lzNenMqoMM5CTIgTqCXgy6fLjP6gIAg68jcHuey/OL+DuKDO0DGklfsJKzXZvhMoPWo9
         F8Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XvviqZAl8ooJ2seRFemcPK2lc0WpeXofCgXkiSY5tNc=;
        b=sSTJfoTYs0CdDAR1zUCsmsKsUdBwb8Prtwb4b5ZfO/tbfgCKIR0sUGOkBeovRbRd+u
         wj0gq+hrE88elHisP8Wp5dSmNeN4Rh0h+r8eT7rkd5sMS8zWGH2HuZxT203cPGc1PBj8
         nqpwHhRTYNgG1A0jwiRCb6k+8TYV+SJq+Izb8liVGtwLFrpXBgf357fYE5CqHwe566B5
         2HFvKHcTdKaOT9OG3H4opp26o3NM8Z6E+ujZHRGD9hfQXJe6P2qljmkuKy71eelgUyIt
         fKQOzzbrhIO54o6AJsVRnXkoKOPC2BzZQi96bUj0rEybyFCX/VKsE0EehD+UnTH5lxJg
         GSug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Archit Taneja <architt@codeaurora.org>,
	Jordan Crouse <jcrouse@codeaurora.org>,
	Rob Clark <robdclark@gmail.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 036/168] drm/msm: Fix NULL deref in adreno_load_gpu
Date: Wed, 11 Apr 2018 00:22:58 +0200
Message-Id: <20180410212801.728309262@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399941861017772?=
X-GMAIL-MSGID: =?utf-8?q?1597399941861017772?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Archit Taneja <architt@codeaurora.org>


[ Upstream commit 9dcfbc182f1aac0aa5ea194733d21e67dd2ba1fd ]

The msm/kms driver should work even if there is no GPU device specified
in DT. Currently, we get a NULL dereference crash in adreno_load_gpu
since the driver assumes that priv->gpu_pdev is non-NULL.

Perform an additional check on priv->gpu_pdev before trying to retrieve
the msm_gpu pointer from it.

v2: Incorporate Jordan's comments:
- Simplify the check to share the same error message.
- Use dev_err_once() to avoid an error message every time we open the
  drm device fd.

Fixes: eec874ce5ff1 (drm/msm/adreno: load gpu at probe/bind time)

Signed-off-by: Archit Taneja <architt@codeaurora.org>
Acked-by: Jordan Crouse <jcrouse@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -125,11 +125,14 @@ struct msm_gpu *adreno_load_gpu(struct d
 {
 	struct msm_drm_private *priv = dev->dev_private;
 	struct platform_device *pdev = priv->gpu_pdev;
-	struct msm_gpu *gpu = platform_get_drvdata(priv->gpu_pdev);
+	struct msm_gpu *gpu = NULL;
 	int ret;
 
+	if (pdev)
+		gpu = platform_get_drvdata(pdev);
+
 	if (!gpu) {
-		dev_err(dev->dev, "no adreno device\n");
+		dev_err_once(dev->dev, "no GPU device was found\n");
 		return NULL;
 	}
 
