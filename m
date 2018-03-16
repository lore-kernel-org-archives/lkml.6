Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsKB6k7/khQd2h3t9SB/l7GdC3DKskb1W7ScNLw8lurvSLEt3+G1JyI2VaJTt4JfAOn5Fcp
ARC-Seal: i=1; a=rsa-sha256; t=1521214631; cv=none;
        d=google.com; s=arc-20160816;
        b=YmwzqMYyy2E5M5BaTUoXD5henxDbdO2RQKSJPHRJL7jzScBg3GGCjnOfo4EuqvZR17
         76BCMD/YKfmrktramtPoTkgJksAwMqBmp5KSBAl4dE9OVkckzE5VlM/puLgKjIBuoXsp
         SlsYSxLY1RfIfs1xGmNCX6TaWTHj7/Meg2LhtXo/E2Evq7z/bg9z/cUFsomU3+h8JdYw
         j9CtkwNzSiEr7xQ/Zj+gMBF1f9lc+TJ4v+j6jRml/fH5fqHlUEzvkdTWJ+eueYJVyHlz
         6vcZY1pXZ6APbR6JiZq8e5dBIgj3W3/z0eYfXeqhgQNRftH4DRtzjCVaBZNKOLH18QYn
         8hzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xi/QLXe2HxqEO6XxAEOVjOJj4hp9y1ilB7s2PaqOJ+0=;
        b=lD5WB4xhIxz2fAzw6DDM3VRJ5ULgCNCf20w6KQ0wdLgqW2XZX9kVytfZAuES6JcZpJ
         8V5/cyGsc+94BZnjKtbKZOjOTwFJNvFfnQIakLLvN8IXwOmmUDVSd5Gm73Dge210RpTk
         mwroY2mU7kJTcayY5ld5vPdbQ3JYXDE4kc2KzoHuYjdC5+ihwIus5DqzW3f3ylqS+bAe
         FIK5E0WHCiZtUEyGYNMlirb13fae/FshGkUoFkL2HAY8ntCltzg9WVqZEvlP/vXSdU5r
         xXZMUKbvSeF6kvGxqZXayi1Rr/0H6/YArY2HCUygKScCWxVcWAj691AptWsrlkC4CAW1
         7JEw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Monk Liu <Monk.Liu@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 075/109] drm/amdgpu:fix virtual dce bug
Date: Fri, 16 Mar 2018 16:23:44 +0100
Message-Id: <20180316152334.052644249@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109153792103743?=
X-GMAIL-MSGID: =?utf-8?q?1595109153792103743?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Monk Liu <Monk.Liu@amd.com>


[ Upstream commit 129d65c18ecfb249aceb540c31fdaf79bd5a11ff ]

this fix the issue that access memory after freed
after driver unloaded.

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -437,6 +437,8 @@ static int dce_virtual_sw_fini(void *han
 	drm_kms_helper_poll_fini(adev->ddev);
 
 	drm_mode_config_cleanup(adev->ddev);
+	/* clear crtcs pointer to avoid dce irq finish routine access freed data */
+	memset(adev->mode_info.crtcs, 0, sizeof(adev->mode_info.crtcs[0]) * AMDGPU_MAX_CRTCS);
 	adev->mode_info.mode_config_initialized = false;
 	return 0;
 }
@@ -723,7 +725,7 @@ static void dce_virtual_set_crtc_vblank_
 							int crtc,
 							enum amdgpu_interrupt_state state)
 {
-	if (crtc >= adev->mode_info.num_crtc) {
+	if (crtc >= adev->mode_info.num_crtc || !adev->mode_info.crtcs[crtc]) {
 		DRM_DEBUG("invalid crtc %d\n", crtc);
 		return;
 	}
