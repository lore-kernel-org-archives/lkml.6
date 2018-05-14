Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrYNg+UWgL5ce/TpJcyRUz9+OqslTfunZyfFaGL0p7wet26cXWLyIwltL+Wzb8bhjGo2n4L
ARC-Seal: i=1; a=rsa-sha256; t=1526280988; cv=none;
        d=google.com; s=arc-20160816;
        b=YKKhuCusR0MJG/gcJHPWrdv6ngVUThxP3JG3JLrmw3SU0pJOtDgBk66ZhFkfizR9He
         sIxbVHCA7jwMu+hWMm3jR/w78hJj5JUL1qRbch3OqAxYzKVCOaRynLG8U/colW9+Q8sr
         LoDeTaFYWegs8nBvabaKr5ujAVPh96+e7/nw/jqiKVUqo7dDG+LPONFKJC5dmx4KP9Pg
         KtoNXEIfVaWtej/2EWVv8rZ2/EoCjTfLP2MDJQXkwo4M1zE/CNlSCijp65OrVpsCaxwn
         2j2E+NGnLN7n7R2QGqrQlJLA5wZt7UC7L7Wk9cWUSS3VAHPUZ9KujNKGlvKQgQrpYByg
         wzdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=O0PHVTkV0uOVBfBgoOj9EgNajFSH+biOiTqFcyrGXjY=;
        b=JC7Cvm8XtL6X7d9RdidW3AZSyZ+I0wuTzNGOsX6JwQfNTUx6XwYix/Vhi0dgq4QGR8
         5phHYAP2mXYvIa291pVmWHyBgmH1jYUsk8u+/HQ0Ju+jzyePOXe914omteY75tma4gDA
         0/Ddk+AvkDvrcWOpVv+169lNwiN7Mb6TNLeXOMKiO1wdmRYgrAl8r/S4eaRR0XcGZsGO
         J2TCHSvEacr3hjsrVsWCFuVl0T/Ttqh8uN3zG3uiee/9ZyIvuP8aP+duTfJhmOgLy0kd
         99DgWFY7LX+q/pvMsvYhjJkxtAEN6GLKt1qzVqcKgZz94w80pRB94wwZ1wZIQBW2k6KS
         FUIw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=2I0Bz3GM;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=2I0Bz3GM;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Florent Flament <contact@florentflament.com>,
	Pavel Petrovic <ppetrovic@acm.org>,
	"=?UTF-8?q?S=C3=A9rgio=20M . =20Basto?=" <sergio@serjux.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.14 38/62] drm/i915: Fix drm:intel_enable_lvds ERROR message in kernel log
Date: Mon, 14 May 2018 08:48:54 +0200
Message-Id: <20180514064818.486047503@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421473062509095?=
X-GMAIL-MSGID: =?utf-8?q?1600421612978795704?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florent Flament <contact@florentflament.com>

commit e8f48f96db7e482995743f461b3e8a5c1a102533 upstream.

Fix `[drm:intel_enable_lvds] *ERROR* timed out waiting for panel to
power on` in kernel log at boot time.

Toshiba Satellite Z930 laptops needs between 1 and 2 seconds to power
on its screen during Intel i915 DRM initialization. This currently
results in a `[drm:intel_enable_lvds] *ERROR* timed out waiting for
panel to power on` message appearing in the kernel log during boot
time and when stopping the machine.

This change increases the timeout of the `intel_enable_lvds` function
from 1 to 5 seconds, letting enough time for the Satellite 930 LCD
screen to power on, and suppressing the error message from the kernel
log.

This patch has been successfully tested on Linux 4.14 running on a
Toshiba Satellite Z930.

[vsyrjala: bump the timeout from 2 to 5 seconds to match the DP
 code and properly cover the max hw timeout of ~4 seconds, and
 drop the comment about the specific machine since this is not
 a particulary surprising issue, nor specific to that one machine]

Signed-off-by: Florent Flament <contact@florentflament.com>
Cc: stable@vger.kernel.org
Cc: Pavel Petrovic <ppetrovic@acm.org>
Cc: Sérgio M. Basto <sergio@serjux.com>
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=103414
References: https://bugzilla.kernel.org/show_bug.cgi?id=57591
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180419160700.19828-1-ville.syrjala@linux.intel.com
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
(cherry picked from commit 280b54ade5914d3b4abe4f0ebe083ddbd4603246)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_lvds.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/intel_lvds.c
+++ b/drivers/gpu/drm/i915/intel_lvds.c
@@ -317,7 +317,8 @@ static void intel_enable_lvds(struct int
 
 	I915_WRITE(PP_CONTROL(0), I915_READ(PP_CONTROL(0)) | PANEL_POWER_ON);
 	POSTING_READ(lvds_encoder->reg);
-	if (intel_wait_for_register(dev_priv, PP_STATUS(0), PP_ON, PP_ON, 1000))
+
+	if (intel_wait_for_register(dev_priv, PP_STATUS(0), PP_ON, PP_ON, 5000))
 		DRM_ERROR("timed out waiting for panel to power on\n");
 
 	intel_panel_enable_backlight(pipe_config, conn_state);
