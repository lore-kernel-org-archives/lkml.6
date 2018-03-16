Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsLJhH0RPXig/OHFtuaZd9wPGn1SAV31zuXyukJ+0jQkdYYn7PRUoDhdQGp55BHhrquY6TY
ARC-Seal: i=1; a=rsa-sha256; t=1521214991; cv=none;
        d=google.com; s=arc-20160816;
        b=l0omHJkcmRC0cCduLHg7lWnBP5FeyCOaM0hWRy97ynyHliWnsZ1xML7yvm+UIcQqSi
         VwOBVDCZ7JIfu/EnwA4gjjHVVI04I4GFqvdBngZ014z/F6pbi+nupdhLRBhhgjPwnMoe
         BvNvt2VUywIF25rNylwZ2S1JxtwStci9VfDwL0kNF4NcdqIprl/nRHEfRi9yLnoPAXE1
         HEOHgwan3b61IsWuhnhFgc4uQ1RpAMcCT3Nq8auBWtASTqzem539VdfBVABbpDvFV29R
         Vhi+8psVdPM9UZy02BVGfQxEGPhmiBB4aEedq5Wjor0dThaYOo83An7idQJNre+09d/p
         17Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pSOcPYGdQoUSBSHRMDdsNigXq2EewgXieMyMkhBq49w=;
        b=GhmsCkHMlWRztMeZKFzTYymhJQfIOiDKrT1OHGA8ukgh8/ozU2OGMX3TzwrJVYJIWB
         Uo3l0H9sMLUdtvWaT3IPLEYI2eP6/pdT8nkYTK5snVK8ThpXKjcB6M4zzgns5R7/FzhK
         UamDw6cf42p/WB7mya4HT5rJV8FFtT4zAmq4cxMMvfy/au5Sa1aSqJ+gxDVXZe6mb0OZ
         /VR4uz7ooqE9OU/NTPt5YYQ78jFnUd8V6G+PiCfJyGBkgEJj2ie85pFXu2GHllb7mRlr
         CmBHRAKSFfooh7t1+bjXbZIGLzaHhWgj4S/2SbiYHuVCgwTPz84bryWbaF21v6qtC4Q+
         3FIQ==
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
Subject: [PATCH 4.15 090/128] drm/amdgpu:fix virtual dce bug
Date: Fri, 16 Mar 2018 16:23:51 +0100
Message-Id: <20180316152341.043174508@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109153792103743?=
X-GMAIL-MSGID: =?utf-8?q?1595109531084155011?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
