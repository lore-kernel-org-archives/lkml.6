Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp0rQZwQvvaIvB01lb/QdNMs8cnQc0nMHgLghvx1cXpm1vsk7ss7hEKxcbEveZPfUCAu3Ir
ARC-Seal: i=1; a=rsa-sha256; t=1526281173; cv=none;
        d=google.com; s=arc-20160816;
        b=RwnY7zZ9qhuvWMiO3WstJZEoYZtlKwSLjcnJ9eVY7Ex1M2bKPNq2XzVkwM/UjuZCHu
         8uDqeQp4Pq6Ys7gc0Dbn2ubs544udyfPF5Bv7e9yJy1KTOlu1L6m7Q8b8nU46hgSKLYu
         bLM/dx5LoelFCNkXonbyZ8HHW/PBxZflviOuc+Kv+Xw4H2Vc6VcjQrWISOy7MCOboY+R
         1QWkZ9Qvl9B4iszBQ28PpEe2N8rW1O9FUqdv3au6934kFEZHIZexfKIdjBShMd2gG8/l
         bF8OgHCtuotN4PQb9R9wTSJ89iino6/ScNXG/UvXSmPVznNhN1BTwcYYIpqqBYMgnkRx
         mcCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=VY8pJK5vr0nAUL29q+Tz/0QURYzCd4VSOy1+w4xZlkE=;
        b=ewpS6oBI2zVF9d7OyDhX6PIong+BuECen+ueI5d5sn+r7ADtAhMsfFfoL6XRiqmKiJ
         7oscxmk+66QKHOsKXuIqfeQ/VlE8loxH+P5sLhffUbrt6XWf+NA1WW1Eq+9gO1gsQz1Z
         1cTlrEL3CR6IBzis3tcJXRgauFRahbQDr6dAwfrjZuk0fvZiozZhnTNbLOpVNb0pw1dq
         /ueXdbJJ3Sdwv6Z0onm7lMU7HJ+Ak5oxiw8JrCxBjctMpx+LxwsaIx+WDlOZKe9fKHrJ
         Um/Qd81xd9eS7nPtdYK0RTi+NdrnXbnWL+Z/TSbCbDHnugJkcycRLeLeyBs3i3fFVJKt
         a8Bg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=iO+eYfGs;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=iO+eYfGs;
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
Subject: [PATCH 4.16 44/72] drm/i915: Fix drm:intel_enable_lvds ERROR message in kernel log
Date: Mon, 14 May 2018 08:49:01 +0200
Message-Id: <20180514064825.067647117@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421473062509095?=
X-GMAIL-MSGID: =?utf-8?q?1600421807593063047?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -319,7 +319,8 @@ static void intel_enable_lvds(struct int
 
 	I915_WRITE(PP_CONTROL(0), I915_READ(PP_CONTROL(0)) | PANEL_POWER_ON);
 	POSTING_READ(lvds_encoder->reg);
-	if (intel_wait_for_register(dev_priv, PP_STATUS(0), PP_ON, PP_ON, 1000))
+
+	if (intel_wait_for_register(dev_priv, PP_STATUS(0), PP_ON, PP_ON, 5000))
 		DRM_ERROR("timed out waiting for panel to power on\n");
 
 	intel_panel_enable_backlight(pipe_config, conn_state);
