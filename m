Return-Path: <ruslan.bilovol@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525397099; cv=none;
        d=google.com; s=arc-20160816;
        b=Ros+2Y2NYs7wxdvpJP/IplDqJl61skYuNLc4xgdI3MFl9USAro+IVZLEOs+YL0Tvxd
         51dfcYhJGgRD6pV1/3yGyYQklPU7xH30EXgfndbaVico16RbceDiw1k9EtGM8l0Yo2j5
         Ks5LWN6ljDBMGE/VyfxQfqm6PSuhzIOBP0sFsWozVsNwHzh1Bao3cQWSAjAHhR9sSWCN
         ebJZnZoIeEAx0JW+2vFEdSBCMrHUpuvRJNNSJXzLHo/nLhdL9BSdDZV4I9vlbMnjlBxh
         NXARAOY2hpHpG5v09bmV3UCilGKRbns3jrAzw0Wk0+cJA5+BidboMT1Z1AmnrQDEXD24
         4IHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=IkAV/g06nKHDES3Kl6nDKkX6xhhNRF4ilUnc9thOxE0=;
        b=O25uJS0JRj3BVCekLiWuvO0tqdtPNuw994rl9b6sMMa0YFWGM2ctgFxlH9EW1zctct
         usG0jb8uAFVPYf84vwVCRPISmbTTriJLwyNUtR2l4qfFWlHbg5ZbLb4cI8/8vcb4xKjM
         0OgLdfY1tDgvZSqLtViiVwo/FyARCVuCRPlj3qVN5B38wdrIGF7//nqt7tf+EWLHWR0Y
         bwazyv5WtUGQXvBel5qXazaq7gwwaw3XXXaNPbmXdVnYH2OLa/PaJSsdPwT3bi9EhA/C
         6sOCte3kKAV5ZxHDEnCVdCq3wDtumv3jl/fe0+C/R1aL1TmaVmDa/pvbu0LHFcJ1lXob
         5+Xg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CWq/mofz;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CWq/mofz;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZqErZNgJNgn3akIVMqmlTeHKmIis45FOqrPqS7IaNG6+sUEUvW2nD+ecvzs2fCsM+AOflE76g==
From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
To: Takashi Iwai <tiwai@suse.com>
Cc: Jorge <jorge.sanjuan@codethink.co.uk>,
	Andrew Chant <achant@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] ALSA: usb: mixer: make string parsing independent of mixer_build state
Date: Fri,  4 May 2018 04:24:02 +0300
Message-Id: <1525397044-15080-6-git-send-email-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525397044-15080-1-git-send-email-ruslan.bilovol@gmail.com>
References: <1525397044-15080-1-git-send-email-ruslan.bilovol@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599494789171550774?=
X-GMAIL-MSGID: =?utf-8?q?1599494789171550774?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Functions like snd_usb_copy_string_desc() or
get_term_name() don't actually need mixer_build
state but can use snd_usb_audio structure instead
to get usb device.

