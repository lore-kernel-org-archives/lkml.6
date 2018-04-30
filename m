Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrYw2k5QXBDkWuEBL99KGu9C/0ikyua3tynpNpQ2OIuLYVsAp5W8T/hUJBVdyqQRsQ/xDHn
ARC-Seal: i=1; a=rsa-sha256; t=1525116432; cv=none;
        d=google.com; s=arc-20160816;
        b=lDu/Rtdh7Pcsby06WEEWlj5NNFY+QZ/aSJrRkT0csWQqvT3Lac8HAP+NOSe+9V5aip
         rvcPjzlapYzctSfDJqSj7ShwSNdTok1XR1iWg7kqE4dUwuz1wJ+lx/sVN1tvjxYfVYJi
         oPV/XeWQlSnd+qxqyQwmpAZmZ/1I0UIKWz/X0npmNJhGWVycLKgiB4f9TOfqdqJK4oV+
         eLz9H4mqUpAkpGum0abIDySF3Jin8e3Z6VShGgMEkeTVldJvyO5NbKja/2X1vl2njhJz
         ZFX+cZ82z5M8jgL6X2fugw5QfQTDi04qEZaxQu7GeQvJrfG7SquAauFX/eU75OcEVhmw
         uHNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=VUh43D/PdK0m6evhnHjUkt8HK0Q0AuvHMOvHyM5HT/k=;
        b=rMmKr0m4sMTBAN3FzMPDBQTzrbk43WQo3mq7OntuvGzp0VXA03cNIlGyRQdD+c3Yv3
         SJsFllDpc7nToscDUzjMLNR9nSlj08Fh85VGTllbJLSog94p8txrISqz8yR7oWYnMeID
         koA1kmPIJoiNvOOQ4XP4KhX0tsHLRkunEA3XFLHGULKSVnn5N9EoSi2uC6VBiNs/zDKn
         IWLDI8VowVDL/wQfiEJY+Wy25DAQvN8TjNw4LAudn3WeWFOaTtAYACsuO6aQryNDx1xO
         ENtP5t44lZ7V0dUq/yWVlxyVQAzet8e/DUPfTdXYXDHOfNL74LgE10zAd+pMSah0cGL5
         3qNQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A79322DCC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 36/91] ALSA: hda - Skip jack and others for non-existing PCM streams
Date: Mon, 30 Apr 2018 12:24:18 -0700
Message-Id: <20180430184006.052682115@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200574792885884?=
X-GMAIL-MSGID: =?utf-8?q?1599200487676228654?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 8a7d6003df41cb16f6b3b620da044fbd92d2f5ee upstream.

When CONFIG_SND_DYNAMIC_MINORS isn't set, there are only limited
number of devices available, and HD-audio, especially with HDMI/DP
codec, will fail to create more than two devices.

The driver warns about the lack of such devices and skips the PCM
device creations, but the HDMI driver still tries to create the
corresponding JACK, SPDIF and ELD controls even for the non-existing
PCM substreams.  This results in confusion on user-space, and even may
break the operation.

Similarly, Intel HDMI/DP codec builds the ELD notification from i915
graphics driver, and this may be broken if a notification is sent for
the non-existing PCM stream.

This patch adds the check of the existence of the assigned PCM
substream in the both scenarios above, and skips the further operation
if the PCM substream is not assigned.

Fixes: 9152085defb6 ("ALSA: hda - add DP MST audio support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_hdmi.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1383,6 +1383,8 @@ static void hdmi_pcm_setup_pin(struct hd
 		pcm = get_pcm_rec(spec, per_pin->pcm_idx);
 	else
 		return;
+	if (!pcm->pcm)
+		return;
 	if (!test_bit(per_pin->pcm_idx, &spec->pcm_in_use))
 		return;
 
@@ -2151,8 +2153,13 @@ static int generic_hdmi_build_controls(s
 	int dev, err;
 	int pin_idx, pcm_idx;
 
-
 	for (pcm_idx = 0; pcm_idx < spec->pcm_used; pcm_idx++) {
+		if (!get_pcm_rec(spec, pcm_idx)->pcm) {
+			/* no PCM: mark this for skipping permanently */
+			set_bit(pcm_idx, &spec->pcm_bitmap);
+			continue;
+		}
+
 		err = generic_hdmi_build_jack(codec, pcm_idx);
 		if (err < 0)
 			return err;
