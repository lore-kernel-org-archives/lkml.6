Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB2AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 23:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28AF2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 23:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbeLNXYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 18:24:43 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58433 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbeLNXYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 18:24:42 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 40B3B80935; Sat, 15 Dec 2018 00:24:34 +0100 (CET)
Date:   Sat, 15 Dec 2018 00:24:37 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>, jikos@suse.cz,
        vojtech@suse.cz, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com
Subject: [rfd] saving old mice -- button glitching/debouncing
Message-ID: <20181214232437.GA8310@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


I believe I have hardware problem, but I'm kind of hoping software
could help me...?

Mouse wheel on my machine started glitching on my machine, generating
double-clicks when I click it once. Which unfortunately is quite
annoying: texts are pasted twice, two tabs are closed instead of one,
=2E...

Event: time 1544733054.903129, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90=
003
Event: time 1544733054.903129, type 1 (EV_KEY), code 274 (BTN_MIDDLE), valu=
e 1
Event: time 1544733054.903129, -------------- EV_SYN ------------
            1544733054.967251, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90=
003
Event: time 1544733054.967251, type 1 (EV_KEY), code 274 (BTN_MIDDLE), valu=
e 0
Event: time 1544733054.967251, -------------- EV_SYN ------------
Event: time 1544733054.975144, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90=
003
Event: time 1544733054.975144, type 1 (EV_KEY), code 274 (BTN_MIDDLE), valu=
e 1
Event: time 1544733054.975144, -------------- EV_SYN ------------
     : time 1544733065.127190, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90=
003
Event: time 1544733065.127190, type 1 (EV_KEY), code 274 (BTN_MIDDLE), valu=
e 0
Event: time 1544733065.127190, -------------- EV_SYN ------------

Now, I could just buy a new mouse, but it seems that most optical mice
die like this... so maybe it would be nice to have an option to
debounce the buttons, so that the useful life of mice is extended a
bit?

(So... I have two mice with that fault -- cheap to replace, but button
in thinkpad X220 started doing that, too. That one will not be so
cheap to fix :-( ).

It is possible that some X versions already do something like this.

Patch is obviously not ready; but:

a) would it be useful to people

b) would it be acceptable if done properly? (cmd line option to
enable, avoiding duplicate/wrong events?)

Thanks,
								Pavel
Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 3304aaa..ce0d081 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -40,6 +40,11 @@ static DEFINE_IDA(input_ida);
 static LIST_HEAD(input_dev_list);
 static LIST_HEAD(input_handler_list);
=20
+static void input_repeat_key(struct timer_list *t);
+static void input_debounce_key(struct timer_list *t);
+
+static int debounce =3D 20;
+
 /*
  * input_mutex protects access to both input_dev_list and input_handler_li=
st.
  * This also causes input_[un]register_device and input_[un]register_handl=
er
@@ -77,6 +82,7 @@ static void input_start_autorepeat(struct input_dev *dev,=
 int code)
 	if (test_bit(EV_REP, dev->evbit) &&
 	    dev->rep[REP_PERIOD] && dev->rep[REP_DELAY] &&
 	    dev->timer.function) {
+		dev->timer.function =3D input_repeat_key;
 		dev->repeat_key =3D code;
 		mod_timer(&dev->timer,
 			  jiffies + msecs_to_jiffies(dev->rep[REP_DELAY]));
@@ -88,18 +94,42 @@ static void input_stop_autorepeat(struct input_dev *dev)
 	del_timer(&dev->timer);
 }
=20
+static void input_start_debounce(struct input_dev *dev, int code)
+{
+	dev->timer.function =3D input_debounce_key;
+	dev->debounce_key =3D code;
+	mod_timer(&dev->timer,
+		  jiffies + msecs_to_jiffies(debounce));
+}
+
+static void input_stop_debounce(struct input_dev *dev)
+{
+	del_timer(&dev->timer);
+	dev->debounce_key =3D -1;
+}
+
 /*
  * Pass event first through all filters and then, if event has not been
  * filtered out, through all open handles. This function is called with
  * dev->event_lock held and interrupts disabled.
  */
