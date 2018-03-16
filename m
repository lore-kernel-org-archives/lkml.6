Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsq/MlqRdbevHk6zwTWB5L+PIuhleqOw34fLNVb4RZvPRFTyf22WERkjJjT7mo1f9HIWjpE
ARC-Seal: i=1; a=rsa-sha256; t=1521214200; cv=none;
        d=google.com; s=arc-20160816;
        b=0XSxp2R9C1UQWv2Wg7J1gv0upgWk/5LNQ+mPoF6hp/wmM+ShyrSkdZDoIZGyDjhTR3
         YuVZul1IuBK9h7EHHi6gw5bMM5M9Lo/EdZDoPDuNJpuuR7CaaoyqPa1amf8KqI/bhXbG
         7qFwFXYPiYI6YNUjm1NWafZYeQTdoYqOq1qwDEbi2rKl7WEa1RR3c39DCbKy/oYmSK8i
         DYiQfoctOgESAczTqELPLMW4ptg4NPLiJKqbKgKX3DitGPzdSxKv4h+k4su7aNTY/21X
         hyvsaevHvT170y1krTGhbnQFYgPLN6DkN58ent/jR0uj2qITJixFa0C40JwkKdC80ztx
         /lzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=w5uv58DlqQ+tEHjGjSAAZoBaAkIVxDzD50woRsDhKho=;
        b=VUpkA7a3mX1zNN+4sWmu+dyupnjeV/dvvxJ/MPAGSYny9YlPyur0RQXmbW8MlbscLG
         z0fEv8tLLGeD33YIKpuUKZNSts0uxW/bsVcLBklbQFMeF68/t9uiH417/kdCTaH18n0n
         naoJEPX3DVj7GT7D0qix1kGPOHMOY24qwTNRlI7mQEFuY2DO7rFOwcbApAoRSEsTrtN+
         Iwg+ITW0fdOgDe0INB1ItrFwqZP5/x5taldAUMyOhPW1FdkwvdLujTOM3dbZyC79alyB
         +ziJz/t0X0mwHlrwxRyCk/JFRowOK5s0dxm1ptBAnf7yDex90DRYyrHr4uys99qDWlYu
         3JZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 4.9 04/86] drm/i915: Try EDID bitbanging on HDMI after failed read
Date: Fri, 16 Mar 2018 16:22:27 +0100
Message-Id: <20180316152317.509047523@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108701452876074?=
X-GMAIL-MSGID: =?utf-8?q?1595108701452876074?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Brüns <stefan.bruens@rwth-aachen.de>

commit 90024a5951029685acc5396258f1b0de9b23cf4a upstream.

The ACK/NACK implementation as found in e.g. the G965 has the falling
clock edge and the release of the data line after the ACK for the received
byte happen at the same time.

This is conformant with the I2C specification, which allows a zero hold
time, see footnote [3]: "A device must internally provide a hold time of
at least 300 ns for the SDA signal (with respect to the V IH(min) of the
SCL signal) to bridge the undefined region of the falling edge of SCL."

Some HDMI-to-VGA converters apparently fail to adhere to this requirement
and latch SDA at the falling clock edge, so instead of an ACK
sometimes a NACK is read and the slave (i.e. the EDID ROM) ends the
transfer.

The bitbanging releases the data line for the ACK only 1/4 bit time after
the falling clock edge, so a slave will see the correct value no matter
if it samples at the rising or the falling clock edge or in the center.

Fallback to bitbanging is already done for the CRT connector.

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=92685
Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/a39f080b-81a5-4c93-b3f7-7cb0a58daca3@rwthex-w2-a.rwth-ad.de
(cherry picked from commit cfb926e148e99acc02351d72e8b85e32b5f786ef)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_hdmi.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/i915/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/intel_hdmi.c
@@ -1452,12 +1452,20 @@ intel_hdmi_set_edid(struct drm_connector
 	struct intel_hdmi *intel_hdmi = intel_attached_hdmi(connector);
 	struct edid *edid;
 	bool connected = false;
+	struct i2c_adapter *i2c;
 
 	intel_display_power_get(dev_priv, POWER_DOMAIN_GMBUS);
 
-	edid = drm_get_edid(connector,
-			    intel_gmbus_get_adapter(dev_priv,
-			    intel_hdmi->ddc_bus));
+	i2c = intel_gmbus_get_adapter(dev_priv, intel_hdmi->ddc_bus);
+
+	edid = drm_get_edid(connector, i2c);
+
+	if (!edid && !intel_gmbus_is_forced_bit(i2c)) {
+		DRM_DEBUG_KMS("HDMI GMBUS EDID read failed, retry using GPIO bit-banging\n");
+		intel_gmbus_force_bit(i2c, true);
+		edid = drm_get_edid(connector, i2c);
+		intel_gmbus_force_bit(i2c, false);
+	}
 
 	intel_hdmi_dp_dual_mode_detect(connector, edid != NULL);
 
