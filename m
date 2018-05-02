Return-Path: <samuel.thibault@ens-lyon.org>
X-Google-Smtp-Source: AB8JxZoWnIyp4sc9hhYFy2wo8JPrmZgJBnPU88WuH5sRpcPXZ8fQzfK+MNDaGZUEgl5CJ8AEtmCy
ARC-Seal: i=1; a=rsa-sha256; t=1525221624; cv=none;
        d=google.com; s=arc-20160816;
        b=aEn0/4iCmVt1q7skuerCj91g1GtuvoS7XVedhKfg94+pkrPF4vL6xkh/eQd8ljyJqo
         UkEtba/RT2X9I5zzhL12nCcNIO0eDsq4OJe/OwbhiOyGv5UO7bjIfFWPBTBQFAKBxsYe
         efTgkBr5HQ2leMv2ZM8O6kdb/TQHewrsLBSFpYCf4deHB9apgdD4CJ3Lpx4DuaFbzf+z
         2RdgGNl03aQZCK8fcxhSXRs7Bx+vh8pxC1+RNQ5MpB0K3rYJe8XurSBT89Y/dnQKPzCd
         GNrqLArOv+wjQd5qGZq4zyNmq+wXkhbNQm90Kil8/f0sJirF7+rGPsWM6WMqzpozuD+A
         uK9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:organization:content-disposition:mime-version
         :mail-followup-to:message-id:subject:to:from:date
         :arc-authentication-results;
        bh=Th14AxXv3gXt6NuYB6pOgNGob337LkYurSOXNS9Eu9c=;
        b=tiNyHnPJ30c9eBvT8oVCHX65Bm8P2gw1PcvFLmbsz8mIDJsjKwA03FphvRIH0iWns3
         6M1Ea2FlCebFfoEm4eYrrfrc/eWNMQ9hrvsZqjRqGZHv6nawKIHeQSNCyWp4HJMp2BjK
         PCLtCrQ6dWs5LbO+fkjLZ8neR1GqY4z0q99CZzYjG9YsGxDuB8BMQoMtQTNVUw+IqRaN
         sjid3TKnZVQhbf46zmV7qKk4ASkKthlyjEp7CVinABtrKbA16UqOohPwg7nsOShK7V6N
         DmgcxCi8kV8CvZvn0VH4WW3OZBML/W0dPaLLtiUf8tDAs05Q+lC/yy3br7ArN2B8Xlgp
         nleA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 185.233.100.1 is neither permitted nor denied by domain of samuel.thibault@ens-lyon.org) smtp.mailfrom=samuel.thibault@ens-lyon.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 185.233.100.1 is neither permitted nor denied by domain of samuel.thibault@ens-lyon.org) smtp.mailfrom=samuel.thibault@ens-lyon.org
Date: Wed, 2 May 2018 02:40:17 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: gregkh@linuxfoundation.org, w.d.hubbs@gmail.com, chris@the-brannons.com,
	kirk@reisers.ca, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [PATCH] staging: speakup: Add pause command used on switching to
 graphical mode
Message-ID: <20180502004017.hityg7k7cxhn75na@var.youpi.perso.aquilenet.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	gregkh@linuxfoundation.org, w.d.hubbs@gmail.com,
	chris@the-brannons.com, kirk@reisers.ca, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, speakup@linux-speakup.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599310790536411239?=
X-GMAIL-MSGID: =?utf-8?q?1599310790536411239?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

