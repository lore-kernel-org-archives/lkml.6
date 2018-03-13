Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsM5IdqFW4oR5I8qIbUXKEUxXzH+xzS/Nf1HgPUdUyK/tzM2AXTxJH9n4dgNT8K0J+ZV/X+
ARC-Seal: i=1; a=rsa-sha256; t=1520954964; cv=none;
        d=google.com; s=arc-20160816;
        b=djmIoNiAngtpBxC43X7ox5LScwUajntfK2Rkgutm8PeNfQxHukjJwTGQ7OVINJKeSe
         AO6F9x65by4eyBUzaMWwsILKkC4sKMva2d8QJD1W1vNv8Qod61+rvYEAnMMl+FQsE4+G
         obTGqI+uxRpc8O6c0Wo5CuQDvT0gDTEDOYMv5QWts0B9GK1b7YWKfPaEXkUmCabpF+Qj
         qnvZkSJZ0hdDJNdPRVe6XbyNrEbtX/FeH7lSayPEP3IY/askMFKZfSJjB3YUDPQ6uREe
         aLNYFsua+94nnqUxzl5r/GmK6ACggA1zB6jsYGR7PMoRzjIkiOyOsOJ72B63//A3rVcM
         1EHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=j6dpp8T2xaauaBlSjCboUqxWulS0NMKeRK0mJ6ADaw8=;
        b=tnnvnMkWkfcJCmRX/mct2fbGpec8SCxw2cLS7JT5c0rDbvVid/n/lTm/WjwMPqJXf8
         731rFCLGBjT1/9q4C8PC4aRO0vdPuHfBqjzg3//EhqEZsDZ61EfpwuQVJv9rl9sTXUVN
         mf2/9O4sdI0AeSQUTPx/CkmFh9hCnTd6wd8s43EIr1LGMhzucnYTmfAm/QcSQt/iL+J2
         wR1KV6SjqKyM9uXKJmsJwhuS++dB3gkSdNV1VWHq2GceQpzwY8UWloAmdM1trggVp/Ax
         9PypcM4dwSSEK7Shgjs/jhx16qMLrgWojD1cfAKcmzMoxhBEfRW+7UDvkFXhZA2Yl/dZ
         Sm4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 4.15 015/146] drm/i915: Try EDID bitbanging on HDMI after failed read
Date: Tue, 13 Mar 2018 16:23:02 +0100
Message-Id: <20180313152321.718926821@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836873021113405?=
X-GMAIL-MSGID: =?utf-8?q?1594836873021113405?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1573,12 +1573,20 @@ intel_hdmi_set_edid(struct drm_connector
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
 
