Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49ESVU4IRM4fq7ni7vOPHHPELIVoToPJ+LT8iP64lpFCY7oExgMM6/nDViG9NAT3bSelpUG
ARC-Seal: i=1; a=rsa-sha256; t=1524405621; cv=none;
        d=google.com; s=arc-20160816;
        b=qVc73Sw4ymoUIPNv6tPN/bQ5cSRTqeUVFSYH9QoLchQFXKxgh9bwWIg/7ULgnaiWNI
         mYVwYXAuMvsb+7VkH8W0gm6qmKbqJtmAziJBUsli+FxAX4Dz8yf5ALeKzV/3bUPP9lye
         FcJC9isuZuFa97RQutCPeHAqTuWj9boYVlfdUXM8dNy7Gj6CK7RlNBbC8OmyqZdGwUid
         P9zGal8apBNSFxnzFxTgq4iTV7DuemnZbBrtXFaWgTS/MD4VkKshN7Sywrp/ChVi/7eB
         680AvpdtpLAVqLVMQdBacFRKorzO1d/YMxNkPpu3ZTYtlBjThbcBovQ7qqpmmNxn9myb
         hcUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=OpSrUTVIlpdZnAZ1mfTnJOwg4fu/lzJ4cbQl2wor3u4=;
        b=iwhkgc8Jihx0nicoKWfc4OoiWLZzDpJ1Ifq47k2fcWCPBN7S7J/noK0bUX1H/8twDJ
         Z6X22ZR7MlIXPs6P0BcOKnf0p/qThZwVYHzR1P/9AqkGBvmNji7MtK4QMell+HkrWQCq
         8P7kleeF4ODWFOk0UWYXFrEmkdEoxbDH0znwLgOQY3YGWkorbNQxjLSS8K1MHmQI9Y7w
         S4fAkdgFf3qY0tXyWNeEvavbuPugiXdM7HUE8fzBfwzLwX2UPC0lDVXfw6ksmB0l7+7x
         JAk/QAM+C4coxWT5sddsK8nbFRkNf6hSE0bWAvSCF7rSZQ9kxlxJe6EYQoiTquck1OF7
         9DFw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shirish S <shirish.s@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>,
	Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 4.16 134/196] Revert "drm/amd/display: fix dereferencing possible ERR_PTR()"
Date: Sun, 22 Apr 2018 15:52:34 +0200
Message-Id: <20180422135111.181299980@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455149112892248?=
X-GMAIL-MSGID: =?utf-8?q?1598455149112892248?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harry Wentland <harry.wentland@amd.com>

commit 1bc8ffbd71380661c5bc9cd65649bb0cf3d0cf09 upstream.

This reverts commit cd2d6c92a8e39d7e50a5af9fcc67d07e6a89e91d.

Cc: Shirish S <shirish.s@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Michel Dänzer <michel.daenzer@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4792,9 +4792,6 @@ static int dm_atomic_check_plane_state_f
 			return -EDEADLK;
 
 		crtc_state = drm_atomic_get_crtc_state(plane_state->state, crtc);
-		if (IS_ERR(crtc_state))
-			return PTR_ERR(crtc_state);
-
 		if (crtc->primary == plane && crtc_state->active) {
 			if (!plane_state->fb)
 				return -EINVAL;
