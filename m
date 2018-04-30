Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq+FSwXchwf9+p0x/3IqXUQGFDtEsR4id7MM0YC593CZUAx0Z88mnJUX5JLNZoBikDpSvR0
ARC-Seal: i=1; a=rsa-sha256; t=1525116529; cv=none;
        d=google.com; s=arc-20160816;
        b=zYdU8yUwDYCI3qU5UZzzs0g/KPC9SVKyE35rzUQdLn5vCmdKmFlUYQfDiKFxrI00kH
         t6IKuA8smhl95RVpa6Hzif43+5emyP39uG29fEuOb44l4Zbs1D+QQzMTLYhDU/NqYtxu
         4tvn1+5tkinCbN8UkB8SCEhJYt/Wx9hnihcFzwwaR5KSnElWlr87cGHrirm797yizhKi
         K//MSpJZ+XBHZvQcm8ESi+nIpbgIafltbv41hYsvVh2TvJqQ27mRxLpl0Y0lcKkJ19Sx
         A7w6CPEvxdyShyxSv9l1NeqaFachYPi0/kJ9a95MRlLQWaUf2fYxRoENdYGBAu77Tc7H
         NMrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=GBa6YydgA16L/OLwlWVbXfNIMS2CILd5f5SWjxepXqQ=;
        b=MNgg4JLfXrp1bGzzj3EKjXTrXI47ChgW4PAN8t4mPNjZU8RUG3jzOv2cFH2oiQlrL4
         UZz+60JgfG88CNm7Uu1OLYYGzZu+1ttb6SkKO8G2gTkeMD8bx3Ynop0bLpFj9ZiXU3p0
         Sd33sHtSe2oJKLJwi/H6p8GKgaBpPnsBB8iVFcjciy5yTPbkpkM8Fk8CXhjutPcj25vs
         shM9oo1fFSfJTpTFFu/RpeHhRtT621x16k6+P1qHnEXVzUeZtuzAZrWAxdnhveOSaO0U
         OFQisK3PZbB4IKyxuFk+WV3hTJw4/7RBOzF6iMbO14yIEl3t+5U81NvLvNVehM7tFuzz
         zzpw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 561C922DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Chris Wilson <chris@chris-wilson.co.uk>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Ian Pilcher <arequipeno@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.16 100/113] drm/i915/fbdev: Enable late fbdev initial configuration
Date: Mon, 30 Apr 2018 12:25:11 -0700
Message-Id: <20180430184019.440372868@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200590650011458?=
X-GMAIL-MSGID: =?utf-8?q?1599200590650011458?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: José Roberto de Souza <jose.souza@intel.com>

commit 0b551f1e0fc50ee4e3cde2dd639cb010dae5b997 upstream.

If the initial fbdev configuration (intel_fbdev_initial_config()) runs
and there still no sink connected it will cause
drm_fb_helper_initial_config() to return 0 as no error happened (but
internally the return is -EAGAIN).  Because no framebuffer was
allocated, when a sink is connected intel_fbdev_output_poll_changed()
will not execute drm_fb_helper_hotplug_event() that would trigger
another try to do the initial fbdev configuration.

So here allowing drm_fb_helper_hotplug_event() to be executed when there
is no framebuffer allocated and fbdev was not set up yet.

This issue also happens when a MST DP sink is connected since boot, as
the MST topology is discovered in parallel if
intel_fbdev_initial_config() is executed before the first sink MST is
discovered it will cause this same issue.

This is a follow-up patch of
https://patchwork.freedesktop.org/patch/196089/

Changes from v1:
- not creating a dump framebuffer anymore, instead just allowing
  drm_fb_helper_hotplug_event() to execute when fbdev is not setup yet.

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=104158
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=104425
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: stable@vger.kernel.org # v4.15+
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: José Roberto de Souza <jose.souza@intel.com>
Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: frederik <frederik.schwan@linux.com> # 4.15.17
Tested-by: Ian Pilcher <arequipeno@gmail.com>
Acked-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180418234158.9388-1-jose.souza@intel.com
(cherry picked from commit df9e6521749ab33cde306e8a4350b0ac7889220a)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_fbdev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/intel_fbdev.c
+++ b/drivers/gpu/drm/i915/intel_fbdev.c
@@ -801,7 +801,7 @@ void intel_fbdev_output_poll_changed(str
 		return;
 
 	intel_fbdev_sync(ifbdev);
-	if (ifbdev->vma)
+	if (ifbdev->vma || ifbdev->helper.deferred_setup)
 		drm_fb_helper_hotplug_event(&ifbdev->helper);
 }
 
