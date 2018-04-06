Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+XMv/1ZvAZRC0v68V1uLHIBMUIgFwNySQ1AzOYxT7UZxQp5ygmAFLxoRrDMJxuquF2HLn2
ARC-Seal: i=1; a=rsa-sha256; t=1523022304; cv=none;
        d=google.com; s=arc-20160816;
        b=lV0wXgDpqUfoDianDnuNCMKedwKl6LAyqK0kFFq3b/IDx83Q7ag8uZHxoLwRAriEpE
         RwoDWLHm12vgNgI6Of4pOi1VEUnMfOgm808mff0czmx9DpXqDC1y0NbUdPMArDKdewh+
         YI1pZTgqKd8b6iUMvUac9t6EHjR6g72IZg+drPIS2NbCIEmUuVJHQwTSKCumFGzSdLen
         isUhYCRAZnzLorAjk3xOU7VoNE4lBs1SSstQqVIIC/vgNWoEp9Dg7UxqSVboA/0ESC3o
         w5OSewfxd1HHFG2dx1F/TruwZw1lyjq/j8oBWK0980vlCMCsxz22ViFF8RcVXiGOWe8H
         A1BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mdITQa2UTPx93AEvm5nBmsXst+Cu9/1BAWWpDMd8Nq8=;
        b=g+M3dBkilJL7oU5J9PkHaoQY/T0J0l1TLIjfTv1RxEhqOWMNPJoBty4reBLHe+zWzQ
         5sWJiM+HY9LGcbNUStbWwGx1Trz+di5inxrNZ8s0xUqMYTGuEJ6WUBbb78ARUfoS32wg
         AdHvt4fC2UbV6WSvbj6yB+CyoWw9o+uoLFgpui/TgEJR5ALRwYww71madJWujOGT7MJP
         R5k31Z2aa9pKp9o4Ar0i/x1eYbkKA3RMmTfNFoTShU9Q79M8FejTLnn9H3peQAILp0pX
         KHrNs7iKMFbZDyBMVliCIThC5lrnQ5GXITKqWlUIpzYtCL+nkiatpply5ZnJseHze+Ue
         374g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Masaki Ota <masaki.ota@jp.alps.com>,
	Aaron Ma <aaron.ma@canonical.com>,
	Jonathan Liu <net147@gmail.com>,
	Jaak Ristioja <jaak@ristioja.ee>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.16 26/31] Input: ALPS - fix TrackStick detection on Thinkpad L570 and Latitude 7370
Date: Fri,  6 Apr 2018 15:24:51 +0200
Message-Id: <20180406084344.561731759@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084340.999820380@linuxfoundation.org>
References: <20180406084340.999820380@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004080957265543?=
X-GMAIL-MSGID: =?utf-8?q?1597004636037370598?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masaki Ota <masaki.ota@jp.alps.com>

commit 567b9b549cfa1cbc202762ae97b5385c29ade1e3 upstream.

The primary interface for the touchpad device in Thinkpad L570 is SMBus,
so ALPS overlooked PS2 interface Firmware setting of TrackStick, and
shipped with TrackStick otp bit is disabled.

The address 0xD7 contains device number information, so we can identify
the device by checking this value, but to access it we need to enable
Command mode, and then re-enable the device. Devices shipped in Thinkpad
L570 report either 0x0C or 0x1D as device numbers, if we see them we assume
that the devices are DualPoints.

The same issue exists on Dell Latitude 7370.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=196929
Fixes: 646580f793 ("Input: ALPS - fix multi-touch decoding on SS4 plus touchpads")
Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
Tested-by: Aaron Ma <aaron.ma@canonical.com>
Tested-by: Jonathan Liu <net147@gmail.com>
Tested-by: Jaak Ristioja <jaak@ristioja.ee>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/alps.c |   24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -2544,13 +2544,31 @@ static int alps_update_btn_info_ss4_v2(u
 }
 
 static int alps_update_dual_info_ss4_v2(unsigned char otp[][4],
-				       struct alps_data *priv)
+					struct alps_data *priv,
+					struct psmouse *psmouse)
 {
 	bool is_dual = false;
+	int reg_val = 0;
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
 
-	if (IS_SS4PLUS_DEV(priv->dev_id))
+	if (IS_SS4PLUS_DEV(priv->dev_id)) {
 		is_dual = (otp[0][0] >> 4) & 0x01;
 
+		if (!is_dual) {
+			/* For support TrackStick of Thinkpad L/E series */
+			if (alps_exit_command_mode(psmouse) == 0 &&
+				alps_enter_command_mode(psmouse) == 0) {
+				reg_val = alps_command_mode_read_reg(psmouse,
+									0xD7);
+			}
+			alps_exit_command_mode(psmouse);
+			ps2_command(ps2dev, NULL, PSMOUSE_CMD_ENABLE);
+
+			if (reg_val == 0x0C || reg_val == 0x1D)
+				is_dual = true;
+		}
+	}
+
 	if (is_dual)
 		priv->flags |= ALPS_DUALPOINT |
 					ALPS_DUALPOINT_WITH_PRESSURE;
@@ -2573,7 +2591,7 @@ static int alps_set_defaults_ss4_v2(stru
 
 	alps_update_btn_info_ss4_v2(otp, priv);
 
-	alps_update_dual_info_ss4_v2(otp, priv);
+	alps_update_dual_info_ss4_v2(otp, priv, psmouse);
 
 	return 0;
 }