For software speech syntheses to be able to manage concurrent audio card
access, they need to know when speakup stops emitting text to be spoken
because the console has switched to graphical mode.  This introduces a
PAUSE command to do so.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Index: linux-4.15/drivers/staging/speakup/speakup_dummy.c
===================================================================
--- linux-4.15.orig/drivers/staging/speakup/speakup_dummy.c
+++ linux-4.15/drivers/staging/speakup/speakup_dummy.c
@@ -30,6 +30,7 @@
 static struct var_t vars[] = {
 	{ CAPS_START, .u.s = {"CAPS_START\n" } },
 	{ CAPS_STOP, .u.s = {"CAPS_STOP\n" } },
+	{ PAUSE, .u.s = {"PAUSE\n"} },
 	{ RATE, .u.n = {"RATE %d\n", 8, 1, 16, 0, 0, NULL } },
 	{ PITCH, .u.n = {"PITCH %d\n", 8, 0, 16, 0, 0, NULL } },
 	{ VOL, .u.n = {"VOL %d\n", 8, 0, 16, 0, 0, NULL } },
Index: linux-4.15/drivers/staging/speakup/speakup_soft.c
===================================================================
--- linux-4.15.orig/drivers/staging/speakup/speakup_soft.c
+++ linux-4.15/drivers/staging/speakup/speakup_soft.c
@@ -45,6 +45,7 @@ static int misc_registered;
 static struct var_t vars[] = {
 	{ CAPS_START, .u.s = {"\x01+3p" } },
 	{ CAPS_STOP, .u.s = {"\x01-3p" } },
+	{ PAUSE, .u.n = {"\x01P" } },
 	{ RATE, .u.n = {"\x01%ds", 2, 0, 9, 0, 0, NULL } },
 	{ PITCH, .u.n = {"\x01%dp", 5, 0, 9, 0, 0, NULL } },
 	{ VOL, .u.n = {"\x01%dv", 5, 0, 9, 0, 0, NULL } },
@@ -164,7 +165,7 @@ static char *get_initstring(void)
 	var = synth_soft.vars;
 	while (var->var_id != MAXVARS) {
 		if (var->var_id != CAPS_START && var->var_id != CAPS_STOP &&
-		    var->var_id != DIRECT)
+		    var->var_id != PAUSE && var->var_id != DIRECT)
 			cp = cp + sprintf(cp, var->u.n.synth_fmt,
 					  var->u.n.value);
 		var++;
Index: linux-4.15/drivers/staging/speakup/spk_types.h
===================================================================
--- linux-4.15.orig/drivers/staging/speakup/spk_types.h
+++ linux-4.15/drivers/staging/speakup/spk_types.h
@@ -42,7 +42,7 @@ enum var_id_t {
 	SAY_CONTROL, SAY_WORD_CTL, NO_INTERRUPT, KEY_ECHO,
 	SPELL_DELAY, PUNC_LEVEL, READING_PUNC,
 	ATTRIB_BLEEP, BLEEPS,
-	RATE, PITCH, VOL, TONE, PUNCT, VOICE, FREQUENCY, LANG, DIRECT,
+	RATE, PITCH, VOL, TONE, PUNCT, VOICE, FREQUENCY, LANG, DIRECT, PAUSE,
 	CAPS_START, CAPS_STOP, CHARTAB,
 	MAXVARS
 };
Index: linux-4.15/drivers/staging/speakup/varhandlers.c
===================================================================
--- linux-4.15.orig/drivers/staging/speakup/varhandlers.c
+++ linux-4.15/drivers/staging/speakup/varhandlers.c
@@ -44,6 +44,7 @@ static struct st_var_header var_headers[
 	{ "lang", LANG, VAR_NUM, NULL, NULL },
 	{ "chartab", CHARTAB, VAR_PROC, NULL, NULL },
 	{ "direct", DIRECT, VAR_NUM, NULL, NULL },
+	{ "pause", PAUSE, VAR_STRING, spk_str_pause, NULL },
 };
 
 static struct st_var_header *var_ptrs[MAXVARS] = { NULL, NULL, NULL };
Index: linux-4.15/drivers/staging/speakup/main.c
===================================================================
--- linux-4.15.orig/drivers/staging/speakup/main.c
+++ linux-4.15/drivers/staging/speakup/main.c
@@ -76,6 +76,8 @@ short spk_punc_mask;
 int spk_punc_level, spk_reading_punc;
 char spk_str_caps_start[MAXVARLEN + 1] = "\0";
 char spk_str_caps_stop[MAXVARLEN + 1] = "\0";
+char spk_str_pause[MAXVARLEN + 1] = "\0";
+bool spk_paused = 0;
 const struct st_bits_data spk_punc_info[] = {
 	{"none", "", 0},
 	{"some", "/$%&@", SOME},
@@ -1789,6 +1791,11 @@ static void speakup_con_update(struct vc
 		/* Speakup output, discard */
 		return;
 	speakup_date(vc);
+	if (vc->vc_mode == KD_GRAPHICS && !spk_paused && spk_str_pause[0])
+	{
+		synth_printf("%s", spk_str_pause);
+		spk_paused = 1;
+	}
 	spin_unlock_irqrestore(&speakup_info.spinlock, flags);
 }
 
Index: linux-4.15/drivers/staging/speakup/speakup.h
===================================================================
--- linux-4.15.orig/drivers/staging/speakup/speakup.h
+++ linux-4.15/drivers/staging/speakup/speakup.h
@@ -94,7 +94,8 @@ extern struct spk_synth *synth;
 extern char spk_pitch_buff[];
 extern u_char *spk_our_keys[];
 extern short spk_punc_masks[];
-extern char spk_str_caps_start[], spk_str_caps_stop[];
+extern char spk_str_caps_start[], spk_str_caps_stop[], spk_str_pause[];
+extern bool spk_paused;
 extern const struct st_bits_data spk_punc_info[];
 extern u_char spk_key_buf[600];
 extern char *spk_characters[];
Index: linux-4.15/drivers/staging/speakup/buffers.c
===================================================================
--- linux-4.15.orig/drivers/staging/speakup/buffers.c
+++ linux-4.15/drivers/staging/speakup/buffers.c
@@ -76,6 +76,9 @@ void synth_buffer_add(u16 ch)
 	*buff_in++ = ch;
 	if (buff_in > buffer_end)
 		buff_in = synth_buffer;
+	/* We have written something to the speech synthesis, so we are not
+	 * paused any more. */
+	spk_paused = 0;
 }
 
 u16 synth_buffer_getc(void)