-static unsigned int input_to_handler(struct input_handle *handle,
+static unsigned int input_to_handler(struct input_dev *dev, struct input_h=
andle *handle,
 			struct input_value *vals, unsigned int count)
 {
 	struct input_handler *handler =3D handle->handler;
 	struct input_value *end =3D vals;
 	struct input_value *v;
=20
+	if (!test_bit(EV_REP, dev->evbit) && test_bit(EV_KEY, dev->evbit) && debo=
unce)
+		for (v =3D vals; v !=3D vals + count; v++) {
+			if (v->type =3D=3D EV_KEY && v->value =3D=3D 0 && dev->debounce_key =3D=
=3D -1) {
+				input_start_debounce(dev, v->code);
+				v->code =3D -2;
+			}
+			if (v->type =3D=3D EV_KEY && v->value =3D=3D 1 && dev->debounce_key =3D=
=3D v->code)
+				input_stop_debounce(dev);
+		}
+
 	if (handler->filter) {
 		for (v =3D vals; v !=3D vals + count; v++) {
 			if (handler->filter(handle, v->type, v->code, v->value))
@@ -117,8 +147,9 @@ static unsigned int input_to_handler(struct input_handl=
e *handle,
 	if (handler->events)
 		handler->events(handle, vals, count);
 	else if (handler->event)
-		for (v =3D vals; v !=3D vals + count; v++)
+		for (v =3D vals; v !=3D vals + count; v++) {
 			handler->event(handle, v->type, v->code, v->value);
+		}
=20
 	return count;
 }
@@ -141,11 +172,11 @@ static void input_pass_values(struct input_dev *dev,
=20
 	handle =3D rcu_dereference(dev->grab);
 	if (handle) {
-		count =3D input_to_handler(handle, vals, count);
+		count =3D input_to_handler(dev, handle, vals, count);
 	} else {
 		list_for_each_entry_rcu(handle, &dev->h_list, d_node)
 			if (handle->open) {
-				count =3D input_to_handler(handle, vals, count);
+				count =3D input_to_handler(dev, handle, vals, count);
 				if (!count)
 					break;
 			}
@@ -203,6 +234,27 @@ static void input_repeat_key(struct timer_list *t)
 	spin_unlock_irqrestore(&dev->event_lock, flags);
 }
=20
+/*
+ * Generate software autorepeat event. Note that we take
+ * dev->event_lock here to avoid racing with input_event
+ * which may cause keys get "stuck".
+ */
+static void input_debounce_key(struct timer_list *t)
+{
+	struct input_dev *dev =3D from_timer(dev, t, timer);
+	unsigned long flags;
+
+	struct input_value vals[] =3D  {
+		{ EV_KEY, dev->debounce_key, 0 },
+		input_value_sync
+	};
+
+	spin_lock_irqsave(&dev->event_lock, flags);
+	input_pass_values(dev, vals, ARRAY_SIZE(vals));
+	input_stop_debounce(dev);
+	spin_unlock_irqrestore(&dev->event_lock, flags);
+}
+
 #define INPUT_IGNORE_EVENT	0
 #define INPUT_PASS_TO_HANDLERS	1
 #define INPUT_PASS_TO_DEVICE	2
@@ -2109,6 +2161,8 @@ int input_register_device(struct input_dev *dev)
 	/* Every input device generates EV_SYN/SYN_REPORT events. */
 	__set_bit(EV_SYN, dev->evbit);
=20
+	dev->debounce_key =3D -1;
+
 	/* KEY_RESERVED is not supposed to be transmitted to userspace. */
 	__clear_bit(KEY_RESERVED, dev->keybit);
=20
diff --git a/include/linux/input.h b/include/linux/input.h
index 7c7516e..b2458b2 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -150,6 +150,7 @@ struct input_dev {
=20
 	struct ff_device *ff;
=20
+	int debounce_key;
 	unsigned int repeat_key;
 	struct timer_list timer;
=20


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwUO7UACgkQMOfwapXb+vKRVACeL0xsqlOvtXPbv2fwmMY6SLEW
HWMAnixQC3dPZJPjQ68BsERor4JfQ2ss
=h2fb
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