This patch has no functional change but prepares
to future UAC3 BADD profiles support which don't
have class-specific descriptors so won't have
mixer_build state.

Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
---
 sound/usb/mixer.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index bb203b3..e280354 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -201,10 +201,10 @@ static void *find_audio_control_unit(struct mixer_build *state,
 /*
  * copy a string with the given id
  */
-static int snd_usb_copy_string_desc(struct mixer_build *state,
+static int snd_usb_copy_string_desc(struct snd_usb_audio *chip,
 				    int index, char *buf, int maxlen)
 {
-	int len = usb_string(state->chip->dev, index, buf, maxlen - 1);
+	int len = usb_string(chip->dev, index, buf, maxlen - 1);
 
 	if (len < 0)
 		return 0;
@@ -658,14 +658,14 @@ int snd_usb_mixer_add_control(struct usb_mixer_elem_list *list,
 	{ 0 },
 };
 
-static int get_term_name(struct mixer_build *state, struct usb_audio_term *iterm,
+static int get_term_name(struct snd_usb_audio *chip, struct usb_audio_term *iterm,
 			 unsigned char *name, int maxlen, int term_only)
 {
 	struct iterm_name_combo *names;
 	int len;
 
 	if (iterm->name) {
-		len = snd_usb_copy_string_desc(state, iterm->name,
+		len = snd_usb_copy_string_desc(chip, iterm->name,
 						name, maxlen);
 		if (len)
 			return len;
@@ -1407,7 +1407,7 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
 	len = check_mapped_name(map, kctl->id.name, sizeof(kctl->id.name));
 	mapped_name = len != 0;
 	if (!len && nameid)
-		len = snd_usb_copy_string_desc(state, nameid,
+		len = snd_usb_copy_string_desc(state->chip, nameid,
 				kctl->id.name, sizeof(kctl->id.name));
 
 	switch (control) {
@@ -1422,10 +1422,10 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
 		 * - otherwise, anonymous name.
 		 */
 		if (!len) {
-			len = get_term_name(state, iterm, kctl->id.name,
+			len = get_term_name(state->chip, iterm, kctl->id.name,
 					    sizeof(kctl->id.name), 1);
 			if (!len)
-				len = get_term_name(state, &state->oterm,
+				len = get_term_name(state->chip, &state->oterm,
 						    kctl->id.name,
 						    sizeof(kctl->id.name), 1);
 			if (!len)
@@ -1498,7 +1498,7 @@ static void get_connector_control_name(struct mixer_build *state,
 				       struct usb_audio_term *term,
 				       bool is_input, char *name, int name_size)
 {
-	int name_len = get_term_name(state, term, name, name_size, 0);
+	int name_len = get_term_name(state->chip, term, name, name_size, 0);
 
 	if (name_len == 0)
 		strlcpy(name, "Unknown", name_size);
@@ -1597,7 +1597,7 @@ static int parse_clock_source_unit(struct mixer_build *state, int unitid,
 	}
 
 	kctl->private_free = snd_usb_mixer_elem_free;
-	ret = snd_usb_copy_string_desc(state, hdr->iClockSource,
+	ret = snd_usb_copy_string_desc(state->chip, hdr->iClockSource,
 				       name, sizeof(name));
 	if (ret > 0)
 		snprintf(kctl->id.name, sizeof(kctl->id.name),
@@ -1840,7 +1840,7 @@ static void build_mixer_unit_ctl(struct mixer_build *state,
 
 	len = check_mapped_name(map, kctl->id.name, sizeof(kctl->id.name));
 	if (!len)
-		len = get_term_name(state, iterm, kctl->id.name,
+		len = get_term_name(state->chip, iterm, kctl->id.name,
 				    sizeof(kctl->id.name), 0);
 	if (!len)
 		len = sprintf(kctl->id.name, "Mixer Source %d", in_ch + 1);
@@ -2154,7 +2154,8 @@ static int build_audio_procunit(struct mixer_build *state, int unitid,
 			nameid = uac_processing_unit_iProcessing(desc, state->mixer->protocol);
 			len = 0;
 			if (nameid)
-				len = snd_usb_copy_string_desc(state, nameid,
+				len = snd_usb_copy_string_desc(state->chip,
+							       nameid,
 							       kctl->id.name,
 							       sizeof(kctl->id.name));
 			if (!len)
@@ -2350,7 +2351,8 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
 		len = check_mapped_selector_name(state, unitid, i, namelist[i],
 						 MAX_ITEM_NAME_LEN);
 		if (! len && check_input_term(state, desc->baSourceID[i], &iterm) >= 0)
-			len = get_term_name(state, &iterm, namelist[i], MAX_ITEM_NAME_LEN, 0);
+			len = get_term_name(state->chip, &iterm, namelist[i],
+					    MAX_ITEM_NAME_LEN, 0);
 		if (! len)
 			sprintf(namelist[i], "Input %u", i);
 	}
@@ -2372,12 +2374,12 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
 		/* if iSelector is given, use it */
 		nameid = uac_selector_unit_iSelector(desc);
 		if (nameid)
-			len = snd_usb_copy_string_desc(state, nameid,
+			len = snd_usb_copy_string_desc(state->chip, nameid,
 						       kctl->id.name,
 						       sizeof(kctl->id.name));
 		/* ... or pick up the terminal name at next */
 		if (!len)
-			len = get_term_name(state, &state->oterm,
+			len = get_term_name(state->chip, &state->oterm,
 				    kctl->id.name, sizeof(kctl->id.name), 0);
 		/* ... or use the fixed string "USB" as the last resort */
 		if (!len)
-- 
1.9.1
