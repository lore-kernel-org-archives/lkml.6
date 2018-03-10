Return-Path: <samuel.thibault@ens-lyon.org>
X-Google-Smtp-Source: AG47ELtJu7vbAJCVDikLXvH3PN43qgoD+fghcgCvyii++iw/3ajuEH8e826vAsJ+YIdEhFiRa9IP
ARC-Seal: i=1; a=rsa-sha256; t=1520679393; cv=none;
        d=google.com; s=arc-20160816;
        b=oHSeyQSTImhL6tHvRygcbsiCYZ3y02X8jYzF2H33r9eEQIQxx8N2LvPYqu/YUJGuVB
         oUptjIdlJAV+JyeFpEy3ihr6UngpqgQS/v4IPtyNOREw8Kty8TFfujm4B4YnbeRya9oJ
         /3/qFtBSni0l3MhgAKzWzB0ndBrhI2bEd9uRo4PXIqNR050qbpQ8yVjIdBqOTJs3C4bS
         ca+IYNYxuGRVBEnUwI3OyC5+15o/W+m7sfrDfH9qWxmQ/HAjvEkbO9OGfMIQ+P6WrhJ+
         B6LWmMKNLN8QfwZ3jVZwyYZVVVEXcQHFttkWNce5UxwrxI3KoV6yErPv7CSVYHl+r9xk
         HpQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:organization:content-disposition:mime-version
         :mail-followup-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=+F9oMyjOAMr9rbc/hiFb/WxYezFdQNG3drLhWJFxk6k=;
        b=a0Wri7/l/GSRs5gYHJExHOT1bzEdmpd1VgW1aVVQ9s0/72tkoF3qILuuDW1p+rpdKv
         MZyzmOLpZ7WE0J6JLX/sd9m4fEblf7BBlbAVf+SnMn0nlMtKQN2Ev+5crORpPnuCp3F3
         JMIBNpoyzsA2EXaG7oVxj6WilhZGERBfk8ndVlGF4mEB6d0OaoczsgquOFmIXie8K4QT
         MAwvQNciwijEOBLUdjGcf+iDmWjVS4PJWTYXPB85IcKIcStq+hROx2zQcTVJTACPOLD4
         YCI+raqztP98rWkTDxWNJ3Tq0i9Qz8DZX6roY1vqjtr95uPRP68mAiLh0MkxQBKk0Niw
         EaoQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2a0c:e300::1 is neither permitted nor denied by domain of samuel.thibault@ens-lyon.org) smtp.mailfrom=samuel.thibault@ens-lyon.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2a0c:e300::1 is neither permitted nor denied by domain of samuel.thibault@ens-lyon.org) smtp.mailfrom=samuel.thibault@ens-lyon.org
Date: Sat, 10 Mar 2018 11:56:27 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: gregkh@linuxfoundation.org, w.d.hubbs@gmail.com, chris@the-brannons.com,
	kirk@reisers.ca
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	speakup@linux-speakup.org
Subject: [PATCH] staging: speakup: Add unicode support to the speakup_dummy
 driver
Message-ID: <20180310105627.lzy35if76vedfvv7@var.youpi.perso.aquilenet.fr>
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
X-GMAIL-THRID: =?utf-8?q?1594547915843054514?=
X-GMAIL-MSGID: =?utf-8?q?1594547915843054514?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This extends spk_io_ops with a synth_out_unicode which takes a u16 character
instead of just a byte, and extends spk_ttyio to implement it to emit
utf-8. spk_do_catch_up_unicode can then be introduced to benefit from
synth_out_unicode, and speakup_dummy made to use spk_do_catch_up_unicode instead
of spk_do_catch_up.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Index: linux-4.15/drivers/staging/speakup/spk_types.h
===================================================================
--- linux-4.15.orig/drivers/staging/speakup/spk_types.h
+++ linux-4.15/drivers/staging/speakup/spk_types.h
@@ -151,6 +151,7 @@ struct spk_synth;
 
 struct spk_io_ops {
 	int (*synth_out)(struct spk_synth *synth, const char ch);
+	int (*synth_out_unicode)(struct spk_synth *synth, u16 ch);
 	void (*send_xchar)(char ch);
 	void (*tiocmset)(unsigned int set, unsigned int clear);
 	unsigned char (*synth_in)(void);
Index: linux-4.15/drivers/staging/speakup/spk_ttyio.c
===================================================================
--- linux-4.15.orig/drivers/staging/speakup/spk_ttyio.c
+++ linux-4.15/drivers/staging/speakup/spk_ttyio.c
@@ -109,6 +109,7 @@ static struct tty_ldisc_ops spk_ttyio_ld
 };
 
 static int spk_ttyio_out(struct spk_synth *in_synth, const char ch);
+static int spk_ttyio_out_unicode(struct spk_synth *in_synth, u16 ch);
 static void spk_ttyio_send_xchar(char ch);
 static void spk_ttyio_tiocmset(unsigned int set, unsigned int clear);
 static unsigned char spk_ttyio_in(void);
