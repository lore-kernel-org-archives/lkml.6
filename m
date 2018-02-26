Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227Wj7nyJoIDmiOpxTGCw/KehQxm7+Zbqs46Mw2oCYMUnqHPVmdxFgwqEvUGiUE+1La68jHk
ARC-Seal: i=1; a=rsa-sha256; t=1519676531; cv=none;
        d=google.com; s=arc-20160816;
        b=BGoHirLj/Q4H3wAbnYlpC3CUjNJKpyIEOLVHtmDY+mHsQf6czESUoFxydxZPhnWsc6
         52tz+fd+AKGtapoB6TTQL5Hmuohp/vURBFMNuNBsH7fZfeYDZCuZfoOelVaS+fzqdbs1
         Ddf5kx/Tuw2x9wnTSyCunY/gIdpMPknhosdQzJMhQLBYk5U7Pa9uCGB75FXXRFmPw1as
         fK8RCDiicKa8wuw71Nvf29Gged/T67E7NEwJacBa1udX7WvXi0HBpIQ3urhLeip6DdzO
         0QpeMa2qdi8UxFzAULvP7kazAMut5WNmAI2Mh8nPfXwhmvdLCKKKSljroL/3/9NgayQW
         eH7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tvF/8jF88M9ij+1fDQWY3cP9znXrBcU0sZLmYlJzFoE=;
        b=nN2Q+Dsd+JOvpYhi1ewo49bD3KkKee/83OSPGGNe7QpyOOBCDx3S2LciwxJ0LiVl5+
         9m/KjmLzJC6xpLNU0yeYNBVbMG7y4Pm5nfynZ74Avb9t2z7CxiFRoPJ3TKgc0K7jXs+C
         eyouw72nk2As4t8qLGtSBbELLSHTpF2NYbMK+kWwMChg4sPdoQGpIXvh3Cv5jjj2g/DA
         XyLo0yxDOK3PJGSlMJrAg86zm646Z3gxEbMuYdoIDchdpuDI8GTdRhYYhQYi7mZWcjFi
         FQLi9X7D62jmnUU2oYbL5YaBCBB6buCclM9geR2oFocCCWAevCfWmoqfcizRSv+pUBm3
         o8NQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.9 25/39] drm/amdgpu: Avoid leaking PM domain on driver unbind (v2)
Date: Mon, 26 Feb 2018 21:20:46 +0100
Message-Id: <20180226201644.773192877@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
References: <20180226201643.660109883@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496025366379001?=
X-GMAIL-MSGID: =?utf-8?q?1593496338359185411?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit 458d876eb869d5a88b53074c6c271b8b9adc0f07 upstream.

We only support vga_switcheroo and runtime pm on PX/HG systems
so forcing runpm to 1 doesn't do anything useful anyway.

Only call vga_switcheroo_init_domain_pm_ops() for PX/HG so
that the cleanup path is correct as well.  This mirrors what
radeon does as well.

v2: rework the patch originally sent by Lukas (Alex)

Acked-by: Lukas Wunner <lukas@wunner.de>
Reported-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de> (v1)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1678,8 +1678,6 @@ int amdgpu_device_init(struct amdgpu_dev
 	 * ignore it */
 	vga_client_register(adev->pdev, adev, NULL, amdgpu_vga_set_decode);
 
-	if (amdgpu_runtime_pm == 1)
-		runtime = true;
 	if (amdgpu_device_is_px(ddev))
 		runtime = true;
 	vga_switcheroo_register_client(adev->pdev, &amdgpu_switcheroo_ops, runtime);
