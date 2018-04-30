Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZriHcPqh8dXrpjj71HjDBtYLe9vJpcEQxMImIgaU9ji0sgbocyJNKppzOkEKWyU+QZoQw1m
ARC-Seal: i=1; a=rsa-sha256; t=1525116514; cv=none;
        d=google.com; s=arc-20160816;
        b=ktyShcdcCasxzw7tICgk4GMIglBtff9bkNdl4Lkk3nrDVk9WDh2uDd+L694noV/TeG
         na996RM+NJlsQCpZ5iH3caKq5Qx9Bzefzf7t1ZkFKqsijIWSXU3bKtWP+IqVPTApad5h
         QoPmSqqcl+C4Eh/i03SJYRoznkVaulsQDqyWhqe2BKS9r6LbAv8R6RUA9lwYzSelWPv+
         tZ/oD14srLm+ueB+RFpPTHPkixgQbHetCWWHv2ihVvu3jg0wPsZOWX8zT/ilKpcKLQsp
         PReeAgGMEQmxjFq4/Wom2Aev11hoYIM3hXNKMhqfZmMpLWaYJ3ivxEAbUbLczU+AZe/4
         S4dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=R3mi5XvdJA7gY6pFdbGFxau0/VcntJFKth7cPcIIfGc=;
        b=x9UvYLRndC7Wtqh0jtFDeCXbeZ0SKgzGWiveQb94gEc8zUM8HyYe5Nkqw79D+DvXq9
         T5BSa1NXgkcUDm3OlRQzhMxlE1krQgUNHLEU2KJAS4JIbGmsmlOhEql3oZNSrOEEDfo8
         ldNoW6Uv4RUDC5m/plT4Ey0LA/wQksZnTfplmakAdRGoZYTSz3sxcUHF9O+cl642V7bh
         j66iZ61VzEGXGpDtYBZHq/LaRN1ulC8JqXaTfs76PjP1cRBcsxia5SM9ZchnPfW9rs3e
         RDL3uD5GdQK3Ki3W1C+nmDZ6VtApnLR9ZJOIMcsib+/dyOhxhWDRX3BU2mnyaTHj4Ymw
         RYwQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCED22DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.16 040/113] ALSA: hda - Skip jack and others for non-existing PCM streams
Date: Mon, 30 Apr 2018 12:24:11 -0700
Message-Id: <20180430184016.748520325@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200574792885884?=
X-GMAIL-MSGID: =?utf-8?q?1599200574792885884?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