@@ -117,6 +118,7 @@ static void spk_ttyio_flush_buffer(void)
 
 struct spk_io_ops spk_ttyio_ops = {
 	.synth_out = spk_ttyio_out,
+	.synth_out_unicode = spk_ttyio_out_unicode,
 	.send_xchar = spk_ttyio_send_xchar,
 	.tiocmset = spk_ttyio_tiocmset,
 	.synth_in = spk_ttyio_in,
@@ -220,6 +222,22 @@ static int spk_ttyio_out(struct spk_synt
 	return 0;
 }
 
+static int spk_ttyio_out_unicode(struct spk_synth *in_synth, u16 ch)
+{
+	int ret;
+	if (ch < 0x80)
+		ret = spk_ttyio_out(in_synth, ch);
+	else if (ch < 0x800) {
+		ret  = spk_ttyio_out(in_synth, 0xc0 | (ch >> 6));
+		ret &= spk_ttyio_out(in_synth, 0x80 | (ch & 0x3f));
+	} else {
+		ret  = spk_ttyio_out(in_synth, 0xe0 | (ch >> 12));
+		ret &= spk_ttyio_out(in_synth, 0x80 | ((ch >> 6) & 0x3f));
+		ret &= spk_ttyio_out(in_synth, 0x80 | (ch & 0x3f));
+	}
+	return ret;
+}
+
 static int check_tty(struct tty_struct *tty)
 {
 	if (!tty) {
Index: linux-4.15/drivers/staging/speakup/synth.c
===================================================================
--- linux-4.15.orig/drivers/staging/speakup/synth.c
+++ linux-4.15/drivers/staging/speakup/synth.c
@@ -51,9 +51,9 @@ static int do_synth_init(struct spk_synt
  * For devices that have a "full" notification mechanism, the driver can
  * adapt the loop the way they prefer.
  */
-void spk_do_catch_up(struct spk_synth *synth)
+static void _spk_do_catch_up(struct spk_synth *synth, int unicode)
 {
-	u_char ch;
+	u16 ch;
 	unsigned long flags;
 	unsigned long jiff_max;
 	struct var_t *delay_time;
@@ -62,6 +62,7 @@ void spk_do_catch_up(struct spk_synth *s
 	int jiffy_delta_val;
 	int delay_time_val;
 	int full_time_val;
+	int ret;
 
 	jiffy_delta = spk_get_var(JIFFY);
 	full_time = spk_get_var(FULL);
@@ -80,7 +81,8 @@ void spk_do_catch_up(struct spk_synth *s
 			synth->flush(synth);
 			continue;
 		}
-		synth_buffer_skip_nonlatin1();
+		if (!unicode)
+			synth_buffer_skip_nonlatin1();
 		if (synth_buffer_empty()) {
 			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
 			break;
@@ -91,7 +93,11 @@ void spk_do_catch_up(struct spk_synth *s
 		spin_unlock_irqrestore(&speakup_info.spinlock, flags);
 		if (ch == '\n')
 			ch = synth->procspeech;
-		if (!synth->io_ops->synth_out(synth, ch)) {
+		if (unicode)
+			ret = synth->io_ops->synth_out_unicode(synth, ch);
+		else
+			ret = synth->io_ops->synth_out(synth, ch);
+		if (!ret) {
 			schedule_timeout(msecs_to_jiffies(full_time_val));
 			continue;
 		}
@@ -116,8 +122,19 @@ void spk_do_catch_up(struct spk_synth *s
 	}
 	synth->io_ops->synth_out(synth, synth->procspeech);
 }
+
+void spk_do_catch_up(struct spk_synth *synth)
+{
+	_spk_do_catch_up(synth, 0);
+}
 EXPORT_SYMBOL_GPL(spk_do_catch_up);
 
+void spk_do_catch_up_unicode(struct spk_synth *synth)
+{
+	_spk_do_catch_up(synth, 1);
+}
+EXPORT_SYMBOL_GPL(spk_do_catch_up_unicode);
+
 void spk_synth_flush(struct spk_synth *synth)
 {
 	synth->io_ops->flush_buffer();
Index: linux-4.15/drivers/staging/speakup/spk_priv.h
===================================================================
--- linux-4.15.orig/drivers/staging/speakup/spk_priv.h
+++ linux-4.15/drivers/staging/speakup/spk_priv.h
@@ -66,6 +66,7 @@ int spk_ttyio_synth_probe(struct spk_syn
 const char *spk_serial_synth_immediate(struct spk_synth *synth, const char *buff);
 const char *spk_ttyio_synth_immediate(struct spk_synth *synth, const char *buff);
 void spk_do_catch_up(struct spk_synth *synth);
+void spk_do_catch_up_unicode(struct spk_synth *synth);
 void spk_synth_flush(struct spk_synth *synth);
 unsigned char spk_synth_get_index(struct spk_synth *synth);
 int spk_synth_is_alive_nop(struct spk_synth *synth);
Index: linux-4.15/drivers/staging/speakup/speakup_dummy.c
===================================================================
--- linux-4.15.orig/drivers/staging/speakup/speakup_dummy.c
+++ linux-4.15/drivers/staging/speakup/speakup_dummy.c
@@ -103,7 +103,7 @@ static struct spk_synth synth_dummy = {
 	.probe = spk_ttyio_synth_probe,
 	.release = spk_ttyio_release,
 	.synth_immediate = spk_ttyio_synth_immediate,
-	.catch_up = spk_do_catch_up,
+	.catch_up = spk_do_catch_up_unicode,
 	.flush = spk_synth_flush,
 	.is_alive = spk_synth_is_alive_restart,
 	.synth_adjust = NULL,
